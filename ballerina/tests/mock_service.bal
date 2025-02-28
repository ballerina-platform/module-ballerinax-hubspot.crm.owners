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

import ballerina/http;

service on new http:Listener(9091) {

    # Get a page of owners
    #
    # + email - Filter by email address (optional)
    # + after - The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results.
    # + 'limit - The maximum number of results to display per page.
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get .(string? email, string? after, int:Signed32 'limit = 100, boolean archived = false) returns CollectionResponsePublicOwnerForwardPaging|error {
        return {
            results: [
                {
                    id: "77288308",
                    email: "kalhara.wso2.dev@gmail.com",
                    'type: "PERSON",
                    firstName: "string",
                    lastName: "string",
                    userId: 77288308,
                    userIdIncludingInactive: 77288308,
                    createdAt: "2025-02-11T09:41:26.664Z",
                    updatedAt: "2025-02-11T09:41:26.664Z",
                    archived: false
                }
            ]
        };
    }

    # Read an owner by given `id` or `userId`
    #
    # + idProperty - The property to search by. Defaults to `id`.
    # + archived - Whether to return only results that have been archived.
    # + return - returns can be any of following types
    # http:Ok (successful operation)
    # http:DefaultStatusCodeResponse (An error occurred.)
    resource function get [int:Signed32 ownerId]("id"|"userId" idProperty = "id", boolean archived = false) returns PublicOwner|error {
        if ownerId == 77288308 {
            return {
                id: "77288308",
                email: "kalhara.wso2.dev@gmail.com",
                'type: "PERSON",
                firstName: "string",
                lastName: "string",
                userId: 77288308,
                userIdIncludingInactive: 77288308,
                createdAt: "2025-02-11T09:41:26.664Z",
                updatedAt: "2025-02-11T09:41:26.664Z",
                archived: false
            };
        } else {
            return error("Owner not found");
        }
    }
}
