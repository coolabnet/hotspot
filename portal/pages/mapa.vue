<template>
  <article>
    <Map height="90vh" :places="places" :token="page.mapBoxToken"></Map>
  </article>
</template>

<script>
export default {
  layout: "pages",
  head: {
    link: [
      {
        rel: "stylesheet",
        href: "https://api.mapbox.com/mapbox-gl-js/v1.10.0/mapbox-gl.css",
      },
    ],
  },
  async asyncData({ $content }) {
    const page = await $content("index").fetch();
    const places = await $content("lugares").fetch();
    return {
      page,
      places,
    };
  },
};
</script>
