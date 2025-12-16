import { createApp } from "vue";
import App from "./App.vue";
import vuetify from "./plugins/vuetify";
import router from "./router";
import VueCookies from "vue-cookies";

const app = createApp(App);
app.use(vuetify);
app.use(router);
app.use(VueCookies);
app.mount("#app");
