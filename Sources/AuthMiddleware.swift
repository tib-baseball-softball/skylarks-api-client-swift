//
//  AuthMiddleware.swift
//  SkylarksAPIClient
//
//  Created by David Battefeld on 27.12.24.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

public struct AuthMiddleware: ClientMiddleware {
    /// The token value.
    var bearerToken: String
    
    public init(bearerToken: String) {
        self.bearerToken = bearerToken
    }

    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.init("X-Authorization")!] = "\(bearerToken)"
        return try await next(request, body, baseURL)
    }
}
