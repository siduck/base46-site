import type { ThemeData } from "$lib/types";

import themelist from "../data.json";

interface StoreType {
  curlang: string;
  items: ThemeData[];
  themelist: any;
  data: any;
  curThemeType: "light" | "dark" | "all";
}

export const store: StoreType = $state({
  curlang: "rust",
  items: [],
  themelist: themelist,
  data: themelist,
  curThemeType: "dark",
});
