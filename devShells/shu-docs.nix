{ pkgs, system }:

let
  pythonEnv = pkgs.python312.withPackages (ps: with ps; [
    mkdocs
    mkdocs-material
    mkdocs-callouts
    mkdocs-glightbox
    mkdocs-obsidian-bridge
    mkdocs-obsidian-support-plugin
    mkdocs-obsidian-interactive-graph-plugin
  ]);
in

pkgs.mkShell {
  packages = [
    pythonEnv

    # Fonts
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.noto
    pkgs.nerd-fonts.source-code-pro

    # Make sure we have access to Obsidian, just in case
    pkgs.obsidian
  ];

  shellHook = ''
    export PS1="(shu-docs) $PS1"
    echo "📝 Welcome to the shu-docs devShell!"

    # Make Python see all plugins
    export PYTHONPATH=${pythonEnv}/${pythonEnv.sitePackages}:$PYTHONPATH

    # Set default docs directory (adjust as needed)
    export MKDOCS_DIR="$PWD/docs"

    # Aliases for convenience
    alias docs-serve="mkdocs serve -f \$MKDOCS_DIR/mkdocs.yml -a 0.0.0.0:8000"
    alias docs-build="mkdocs build -f \$MKDOCS_DIR/mkdocs.yml -d \$MKDOCS_DIR/site"
    alias docs-clean="rm -rf \$MKDOCS_DIR/site || true && echo '🧹 Cleaned MkDocs build output'"

    echo "✅ MkDocs dev environment ready. Docs directory: \$MKDOCS_DIR"
  '';
}
