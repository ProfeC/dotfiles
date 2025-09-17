{ pkgs, system }:

let
  python = pkgs.python312;
in pkgs.mkShell {
  name = "python-devshell";

  buildInputs = [
    python
    python.pkgs.pip
    python.pkgs.setuptools
    python.pkgs.virtualenv
    python.pkgs.black
    python.pkgs.flake8
    python.pkgs.mypy
    python.pkgs.pytest
  ];

  shellHook = ''
    export PS1="(Python Dev Shell) $PS1"
    echo "✅ Welcome to the Python devShell!"
    echo "Python version: ${python.interpreter}"
    export PYTHONPATH=${pkgs.python312.sitePackages}
    
    # Aliases for convenience
    # alias some-alias="some command"
  '';
}
