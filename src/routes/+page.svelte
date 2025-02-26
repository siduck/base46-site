<script lang="ts">
  import ThemeCard from "$lib/components/themecard.svelte";
  import LangBtns from "$lib/components/langbtns.svelte";
  import { store } from "$lib/store.svelte";
  import { page } from "$app/state";
  import { changeBodyColors, gethemes } from "$lib/utils";
  import { onMount } from "svelte";

  const searchParams = $derived(page.url.searchParams);

  $effect(() => {
    store.curThemeType = searchParams.get("type") || "dark";
    if (searchParams.get("search")) return;
    gethemes();
  });

  onMount(() => {
    const theme = localStorage.theme;

    if (theme == "dark") {
      changeBodyColors("#131a21", "white");
      return;
    }

    changeBodyColors("#ffffff", "#000000");
  });
</script>

<LangBtns />

<div grid="~ gap-x-8 gap-y-6 xl:cols-2">
  {#each store.items as data}
    <ThemeCard {data} />
  {/each}
</div>
