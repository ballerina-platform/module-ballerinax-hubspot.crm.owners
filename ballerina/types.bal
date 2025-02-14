// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

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

# Represents the Queries record for the operation: get-/crm/v3/owners/{ownerId}_getById
public type GetCrmV3OwnersOwnerIdGetByIdQueries record {
    # Whether to return only results that have been archived.
    boolean archived = false;
    "id"|"userId" idProperty = "id";
};

# Details about forward pagination used to retrieve the next set of results in a paginated response.
public type ForwardPaging record {
    NextPage next?;
};

# Represents a HubSpot team with a name, a unique identifier, and a flag indicating whether it is the primary team.
public type PublicTeam record {
    string name;
    string id;
    boolean primary;
};

# Represents a HubSpot owner, which can be either an individual (PERSON) or a queue (QUEUE), along with their associated details.
public type PublicOwner record {
    string firstName?;
    string lastName?;
    string createdAt;
    boolean archived;
    PublicTeam[] teams?;
    string id;
    int:Signed32 userIdIncludingInactive?;
    "PERSON"|"QUEUE" 'type;
    int:Signed32 userId?;
    string email?;
    string updatedAt;
};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# Collection of owners with forward paging information for continued retrieval.
public type CollectionResponsePublicOwnerForwardPaging record {
    ForwardPaging paging?;
    PublicOwner[] results;
};

# Information about the next page, including a link and the paging cursor token to retrieve more results.
public type NextPage record {
    string link?;
    string after;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string private\-app\-legacy;
    string private\-app;
|};

# Represents the Queries record for the operation: get-/crm/v3/owners/_getPage
public type GetCrmV3OwnersGetPageQueries record {
    # Whether to return only results that have been archived.
    boolean archived = false;
    # The maximum number of results to display per page.
    int:Signed32 'limit = 100;
    # The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results.
    string after?;
    # Filter by email address (optional)
    string email?;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};
