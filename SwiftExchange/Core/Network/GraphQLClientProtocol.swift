//
//  GraphQLClientProtocol.swift
//  SwiftExchange
//
//  Created by Nathan on 2026/4/28.
//

protocol GraphQLClientProtocol: Sendable {
    func fetch<QueryResult>(
        operationName: String,
        variables: [String: Any]
    ) async throws -> QueryResult

    func mutate<MutationResult>(
        operationName: String,
        variables: [String: Any]
    ) async throws -> MutationResult
}
