<script lang="ts">
  let { css, bg } = $props();
</script>

<div
  class={`p3 w-full h-100px curved ${css}`}
  animate="pulse"
  style="background: {bg}"
>
</div>
