//
//  API.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/13.
//

import Combine
import Foundation

enum RequestState: Equatable {
    case loading, succeed, failure(error: APIError)
}

struct APIError: Error, Equatable {
    let message: String
    
    static let unknown: APIError = .init(message: "Unknown error")
    static let notFound: APIError = .init(message: "Not found")
    static let noItems: APIError = .init(message: "No items")
    static let invalidResponse: APIError = .init(message: "Invalid response")
}

protocol API {
    
    associatedtype Request
    associatedtype Response
    
    func request(_ param: Request) -> AnyPublisher<Response, APIError>
    
    func urlString(_ param: Request) -> String
    
}
