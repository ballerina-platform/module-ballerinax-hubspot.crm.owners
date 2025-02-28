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

configurable boolean isLiveServer = false;
configurable string clientId = "client-id";
configurable string clientSecret = "client-secret";
configurable string refreshToken = "refresh-token";

const int:Signed32 TEST_OWNER_ID = 77288308;
const string TEST_OWNER_EMAIL = "kalhara.wso2.dev@gmail.com";
const int:Signed32 TEST_INVALID_OWNER_ID = -1;

final Client hubspot = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, "https://api.hubapi.com/crm/v3/owners");
    }
    return check new ({
        auth: {token: "test-token"}
    }, "http://localhost:9091");
}

@test:Config {groups: ["live_tests", "mock_tests", "positive_tests"]}
isolated function testGetAllOwners() returns error? {
    CollectionResponsePublicOwnerForwardPaging response = check hubspot->/.get();
    test:assertTrue(response.results.length() > 0, msg = "Expected non-empty list");
}

@test:Config {groups: ["live_tests", "mock_tests", "positive_tests"]}
isolated function testGetOwnerById() returns error? {
    PublicOwner response = check hubspot->/[TEST_OWNER_ID]();
    test:assertEquals(response.id, TEST_OWNER_ID.toString(), msg = "ID mismatch");
    test:assertEquals(response.email, TEST_OWNER_EMAIL, msg = "Email mismatch");
}

@test:Config {groups: ["live_tests", "mock_tests", "negative_tests"]}
isolated function testGetOwnerByInvalidId() {
    PublicOwner|error? response = hubspot->/[TEST_INVALID_OWNER_ID]();
    test:assertTrue(response is error, msg = "Expected an error");
}
