## Overview

[//]: # "TODO: Add overview mentioning the purpose of the module, supported REST API versions, and other high-level details."

The Notion connector allows you to interact with Notion databases and pages programmatically. This module supports various REST API versions provided by Notion and enables you to perform operations such as reading, creating, and updating Notion pages and databases. It’s designed to streamline integration with Notion’s API by simplifying the credential setup and providing easy-to-use methods for interacting with Notion content.

## Setup guide

[//]: # "TODO: Add detailed steps to obtain credentials and configure the module."

To use the Notion connector, you need to obtain the necessary credentials and configure them within your application. Follow the steps below to set up the credentials:

Step 1: Create a Notion Integration

1. Log in to your Notion account and navigate to Notion Integrations.

![create integration](https://github.com/Jaagrav/module-ballerinax-notion/blob/main/docs/assets/create-integration.png?raw=true)

2. Click on New Integration.

![new integration](https://github.com/Jaagrav/module-ballerinax-notion/blob/main/docs/assets/new-integration.png?raw=true)

3. Provide a name for your integration, and choose the workspace that this integration will have access to.

![integration created](https://github.com/Jaagrav/module-ballerinax-notion/blob/main/docs/assets/integration-created.png?raw=true)

4. After creating the integration, you will see a page with your Integration Token (which you’ll need in the following steps). Copy the Integration Token and store it securely.

![copy secrets](https://github.com/Jaagrav/module-ballerinax-notion/blob/main/docs/assets/secret.png?raw=true)

Step 2: Share a Notion Page with Your Integration

1. Go to the Notion page or database that you want your integration to access.
2. Click on the Share button at the top right corner of the page.
3. In the sharing options, search for your integration by the name you provided when creating it.
4. Grant the integration access by selecting it. This allows your integration to read or update the contents of the page or database.

![connect integration](https://github.com/Jaagrav/module-ballerinax-notion/blob/main/docs/assets/connect-page.png?raw=true)

## Quickstart

[//]: # "TODO: Add a quickstart guide to demonstrate a basic functionality of the module, including sample code snippets."

Simply setup the API client and start using it after initialising with the Notion API key

```bal
configurable string authToken = os:getEnv("NOTION_AUTH_TOKEN");

notion_rest:ConnectionConfig config = {
    auth: {
        token: authToken
    }
};

final notion_rest:Client notion = check new (config);
```

## Examples

Creating a page inside another page using `Notion` module

```bal
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

    if result is error {
        io:println("Error retrieving page: ", result.message());
    } else {
        io:println("Page retrieved successfully:");
        io:println(result.toString());
    }
}
```
