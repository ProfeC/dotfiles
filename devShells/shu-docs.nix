{ inputs, ... }:
{ system }:
let
  pkgs = inputs.nixpkgs.legacyPackages."${system}";
in
pkgs.mkShell
{
  packages = [
    pkgs.mkdocs
    pkgs.python
    pkgs.python312Packages.mkdocs-material
    pkgs.obsidian
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.noto
    pkgs.virtualenv
  ];
  
  shellHook = ''
    # Set up a throwaway venv if one doesn't exist
    if [ ! -d .venv ]; then
      echo "⚙️ Creating Python venv for MkDocs..."
      virtualenv .venv
      .venv/bin/pip install -r requirements.txt
    fi
    source .venv/bin/activate
    echo "✅ MkDocs dev environment ready. Run: mkdocs serve"
  '';
}
