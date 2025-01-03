<script>
  let { children } = $props();
  import Navbar from "$lib/components/navbar.svelte";
</script>

<main box mxauto p5 grid>
  <Navbar />
  {@render children()}
</main>
