import ballerina/io;
import ballerinax/notion_rest;
 
configurable string authToken = os:getEnv("NOTION_AUTH_TOKEN");
configurable string testPageId = "xyz";


// Initialize the client with your notion_rest authentication token
notion_rest:ConnectionConfig config = {
    auth: {
        token: authToken
    }
};
final notion_rest:Client notion = check new (config);

public function main() returns error? {
    PageResponse result = check notion->/v1/pages/[testPageId];

    if result is error {
        io:println("Error retrieving page: ", result.message());
    } else {
        io:println("Page retrieved successfully:");
        io:println(result.toString());
    }
}