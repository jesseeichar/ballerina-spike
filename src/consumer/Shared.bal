import ballerina/http;
import ballerina/oauth2;
const v1BasePath = "/api/v1";
const authHeaderName = "Authorization";

oauth2:IntrospectionServerConfig introspectionServerConfig = {
    url: "https://dev-keycloak.k8s.polypoint-dev.com/auth/realms/polypoint-tpms-realm/protocol/openid-connect/token/introspect"
};
oauth2:InboundOAuth2Provider oauth2Provider = new (introspectionServerConfig);

http:BearerAuthHandler jwtAuthHandler = new(oauth2Provider);

listener http:Listener mainListener = new (9090, config = {
    auth: {
        authHandlers: [jwtAuthHandler]
    }
});


final http:Client tpmsCore = new ("http://localhost:8081/api");

function requestWithAuthHeader(http:Request req) returns http:Request {
    http:Request forwardReq = new;
    if (req.hasHeader(authHeaderName)) {
        forwardReq.addHeader(authHeaderName, req.getHeader(authHeaderName));
    }
    return forwardReq;
}

function handleResponse(http:Caller caller, http:Response | error response) {
    if (response is http:Response) {
        var replyResponse = caller->respond(response);
    } else {
        http:Response errorResponse = new;
        errorResponse.statusCode = 502;
        errorResponse.reasonPhrase = response.reason();
        var replyResponse = caller->respond(errorResponse);
    }
}
