<template>
  <div class="d-flex justify-space-around ga-4">
    <!-- <v-btn :icon="mdiPencil" @click.stop="handleUpdate"></v-btn> -->
  <button class="deleteBtn" @click.stop="handleDelete"><img :src="deleteImg" alt=""></button>
    <!-- <v-btn :icon="mdiDelete" class="bg-primary" @click.stop="handleDelete"></v-btn> -->
        <button  class="deleteBtn" @click.stop="handleUpdate"><img :src="updateImg" alt=""></button>

  </div>
</template>

<script>
import { mdiPencil, mdiDelete } from "@mdi/js";
import {db} from "@/utility/firebaseConfig";
import {doc, deleteDoc} from "firebase/firestore";
// import image from .
import deleteImg from "@/assets/delete.png"
import updateImg from "@/assets/edit.png"
export default {
  props: {
      listData: Object,

    productData: {
      type: Object
    },
  },
  emits: ["list-deleted"],
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
    this.$router.push({
      path: "/updateproduct",
      query: { id: this.productData.Listid}
    });
    },
  async handleDelete() {
  try {
    const docRef = doc(db, "indkoebsliste", this.listData.id);
    await deleteDoc(docRef);

    this.$emit("list-deleted", this.listData.id);
  } catch (error) {
    console.error("Fejl i sletning af produkt", error);
  }
}
    
    },
    
}
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
