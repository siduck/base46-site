import { page } from "$app/state";
import themelist from "../data.json";
import { goto } from "$app/navigation";
import { store } from "$lib/store.svelte";

export const getComponent = async (name: string) => {
	const module = await import(`../lib/vihtml/${name}.svelte`);
	return module.default;
};

export const copyToClipboard = (text: string) => {
	navigator.clipboard
		.writeText(text)
		.then(() => {
			console.log("Text copied to clipboard!");
		})
		.catch((err) => {
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
		if (obj[key] == "") url.searchParams.delete(key);
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

const lightenColor = (color:string, percent:number) => {
	let num = parseInt(color.replace(/^#/, ""), 16),
		amt = Math.round(2.55 * percent),
		R = Math.min(255, Math.max(0, (num >> 16) + amt)),
		G = Math.min(255, Math.max(0, ((num >> 8) & 0xff) + amt)),
		B = Math.min(255, Math.max(0, (num & 0xff) + amt));

	return `#${((R << 16) | (G << 8) | B).toString(16).padStart(6, "0")}`;
};

const isLightColor = (hex:string) => {
	let c = hex
		.replace(/^#/, "")
		.match(/.{2}/g)
		.map((h) => parseInt(h, 16));
	return 0.2126 * c[0] + 0.7152 * c[1] + 0.0722 * c[2] > 127.5;
};

export const changeBodyColors = (bg: string, fg: string) => {
	const lightbg = isLightColor(bg);
	const intensity = lightbg ? -1 : 1;

	document.querySelector("html").className = lightbg ? "light" : "dark";

	const inputEl = document.querySelector(".searchInput");
	inputEl.style.backgroundColor = lightenColor(bg, 6 * intensity);

	const borderColor = lightenColor(bg, 20 * intensity);

	const styles = `
     body { background-color: ${bg} !important ; color: ${fg} !important }
    .bordered , .bordered-b { border-color: ${borderColor} !important }
    .btnactive { background: ${lightenColor(bg, 15 * intensity)} !important}
    .btntint { background: ${lightenColor(bg, 6 * intensity)} !important }
    .termcode { color: ${fg}; background: ${lightenColor(bg, 5 * intensity)} !important}
`;

	const styleSheet = document.createElement("style");
	styleSheet.textContent = styles;
	document.head.appendChild(styleSheet);
};
