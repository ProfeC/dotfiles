{ pkgs, system }:

pkgs.mkShell {
  packages = [
    pkgs.mkdocs
    pkgs.python312
    pkgs.python312Packages.mkdocs-material
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.noto
    pkgs.virtualenv
  ];

  shellHook = ''
    export PS1="(shu-docs) $PS1"
    echo "📝 Welcome to the shu-docs devShell!"

    # Set up a throwaway venv if one doesn't exist
    if [ ! -d .venv ]; then
      echo "⚙️ Creating Python venv for MkDocs..."
      virtualenv .venv
      .venv/bin/pip install -r requirements.txt || true
    fi

    source .venv/bin/activate
    echo "✅ MkDocs dev environment ready. Run: mkdocs serve"
  '';
}
