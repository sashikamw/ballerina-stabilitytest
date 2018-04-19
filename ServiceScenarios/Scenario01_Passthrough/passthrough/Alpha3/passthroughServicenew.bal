import ballerina/http;

endpoint http:ServiceEndpoint passthroughEP {
    port:9090
};

endpoint http:ClientEndpoint nyseEP {
    targets:[{url:"http://192.168.32.5:9191"}]
};

@http:ServiceConfig {basePath:"/passthrough"}
service<http:Service> passthroughService bind passthroughEP {

    @http:ResourceConfig {
        methods:["GET"],
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request clientRequest) {
        var response = nyseEP -> get("/nyseStock/stocks", clientRequest);
        match response {
            http:Response httpResponse => {
                _ = outboundEP -> forward(httpResponse);
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

