<template>
  <header>Would you like to Signout?</header>
  <main>
    <v-sheet class="mx-auto" width="300">
      <v-form @submit.prevent="logout">
        <logout-btn-form class="mt-2" color="#096123" type="submit" block></logout-btn-form>
      </v-form>
    </v-sheet>
  </main>
</template>
<script>
import LogoutBtnForm from "@/components/UI/LogoutBtnForm.vue";
import { logout } from "@/api";
export default {
  name: "LoginForm",
  components: {
    LogoutBtnForm,
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
