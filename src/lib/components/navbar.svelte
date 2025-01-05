<script lang="ts">
  import { store } from "$lib/store.svelte";
  import { onMount } from "svelte";
  import type { ThemeData } from "$lib/types";
  import { updateQueryParams } from "$lib/utils";

  let theme = $state("dark");

  const toggleTheme = () => {
    theme = theme == "dark" ? "light" : "dark";
    const html = document.querySelector("html");
    if (html) html.className = localStorage.theme = theme;
  };

  onMount(() => theme = localStorage.theme);

  let searchValue = $state("");
  //
  //$effect(() => {
  //  store.items = store.data.filter((theme: ThemeData) => {
  //    return theme.name.toLowerCase().startsWith(searchValue.toLowerCase());
  //  }).slice(store.curindex, (store.curindex + 1) * store.pagelimit);
  //});

  const themTypes = ["dark", "light", "all"];

  const updateThemeType = (type: string) => {
    store.curThemeType = type;
    updateQueryParams("type", type);
  };
</script>

<nav flexrow border="0 b-1 solid slate3 dark:slate7">
  <h2>
    <a href="/">Base46 Themes</a>
  </h2>

  <div
    class="flex gap1 mlauto bordered p1 curved"
    un-children="bg-white text-black dark:bg-black"
  >
    {#each themTypes as type}
      <button
        class={store.curThemeType == type
        ? "!bg-indigo text-white dark:text-black  dark:!bg-black2"
        : ""}
        Capitalize
        onclick={() => updateThemeType(type)}
      >
        {type}
      </button>
    {/each}
  </div>

  <div
    class="flexrow gap2 px4 rounded-lg"
    ring="focus-within:1 slate5 dark:slate7"
    bg="slate2 dark:black1"
  >
    <div i="iconamoon-search-bold"></div>
    <input
      mlauto
      bind:value={searchValue}
      type="text"
      placeholder="Search themes"
      class="py3 rounded-lg border-0 outline-0"
      bg="slate2 dark:black1"
    />
  </div>

  <button
    aria-label="site theme toggle"
    onclick={toggleTheme}
    rounded-full
    bg='black'
  >
    <div
      text-lg
      class={theme == "dark"
      ? "i-line-md-moon-simple-filled"
      : "i-line-md-sun-rising-loop"}
    >
    </div>
  </button>
</nav>
