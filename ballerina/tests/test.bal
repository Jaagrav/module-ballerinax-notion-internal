import ballerina/test;
import ballerina/io;
import ballerina/os;

configurable string authToken = os:getEnv("NOTION_AUTH_TOKEN");
configurable string testBlockId = os:getEnv("TEST_BLOCK_ID");
configurable string testDatabaseId = os:getEnv("TEST_DATABASE_ID");
configurable string testPageId = os:getEnv("TEST_PAGE_ID");
configurable string testUserId = os:getEnv("TEST_USER_ID");

ConnectionConfig notionConfig = {
    auth: {
        token: authToken
    }
};
Client notion = check new (notionConfig);

@test:Config {}
function testGetBlockChildren() returns error? {
    BlockChildrenResponse response = check notion->/v1/blocks/[testBlockId]/children();
    io:println("Block Children Response: ", response);
    test:assertNotEquals(response, (), "Block children response should not be null");
}
 
@test:Config {}
function testRetrieveDatabase() returns error? {
    Database response = check notion->/v1/databases/[testDatabaseId];
    io:println("Retrieve Database Response: ", response);
    test:assertNotEquals(response, (), "Retrieved database should not be null");
}

@test:Config {}
function testRetrievePage() returns error? {
    PageResponse response = check notion->/v1/pages/[testPageId];
    io:println("Retrieve Page Response: ", response);
    test:assertNotEquals(response, (), "Retrieved page should not be null");
}

@test:Config {}
function testListAllUsers() returns error? {
    PaginatedUsers response = check notion->/v1/users;
    io:println("List All Users Response: ", response);
    test:assertNotEquals(response, (), "User list response should not be null");
}

@test:Config {}
function testRetrieveUser() returns error? {
    User response = check notion->/v1/users/[testUserId];
    io:println("Retrieve User Response: ", response);
    test:assertNotEquals(response, (), "Retrieved user should not be null");
}

@test:Config {}
function testAppendBlockChildren() returns error? {
    PageUpdateRequestBody payload = {
      "children": [
        {
          "object": "block",
          "type": "heading_2",
          "heading_2": {
            "rich_text": [{ "type": "text", "text": { "content": "Test block" } }]
          }
        }
      ]
    };
    ChildBlockContent response = check notion->/v1/blocks/[testBlockId]/children.patch(payload);
    io:println("Append Block Children Response: ", response);
    test:assertNotEquals(response, (), "Appended block children response should not be null");
}

@test:Config {}
function testCreateDatabase() returns error? {
    DatabaseBodyParams payload = {
        "parent": {
            "type": "page_id",
            "page_id": testPageId
        },
        "icon": {
          "type": "emoji",
          "emoji": "📝"
        },
        "title": [
            {
                "type": "text",
                "text": {
                    "content": "Test Database",
                    "link": null
                }
            }
        ],
        "properties": {
            "Name": {
                "title": {}
            },
            "Description": {
                "rich_text": {}
            }
        }
    };
    DatabaseResponse_results response = check notion->/v1/databases.post(payload);
    io:println("Create Database Response: ", response); 
    // test:assertNotEquals(response, (), "Created database response should not be null");
}

@test:Config {}
function testCreatePage() returns error? {
    PageBodyParams payload = {
        "parent": { 
            "type": "page_id",
            "page_id": testPageId
        }, 
        "properties": { 
          "title": [
            {
              "text": {
                "content": "Test page"
              }
            }
          ] 
        },
        "icon": {
          "emoji": "🥬"
        }
    };
    PageResponse response = check notion->/v1/pages.post(payload);
    io:println("Create Page Response: ", response);
    test:assertNotEquals(response, (), "Created page response should not be null");
}

@test:Config {}
function testSearchPages() returns error? {
    record {} response = check notion->/v1/search.post();
    io:println("Search Pages Response: ", response);
    test:assertNotEquals(response, (), "Search pages response should not be null");
}