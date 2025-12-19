<template>
  <main>
    <admin-header />
    <div class="content" display="flex" >
<div class="form">
  <h2 class="h2-login">Login</h2>
<v-sheet  width="300" >
      <v-form @submit.prevent="login">
        <v-text-field v-model="Username" :rules="rules" label="Username"></v-text-field>
        <v-text-field
          v-model="UserPassword"
          :rules="rules"
          type="password"
          label="UserPassword"
        ></v-text-field>
        <v-btn color="grey" :to="{ path: '/register' }">Register</v-btn>
        <login-btn-form class="mt-2" color="#096123" type="submit" block></login-btn-form>
      </v-form>
    </v-sheet>
</div>
 
    <div class="add-mobile-green">
    <img :src="backgroundImage" class="img"></img>
    <h2 class="white">Download appen!</h2>
    <v-btn class="download-btn">Download appen</v-btn>

    </div>
   

    </div>
  </main>
  <TheFooter/>
</template>
<script>
import LoginBtnForm from "@/components/UI/LoginBtnForm.vue";
import { login } from "@/api";
import AdminHeader from "../components/AdminHeader.vue";
import TheFooter from "../components/layout/TheFooter.vue";
import backgroundImage from "@/assets/backgroundlogin.png";

export default {
  name: "LoginForm",
  components: {
    LoginBtnForm,
    AdminHeader,
    TheFooter
  },

  data() {
    return {
      Username: "",
      UserPassword: "",
      rules: [(v) => !!v || "Field is required"],
      RegisterText: "Register",
      backgroundImage
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
<style scoped>
.form{
  display:flex;
  flex-direction: column;
  /* justify-content: center;
   */
   background-color:white;
   height: 100%;
    
}
.h2-login{
 color: #096123;
}
.content{
  display:flex;
  flex-direction: column;
  justify-content: center !important;
  align-items:center;
  width: 100vw;  
  margin-top:200px ;
  padding-bottom: 32px;
  padding-top: 32px;
}
.add-mobile-green{
  /* background-color:blanchedalmond; */
  display:none;
}
header{
  position: absolute;
  height: 200px;
z-index: 1;
}
main{
  display: flex;
  flex-direction: row;
  justify-content: center;
  

}

.add-mobile{
}
@media (min-width: 700px) {
  .form{
  display:flex;
  flex-direction: column!important;
  justify-content: center!important;
  width: 50vw;  
height: 100%;
    align-items:center!important;

}
main{
  /* background-color:rgb(220, 220, 220); */
  display: flex;
  justify-content: center;
  margin-top: 0px;
  width: 100vw;

}
/* .add-mobile-green{
  background-color:#096123;
;
  display:flex;
width: 50vw;
z-index: 1;
justify-content: center !important;;
align-items: center!important;
flex-direction: column;
height: 100%;
} */
 .add-mobile-green {
  position: relative;
  background-color: #096123;
  width: 50vw;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden; /* vigtigt */
  justify-content: center;
  align-items: center;
}

.content {
  display: flex;
  flex-direction: row;
  width: 100vw;
  height: 100vh;
}

.add-mobile-green::before {
  content: "";
  position: absolute;
  left: -100px;        
  top: 0;
  width: 240px;
  height: 100%!important;
  background: #ffffff;
  border-radius: 0% 100% 100% 0%;
}
.add-mobile-green > * {
  position: relative;
  z-index: 2;
}


.h2-login{
 color: #096123;
padding-top: 32px; 
}
.white{
  color:white;
  
}
.img{
  z-index: 0;
  position: absolute;
  right:-10%;
  width: 40%;
  bottom:-10%;
  width: 380px;
}
.download-btn{
  margin-bottom: 150px;
  box-shadow: black 50% 50% 50% 50%;
}

}
</style>