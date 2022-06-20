#!/usr/bin/python
#adapted from https://github.com/nikosft/captive-portal/
import subprocess
import BaseHTTPServer
import cgi
import os

# These variables are used as settings
PORT       = 9090         # the port in which the captive portal web server listens
IFACE      = "wlan0"      # the interface that captive portal protects
FDROID_IP_1 = "148.251.140.42"
FDROID_IP_2 = "149.202.95.241"

ip_pipe = subprocess.Popen(['ip', 'r'],  stdout=subprocess.PIPE)
interface_pipe = subprocess.Popen (['grep', IFACE], stdin=ip_pipe.stdout, stdout=subprocess.PIPE)
IP_ADDRESS = subprocess.check_output (['cut', '-d', ' ', '-f', '9'], stdin=interface_pipe.stdout).split()[0]

'''
This it the http server used by the the captive portal
'''
class CaptivePortal(BaseHTTPServer.BaseHTTPRequestHandler):
    #this is the index of the captive portal
    #it simply redirects the user to the to login page
    html_redirect = """
    <html>
    <head>
        <meta http-equiv="refresh" content="0; url=http://%s" />
    </head>
    <body>
        <b>Redirecting to login page</b>
    </body>
    </html>
    """%(IP_ADDRESS)

    '''
    if the user requests the login page show it, else
    use the redirect page
    '''
    def do_GET(self):
        path = self.path
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(self.html_redirect)
    '''
    this is called when the user submits the login form
    '''
    def do_POST(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={'REQUEST_METHOD':'POST',
                     'CONTENT_TYPE':self.headers['Content-Type'],
                     })
        # username = form.getvalue("username")
        # password = form.getvalue("password")
        #dummy security check
        # if username == 'nikos' and password == 'fotiou':
            #authorized user
        remote_IP = self.client_address[0]
        print ('New authorization from '+ remote_IP)
        print ('Updating IP tables')
        subprocess.call(["iptables","-t", "nat", "-I", "PREROUTING","1", "-s", remote_IP, "-j" ,"ACCEPT"])
        subprocess.call(["iptables", "-I", "FORWARD", "-s", remote_IP, "-j" ,"ACCEPT"])
        self.wfile.write("{success: true, ip:" + remote_IP + "}")
        # else:
        #     #show the login form
        #     self.wfile.write(self.html_login)

    #the following function makes server produce no output
    #comment it out if you want to print diagnostic messages
    #def log_message(self, format, *args):
    #    return

print "*********************************************"
print "* Note, if there are already iptables rules *"
print "* this script may not work. Flush iptables  *"
print "* at your own risk using iptables -F        *"
print "*********************************************"
print "Updating iptables"
print ".. Allow TCP DNS"
subprocess.call(["iptables", "-A", "FORWARD", "-i", IFACE, "-p", "tcp", "--dport", "53", "-j" ,"ACCEPT"])
print ".. Allow UDP DNS"
subprocess.call(["iptables", "-A", "FORWARD", "-i", IFACE, "-p", "udp", "--dport", "53", "-j" ,"ACCEPT"])
print ".. Allow traffic to captive portal"
subprocess.call(["iptables", "-A", "FORWARD", "-i", IFACE, "-p", "tcp", "--dport", str(PORT),"-d", IP_ADDRESS, "-j" ,"ACCEPT"])
print ".. Allow traffic to F-Droid repositories"
subprocess.call(["iptables", "-A", "FORWARD", "-i", IFACE, "-p", "tcp", "--dport", "80","-d", FDROID_IP_1, "-j" ,"ACCEPT"])
subprocess.call(["iptables", "-A", "FORWARD", "-i", IFACE, "-p", "tcp", "--dport", "80","-d", FDROID_IP_2, "-j" ,"ACCEPT"])
print ".. Block all other traffic"
subprocess.call(["iptables", "-A", "FORWARD", "-i", IFACE, "-j" ,"DROP"])
print "Starting web server"
httpd = BaseHTTPServer.HTTPServer(('', PORT), CaptivePortal)
print "Redirecting HTTP traffic to captive portal"
subprocess.call(["iptables", "-t", "nat", "-A", "PREROUTING", "-i", IFACE, "-p", "tcp", "--dport", "80", "-j" ,"DNAT", "--to-destination", IP_ADDRESS+":"+str(PORT)])

try:
    httpd.serve_forever()
except KeyboardInterrupt:
    pass
httpd.server_close()
