// @ts-nocheck

const base16order = [
  "base00",
  "base01",
  "base02",
  "base03",
  "base04",
  "base05",
  "base06",
  "base07",
  "base08",
  "base09",
  "base0A",
  "base0B",
  "base0C",
  "base0D",
  "base0E",
  "base0F",
];

const alacritty = (colors) => {
  let config = "";

  const format = (color, name) => `${name} = "${color}"`;

  // Generate primary colors section
  config += `[colors.primary]\n`;
  config += format(colors.base00, "background") + "\n";
  config += format(colors.base05, "foreground") + "\n";
  config += format(colors.base04, "dim_foreground") + "\n";
  config += format(colors.base06, "bright_foreground") + "\n\n";

  // Generate cursor colors section
  config += `[colors.cursor]\n`;
  config += format(colors.base00, "text") + "\n";
  config += format(colors.base05, "cursor") + "\n\n";

  // Generate vi_mode_cursor section
  config += `[colors.vi_mode_cursor]\n`;
  config += format(colors.base00, "text") + "\n";
  config += format(colors.base05, "cursor") + "\n\n";

  // Generate search matches section
  config += `[colors.search.matches]\n`;
  config += format(colors.base00, "foreground") + "\n";
  config += format(colors.base0B, "background") + "\n\n";

  // Generate focused match section
  config += `[colors.search.focused_match]\n`;
  config += format(colors.base00, "foreground") + "\n";
  config += format(colors.base0D, "background") + "\n\n";

  // Generate footer bar section
  config += `[colors.footer_bar]\n`;
  config += format(colors.base00, "foreground") + "\n";
  config += format(colors.base0B, "background") + "\n\n";

  // Generate hints start section
  config += `[colors.hints.start]\n`;
  config += format(colors.base00, "foreground") + "\n";
  config += format(colors.base0A, "background") + "\n\n";

  // Generate hints end section
  config += `[colors.hints.end]\n`;
  config += format(colors.base00, "foreground") + "\n";
  config += format(colors.base09, "background") + "\n\n";

  // Generate selection section
  config += `[colors.selection]\n`;
  config += format(colors.base00, "text") + "\n";
  config += format(colors.base05, "background") + "\n\n";

  // Generate normal colors section
  config += `[colors.normal]\n`;
  config += format(colors.base00, "black") + "\n";
  config += format(colors.base08, "red") + "\n";
  config += format(colors.base0B, "green") + "\n";
  config += format(colors.base0A, "yellow") + "\n";
  config += format(colors.base0D, "blue") + "\n";
  config += format(colors.base0E, "magenta") + "\n";
  config += format(colors.base0C, "cyan") + "\n";
  config += format(colors.base05, "white") + "\n\n";

  // Generate bright colors section
  config += `[colors.bright]\n`;
  config += format(colors.base03, "black") + "\n";
  config += format(colors.base08, "red") + "\n";
  config += format(colors.base0B, "green") + "\n";
  config += format(colors.base0A, "yellow") + "\n";
  config += format(colors.base0D, "blue") + "\n";
  config += format(colors.base0E, "magenta") + "\n";
  config += format(colors.base0C, "cyan") + "\n";
  config += format(colors.base06, "white") + "\n";

  // Indexed colors (if present)
  if (colors.base0F) {
    config += `[[colors.indexed_colors]]\n`;
    config += `index = 16\n`;
    config += `color = "${colors.base0F}"\n`;
  }

  return `\n${config}\n`;
};

const kitty = (colors) => {
  let config = "";

  const format = (color, name) => `${name} ${color}`;

  config += format(colors.base00, "background") + "\n";
  config += format(colors.base05, "foreground") + "\n";
  config += format(colors.base03, "cursor") + "\n";
  config += format(colors.base07, "cursor_text") + "\n\n";

  // Add normal colors
  config += format(colors.base00, "color0") + "\n";
  config += format(colors.base08, "color1") + "\n";
  config += format(colors.base0B, "color2") + "\n";
  config += format(colors.base0A, "color3") + "\n";
  config += format(colors.base0D, "color4") + "\n";
  config += format(colors.base0E, "color5") + "\n";
  config += format(colors.base0C, "color6") + "\n";
  config += format(colors.base05, "color7") + "\n\n";

  // Add bright colors
  config += format(colors.base03, "color8") + "\n";
  config += format(colors.base08, "color9") + "\n";
  config += format(colors.base0B, "color10") + "\n";
  config += format(colors.base0A, "color11") + "\n";
  config += format(colors.base0D, "color12") + "\n";
  config += format(colors.base0E, "color13") + "\n";
  config += format(colors.base0C, "color14") + "\n";
  config += format(colors.base06, "color15") + "\n";

  // Add indexed colors (if any)
  if (colors.base0F) {
    config += format(colors.base0F, "color16");
  }

 return `\n${config}\n`;
};

const ghostty = (colors) => {
  const format = (color, name) => `${name} = ${color}`;

  let config = "";

  const paletteOrder = [
    "base00", "base08", "base0B", "base0A", "base0D", "base0E", "base0C", "base05",
    "base03", "base08", "base0B", "base0A", "base0D", "base0E", "base0C", "base06"
  ];

  // Generate palette colors for base00 to base0F (0 to 15)
  paletteOrder.forEach((colorKey, i) => {
    config += `palette = ${i}=${colors[colorKey]}\n`;
  });

  // Generate background, foreground, cursor, and selection colors
  config += format(colors.base00, "background") + "\n";
  config += format(colors.base05, "foreground") + "\n";
  config += format(colors.base0D, "cursor-color") + "\n";
  config += format(colors.base03, "selection-background") + "\n";
  config += format(colors.base05, "selection-foreground");

  // Add newline for readability
  return `\n${config}\n`;
};

const xresources = (colors) => {
  const format = (name, value) => `${name}: ${value}`;

  let config = "";

  base16order.forEach((colorKey, i) => {
    if (colors[colorKey]) {
      config += format(`*.color${i}`, colors[colorKey]) + "\n";
    }
  });

  config += format("*.background", colors.base00) + "\n";
  config += format("*.foreground", colors.base05) + "\n";
  config += format("*.cursorColor", colors.base05) + "\n";
  config += format("*.highlightForeground", colors.base05) + "\n";
  config += format("*.highlightBackground", colors.base03);

  // Add newline for readability
  return `\n${config}\n`;
};

export const genTerminalConfig = {
  alacritty,
  kitty,
  ghostty,
  xresources,
};
