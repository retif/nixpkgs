{
  lib,
  rustPlatform,
  fetchFromGitHub,
  makeBinaryWrapper,
  gitMinimal,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nixpkgs-cache-status";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "retif";
    repo = "nixpkgs-cache-status";
    tag = "v${finalAttrs.version}";
    hash = "sha256-CtdjGls7SqkX0JILs2DWufpsW1/swasKA+LJUemf2KE=";
  };

  cargoHash = "sha256-FtZfPk2vZ0KkCWF9S0MjZ1g+/VARWI1wvCs4ZlmH85A=";

  nativeBuildInputs = [ makeBinaryWrapper ];

  postInstall = ''
    wrapProgram $out/bin/nixpkgs-cache-status \
      --prefix PATH : ${lib.makeBinPath [ gitMinimal ]}
  '';

  meta = {
    description = "Show nixpkgs pin cache coverage vs nixos-unstable channel and Hydra build farm";
    homepage = "https://github.com/retif/nixpkgs-cache-status";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ retif ];
    mainProgram = "nixpkgs-cache-status";
    platforms = lib.platforms.unix;
  };
})
