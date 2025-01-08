import { page } from "$app/state";
import themelist from "../data.json";
import { goto } from "$app/navigation";
import { store } from "$lib/store.svelte";

export const getComponent = async (name: string) => {
  const module = await import(`../lib/vihtml/${name}.svelte`);
  return module.default;
};

export const copyToClipboard = (text: string) => {
  navigator.clipboard.writeText(text).then(() => {
    console.log("Text copied to clipboard!");
  }).catch((err) => {
    console.error("Failed to copy text: ", err);
  });
};

export const fileExtensions = {
  rust: ".rs",
  go: ".go",
  elixir: ".ex",
  haskell: ".hs",
  c: ".c",
  python: ".py",
  ruby: ".rb",
  typescript: ".ts",
  sh: ".sh",
};

export const updateQueryParams = (obj: Record<string, string>) => {
  const url = new URL(page.url);

  Object.keys(obj).forEach((key) => {
    if (obj[key] == '') url.searchParams.delete(key);
    else url.searchParams.set(key, obj[key]);
  });

  goto(url, { noScroll: true });
};

export const deleteQueryParams = (obj: Record<string, string>) => {
  const url = new URL(page.url);

  Object.keys(obj).forEach((key) => {
    url.searchParams.delete(key);
  });

  goto(url, { noScroll: true });
};

export const gethemes = () => {
  let tmp = themelist;

  if (store.curThemeType == "light") {
    tmp = tmp.filter((x) => x.type == "light");
  } else if (store.curThemeType == "dark") {
    tmp = tmp.filter((x) => x.type == "dark");
  }

  store.items = tmp.map((theme) => ({
    name: theme.name,
    colors: theme.colors,
    type: theme.type,
  }));
};
