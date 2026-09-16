{
    inputs = { } ;
    outputs = { self } :
	    {
	        lib =
	            {
	                implementation =
	    		        { lazy-shell-application } : { config , lib , pkgs , ... } :
	    		            let
	    		                parameters =
	    		                    {
	    		                        lazy-shell-application = lazy-shell-application ;
	    		                    } ;
                                in
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
                                                                                            lazy-shell-application
                                                                                                {
                                                                                                    runtime-inputs =
                                                                                                        pkgs :
                                                                                                            [
                                                                                                            ] ;
                                                                                                    text =
                                                                                                        ''
                                                                                                        '' ;
                                                                                                } ;
                                                                                        in "${ application }/bin/application" ;
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
