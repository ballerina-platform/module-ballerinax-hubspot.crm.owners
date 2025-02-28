## Overview

[HubSpot](https://developers.hubspot.com) is an AI-powered customer relationship management (CRM) platform.

The `ballerinax/hubspot.crm.owners` offers APIs to connect and interact with the [HubSpot CRM Owners API](https://developers.hubspot.com/docs/reference/api/crm/owners) endpoints, specifically based on the [HubSpot REST API](https://developers.hubspot.com/docs/reference/api).

## Setup guide

To use the HubSpot CRM Owners connector, you must have access to the HubSpot API through a HubSpot developer account and a HubSpot App under it. Therefore you need to register for a developer account at HubSpot if you don't have one already.

### Step 1: Create/Login to a HubSpot developer account

If you don't have a HubSpot Developer Account you can sign up to a free account [here](https://developers.hubspot.com/get-started)

If you have an account already, go to the [HubSpot developer portal](https://app.hubspot.com/)

### Step 2: Create a developer test account (Optional)

Within app developer accounts, you can create a [developer test account](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) under your account to test apps and integrations without affecting any real HubSpot data.

> **Note:** These accounts are only for development and testing purposes. In production you should not use Developer Test Accounts.

1. Go to the Test accounts section from the left sidebar.
   ![Test accounts section](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/test-account.png)

2. Click on the `Create developer test account` button on the top right corner.
   ![Create developer test account](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/create-test-account.png)

3. In the pop-up window, provide a name for the test account and click on the `Create` button.
   ![Create test account](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/create-account.png)
   You will see the newly created test account in the list of test accounts.
   ![Test account portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/test-account-portal.png)

### Step 3: Create a HubSpot app

1. Now navigate to the `Apps` section from the left sidebar and click on the `Create app` button on the top right corner.
   ![Create app](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/create-app.png)

2. Provide a public app name and description for your app.
   ![App name and description](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/app-name-desc.png)

### Step 4: Setup authentication

1. Move to the `Auth` tab.
   ![Configure authentication](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/config-auth.png)

2. In the `Scopes` section, add the following scopes for your app using the `Add new scopes` button.
   - `crm.objects.owners.read`

   ![Add scopes](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/add-scopes.png)

3. In the `Redirect URL` section, add the redirect URL for your app. This is the URL where the user will be redirected after the authentication process. You can use `localhost` for testing purposes. Then click the `Create App` button.

   ![Redirect URL](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/redirect-url.png)

### Step 5: Get the client id and client secret

Navigate to the `Auth` tab and you will see the `Client ID` and `Client Secret` for your app. Make sure to save these values.
![Client ID and Client Secret](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/client-id-secret.png)

### Step 6: Setup authentication flow

Before proceeding with the Quickstart, ensure you have obtained the Access Token or Refresh Token using the following steps:

1. Create an authorization URL using the following format:

   ```
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>` and `<YOUR_SCOPES>` with your specific value.
2. Paste it in the browser and select your developer test account to install the app when prompted.
   ![Account select](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/account-select.png)

3. Click `Connect App`.

   ![Account connect](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/refs/heads/main/docs/resources/connect.png)

4. A code will be displayed in the browser. Copy the code.

5. Run the following curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI`> and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the above step 3 as the `<CODE>`.

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command will return the access token and refresh token which are necessary for API calls.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```

6. Store the refresh token securely for use in your application.

## Quickstart

To use the `Hubspot CRM Owners` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `hubspot.crm.owners` module and `oauth2` module.

```ballerina
import ballerina/oauth2;
import ballerinax/hubspot.crm.owners as hsowners;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

   ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
   ```

2. Instantiate a `hsowners:ConnectionConfig` with the obtained credentials and initialize the connector with it.

    ```ballerina
    configurable string clientId = ?;
    configurable string clientSecret = ?;
    configurable string refreshToken = ?;

    hsowners:ConnectionConfig config = {
        auth: {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final hsowners:Client hubspot = check new (config);
    ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample usecase is shown below.

#### View owners

```ballerina
public function main() returns error? {
   hsowners:CollectionResponsePublicOwnerForwardPaging getPageOfOwners = check hubspot->/('limit = 10);
   io:println("Owners: ", getPageOfOwners);
}
```

## Examples

The `HubSpot CRM Owners` connector provides practical examples illustrating usage in various scenarios.

1. [Retrieve the owner IDs for all users in the account to later assign CRM records across the team.](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/tree/main/examples/retrieve-owner-ids) - This example demonstrates how to use the HubSpot CRM Owners connector to retrieve a page of owners from your HubSpot account. It shows how to fetch owner details—such as owner ID, first name, and last name—which can then be used to assign CRM records to team members.
