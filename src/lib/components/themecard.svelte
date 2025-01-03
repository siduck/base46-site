<script lang="ts">
  import Skeleton from "$lib/ui/skeleton.svelte";

  let { data = [], lang = "" }: any = $props();
</script>

<div class="flexcol [&_section]:bg-red">
  <a href={`/theme?name=${data.name}&lang=${lang}`}>
    <button font-medium capitalize badge bg-blue2 px5 text-black>
      {data.name}
    </button>
  </a>

  {#await data.component}
    <Skeleton css="h-200px" />
  {:then Component}
    <Component />
  {/await}
</div>
