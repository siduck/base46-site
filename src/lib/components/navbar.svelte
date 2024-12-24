<script lang="ts">
  import { onMount } from "svelte";

  let theme = $state("dark");

  const toggleTheme = () => {
    theme = theme == "dark" ? "light" : "dark";
    const html = document.querySelector("html");
    if (html) html.className = localStorage.theme = theme;
  };

  onMount(() => theme = localStorage.theme);
</script>

<nav flexrow border="0 b-1 solid slate3 dark:slate7">
  <h2>
    <a href="/">Neovim Themes</a>
  </h2>

  <button
    mlauto
    aria-label="site theme toggle"
    onclick={toggleTheme}
    rounded-full
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
