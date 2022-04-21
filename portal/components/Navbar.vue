<template>
  <div
    class="bg-red-400 flex flex-row justify-around justify-items-center items-center sm:justify-end shadow"
  >
    <NuxtLink to="/" class="divicone sm:self-start">
      <img src="~/assets/home.svg" alt="iconeHome" class="icone" />
    </NuxtLink>

    <NuxtLink to="/sobre" class="divicone">
      <img src="~/assets/comunidade.svg" alt="iconeSobre" class="icone" />
    </NuxtLink>

    <NuxtLink to="/mapa" class="divicone">
      <img src="~/assets/mapa.svg" alt="iconeMapa" class="icone" />
    </NuxtLink>

    <NuxtLink to="/apps" class="divicone">
      <img src="~/assets/apps.svg" alt="iconeApps" class="icone" />
    </NuxtLink>

    <NuxtLink to="/contato" class="divicone">
      <img src="~/assets/arvore.svg" alt="iconeContato" class="icone" />
    </NuxtLink>
  </div>
</template>

<script></script>
<style>
.nuxt-link-exact-active {
  box-shadow: none;
  background-color: rgb(245, 16, 16);
  opacity: 100%;
  cursor: auto;
}
.nuxt-link-exact-active img {
  cursor: auto;
}
</style>
