{
  bash,
  nix-gitignore,
  python39Packages,
  writers
}:
let
  helpers = import ./helpers.nix { inherit bash python39Packages writers; };
  pythonPackages = python39Packages;

in pythonPackages.buildPythonApplication {
  version = "0.1.0";
  pname = "flatten-references-graph";

  # Note: this uses only ./src/.gitignore
  src = nix-gitignore.gitignoreSource [] ./src;

  propagatedBuildInputs = with pythonPackages; [
    python-igraph
    toolz
  ];

  doCheck = true;

  checkPhase = ''
    ${helpers.lint}/bin/lint
    ${helpers.unittest}/bin/unittest
  '';
}
