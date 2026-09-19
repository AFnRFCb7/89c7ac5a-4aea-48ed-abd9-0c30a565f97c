{
    inputs = { } ;
    outputs = { self } :
	    {
	        lib =
	            {
	                lazy-shell-application
                } :
                    let
                        implementation =
                            { config , lib , pkgs , ... } :
                                let
                                    implementation-parameters =
                                        {
                                            config = config ;
                                            lib = lib ;
                                            pkgs = pkgs ;
                                        } ;
                                    in
                                        {
                                            config =
                                                {
                                                    systemd =
                                                        {
                                                            services =
                                                                implementation-parameters.lib.mkIf
                                                                    implementation-parameters.config.trump5000.services.enable
                                                                        {
                                                                            trump5000-server =
                                                                                implementation-parameters.lib.mkIf
                                                                                    implementation-parameters.config.trump5000.services.server.enable
                                                                                    {
                                                                                        after = [ "network.target" ] ;
                                                                                        name = "${ implementation-parameters.config.trump5000.services.server.name }.service" ;
                                                                                        serviceConfig =
                                                                                            {
                                                                                                DynamicUser = true ;
                                                                                                ExecStart =
                                                                                                    let
                                                                                                        application =
                                                                                                            root-parameters.lazy-shell-application
                                                                                                                {
                                                                                                                    name = "application" ;
                                                                                                                    mounts = { } ;
                                                                                                                    post = null ;
                                                                                                                    runtime-inputs = pkgs : [ pkgs.nodejs ] ;
                                                                                                                    text =
                                                                                                                        let
                                                                                                                            package =
                                                                                                                                {
                                                                                                                                    name = "tmp.igznjft05g" ;
                                                                                                                                    version = "1.0.0" ;
                                                                                                                                    description = "" ;
                                                                                                                                    main = "index.js" ;
                                                                                                                                    scripts =
                                                                                                                                        {
                                                                                                                                            test = "echo \"Error: no test specified\" && exit 1" ;
                                                                                                                                        } ;
                                                                                                                                    author = "" ;
                                                                                                                                    license = "ISC" ;
                                                                                                                                    dependencies =
                                                                                                                                        {
                                                                                                                                            express = "^5.2.1" ;
                                                                                                                                        } ;
                                                                                                                                } ;
                                                                                                                            server =
                                                                                                                                builtins.toFile
                                                                                                                                    "server.js"
                                                                                                                                    ''
                                                                                                                                        const express = require("express") ;
                                                                                                                                        const app = express() ;
                                                                                                                                        const port = 3000 ;
                                                                                                                                        app.get("/hello", (request, response) =>
                                                                                                                                            {
                                                                                                                                                const name = request.query.name || "world" ;
                                                                                                                                                response.send( `hi ${ "$" }{ name }`) ;
                                                                                                                                            } ) ;
                                                                                                                                        app.listen( port, () => { console.log(`listening on port ${ "$" }{ port }`) ; } ) ;
                                                                                                                                    '' ;
                                                                                                                            in
                                                                                                                                ''
                                                                                                                                    ln --symbolic ${ builtins.toFile "package.json" ( builtins.toJSON package ) } package.json
                                                                                                                                    npm install
                                                                                                                                    node ${ server }
                                                                                                                                '' ;
                                                                                                                } ;
                                                                                                        in "${ application }/bin/application" ;
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
                                                                    enable = implementation-parameters.lib.mkOption { default = true ; type = lib.types.bool ; } ;
                                                                    server =
                                                                        {
                                                                            enable = implementation-parameters.lib.mkOption { default = true ; type = lib.types.bool ; } ;
                                                                            name = implementation-parameters.lib.mkOption { default = "trump5000-server" ; type = lib.types.str ; } ;
                                                                        } ;
                                                                } ;
                                                        } ;
                                                } ;
                                        } ;
                                root-parameters =
                                    {
                                        lazy-shell-application = lazy-shell-application ;
                                    } ;
                                in
                                    {
                                        check =
                                            lazy-shell-application :
                                            {
                                                client ,
                                                coreutils ,
                                                findutils ,
                                                curl ,
                                                nixosTest ,
                                                nodes ,
                                                order ,
                                                test-setup ,
                                                writeShellApplication
                                            } :
                                            { } :
                                                let
                                                    check-parameters =
                                                        {
                                                            client = client ;
                                                            coreutils = coreutils ;
                                                            findutils = findutils ;
                                                            curl = curl ;
                                                            lazy-shell-application = lazy-shell-application ;
                                                            nixosTest = nixosTest ;
                                                            nodes = nodes ;
                                                            order = order ;
                                                            test-setup = test-setup ;
                                                            writeShellApplication = writeShellApplication ;
                                                        } ;
                                                    in
                                                        check-parameters.lazy-shell-application
                                                            {
                                                                client = check-parameters.client ;
                                                                coreutils = check-parameters.coreutils ;
                                                                findutils = check-parameters.findutils ;
                                                                nixosTest = check-parameters.nixosTest ;
                                                                nodes = check-parameters.nodes ;
                                                                order = check-parameters.order ;
                                                                test-setup = check-parameters.test-setup ;
                                                                writeShellApplication = check-parameters.writeShellApplication ;
                                                            }
                                                            {
                                                                mounts = { } ;
                                                                name = "trump5000" ;
                                                                runtime-inputs = pkgs : [ pkgs.curl ] ;
                                                                text =
                                                                    ''
                                                                        curl http://127.0.0.1:3000/hello?name=4646461779242742
                                                                    '' ;
                                                            }
                                                            {
                                                                arguments = [ ] ;
                                                                standard-error = "" ;
                                                                standard-input = null ;
                                                                standard-output = "" ;
                                                                status = 0 ;
                                                            } ;
                                        implementation = implementation ;
                                    } ;
        } ;
}

