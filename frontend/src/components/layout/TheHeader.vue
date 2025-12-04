<template>
  <v-app-bar class="header-green"  d-flex flex-column :elevation="4">
    <template v-slot:prepend>
    <!-- <template> -->
      <v-menu location="bottom start">
        <template v-slot:activator="{ props }">
          <v-btn class="btnmenu" :icon="mdiMenu" v-bind="props"> </v-btn>
        </template>

        <the-menu />
      </v-menu>
    </template>
     <v-app-bar-title class="v-bar-title-costum">
  <!--  <h1>Dine Indkøbslister</h1> -->

      <p>{{ $route.meta.headerDesc }}</p>
    <h1>{{ $route.meta.headerTitle }}</h1>
</v-app-bar-title>
    <!-- <v-app-bar-title>Dine Indkøbslister</v-app-bar-title> -->

    <!-- <template v-slot:append>
      <v-btn>
        <v-icon :icon="mdiMagnify"></v-icon>
      </v-btn>
      <v-btn>
        <v-icon :icon="mdiDotsVertical"></v-icon>
      </v-btn>
    </template> -->
  </v-app-bar>
</template>

<script>
import TheMenu from "../UI/TheMenu.vue";
import { mdiMagnify, mdiDotsVertical, mdiMenu } from "@mdi/js";
export default {
  data() {
    return {
      mdiMagnify,
      mdiDotsVertical,
      mdiMenu,
      isMenu: false,
    };
  },
  components: {
    TheMenu,
  },
};
</script>
<style scoped>
header{
display: flex;
  flex-direction: column;
      border-radius:0 0 50px 50px;
      /* justify-content: center;
      align-items: center;
        text-align: center; */

}
.header-green{
  background-color: green;
  height: 150px;
    /* border-radius:50px; */
  justify-content: center;
  align-items: center;
  display: flex;
  flex-direction: column !important;


  text-align: center;
  color:white;

  border-radius: 0 0 50px 50px !important;
  box-shadow: inset -2px -12px 20px 10px rgba(0,0,0,0.3) !important;
  overflow: visible !important;
  position: relative;
  /* z-index: 0; */
  /* margin-bottom: 100px; */
}
h1{
  font-size:25px;}
  .v-bar-title-costum{
    background-color:red;;
    width: 100%;
    position: relative;
  }
.btnmenu{
  position: fixed;
}
</style>
