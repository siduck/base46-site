import type { ThemeData } from "$lib/types";

import themelist from "../data.json";

interface StoreType {
  curindex: number;
  items: ThemeData[];
  data: any;
}

export const store: StoreType = $state({
  curindex: 0,
  items: [],
  data: themelist,
});
