{ pkgs } :
	pkgs.dockerTools.buildLayeredImage
		{
			name = "trump-dividend-server" ;
			tag = "latest" ;
			contents = [ pkgs.nodejs ] ;
			config =
				{
					WorkingDir = "/app" ;
					Cmd = [ "${ pkgs.nodejs }/bin/node" "/app/index.js" ] ;
					ExposedPorts = { "3000/tcp" = { } ; } ;
				} ;
		}
