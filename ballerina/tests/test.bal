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

import ballerina/oauth2;
import ballerina/test;

configurable boolean isLiveServer = ?;
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
final string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v3/owners" : "http://localhost:9091";

final Client hubspot = check initClient();

final int:Signed32 testOwnerId = 77288308;
final string testOwnerEmail = "kalhara.wso2.dev@gmail.com";
final int:Signed32 testInvalidOwnerId = -1;

// Init client
isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, serviceUrl);
    }
    return check new ({
        auth: {token: "test-token"}
    }, serviceUrl);
}

// Test: Get all owners
@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetAllOwners() returns error? {
    CollectionResponsePublicOwnerForwardPaging response = check hubspot->/.get();
    test:assertTrue(response.results.length() > 0, msg = "Expected non-empty list");
}

// Test: Get owner by ID
@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetOwnerById() returns error? {
    PublicOwner response = check hubspot->/[testOwnerId]();
    test:assertEquals(response.id, testOwnerId.toString(), msg = "ID mismatch");
    test:assertEquals(response.email, testOwnerEmail, msg = "Email mismatch");
}

// Negative test: Get owner by ID with invalid ID
@test:Config {groups: ["live_tests", "mock_tests"]}
isolated function testGetOwnerByInvalidId() {
    PublicOwner|error response = hubspot->/[testInvalidOwnerId]();
    test:assertTrue(response is error, msg = "Expected an error");
}
