
<template>
<the-header/>
<div class="wrapper">
 <v-form id="list-form" @submit.prevent="handleSaveList">
    
    <div>

    </div>
<label for="name-input"></label>
    <v-text-field
      id="name-input"
      placeholder="Skriv navn"
      v-model="listName"
      :rules="validationRules"
       variant="solo"
  bg-color="white"
    />

    <v-list id="selected-products-list">
      <v-list-item v-for="product in shoppingListProducts" v-bind:key="product">
        <v-list-item-title>{{
          productsList.find((prod) => prod.value === product).title
        }}</v-list-item-title>
        <v-list-item-subtitle
          >{{ productsList.find((prod) => prod.value === product).co2_per_kg }} kg
          CO₂</v-list-item-subtitle>          <v-btn @click="deleteFromList(product)" class="delete-v-Btn" ><img  class="delete" :src="DeleteImage" alt=""></v-btn>

      </v-list-item>
    </v-list>

    <v-combobox
      :items="productsList"
      item-value="value"
      label="Vælg produkt"
      v-model="selectedItem"
      @update:model-value="setShoppingListData"
       variant="solo"
  bg-color="white"
    >
      <template v-slot:item="{ props, item }">
        <v-list-item v-bind="props" title="">
          <v-list-item-title>{{ item.raw.title }}</v-list-item-title>
          <v-list-item-subtitle>{{ item.raw.co2_per_kg }} kg CO₂</v-list-item-subtitle>
        </v-list-item>
      </template>
    </v-combobox>

    <v-btn class="submit-btn" type="submit">Gem</v-btn>
  </v-form>

</div>
<v-btn class="backBtn" size="small" @click="handleClickBackBtn">
      <v-icon :icon="mdiChevronLeft"></v-icon>Tilbage</v-btn
    >
 <the-footer/>
</template>

<script>
import productService from "../services/productService";
import { mdiChevronLeft } from "@mdi/js";
import TheHeader from '../components/layout/TheHeader.vue';
import TheFooter from '../components/layout/TheFooter.vue';
import DeleteImage from '@/assets/delete.png'
export default {
  components: { TheHeader, TheFooter },
  data() {
    return {
      productsList: [],
      shoppingListProducts: [],
      selectedItem: null,
      listName: "",
      validationRules: [(value) => !!value || "Liste navn er pakrævet."],
      mdiChevronLeft,
      DeleteImage
    };
  },
  methods: {
    handleClickBackBtn() {
      if (this.shoppingListProducts.length === 0) this.$router.push({ path: "/" });
      else this.handleSaveList();
    },
   deleteFromList(productValue) {
    this.shoppingListProducts = this.shoppingListProducts.filter(
      item => item !== productValue
    );
  },
    setShoppingListData(data) {
      this.shoppingListProducts.push(data.value);
    },
    async handleSaveList() {
      if (!this.listName || this.shoppingListProducts.length === 0) return;

      const list = {
        CategoryName: this.listName,
        CreatedDate: new Date(),
        Products: this.shoppingListProducts,
      };

      productService.saveListData(list);

      this.$router.push({ path: "/" });
    },
  },
  async mounted() {
    try {
      const receivedProductsListFromDatabase = await productService.getProductsList();
      this.productsList = receivedProductsListFromDatabase.map((list) => {
        return {
          value: list.id,
          title: list.prodName,
          co2_per_kg: list.co2_per_kg,
          prodAlternatives: list.prodAlternatives || [],
        };
      });
    } catch (err) {
      console.error("Error fetching products list", err);
    }
  },
};
</script>

<style>
#list-form {
  position: unset;
  width: 90vw;
  
  /* padding: 3vh 5vw; */
  margin: 0px;
    margin-top: 32px;

  padding:0px!important;
  display: flex;
  flex-direction: column;

}

#name-input {
  margin-bottom: ;
}
.name-input{
}

#selected-products-list {
  max-height: 50vh;
  overflow: auto;
}
.wrapper{
  display:flex;
  flex-direction: column;
  justify-content: center!important;;
  align-items: center!important;
overscroll-behavior-y: scroll;}
.submit-btn{
  background-color: #096124;
  color: white;
  margin-bottom: 16px;
}
.submit-btn:hover{
  opacity: 50%;
}
.backBtn{
  width: 150px;
}
.delete{
  padding: 8px;
  background-color: transparent!important;
width: 40px;

}
.delete-v-Btn{
  background-color: transparent!important;
  padding: 8px;
  display: flex;
  justify-content: center;
  align-items: center;
margin-bottom: 8px;
  
}
</style>
