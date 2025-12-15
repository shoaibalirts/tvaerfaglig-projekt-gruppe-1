<template>
  <!-- <header>Would you like to Signout?</header> -->

  <tool-bar toolbarTitle="Signout" />
  <main class="logout-container">
    <v-sheet class="mx-auto" width="300">
      <v-form @submit.prevent="logout">
        <logout-btn-form class="mt-2" color="#096123" type="submit" block></logout-btn-form>
      </v-form>
    </v-sheet>
  </main>
</template>
<script>
import LogoutBtnForm from "@/components/UI/LogoutBtnForm.vue";
import ToolBar from "@/components/layout/ToolBar.vue";

import { logout } from "@/api";
export default {
  components: {
    LogoutBtnForm,
    ToolBar,
  },

  data() {
    return {
      Username: "",
      UserPassword: "",
      rules: [(v) => !!v || "Field is required"],
      RegisterText: "Register",
    };
  },
  methods: {
    async logout() {
      const logoutUser = await logout();

      this.$router.push("/");
    },
  },
};
</script>
<style scoped>
.logout-container {
  width: 100%;
  max-width: 480px;
  height: 80vh;
  margin: 10rem auto;

  padding: 0;
  display: flex;
  flex-direction: column;
  /* border-radius: 12px; */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  background: #ffffff;
  overflow: hidden;
}
</style>
