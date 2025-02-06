<script lang="ts">
  import ThemeCard from "$lib/components/themecard.svelte";
  import { store } from "$lib/store.svelte";
  import { page } from "$app/state";
  import {
    changeBodyColors,
    gethemes,
    updateQueryParams,
  } from "$lib/utils";
  import { onMount } from "svelte";

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

  const searchParams = $derived(page.url.searchParams);

  $effect(() => {
    store.curThemeType = searchParams.get("type") || "dark";
    if (searchParams.get("search")) return;
    gethemes();
  });

  const updateLang = (lang: string) => {
    cur_lang = lang;
    updateQueryParams({ lang, search: "" });
  };

  onMount(() => {
    const theme = localStorage.theme;

    if (theme == "dark") {
      changeBodyColors("#131a21", "white", "#000000");
      return;
    }

    changeBodyColors("#ffffff", "#000000", "#000000");
  });
</script>

<div flexrow mb5>
  {#each Object.keys(icons) as lang}
    <button
      class={"capitalize " + (lang == cur_lang ? "btnactive" : "btntint")}
      onclick={() => updateLang(lang)}
    >
      <div class={"text-lg " + icons[lang]}></div> {lang}
    </button>
  {/each}
</div>

<div grid="~ gap-x-8 gap-y-6 xl:cols-2">
  {#each store.items as data}
    <ThemeCard {data} lang={cur_lang} />
  {/each}
</div>
