<script lang="ts">
  import themelist from "../data.json";

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

<main>
  <section grid="~ gap5 cols-2" p10>
    {#each themes as theme (theme.name)}
      {#await theme.components[0]}
        <p>Loading...</p>
      {:then Component}
        <Component />
      {/await}
    {/each}
  </section>
</main>
