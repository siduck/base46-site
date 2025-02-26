<script lang="ts">
  import { page } from "$app/state";
  import { updateQueryParams } from "$lib/utils";

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

  const searchParams = page.url.searchParams;
  let lang = $state(searchParams.get("lang") || "rust");

  const updateLang = (v: string) => {
    updateQueryParams({ lang: v, search: "" });
    lang = v;
  };
</script>

<div flexrow mb5>
  {#each Object.keys(icons) as x}
    <button
      class={"capitalize " + (x == lang ? "btnactive" : "btntint")}
      onclick={() => updateLang(x)}
    >
      <div class={"text-lg " + icons[x]}></div>
      {x}
    </button>
  {/each}
</div>
