{
  cataclysm-dda-git,
  fetchFromGitHub,
}:
cataclysm-dda-git.overrideAttrs (old: {
  version = "2024-09-07-0110-experimental";

  src = fetchFromGitHub {
    owner = "CleverRaven";
    repo = "Cataclysm-DDA";
    rev = "cdda-experimental-2024-09-07-0110";
    sha256 = "sha256-eenBpUkR+boB9+q7YBCekeOADCWCwlKnxnnVWaaKX9g=";
  };

  patches = [
  ];
})
