<template>
  <header id="header-mobile" class="header-mobile">
    <p >{{ $route.meta.Desc }}</p>
    <h1>{{ $route.meta.adminHeaderTitle }}</h1>

    <nav class="nav-desktop">
      <ul>
      <li>Dine lister</li>
      <li>Tilføj liste</li>
      </ul>

    </nav>
  </header>
  
</template>


<script>
export default {
  name: "TheHeaderAdmin",
};
</script>

<style scoped>
header {
  height: 200px;
  background: #096123;
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  color: white;
  width: 100vw;
  border-bottom-left-radius: 58px;
  border-bottom-right-radius: 58px;

  box-shadow: inset 8px -40px 15px rgba(0, 0, 0, 0.25);
}
.nav-desktop{
  display: none;
}
.header-desktop{
  display: none;
}

@media(min-width: 700px){
.header-mobile{
  display:flex;
border-radius: 0
}
.header-mobile p {
  display:none;
}
.header-mobile h1{
  display:none;
}
.nav-desktop{
  display:flex;
  /* background:red; */
  padding:16px;
  list-style: none;

}
#header-mobile{
  background: white;
  box-shadow:none;
height: 50px!important;
display: flex;
justify-content: center;
color:green;
;
}
header nav ul{
  list-style: none;
  display: flex; 
  height: 100%;
}
header nav ul li{
    padding: 16px;

}
}

</style>
