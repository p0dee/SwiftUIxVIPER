//
//  RepositorySearchAPI.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/08/13.
//

import Combine
import Foundation

struct RepoSearchAPI {
    
    let username: String
    
    func request(receiveOnMainThread: Bool = true) -> AnyPublisher<[Repository], APIError> {
        let urlString = "https://api.github.com/users/\(username)/repos"
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let item = URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap({ (data, response) -> Data in
                guard let response = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                switch response.statusCode {
                case 200: return data
                case 404: throw APIError.notFound
                default:  throw APIError.unknown
                }
            })
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .tryMap({ (repos) -> [Repository] in
                if repos.count == 0 { throw APIError.noItems }
                return repos
            })
            .mapError({ err -> APIError in
                if let err = err as? APIError {
                    return err
                } else {
                    return APIError.invalidResponse
                }
            })
            .receive(on: receiveOnMainThread ? RunLoop.main : RunLoop.current)
            .eraseToAnyPublisher()
        return item
    }
    
}

/*
.mapError({ (err) -> Error in
    if let err = err as? APIError {
        return err
    } else {
        return APIError.invalidResponse
    }
})
.tryMap({ (repos) -> [Repository] in
    if repos.count == 0 { throw APIError.noItems }
    return repos
})
*/
