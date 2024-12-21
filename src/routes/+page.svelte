<script lang="ts">
  const files = import.meta.glob('./../lib/vihtml/*')
  import Onedark from '../lib/vihtml/onedark.svelte'

  import 'virtual:uno.css'
  import '../lib/css/style.css'
</script>



<main> 
  <Onedark />
  <!-- here -->
</main>
