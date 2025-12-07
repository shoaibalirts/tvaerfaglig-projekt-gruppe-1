<template>
  <v-footer class="text-center d-flex flex-column ga-2 py-4 bg-primary" color="indigo-lighten-1">
    <div class="d-flex ga-3">
      <v-btn
        v-for="icon in icons"
        :key="icon.altText"
        :icon="icon.icon"
        density="comfortable"
        variant="text"
        :aria-label="icon.altText"
      ></v-btn>
    </div>
  </v-footer>
</template>
<script>
import { mdiFacebook, mdiTwitter, mdiLinkedin, mdiInstagram } from "@mdi/js";
export default {
  data() {
    return {
      icons: [
        { icon: mdiFacebook, altText: "Facebook" },
        { icon: mdiTwitter, altText: "Twitter" },
        { icon: mdiLinkedin, altText: "LinkedIn" },
        { icon: mdiInstagram, altText: "Instagram" },
      ],
    };
  },
  methods: {},
};
</script>
