//
//  NetworkManager.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 16/05/21.
//

import UIKit
import Foundation

class NetworkManager {
    
    static func requestData<T:Codable, U: Codable>(_ requestModel:RequestModel<U>,
                                                   _ modelType: T.Type,
                                                   completion: @escaping (Result<T,APIError>) -> Void) {
        // 1
        let isConnected = NetworkConnectivity.isConnectedToNetwork
        // 2
        if !isConnected() {
            completion(.failure(APIError.noInternet(erroMessage: "The Internet connection appears to be offline")))
            return
        }
        // 3
        let urlRequest = getUrlRequest(requestModel)
        // 4
        print(" url:-> \(urlRequest.url!)")
        // 5
        httpRequest(urlRequest, T.self) { (response) in
            // 6
            switch response{
            
            case .success(let data):
                
                completion(.success(data))
                
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
    
    static func request<T:Codable, U: Codable>(_ requestModel:RequestModel<U>,
                                               _ modelType: T.Type,
                                               completion: @escaping (Result<T,APIError>) -> Void) {
        // 1
        let isConnected = NetworkConnectivity.isConnectedToNetwork
        // 2
        if !isConnected() {
            completion(.failure(APIError.noInternet(erroMessage: "The Internet connection appears to be offline")))
            return
        }
        // 3
        let urlRequest = getUrlRequest(requestModel)
        // 4
        print("URL:-> \(urlRequest.url!)")
        // 5
        let jsonData = try? JSONEncoder().encode(requestModel.httpBody)
        // 6
        let json = String(data: jsonData!, encoding: .utf8)
        print(json as Any)
        // 7
        httpRequest(urlRequest, T.self) { (response) in
            // 8
            switch response{
            
            case .success(let wrapper):
                // 9
                completion(.success(wrapper))
            case .failure(let error):
                // 10
                switch error {
                case .jsonConversionFailure:
                    completion(.failure(error))
                default:
                    // we can use the error msg here if we receive that from the API
                    completion(.failure(APIError.serviceFailureError(errorCode: COMMON_ERROR_MESSAGE, errorMessage: COMMON_ERROR_MESSAGE)))
                }
            }
        }
    }
    
    
    fileprivate static func httpRequest<T:Codable>(_ urlRequest: URLRequest,
                                                   _ responseType: T.Type,
                                                   completion: @escaping (Result<T,APIError>) -> Void) {
        
        // 1
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 120.0
        sessionConfig.timeoutIntervalForResource = 120.0
        let session = URLSession(configuration: sessionConfig)
        // 2
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            // 3
            guard let data = data else {
                completion(.failure(.internalServerError))
                return
            }
            
            // 4
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.internalServerError))
                return
            }
            // 5
            print("statusCode: \(httpResponse.statusCode)")
            print("HTTPURLResponse allHeaderFields :-> \(httpResponse.allHeaderFields)")
            print("JSON Response := \(String(decoding: data, as: UTF8.self))")
            
            // 6
            switch httpResponse.statusCode {
            // 7
            case 200:
                do {
                    let wrapper = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(wrapper))
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(.jsonConversionFailure))
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(.jsonConversionFailure))
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(.failure(.jsonConversionFailure))
                } catch {
                    print("error: ", error)
                    completion(.failure(.jsonConversionFailure))
                }
            case 401:
                completion(.failure(APIError.unauthorized))
                
            default:
                completion(.failure(.internalServerError))
            }
            
        }.resume()
        
    }
    
    
    // MARK:- GET URL REQUEST
    fileprivate static func getUrlRequest<T:Codable>(_ requestData: RequestModel<T>) -> URLRequest{
        // 1
        let urlString = requestData.url.description
        // 2
        var urlRequest: URLRequest
        // 3
        var url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20"))
        // 4
        if  !requestData.pathParam.isEmpty {
            url?.appendPathComponent(requestData.pathParam)
        }
        
        url?.appendQueryItem(name: "api_key", value: API_KEY)
        // 5
        urlRequest = URLRequest(url: url!)
        // 6
        urlRequest.setValue(ContentType.accept.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.acceptEncoding.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptEncoding.rawValue)
        
        print("Headers ==> \(urlRequest.allHTTPHeaderFields ?? [:])")
        print("urlRequest ======>", urlRequest)
        return urlRequest
    }
}

extension EndPoint : CustomStringConvertible {
    var description: String {
        return BASE_URL + self.rawValue
    }
}
// end of extension

