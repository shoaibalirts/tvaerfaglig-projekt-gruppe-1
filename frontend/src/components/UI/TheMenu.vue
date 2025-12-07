<template>
  <v-list v-if="!isLoggedIn">
    <v-list-item v-for="(item, index) in userArr" :key="index" :to="item.to" router>
      <v-list-item-title class="text-center bg-primary pa-4">
        {{ item.title }}
      </v-list-item-title>
    </v-list-item>
  </v-list>

  <v-list v-else>
    <v-list-item v-for="(item, index) in items" :key="index" :to="item.to" router>
      <v-list-item-title class="text-center bg-primary pa-2">
        {{ item.title }}
      </v-list-item-title>
    </v-list-item>
  </v-list>
</template>

<script>
import Cookies from "js-cookie";
export default {
  data() {
    return {
      items: [
        // { title: "Add a product", to: "/addproduct" },
        { title: "Produkter", to: "/products" },
        { title: "Chat", to: "/chat" },
        { title: "Signout", to: "/logout" },
        // { title: "Find a single product", to: "/product" },
        // { title: "Update Product", to: "/updateproduct" },
        // { title: "Remove Product", to: "/deleteproduct" },
      ],
      userArr: [
        { title: "Login", to: "/login" },
        { title: "Register", to: "/register" },
      ],
    };
  },
  computed: {
    isLoggedIn() {
      // console.log("Checking token:", Cookies.get("token"));
      console.log("Checking token:", Cookies.get("token")); // undefined first, then after changing to localhost at the server, i get the value
      return !!Cookies.get("token");
    },
  },
};
</script>
