<script lang="ts">
  import Skeleton from "$lib/ui/skeleton.svelte";

  let { data = [], lang = "" }: any = $props();
</script>

<div class="flexcol [&_section]:bg-red">

  {#await data.component}
    <Skeleton css="h-200px" />
  {:then Component}
    <Component />
  {/await}
</div>
