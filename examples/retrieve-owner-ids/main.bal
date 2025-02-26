// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.owners as hsowners;

// These values are configured externally (e.g., via Ballerina.toml).
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

// Configure OAuth 2.0 refresh token grant details to connect to HubSpot.
hsowners:OAuth2RefreshTokenGrantConfig auth = {
    clientId: clientId,
    clientSecret: clientSecret,
    refreshToken: refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

// Create a new HubSpot owners client using the OAuth config.
final hsowners:Client hubspot = check new ({ auth });

public function main() returns error? {
    // Retrieve all owners from HubSpot.
    hsowners:CollectionResponsePublicOwnerForwardPaging response = check hubspot->/();

    // Print the details of each owner.
    foreach hsowners:PublicOwner owner in response.results {
        io:println("Owner -> ", owner.email, " (ID: ", owner.id, ")");
        io:println("   First Name       : ", owner.firstName);
        io:println("   Last Name        : ", owner.lastName);
        io:println("   User ID          : ", owner.userId);
        io:println("   Created At       : ", owner.createdAt);
        io:println("   Updated At       : ", owner.updatedAt);
        io:println("   Archived         : ", owner.archived);
        io:println();
    }

    return ();
}
