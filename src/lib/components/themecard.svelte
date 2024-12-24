<script lang="ts">
  import Skeleton from "$lib/ui/skeleton.svelte";

  let index = $state(0);
  let { data = [], lang = "" }: any = $props();
</script>

<div class="flexcol [&_section]:bg-red">
  <span font-medium text-xl class="capitalize px5">{data.variants[index]}</span>

  {#await data.components[index]}
    <Skeleton css="h-200px" />
  {:then Component}
    <Component />

    <div flexrow mt3 ml-auto hidden={data.variants.length == 1}>
      {#each data.variants as variant, i}
        <button
          aria-label={variant + " theme switcher"}
          border="3 solid slate3 dark:slate7"
          onclick={() => index = i}
          class={`${variant + "_" + lang} boxbg p3 rounded-full`}
        >
        </button>
      {/each}
    </div>
  {/await}
</div>
