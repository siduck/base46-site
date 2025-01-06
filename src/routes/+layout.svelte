<script>
  import "virtual:uno.css";
  import "$lib/css/style.css";

  let { children } = $props();
  import Navbar from "$lib/components/navbar.svelte";
</script>

<main mxauto px5 grid>
  <Navbar />
  {@render children()}
</main>
