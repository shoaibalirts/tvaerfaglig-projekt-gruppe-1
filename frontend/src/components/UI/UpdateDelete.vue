<template>
  <div class="d-flex justify-space-around ga-4">
    <!-- <v-btn :icon="mdiPencil" @click.stop="handleUpdate"></v-btn> -->
    <btn class="deleteBtn" @click.stop="handleUpdate"><img :src="deleteImg" alt=""></btn>
    <!-- <v-btn :icon="mdiDelete" class="bg-primary" @click.stop="handleDelete"></v-btn> -->
        <btn  class="deleteBtn" @click.stop="handleUpdate"><img :src="updateImg" alt=""></btn>

  </div>
</template>

<script>
import { mdiPencil, mdiDelete } from "@mdi/js";
import { deleteProduct, updateProduct } from "@/api.js";
// import image from .
import deleteImg from "@/assets/delete.png"
import updateImg from "@/assets/edit.png"
export default {
  props: {
    productData: {
      type: Object,
    },
  },
  emits: ["product-deleted"],
  data() {
    return {
      mdiPencil,
      mdiDelete,
      deleteImg,
      updateImg
    };
  },
  methods: {
    async handleUpdate() {
      // console.log("update function is executing");
      // console.log(this.productData);
      //       {
      //     "prodId": 3,
      //     "prodName": "Kylling",
      //     "prodCo2": 8
      // }

      try {
        this.$router.push({
          path: "/updateproduct",
          query: { id: this.productData.prodId },
        });
        // this.$emit("product-updated", this.productData.id);
      } catch (error) {
        console.error("Error delete the product:", error);
      }
    },
    async handleDelete() {
      // console.log("delete function is executing");
      // console.log(this.productData);
      try {
        const deletedProductInMySqlDatabase = await deleteProduct(this.productData.prodId);
        // console.log(deletedProductInMySqlDatabase);
        this.$emit("product-deleted", this.productData.id);
      } catch (error) {
        console.error("Error delete the product:", error);
      }
    },
  },
};
</script>
<style >
.deleteBtn{
  background-color: transparent!important;
  border:1px, solid rgb(222, 221, 221);
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 100%;
  width: 42px;
  height: 42px;

}
.deleteBtn img{
  width: 20px;
    padding: 2px;

}
</style>
