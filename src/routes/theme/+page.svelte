<script lang="ts">
  import { page } from "$app/state";
  import { getComponent, copyToClipboard,   updateQueryParams } from "$lib/utils";
  import ThemeCard from "$lib/components/themecard.svelte";
  import type { ThemeData } from "$lib/types";
  import { store } from "$lib/store.svelte";
  import { genTerminalConfig } from "$lib/configen/terminal";

  const searchParams = page.url.searchParams;
  const theme = searchParams.get("name") || "onedark";
  const terminal = searchParams.get("terminal") || "alacritty";
  const lang = searchParams.get('lang')||'rust'

  let data: ThemeData|undefined = $state();
  let cur_term = $state(terminal);

  const themedata = store.themelist.find((x:any) => x.name == theme);

  data = {
    name: theme,
    component: getComponent(theme + "_" + lang),
    colors: themedata.colors,
    type: themedata.type,
  };

const isLight = (hex:string)=> {
  const rgb = parseInt(hex.slice(1), 16);
  const r = (rgb >> 16) & 0xff;
  const g = (rgb >> 8) & 0xff;
  const b = rgb & 0xff;
  return (r * 0.2126 + g * 0.7152 + b * 0.0722) > 128;
}

  const bg = data.colors.base00;
  const bg2 = data.colors.base02;
  const fg = data.colors.base05;

  const terminals = {
    alacritty: "i-file-icons:alacritty",
    kitty:'i-solar:cat-broken',
    ghostty:'i-mingcute:ghost-fill',
    xresources:'i-si:terminal-fill',
    wezterm:'i-simple-icons:wezterm'
  }

  let terminalConf = $state(genTerminalConfig.alacritty(data.colors))
  let copyIconToggle=$state(true);

  const copyIconClick = () => {
    copyToClipboard(terminalConf);
    copyIconToggle = !copyIconToggle;
    setTimeout(() => {
      copyIconToggle = !copyIconToggle;
    },1000)
  };
</script>

<br/>
<ThemeCard {data} lang={lang} />
<br/>
<br/>

<div grid='~ cols-2 md:cols-4 lg:cols-8  gap5'>
  {#each Object.values(data.colors) as color}
    <div curved text-center p4  style="background: {color}; color :{isLight(color)? "black" :"white" }" >{color}</div>
  {/each}
</div>


<br/>
<h2> Terminal Configs</h2>

<div flex='~ wrap gap3'>
  {#each Object.keys(terminals) as name}
    <button
      class={"capitalize btnalt " + (name == cur_term
      ? "!bg-slate-2 dark:!bg-slate-6"
      : "  dark:!bg-slate-8")}
      border="1px solid slate3 dark:0"
      onclick={() => {
        cur_term = name
        terminalConf= genTerminalConfig[name](data.colors)
        updateQueryParams("terminal",name)
      }}
    >

      <div class={terminals[name]}></div> 
     {name}</button>
  {/each}
</div>

<br/>

<div relative='~' id='terminal-conf'>
  <pre bordered px9 curved style="background: {bg}; color: {fg}">
    {terminalConf}
  </pre>

  <button absolute top-4 right-4 style="background: {bg2}; color: {fg}" onclick={copyIconClick} aria-label='copyButton'>

  <div class={copyIconToggle?  'i-uil:clipboard ' : 'i-line-md:check-all'}></div>
  </button>
</div>
