<script lang="ts">
  const files = import.meta.glob('./../lib/vihtml/*', { eager: true });

  const mappedComponents = Object.entries(files).map(([path, module]) => {
    const name = path.split('/').pop().split('.')[0];

    return {
        name: name,
        Component: module.default
    };
});

  import Onedark from '../lib/vihtml/onedark.svelte'

  import 'virtual:uno.css'
  import '../lib/css/style.css'
</script>



<main> 

  <section grid='~ gap10 cos-3' p10> 

  {#each mappedComponents as { name, Component }}
        <Component />
{/each}
  </section>

  <!-- here -->
</main>
