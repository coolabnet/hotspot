<template>
  <div
    :style="banner"
    class="h-70vh bg-gradient-to-r from-yellow-400 via-green-500 to-red-500 bg-cover bg-bottom"
  >
    <h1 class="mx-auto text-center text-5xl text-white bg-light-blue-900 bg-opacity-65 relative top-45 w-95vw md:w-70vw rounded p-4">
      {{ titulo }}
    </h1>
  </div>
</template>

<script>
import getImage from '../libs/getImage'

export default {
  props: {
    titulo: String,
    img: String,
  },
  data() {
    return {
      banner: getImage(this.img, true)
    };
  },
};
</script>
