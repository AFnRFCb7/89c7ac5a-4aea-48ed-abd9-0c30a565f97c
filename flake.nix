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
                                                        services =
                                                            lib.mkIf
                                                                config.trump5000.services.enable
                                                                    {
                                                                        ${ config.trump5000.services.server.name } =
                                                                            lib.mkIf
                                                                                config.trump5000.services.server.enable
                                                                                {
                                                                                    after = [ "network.target" ] ;
                                                                                    serviceConfig =
                                                                                        {
                                                                                            ExecStart =
                                                                                                let
                                                                                                    application =
                                                                                                        lazy-shell-application
                                                                                                            {
                                                                                                                name = "application" ;
                                                                                                                runtime-inputs =
                                                                                                                    pkgs :
                                                                                                                        [
                                                                                                                        ] ;
                                                                                                                text =
                                                                                                                    ''
                                                                                                                    '' ;
                                                                                                            } ;
                                                                                                    in "${ application }/bin/application" ;
                                                                                            User = config.trump5000.services.server.user ;
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
                                                        services =
                                                            {
                                                                enable = lib.mkOption { default = true ; type = lib.types.bool ; } ;
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
