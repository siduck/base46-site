<script lang="ts">
  import ThemeCard from "$lib/components/themecard.svelte";
  import { store } from "$lib/store.svelte";
  import type { ThemeData } from "$lib/types";
  import { getComponent } from "$lib/utils";

  let cur_lang = $state("rust");

  const icons: any = {
    rust: "i-devicon-rust",
    go: "i-file-icons:go-old",
    elixir: "i-devicon:elixir",
    haskell: "i-devicon:haskell",
    c: "i-devicon:c",
    python: "i-lineicons:python",
    ruby: "i-devicon:ruby",
    typescript: "i-devicon:typescript",
    sh: "i-line-md:hash",
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
</script>

<br />

<div flexrow>
  {#each Object.keys(icons) as lang}
    <button
      class={"capitalize btnalt " + (lang == cur_lang
      ? "!bg-slate-2 dark:!bg-slate-6"
      : " bg-slae1 dark:!bg-slate-8")}
      border="1px solid slate3 dark:0"
      onclick={() => cur_lang = lang}
    >
      <div class={"text-lg " + icons[lang]}></div> {lang}
    </button>
  {/each}
</div>

<br />

<div grid="~ gap-x-8 gap-y-6 xl:cols-2">
  {#each themes as data}
    <ThemeCard {data} lang={cur_lang} />
  {/each}
</div>

<div flexrow my10 mxauto>
  <button onclick={() => store.curindex -= 1}>Prev Page</button>
  <button onclick={() => store.curindex += 1}>Next Page</button>
</div>
