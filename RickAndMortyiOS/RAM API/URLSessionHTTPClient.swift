//
//  URLSessionHTTPClient.swift
//  RickAndMortyiOS
//
//  Created by Sebastian Wiatrzyk on 14/08/2020.
//  Copyright © 2020 Sebastian Wiatrzyk. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noHTTPResponse
    case httpError(code: Int)
}

private struct UnexpectedValuesRepresentation: Error {}

public class URLSessionHTTPClient: HTTPClient {
    
    public static let shared = URLSessionHTTPClient()
    
    private let session = URLSession.shared

    private init() {}
    
    // MAKR: - Networking methods
    public func get(from url: URL, forPage pageNumber: Int? = nil, completion: @escaping (HTTPClient.Result) -> Void) {
        
        guard let request = getURLRequest(for: url, forPage: pageNumber) else { return }
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        
        task.resume()
    }
    
    func getURLRequest(for url: URL, forPage pageNumber: Int?) -> URLRequest? {
        var request: URLRequest
        if let pageNumber = pageNumber,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem(name: "page", value: String(pageNumber))]
            guard let urlWithPageNumber = urlComponents.url else { return nil}
            request = URLRequest(url: urlWithPageNumber)
        } else {
            request = URLRequest(url: url)
        }
        return request
    }
}
