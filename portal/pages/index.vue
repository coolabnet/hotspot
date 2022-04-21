<template>
  <main>
    <Header :titulo="page.titulo" :img="page.imagemBanner"> </Header>
    <div
      class="flex flex-col md:flex-row items-center text-center justify-around py-100px gap-y-50px bg-red-100"
    >
      <Nav
        v-for="(menus, index) in page.menus"
        :key="index"
        :nome="menus.nome"
        :detalhe="menus.detalhe"
        :ilustra="menus.icone"
        :index="index"
      ></Nav>
    </div>
    <Map height="500px" :places="places" :token="page.mapBoxToken"></Map>
    <Footer></Footer>
  </main>
</template>

<script>
export default {
  async asyncData({ $content }) {
    const places = await $content("lugares").fetch();
    const page = await $content("index").fetch();
    return {
      places,
      page,
    };
  },
  head: {
    link: [
      {
        rel: "stylesheet",
        href: "/mapbox.css",
      },
    ],
  },
};
</script>
