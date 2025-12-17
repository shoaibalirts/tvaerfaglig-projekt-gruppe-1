<template>
  <v-container class="mt-8">
    <h1 class="mb-6">Produkter</h1>

    <v-btn color="green" class="mb-6" @click="showAddRow = !showAddRow">
      Tilføj Produkt
    </v-btn>

    <!-- TABLE HEADER -->
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

    <!-- ADD ROW (NOW UNDER HEADER) -->
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

    <!-- TABLE ROWS -->
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
          color="green"
          class="mr-3"
          @click="startEdit(product)"
        >
          mdi-pencil
        </v-icon>

        <v-icon
          v-if="editId === product.id"
          color="green"
          class="mr-3"
          @click="saveEdit(product.id)"
        >
          mdi-content-save
        </v-icon>

        <v-icon
          color="red"
          @click="removeProduct(product.id)"
        >
          mdi-delete
        </v-icon>
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

export default {
  name: "DesktopProducts",

  data() {
    return {
      products: [],
      showAddRow: false,
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
      this.products = await getAllProducts();
    },

    async addNewProduct() {
      await addProduct({
        prod_name: this.newProduct.name,
        prod_co2: this.newProduct.co2
      });

      this.newProduct.name = "";
      this.newProduct.co2 = "";
      this.showAddRow = false;
      this.loadProducts();
    },

    startEdit(product) {
      this.editId = product.id;
      this.editProduct.name = product.prod_name;
      this.editProduct.co2 = product.prod_co2;
    },

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
