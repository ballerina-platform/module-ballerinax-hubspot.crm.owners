# Examples

The `ballerinax/hubspot.crm.owners` connector provides practical examples illustrating usage in various scenarios.

1. [Retrieve the owner IDs for all users in the account to later assign CRM records across the team.](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/tree/main/examples/retrieve-owner-ids) - This example demonstrates how to use the HubSpot CRM Owners connector to retrieve a page of owners from your HubSpot account. It shows how to fetch owner details such as owner ID, first name, and last name, which can then be used to assign CRM records to team members.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.owners/blob/main/ballerina/Package.md#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
