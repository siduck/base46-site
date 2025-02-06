<script lang="ts">
  import { store } from "$lib/store.svelte";
  import { onMount } from "svelte";
  import type { ThemeData } from "$lib/types";
  import { gethemes, updateQueryParams, changeBodyColors } from "$lib/utils";
  import { page } from "$app/state";

  let theme = $state("dark");
  const searchParams = page.url.searchParams;

  const toggleTheme = () => {
    theme = theme == "dark" ? "light" : "dark";
    const html = document.querySelector("html");
    if (html) html.className = localStorage.theme = theme;

  if(theme == 'light') changeBodyColors('#ffffff', '#131a21')
  else changeBodyColors('#131a21', '#ffffff')

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

<nav flexrow class='bordered-b' mb6 mx="-5" px5>
  <h2>
    <a href="/">Base46 Themes</a>
  </h2>

  <div
    class="flex gap1 mlauto bordered p1 curved"
  >
    {#each themTypes as type}
      <button
        class={store.curThemeType == type ? "btnactive" : "btntint"}
        Capitalize
        onclick={() => updateThemeType(type)}
      >
        {type}
      </button>
    {/each}
  </div>

  <div
    class="flexrow gap2 px4 rounded-lg relative searchInput"
    ring="focus-within:1 slate5 dark:slate7"
    bg="#f0f0f0 dark:[#222930]"
  >
    <div i="iconamoon-search-bold"></div>
    <input
      mlauto
      oninput={handleSearch}
      type="text"
      placeholder="Search themes"
      class="py3 rounded-lg border-0 outline-0"
      bg="transparent"
      text="dark:white"
    />
    <div class="i-eos-icons-loading absolute right-3" hidden={!loaderIcon}>
    </div>
  </div>

  <button
    aria-label="site theme toggle"
    onclick={toggleTheme}
    class='btnactive rounded-full'
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
