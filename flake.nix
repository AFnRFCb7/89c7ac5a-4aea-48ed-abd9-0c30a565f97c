{
    inputs = { } ;
    outputs = { self } :
	    {
	        lib =
	            {
	                implementation =
	    		        { } : { config , lib , pkgs , ... } :
			                {
			                    config =
			                        {
                                        systemd =
                                            {
                                                after = [ "network.target" ] ;
                                                services =
                                                    {
                                                        "${ config.trump5000.services.server.name}" =
                                                            {
                                                                after = [ "network.target" ] ;
                                                                serviceConfig =
                                                                    {
                                                                        ExecStart =
                                                                            let
                                                                                application =
                                                                                    pkgs.writeShellApplication
                                                                                        {
                                                                                            name = "ExecStart" ;
                                                                                            runtimeInputs =
                                                                                                [
                                                                                                    (
                                                                                                        pkgs.buildFSHUserEnv
                                                                                                            {
                                                                                                                name = "ExecStart" ;
                                                                                                                targetPkgs =
                                                                                                                    pkgs :
                                                                                                                        [
                                                                                                                            (
                                                                                                                                pkgs.writeShellApplication
                                                                                                                                    {
                                                                                                                                        name = "ExecStart" ;
                                                                                                                                        runtimeInputs = [ ] ;
                                                                                                                                        text =
                                                                                                                                            ''
                                                                                                                                            '' ;
                                                                                                                                    }
                                                                                                                            )
                                                                                                                        ] ;
                                                                                                                runScript = "ExecStart" ;
                                                                                                            }
                                                                                                    )
                                                                                                ] ;
                                                                                            text = "ExecStart" ;
                                                                                        } ;
                                                                                in "${ application }/bin/ExecStart" ;
                                                                        User = config.trump5000.services.server ;
                                                                    } ;
                                                                wantedBy = [ "multi-user.target" ] ;
                                                            } ;
                                                    } ;
                                            } ;
			                        } ;
                                options =
                                    {
                                        trump5000 =
                                            {
                                                enable = lib.mkOption { default = true ; type = lib.types.bool ; } ;
                                                services =
                                                    {
                                                        server =
                                                            {
                                                                enable = lib.mkOption { default = true ; type = lib.types.bool ; } ;
                                                                name = lib.mkOption { default = "server" ; type = lib.types.str ; } ;
                                                                user = lib.mkOption { type = lib.types.str ; } ;
                                                            } ;
                                                    } ;
                                            } ;
                                    } ;
			                } ;
	                checks = null ;
	            } ;
        } ;
}
