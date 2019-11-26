import ballerina/http;

final string serviceProvidersPath = v1BasePath + "/service-providers";
final string serviceProvidersPathWithVar = serviceProvidersPath + "/{service-provider-id}";

@http:ServiceConfig {
    basePath: serviceProvidersPath
}
service serviceproviders on mainListener {

    @http:ResourceConfig {
        path: "/"
    }
    resource function list(http:Caller caller, http:Request req) {
        var forwardReq = requestWithAuthHeader(req);
        var listOfServiceProviders = tpmsCore->get("/service-providers/with-orgunits", forwardReq);
        handleResponse(caller, listOfServiceProviders);
    }

    @http:ResourceConfig {
        path: "/{serviceprovider}"
    }
    resource function get(http:Caller caller, http:Request req, string serviceprovider) {
        var forwardReq = requestWithAuthHeader(req);
        var listOfServiceProviders = tpmsCore->get("/service-providers/with-orgunits/" + (<@untainted> serviceprovider), forwardReq);
        handleResponse(caller, listOfServiceProviders);
    }
}
