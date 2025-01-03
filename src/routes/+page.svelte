<script lang="ts">
  import ThemeCard from "$lib/components/themecard.svelte";
  import Navbar from "$lib/components/navbar.svelte";
  import { store } from "$lib/store.svelte";
  import type { ThemeData } from "$lib/types";

  let cur_lang = $state("rust");

  const icons = {
    rust: "i-devicon-rust",
    go: "i-logos:go text-sm",
    elixir: "i-devicon:elixir",
    haskell: "i-devicon:haskell",
    c: "i-devicon:c",
    python: "i-lineicons:python",
    ruby: "i-devicon:ruby",
  };

  let themes: ThemeData[] = $state([]);

  const getComponent = async (theme: string) => {
    const filename = theme + "_" + cur_lang;
    const module = await import(`../lib/vihtml/${filename}.svelte`);
    return module.default;
  };

  $effect(() => {
    themes = store.items.map((theme) => {
      return {
        name: theme.name,
        component: getComponent(theme.name),
      };
    });
  });

  import "virtual:uno.css";
  import "$lib/css/style.css";
</script>

<main box mxauto p5 grid gap5>
  <Navbar />

  <div flexrow>
    {#each Object.keys(icons) as lang}
      <button
        class={"capitalize btnalt " + (lang == cur_lang
        ? "!bg-slate-2 dark:!bg-slate-6"
        : " bg-slate1 dark:!bg-slate-8")}
        border="1px solid slate3 dark:0"
        onclick={() => cur_lang = lang}
      >
        <div class={"text-lg " + icons[lang]}></div> {lang}
      </button>
    {/each}
  </div>

  <div grid="~ gap10 xl:cols-2">
    {#each themes as theme}
      <ThemeCard data={theme} lang={cur_lang} />
    {/each}
  </div>

  <div flexrow my10 mxauto>
    <button onclick={() => store.curindex -= 1}>Prev Page</button>
    <button onclick={() => store.curindex += 1}>Next Page</button>
  </div>
</main>
