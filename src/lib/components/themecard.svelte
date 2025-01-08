<script lang="ts">
  import { getComponent } from "$lib/utils";

  import Stl from "$lib/components/stl.svelte";
  import Skeleton from "$lib/ui/skeleton.svelte";
  import { page } from "$app/state";

  let { data = [], lang = "" }: any = $props();

  let element: HTMLElement;
  let visible = false;

  let component = $state(new Promise(() => {}));
  let componentLoaded = false;
  const componentName = $derived(data.name + "_" + lang);

  $effect(() => {
    const route = page.route.id;

    if (route == "theme") {
      component = getComponent(componentName);
      return;
    }

    componentLoaded = false;

    const observer = new IntersectionObserver(
      ([entry]) => {
        visible = entry.isIntersecting;
        if (visible && !componentLoaded) {
          getComponent(componentName).then((x) => {
            componentLoaded = true;
            component = x;
          });
        }
      },
      { threshold: 0.1 },
    );

    if (element) observer.observe(element);

    return () => {
      if (element) observer.unobserve(element);
    };
  });
</script>

<div class="flexcol [&_section]:bg-red w-full" bind:this={element}>
  <a href={`/theme?name=${data.name}&lang=${lang}`} w-fit>
    <button font-medium capitalize badge bg-sky2 px5 text-black>
      {data.name} <div class="i-line-md:external-link"></div>
    </button>
  </a>

  {#await component}
    <Skeleton css="h-39vh !w-[97%] fade-me" />
  {:then Component}
    <div class="relative">
      <Component />
      <Stl colors={data.colors} {lang} />
    </div>
  {/await}
</div>
