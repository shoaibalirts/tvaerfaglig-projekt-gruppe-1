<template>
  <main class="background-register">
    <admin-header />
    <v-sheet class="mx-auto background" width="300">
      <v-form class="form-register" @submit.prevent="register">
        <label for="user_name">Bruger navn</label>
        <v-text-field
          id="user_name"
          class="input-field"
          v-model="Username"
          :rules="rules"
        ></v-text-field>

        <label for="password">Kodeord</label>
        <v-text-field
          style="backgroundcolor: white; marign: 0px; padding: 0px"
          class="input-field text-black"
          v-model="UserPassword"
          :rules="rules"
          id="password"
          type="password"
        ></v-text-field>
        <v-btn class="mt-2" color="#096123" type="submit" block>Register</v-btn>
      </v-form>
    </v-sheet>
  </main>
</template>
<script>
import { signup } from "@/api";
import AdminHeader from "../components/AdminHeader.vue";

export default {
  components: { AdminHeader },
  name: "RegisterForm",
  data() {
    return {
      Username: "",
      UserPassword: "",
      UserRole: "admin",
      rules: [(v) => !!v || "Field is required"],
    };
  },
  methods: {
    async register() {
      const data = {
        user_name: this.Username,
        user_password: this.UserPassword,
        user_role_name: this.UserRole,
      };

      const signupUser = await signup(data);
      if (signupUser === 201) {
        alert(`Bruger ${this.Username} er oprettet, venligst login`);
        this.$router.push(`/login`);
      }
    },
  },
};
</script>
<style scoped>
.v-label {
  color: black;
  opacity: 0.8;
}

.background {
  background-color: transparent !important;
  margin-top: 32px !important;
}
.form-register {
  margin-top: 100px !important;
  background-color: transparent !important;
}
.background-register {
  background-image: url("@/assets/background.png");
  background-size: 80%;
  background-position: 100% 210%; /* venstre bund */
  background-repeat: no-repeat;
  height: 100vh;
}
input[type="text"] {
  background-color: white !important;
}
</style>
