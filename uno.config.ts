import transformerDirectives from "@unocss/transformer-directives";

import {
	defineConfig,
	presetAttributify,
	presetIcons,
	presetTagify,
	presetUno,
} from "unocss";

export default defineConfig({
	presets: [
		presetUno(),
		presetAttributify(),
		presetTagify(),

		presetIcons({ scale: 1.1 }),
	],

	theme: {
		colors: {
      black: {
        DEFAULT: '#131a21',
        1:'#1c2631',
      },
			pale: "#F6F8FB",
		},
	},

	rules: [
		["lighten", { filter: "brightness(1.3)" }],
		["lighten2", { filter: "brightness(1.1)" }],
		["darken", { filter: "brightness(0.95)" }],
		["nocolor", { filter: "brightness(1)" }],
	],

	transformers: [transformerDirectives()],

	shortcuts: {
		box: "2xl:max-w-[80%]",
		badge: "bg-slate-1 p2 px3 rounded-lg w-fit",
		col5: "grid gap5",

		btnglass: "bg-transparent text-black hover:nocolor rounded-none",
		btnalt: `bg-white text-black hover:darken 
            border-1 border-solid border-slate-3`,

		curved: "rounded-lg",
		btnPrimary: "bg-primary text-white",

		card: "bg-white shadow-md curved grid gap5 p5",
		cardF: "bg-white shadow-md curved flex flex-col gap5 p5",
		cardAlt: "bg-slate1 curved grid gap5 p5",

		"full-overlay": `fixed inset-0 z-10 bg-white
                     w-100vw lg:h-100vh p-5 md:p-10
                     overflow-auto`,

		"modal-overlay": "full-overlay opacity-75 bg-black",
		"overlay-parent": "absolute bg-white h-full w-full z-1",

		flexcol: "flex flex-col gap5 lt-md:gap3",
		row: "flex gap3 items-center",
		flexrow: "flex gap3 items-center",
		bordered: "border-1 border-solid border-slate-3 dark:border-slate-7",
		"bordered-b": "border-0 border-b-1 border-solid border-slate-3",
		hline: "border-0 !border-b-1 border-solid border-slate-2",
		col12: "grid gap5 grid-cols-12",

		"fade-me": "animate-fade-in animate-duration-500",
	},
});
