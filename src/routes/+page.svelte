<script lang="ts">
  import themelist from "../data.json";
  import ThemeCard from "$lib/components/themecard.svelte";
  import Navbar from "$lib/components/navbar.svelte";

  type ThemeData = {
    name: string;
    variants: string[];
    components: Promise<any>[];
  };

  let languages = ["rust", "elixir", "go", "python", "c", "haskell"];
  let cur_lang = $state("rust");

  const icons = {
    rust: "i-mdi:language-rust",
    go: "i-logos:go text-sm",
    elixir: "i-devicon:elixir",
    haskell: "i-devicon:haskell",
    c: "i-devicon:c",
    python: "i-lineicons:python",
  };

  let themes: ThemeData[] = $state([]);

  const getComponent = async (theme: string) => {
    const filename = theme + "_" + cur_lang;
    const module = await import(`../lib/vihtml/${filename}.svelte`);
    return module.default;
  };

  $effect(() => {
    themes = themelist.map((theme) => {
      return {
        name: theme.name,
        variants: theme.variants,
        components: theme.variants.map((x) => getComponent(x)),
      };
    });
  });

  import "virtual:uno.css";
  import "$lib/css/style.css";
</script>

<main box mxauto p5 grid gap5>
  <Navbar />

  <div flexrow>
    {#each languages as lang}
      <button
        class={"capitalize btnalt " + (lang == cur_lang ? "!bg-slate-2" : "")}
        onclick={() => cur_lang = lang}
      >
        <div class={"text-lg " + icons[lang]}></div> {lang}
      </button>
    {/each}
  </div>

  <div grid="~ gap-x-10 xl:cols-2">
    {#each themes as theme}
      <ThemeCard data={theme} lang={cur_lang} />
    {/each}
  </div>
</main>
