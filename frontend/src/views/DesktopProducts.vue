<template>
  <v-container class="mt-8">
    <h1 class="mb-6">Produkter</h1>

   <v-btn
  color="green"
  class="mb-6"
  :disabled="showAddRow"
  @click="showAddRow = true"
>
  Tilføj Produkt
</v-btn>

    <v-card
      class="pa-4 mb-2 d-flex align-center font-weight-bold"
      color="grey-lighten-4"
    >
      <div class="flex-grow-1">
        Produkt
      </div>

      <div class="flex-grow-1 text-center">
        Co2
      </div>

      <div style="width: 120px; text-align: right;">
        Handlinger
      </div>
    </v-card>

    <v-card
      v-if="showAddRow"
      class="pa-4 mb-2 d-flex align-center"
    >
      <div class="flex-grow-1">
        <v-text-field
          v-model="newProduct.name"
          hide-details
          placeholder="Produkt"
        />
      </div>

      <div class="flex-grow-1 text-center">
        <v-text-field
          v-model="newProduct.co2"
          type="number"
          hide-details
          placeholder="Co2"
        />
      </div>

      <div style="width: 120px; text-align: right;">
        <v-btn color="green" size="small" @click="addNewProduct">
          Gem
        </v-btn>
      </div>
    </v-card>

    <v-card
      v-for="product in products"
      :key="product.id"
      class="pa-4 mb-2 d-flex align-center"
    >
      <div class="flex-grow-1">
        <v-text-field
          v-if="editId === product.id"
          v-model="editProduct.name"
          hide-details
        />
        <span v-else>{{ product.prod_name }}</span>
      </div>

      <div class="flex-grow-1 text-center">
        <v-text-field
          v-if="editId === product.id"
          v-model="editProduct.co2"
          type="number"
          hide-details
        />
        <span v-else>{{ product.prod_co2 }} Co2</span>
      </div>

      <div style="width: 120px; text-align: right;">
  <v-icon
    :icon="mdiPencil"
    color="green"
    class="mr-3"
    @click="startEdit(product)"
  />

  <v-icon
    v-if="editId === product.id"
    :icon="mdiContentSave"
    color="green"
    class="mr-3"
    @click="saveEdit(product.id)"
  />

  <v-icon
    :icon="mdiDelete"
    color="red"
    @click="removeProduct(product.id)"
  />
</div>

    </v-card>
  </v-container>
</template>


<script>
import {
  getAllProducts,
  addProduct,
  updateProduct,
  deleteProduct
} from "@/api";
import{mdiPencil,mdiContentSave,mdiDelete}from'@mdi/js';

export default {
  name: "DesktopProducts",

  data() {
    return {
      mdiPencil,
      mdiContentSave,
     mdiDelete,
      products: [],
      showAddRow: false,
      activeAddRow: false,
      newProduct: {
        name: "",
        co2: ""
      },
      editId: null,
      editProduct: {
        name: "",
        co2: ""
      }
    };
  },

  mounted() {
    this.loadProducts();
  },

  methods: {
   async loadProducts() {
  try {
    const data = await getAllProducts();
    this.products = Array.isArray(data) ? data : [];
  } catch {
    this.products = [];
  }
},

   async addNewProduct() {
  const tempId = Date.now();

  const tempProduct = {
    id: tempId,
    prod_name: this.newProduct.name,
    prod_co2: this.newProduct.co2,
    isTemporary: true
  };

  this.products.unshift(tempProduct);

  this.newProduct.name = "";
  this.newProduct.co2 = "";
  this.showAddRow = false;

  const savedProduct = await addProduct({
    prod_name: tempProduct.prod_name,
    prod_co2: tempProduct.prod_co2
  });

  if (!savedProduct) {
    console.log("Backend down, keeping product frontend-only");
    return;
  }

  const index = this.products.findIndex(p => p.id === tempId);
  if (index !== -1) {
    this.products[index] = savedProduct;
  }
},

   startEdit(product) {
  if (product.isTemporary) return;

  this.editId = product.id;
  this.editProduct.name = product.prod_name;
  this.editProduct.co2 = product.prod_co2;
}
,

    async saveEdit(id) {
      await updateProduct({
        id,
        prod_name: this.editProduct.name,
        prod_co2: this.editProduct.co2
      });

      this.editId = null;
      this.loadProducts();
    },

    async removeProduct(id) {
      await deleteProduct(id);
      this.loadProducts();
    }
  }
};
</script>
