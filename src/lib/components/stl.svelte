<script lang="ts">
  let { colors, lang } = $props();

  import {fileExtensions} from "$lib/utils";
  const ext = fileExtensions[lang];
</script>

<div 
  style='background: {colors.base01}; color: {colors.base07}'
  un-children='p1'
  class='flex w-full bottom-6 absolute items-center gap2 code-font '
>
  <span style="color: {colors.base01}; background: {colors.base0D}" px2>
    NORMAL
  </span>

  <span style="color: {colors.base0D}"   >code{ext}</span> 

  <span style="color: {colors.base07}" op50 class='i-bx:git-branch text-[9px]'></span>
  <span style="color: {colors.base07}" op50 ml='-2'>main</span>
  <span style="color: {colors.base0D}" ml-auto> unix </span>
  <span class='i-line-md:folder-twotone text-[9px]'></span>
  <span ml='-1'>base46</span>
  <span pr3> utf-8 </span>
</div>
