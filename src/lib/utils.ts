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
