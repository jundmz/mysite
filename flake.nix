{
  description = "jundmz.dev — personal site (Zola)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        # `nix develop`  — shell for writing and previewing
        #   zola serve   live-reload preview at http://127.0.0.1:1111
        #   zola build   render the static site into ./public
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.zola ];
          shellHook = ''
            echo "$(zola --version) — 'zola serve' to preview, 'zola build' to render"
          '';
        };

        # `nix build`  — reproducible static site, output in ./result
        # Point your host (Netlify/Cloudflare Pages/nginx) at the result, or
        # deploy the ./public dir from `zola build` directly.
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "jundmz-site";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [ pkgs.zola ];
          buildPhase = "zola build";
          installPhase = "cp -r public $out";
        };
      });
}
