import ballerina/test;
import ballerina/http;


string uri = "http://0.0.0.0:9090/api/v1";
// Test function.
@test:Config {}
function testGetServiceProviders() {
    http:Client clientEndpoint = new(uri);

    var response = clientEndpoint->get("/service-providers/get");

    if (response is http:Response) {
        var strRes = response.getTextPayload();
        string expected = "Sample listPets Response";
        test:assertEquals(strRes, expected);
    } else {
        test:assertFail(msg = "Failed to call the endpoint: " + uri);
    }
}
