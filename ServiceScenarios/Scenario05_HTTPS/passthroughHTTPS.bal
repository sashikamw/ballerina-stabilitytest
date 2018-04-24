import ballerina/http;

endpoint http:Listener passthroughEP {
    port:9090,
	secureSocket: {
        keyStore: {
          path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

endpoint http:Client nyseEP {
    url:"https://192.168.32.5:9191",
    secureSocket: {
       verifyHostname:false
    }
};

@http:ServiceConfig {basePath:"/passthrough"}
service<http:Service> passthroughService bind passthroughEP {

    @http:ResourceConfig {
        methods:["POST"],
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request clientRequest) {
        var response = nyseEP -> post("/nyseStock/stocks", request = clientRequest);
        match response {
            http:Response httpResponse => {
                _ = outboundEP -> respond(httpResponse);
            }
            http:HttpConnectorError err => {
                http:Response errorResponse = new;
                json errMsg = {"error":"error occurred while invoking the service"};
                errorResponse.setJsonPayload(errMsg);
                _ = outboundEP -> respond(errorResponse);
            }
        }
    }
}

