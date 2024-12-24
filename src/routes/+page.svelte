<script lang="ts">
  import themelist from "../data.json";
  import ThemeCard from "$lib/components/themecard.svelte";
  import  Navbar from "$lib/components/navbar.svelte";

  type ThemeData = {
    name: string;
    variants: string[];
    components: Promise<any>[];
  };

  let themes: ThemeData[] = $state([]);

  const getComponent = async (path: string) => {
    const module = await import(`../lib/vihtml/${path}.svelte`);
    return module.default;
  };

  themes = themelist.map((theme) => {
    return {
      name: theme.name,
      variants: theme.variants,
      components: theme.variants.map((x) => getComponent(x)),
    };
  });

  import "virtual:uno.css";
  import "$lib/css/style.css";
</script>

<main box mxauto p3 grid gap5>
  <Navbar />

  <div grid="~ gap10 cols-2" >
    {#each themes as theme}
      <ThemeCard data={theme} />
    {/each}
  </div>
</main>
