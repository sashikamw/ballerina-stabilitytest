import ballerina/http;

endpoint http:Listener passthroughEP {
    port:9191,
secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
};

@http:ServiceConfig {basePath:"/nyseStock"}
service<http:Service> nyseStockQuote bind passthroughEP {

    @http:ResourceConfig {
        methods:["POST"],
        path:"/stocks"
    }
    stocks (endpoint outboundEP, http:Request clientRequest) {
	var jsonMsg = check clientRequest.getJsonPayload();
	var xmlMsg = check jsonMsg.toXML({});
        http:Response res = new;
        res.setXmlPayload(xmlMsg);
        _ = outboundEP -> respond(res);
    }
}
