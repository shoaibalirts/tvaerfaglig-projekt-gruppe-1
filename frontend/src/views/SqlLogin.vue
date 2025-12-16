<template>
  <main>
    <admin-header />
    <v-sheet class="mx-auto" width="300">
      <v-form @submit.prevent="login">
        <label for="user_name">Bruger navn</label>
        <v-text-field
          id="user_name"
          v-model="Username"
          :rules="rules"
          class="text-black"
        ></v-text-field>

        <label for="password">Kodeord</label>
        <v-text-field
          id="password"
          v-model="UserPassword"
          :rules="rules"
          type="password"
          class="text-black"
        ></v-text-field>
        <v-btn color="grey" :to="{ path: '/register' }">Register</v-btn>
        <login-btn-form class="mt-2" color="#096123" type="submit" block></login-btn-form>
      </v-form>
    </v-sheet>
  </main>
</template>
<script>
import LoginBtnForm from "@/components/UI/LoginBtnForm.vue";
import { login } from "@/api";
import AdminHeader from "../components/AdminHeader.vue";
export default {
  name: "LoginForm",
  components: {
    LoginBtnForm,
    AdminHeader,
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
    async login() {
      const data = {
        user_name: this.Username,
        user_password: this.UserPassword,
      };
      const loginUser = await login(data);
      if (loginUser === 201) {
        // this.$router.push({ path: "/" });
        this.$router.push("/");
        // window.location.reload();
      }
    },
  },
};
</script>

<style>
.v-label {
  color: black;
  opacity: 0.8;
}
</style>
