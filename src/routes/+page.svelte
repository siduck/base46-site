<script lang="ts">
  import ThemeCard from "$lib/components/themecard.svelte";
  import { store } from "$lib/store.svelte";
  import { page } from "$app/state";
  import { gethemes, updateQueryParams } from "$lib/utils";

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

  $effect(() => {
    const search = page.url.searchParams.get("search");
    store.curThemeType = page.url.searchParams.get("type") || "dark";
    if (search) return;
    gethemes();
  });

  const updateLang = (lang: string) => {
    cur_lang = lang;
    updateQueryParams({ lang, search: "" });
  };
</script>

<div flexrow mb5>
  {#each Object.keys(icons) as lang}
    <button
      class={"capitalize btnalt " + (lang == cur_lang
      ? "!bg-slate-2 dark:!bg-slate-6"
      : " bg-slae1 dark:!bg-slate-8")}
      border="1px solid slate3 dark:0"
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
