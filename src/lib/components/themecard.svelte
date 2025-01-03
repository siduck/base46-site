<script lang="ts">
  import Skeleton from "$lib/ui/skeleton.svelte";

  let { data = [], lang = "" }: any = $props();
</script>

<div class="flexcol [&_section]:bg-red">
  <span font-medium capitalize badge bg-blue2 px5>
    {data.name}</span>

  {#await data.component}
    <Skeleton css="h-200px" />
  {:then Component}
    <Component />
  {/await}
</div>
