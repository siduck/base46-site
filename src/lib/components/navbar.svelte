<script lang="ts">
  import { store } from "$lib/store.svelte";
  import { onMount } from "svelte";
  import type { ThemeData } from "$lib/types";
  import { gethemes, updateQueryParams } from "$lib/utils";
  import { page } from "$app/state";

  let theme = $state("dark");
  const searchParams = page.url.searchParams;

  const toggleTheme = () => {
    theme = theme == "dark" ? "light" : "dark";
    const html = document.querySelector("html");
    if (html) html.className = localStorage.theme = theme;
  };

  onMount(() => theme = localStorage.theme);

  const filterThemes = (str: string) => {
    let tmp: Record<string, boolean> = {};

    const startsArr: ThemeData[] = store.data.filter((theme: ThemeData) => {
      tmp[theme.name] = true;
      return theme.name.startsWith(str.toLowerCase());
    });

    const includesArr: ThemeData[] = store.data.filter((theme: ThemeData) =>
      !tmp[theme.name] && theme.name.includes(str.toLowerCase())
    );

    store.items = [...startsArr, ...includesArr];
  };

  let search = $state(searchParams.get("search")), timeout;
  let loaderIcon = $state(false);

  const handleSearch = (e: any) => {
    clearTimeout(timeout);
    loaderIcon = true;

    timeout = setTimeout(() => {
      search = e.target.value;

      if (search == "" || search == null) {
        gethemes();
        loaderIcon = false;
        updateQueryParams({ search: "" });
        return;
      }
      filterThemes(search);

      if (searchParams.get("search") != search) {
        updateQueryParams({ search });
        loaderIcon = false;
      }
    }, 500);
  };

  onMount(() => {
    if (search) filterThemes(search);
  });

  const themTypes = ["dark", "light", "all"];

  const updateThemeType = (type: string) => {
    store.curThemeType = type;
    updateQueryParams({ type, search: "" });
  };
</script>

<nav flexrow border="0 b-1 solid slate3 dark:slate7" mb6 mx="-5" px5>
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
    class="flexrow gap2 px4 rounded-lg relative"
    ring="focus-within:1 slate5 dark:slate7"
    bg="slate2 dark:black1"
  >
    <div i="iconamoon-search-bold"></div>
    <input
      mlauto
      oninput={handleSearch}
      type="text"
      placeholder="Search themes"
      class="py3 rounded-lg border-0 outline-0"
      bg="slate2 dark:black1"
      text="dark:white"
    />
    <div class="i-eos-icons-loading absolute right-3" hidden={!loaderIcon}>
    </div>
  </div>

  <button
    aria-label="site theme toggle"
    onclick={toggleTheme}
    rounded-full
    bg="black"
  >
    <div
      text-lg
      class={theme == "dark"
      ? "i-line-md-moon-simple-filled"
      : "i-line-md-sun-rising-loop"}
    >
    </div>
  </button>

  <a
    target="_blank"
    class="i-bi:github text-3xl"
    aria-label="github"
    href="https://github.com/siduck/base46-themes"
  >
  </a>
</nav>
