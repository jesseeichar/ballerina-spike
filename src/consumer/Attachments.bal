import ballerina/http;
import ballerina/log;

@http:ServiceConfig {
    basePath: v1BasePath + "/attachments"
}
service attachments on mainListener {
    @http:ResourceConfig {
                path: "/"
	}
    resource function list(http:Caller caller, http:Request req) {
        // Send a response back to the caller.
        var result = caller->respond("Attached!");
        if (result is error) {
            log:printError("Error sending response", result);
        }
    }
}

