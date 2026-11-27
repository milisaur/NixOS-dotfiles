{...}: let
  p = import ./palette.nix;
  mix = a: b: pct: "color-mix(in srgb, ${a} ${toString pct}%, ${b})";

  vars = ''

    :root {
      --ctp-frappe-crust: ${p.bg};
      --ctp-frappe-mantle: ${mix p.surface p.bg 50};
      --ctp-frappe-base: ${p.surface};

      --ctp-frappe-surface0: ${p.overlay};
      --ctp-frappe-surface1: ${mix p.text p.overlay 8};
      --ctp-frappe-surface2: ${mix p.text p.overlay 16};

      --ctp-frappe-overlay0: ${p.surfaceBright};
      --ctp-frappe-overlay1: ${mix p.subtext p.bg 45};
      --ctp-frappe-overlay2: ${mix p.subtext p.bg 60};

      --ctp-frappe-text: ${p.text};
      --ctp-frappe-subtext1: ${p.subtext};
      --ctp-frappe-subtext0: ${mix p.subtext p.bg 80};

      --ctp-frappe-blue: ${p.accent};
      --ctp-frappe-lavender: ${p.accentLight};
      --ctp-frappe-rosewater: ${p.accent};
      --ctp-frappe-peach: ${p.accentDark};
      --ctp-frappe-green: ${p.success};
      --ctp-frappe-yellow: ${p.warning};
      --ctp-frappe-red: ${p.critical};
      --ctp-frappe-maroon: ${p.criticalBright};
      --ctp-frappe-mauve: ${p.magenta};
      --ctp-frappe-pink: ${p.magentaBright};
      --ctp-frappe-flamingo: ${p.magentaBright};
      --ctp-frappe-teal: ${p.cyan};
      --ctp-frappe-sky: ${p.blueBright};
      --ctp-frappe-sapphire: ${p.blue};

      --light: ${p.text};
      --lighter-grey: ${p.subtext};
      --light-grey: ${mix p.subtext p.bg 60};
    }
  '';

  selection = mix p.accentDark "transparent" 35;

  chromeExtra = ''

    .CodeMirror-selected,
    pre.CodeMirror-line span.CodeMirror-selectedtext,
    pre.cm-jn-code-block.CodeMirror-line span.cm-comment.cm-jn-monospace.CodeMirror-selectedtext,
    pre.cm-jn-code-block.CodeMirror-line::selection,
    div.cm-jn-code-block-background.CodeMirror-linebackground::selection,
    pre.cm-jn-code-block.CodeMirror-line::selection span {
      background: ${selection} !important;
    }

    .cm-fat-cursor-mark {
      background-color: ${mix p.accent "transparent" 50} !important;
    }
  '';

  styleExtra = ''

    @media screen {
      .study-box {
        background: var(--ctp-frappe-surface0);
        border-left-color: var(--ctp-frappe-overlay2);
      }

      .study-box.definition { border-color: ${p.success}; }
      .study-box.merksatz   { border-color: ${p.warning}; }
      .study-box.beispiel   { border-color: ${p.accent}; }
      .study-box.aufgabe    { border-color: ${p.magenta}; }
      .study-box.formel     { border-color: ${p.blue}; }

      .study-box strong {
        color: ${p.text};
      }
    }
  '';
in {
  xdg.configFile."joplin-desktop/userchrome.css".text =
    builtins.readFile ./joplin/userchrome.css + vars + chromeExtra;

  xdg.configFile."joplin-desktop/userstyle.css".text =
    builtins.readFile ./joplin/userstyle.css + vars + styleExtra;
}
