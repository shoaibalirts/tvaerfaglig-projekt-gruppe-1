<template>
  <!-- // template fra vuetify -->
  <div>
    <label for="alternatives" v-if="alternatives.length">Vælg grønt alternativ</label>
    <v-select
      id="alternatives"
      bg-color="dark-green"
      clearable
      chips
      :items="alternatives"
      item-title="prodName"
      item-value="prodName"
      v-if="alternatives.length"
      variant="solo-filled"
      @update:model-value="snackbar = true"
    >
    </v-select>
    <v-snackbar color="green" v-model="snackbar" absolute="true">
      Tillykke, du har reduceret CO2 af din liste!
    </v-snackbar>
  </div>
</template>
<script setup>
import { ref, onMounted } from "vue";
import { db } from "@/utility/firebaseConfig";
import { doc, getDoc } from "firebase/firestore";

// modtag produktets id som prop
const props = defineProps({
  productId: {
    type: String,
    required: true,
  },
});

const snackbar = ref(false);
const alternatives = ref([]);

onMounted(async () => {
  try {
    const prodRef = doc(db, "Products", props.productId);
    const prodSnap = await getDoc(prodRef);

    if (!prodSnap.exists()) return;

    const data = prodSnap.data();
    if (Array.isArray(data.prodAlternatives)) {
      alternatives.value = data.prodAlternatives;
    } else {
      alternatives.value = [];
    }
  } catch (err) {
    console.error("Fejl ved hentning af alternativer:", err);
  }
});
</script>
<style scoped>
label {
  font-size: small;
  font-weight: 100;
  color: green;
}
</style>
