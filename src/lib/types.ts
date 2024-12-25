export interface ThemeData {
  name: string;
  variants: string[];
  components?: Promise<any>[];
}
