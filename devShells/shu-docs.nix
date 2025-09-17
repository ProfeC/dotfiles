{ pkgs, system }:

pkgs.mkShell {
  name = "shu-docs";

  # Python + Nixpkgs packages
  packages = [
    (pkgs.python3.withPackages (ps: with ps; [
      docx2python
      docx2txt
      mammoth
      mkdocs
      mkdocs-material
      mkdocs-glightbox
      tqdm
      virtualenv
    ]))

    pkgs.pandoc
    pkgs.python3Packages.python-docx
    pkgs.python3Packages.html2text

    # Fonts for previews and such
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.noto
    pkgs.nerd-fonts.sauce-code-pro
  ];

  shellHook = ''
    export PS1="(shu-docs) $PS1"
    echo "📝 Welcome to the shu-docs devShell!"

    # Aliases for convenience
    alias docs-serve="mkdocs serve -a 0.0.0.0:8000"
    alias docs-build="mkdocs build"
    alias docs-clean="rm -rf site || true && echo '🧹 Cleaned MkDocs build output'"

    # Ensure a venv exists
    if [ ! -d .venv ]; then
      echo "⚙️ Creating Python venv for MkDocs..."
      virtualenv .venv
    fi

    source .venv/bin/activate

    # Install remaining MkDocs plugins that aren't in Nixpkgs
    pip install --upgrade pip
    pip install \
      mkdocs-callouts \
      mkdocs-drawio \
      mkdocs-include \
      mkdocs-obsidian-bridge \
      mkdocs-obsidian-support-plugin \
      mkdocs-obsidian-interactive-graph-plugin \
      mkdocs-pygments \
      --quiet

    echo "✅ MkDocs dev environment ready. Running: docs-serve"
  '';
}
