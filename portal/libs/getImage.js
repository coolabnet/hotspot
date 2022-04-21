import isHttp from 'is-http'


export default (img, isBackground) => {
    let imagem
    if (!img) return null
    const isRemote = isHttp(img)
    if (isRemote) {
        imagem = img
    } else {
        imagem = require(`~/assets/${img}`);
    }
    if (isBackground) return `background-image: url("${imagem}");`;
    else return imagem
}