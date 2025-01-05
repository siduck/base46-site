import type { ThemeData } from "$lib/types";

import themelist from "../data.json";

interface StoreType {
  curindex: number;
  curlang: string;
  items: ThemeData[];
  themelist: any;
  data: any;
  pagelimit: number;
  curThemeType: "light" | "dark" | "all";
}

export const store: StoreType = $state({
  curindex: 0,
  curlang: "rust",
  items: [],
  themelist: themelist,
  data: themelist,
  pagelimit: 10,
  curThemeType: "dark",
});
