<template>
<div class="list-wrapper m-0 p-0">  
  <div class="d-flex align-center justify-end status ">
                  <v-icon
                   class="p-0"
                    :color="getCo2LevelColor(listData.totalCO2)"
                    :icon="mdiCircleMedium"
                    size="29"
                  ></v-icon>
                  <span
                    class="text-body-2 font-weight-medium p-0 m-0" 
                    :class="`text-${getCo2LevelColor(listData.totalCO2)}`"
                    >{{ getCo2LevelText(listData.totalCO2) }}</span
                  >

            </div>
  <v-list-item class="rounded border m-0 p-0 styled-item "
    :to="{ name: 'ListDetails', params: { id: listData.id } }"> 
    

      <!-- Gamle kode slettet fordi der er indbygget vuetify styling som ikke stemmer overens med vores mockupt -->
    <!-- <v-list-item-title class="font-weight-bold listName">{{ listData.listName }}</v-list-item-title>
    <span class="text-caption c02level">CO<sub>2</sub>: {{ listData.totalCO2.toFixed(2) }} kg</span>
<v-list-item-subtitle class="listCreateDate">{{ listData.listCreatedDate }}</v-list-item-subtitle> -->
      <!-- Gamle kode slettet fordi der er indbygget vuetify styling som ikke stemmer overens med vores mockupt -->




    <div class="listName">{{ listData.listName }}</div>
  <span class="c02level">CO<sub>2</sub>: {{ listData.totalCO2.toFixed(2) }} kg</span>
  <div class="listCreateDate">{{ listData.listCreatedDate }}</div>

    <template v-slot:append>
      <div class="d-flex flex-column align-end">
        
        <update-delete />
      </div>
    </template>
  </v-list-item>
  </div>
</template>

<script>
import getCo2LevelColor from "@/utility/getCo2LevelColor";
import getCo2LevelText from "@/utility/getCo2LevelText";
import UpdateDelete from "./UI/UpdateDelete.vue";
import { mdiCircleMedium } from "@mdi/js";
export default {
  props: ["listData"],
  data() {
    return {
      mdiCircleMedium,
    };
  },
  setup() {
    return {
      getCo2LevelColor,
      getCo2LevelText,
    };
  },
  components: {
    UpdateDelete,
  },
};
</script>
<style scoped>
.styled-item{
  /* background-color:black; */
  width: 100%;
  margin-top: 0px!important;
 border:1px, solid  rgba(0, 0, 0, 0);
 border-radius: 20px!important;
 padding:16px;
 justify-content: baseline;
 box-shadow: none;
}  
.c02level{
  color: #096123;
  font-size: 12px!important;

}
.listName{
  color:#096123;
  font-weight: 600;
}

.list-wrapper{
  width: 90%;
  margin: 0;
  padding: 0;
  
}
.listName, .c02level, .listCreateDate {
  margin: 0!important;
  padding: 0!important;
  line-height: 1;
}
.listCreateDate{
  font-size: 8px;
  color: #096124;
  opacity: 50%;
  margin-top: 12px!important;
}
.status{
  position: !important;
  z-index: 0;
}


</style>