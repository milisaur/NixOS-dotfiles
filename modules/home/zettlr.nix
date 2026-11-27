{...}: let
  p = import ./palette.nix;
  mix = a: b: pct: "color-mix(in srgb, ${a} ${toString pct}%, ${b})";

  from = [
    "#0d0f10"
    "#111315"
    "#151719"
    "#17191c"
    "#252a2e"
    "#33393e"
    "#d7dce0"
    "#c5cbd0"
    "#b3bbc0"
    "#9ca5ab"
    "#91b8a1"
    ''"Noto Sans"''
    ''"JetBrains Mono"''
  ];

  to = [
    p.bg
    (mix p.surface p.bg 40)
    (mix p.surface p.bg 70)
    p.surface
    p.overlay
    (mix p.accentDark "transparent" 35)
    p.text
    (mix p.text p.subtext 60)
    p.subtext
    (mix p.subtext p.bg 80)
    p.accent
    ''"${p.font}"''
    ''"${p.font}"''
  ];

  extra = ''

    :root, body, body.dark {
      --system-accent-color: ${p.accent} !important;
      --system-accent-color-contrast: ${p.bg} !important;
    }

    body.dark input {
      background-color: ${p.surface} !important;
      color: ${p.text} !important;
      border-color: ${p.overlay} !important;
    }

    body.dark .tab-container,
    body.dark .tab-container .document {
      background-color: ${p.surface} !important;
      color: ${p.subtext} !important;
      border-color: ${p.overlay} !important;
    }

    body.dark .tab-container .document.active {
      background-color: ${p.bg} !important;
      color: ${p.text} !important;
      border-bottom: 2px solid ${p.accent} !important;
    }

        body.dark .cm-editor .cm-strong {
      color: ${p.accentLight} !important;
    }

    body.dark .cm-editor .cm-emphasis {
      color: ${p.subtext} !important;
    }

  '';
in {
  xdg.configFile."Zettlr/custom.css".text =
    builtins.replaceStrings from to (builtins.readFile ./zettlr/custom.css) + extra;
}
