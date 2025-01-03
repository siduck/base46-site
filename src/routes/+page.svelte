<script lang="ts">
  import ThemeCard from "$lib/components/themecard.svelte";
  import { store } from "$lib/store.svelte";
  import type { ThemeData } from "$lib/types";
  import { getComponent } from "$lib/utils";

  let cur_lang = $state("rust");

  const icons: any = {
    rust: "i-devicon-rust",
    go: "i-logos:go text-sm",
    elixir: "i-devicon:elixir",
    haskell: "i-devicon:haskell",
    c: "i-devicon:c",
    python: "i-lineicons:python",
    ruby: "i-devicon:ruby",
    javascript: "i-devicon:javascript",
  };

  let themes: ThemeData[] = $state([]);

  $effect(() => {
    themes = store.items.map((theme) => {
      return {
        name: theme.name,
        component: getComponent(theme.name + "_" + cur_lang),
        colors: theme.colors,
        type: theme.type,
      };
    });
  });

  import "virtual:uno.css";
  import "$lib/css/style.css";
</script>

<br/>
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

<br/>
<div grid="~ gap10 xl:cols-2">
  {#each themes as data}
    <ThemeCard {data} />
  {/each}
</div>

<div flexrow my10 mxauto>
  <button onclick={() => store.curindex -= 1}>Prev Page</button>
  <button onclick={() => store.curindex += 1}>Next Page</button>
</div>
