import ballerina/http;
import ballerina/log;

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
        // Send a response back to the caller.
        var result = caller->respond("serviceproviders!");
        if (result is error) {
            log:printError("Error sending response", result);
        }
    }

    @http:ResourceConfig {
                path: "/{serviceprovider}"
	}
    resource function get(http:Caller caller, http:Request req, string serviceprovider) {
        // Send a response back to the caller.
        var result = caller->respond("serviceproviders!" + (<@untainted>serviceprovider));
        if (result is error) {
            log:printError("Error sending response", result);
        }
    }
}
