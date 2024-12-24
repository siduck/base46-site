<script lang="ts">
  let index = $state(0);
  let { data = [] }: any = $props();
</script>

<div class="flexcol">
  <span font-medium text-xl class="capitalize  px5">{
    data.variants[index]
  }</span>

  {#await data.components[index]}
    <p>Loading...</p>
  {:then Component}
    <Component />

    <div flexrow mt3 ml-auto hidden={data.variants.length == 1}>
      {#each data.variants as variant, i}
        <button
          aria-label={variant + " theme switcher"}
          border="3 solid slate3 dark:slate7"
          onclick={() => index = i}
          class={`${variant} boxbg p3 rounded-full`}
        >
        </button>
      {/each}
    </div>
  {/await}
</div>
