import ballerina/http;

endpoint http:Listener passthroughEP {
    port:9191,
    httpVersion:"2.0"
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
