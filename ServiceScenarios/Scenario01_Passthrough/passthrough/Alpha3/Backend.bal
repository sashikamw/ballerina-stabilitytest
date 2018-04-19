import ballerina/http;

endpoint http:ServiceEndpoint passthroughEP {
    port:9191
};


@http:ServiceConfig {basePath:"/nyseStock"}
service<http:Service> nyseStockQuote bind passthroughEP {

    @http:ResourceConfig {
        methods:["GET"],
        path:"/stocks"
    }
    stocks (endpoint outboundEP, http:Request clientRequest) {
        http:Response res = new;
        json payload = {"exchange":"nyse", "name":"IBM", "value":"127.80"};
        res.setJsonPayload(payload);
        _ = outboundEP -> respond(res);
    }
}
