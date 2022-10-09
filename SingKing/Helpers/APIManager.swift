//
//  APIManager.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import Foundation

class APIManager {
    
    typealias Headers = [String: String]
    typealias Params = [String: Any?]
    
    enum HTTPMethod: String {
        case connect = "CONNECT"
        case trace = "TRACE"
        case options = "OPTIONS"
        case head = "HEAD"
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum RequestError: Error {
        case badURL
        case serialization(Error)
        case noConnection
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case serverError
        case unknown(Int)
    }
    
    enum RequestResult {
        case success(Data)
        case failure(RequestError)
    }
    
    class func request(endpoint: String, httpMethod: HTTPMethod, headers: Headers? = nil, params: Params? = nil, completion: @escaping (RequestResult) -> Void) {
        
        guard let url = URL(string: API.baseURL + endpoint) else {
            completion(RequestResult.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = API.defaultHeaders.merging(headers ?? [String: String]()) { (_, new) in new }
        if let params = params {
            do {
                let paramsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                urlRequest.httpBody = paramsData
            } catch {
                completion(RequestResult.failure(.serialization(error)))
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            guard error == nil else {
                completion(RequestResult.failure(.noConnection))
                return
            }
            
            if let httpURLResponse = urlResponse as? HTTPURLResponse {
                switch httpURLResponse.statusCode {
                case 200:
                    if let data = data {
                        completion(RequestResult.success(data))
                    }
                case 400:
                    completion(RequestResult.failure(.badRequest))
                case 401:
                    completion(RequestResult.failure(.unauthorized))
                case 403:
                    completion(RequestResult.failure(.forbidden))
                case 404:
                    completion(RequestResult.failure(.notFound))
                case 500...599:
                    completion(RequestResult.failure(.serverError))
                default:
                    completion(RequestResult.failure(.unknown(httpURLResponse.statusCode)))
                }
            }
            
        }.resume()
        
    }
    
}
