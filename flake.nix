{
  description = "Trump $5K Dividend tracker";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f {
            pkgs = import nixpkgs {
              inherit system;
            };
          });
    in
    {
      devShells = forAllSystems ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs
            docker
            docker-compose
            postgresql
	    emacs
          ];

          shellHook = ''
            echo "Trump $5K development environment"
            node --version
            npm --version
          '';
        };
      });

      checks = forAllSystems ({ pkgs }: {
        default = pkgs.runCommand "flake-check" {} ''
          echo "TODO: project checks"
          touch $out
        '';
      });


	packages = forAllSystems ({ pkgs }: {
	  server = import ./services/server { inherit pkgs; };
	});

	lib = {
	    implementation =
	    		   { } : { ... } :
			     {
				systemd =
					{
						services =
							 {
								
							 } ;
					} ;
			     } ;
	    checks = null ;
	} ;
   } ;

}
