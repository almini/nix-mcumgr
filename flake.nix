{
  description = "MCU Manager (mcumgr)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: {
    overlays.default = final: prev: {

      mcumgr = with final; buildGoModule rec {
        
        pname = "mcumgr";
        version = "0.0.0-dev";

        src = fetchFromGitHub {
          owner = "apache";
          repo = "mynewt-mcumgr-cli";
          rev = "5c56bd24066c780aad5836429bfa2ecc4f9a944c";
          sha256 = "sha256-WyaDnCRyZRwOkZyzNp1ouhNY5HuAvU6U3yUjiB5m+uE=";
        };

        vendorSha256 = "sha256-EPwV47zeBqxQPtD9QeQTKB64PmMt4HYseg38cI/owwE=";

      };

    };
  } // flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
    let
      pkgs = import nixpkgs { 
        inherit system; 
        overlays = [ 
          self.overlays.default
        ]; 
      };
    in
    {

      packages.default = pkgs.mcumgr;

    });
}