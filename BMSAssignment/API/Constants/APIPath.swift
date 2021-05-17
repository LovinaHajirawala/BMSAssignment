//
//  API_PATH.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 16/05/21.
//

import Foundation
import UIKit

enum RequestType : String {
    case GET
    case POST
}

enum EndPoint : String {
    case movieList = "movie/now_playing"
}

enum NetworkError: Error {
    case domainError
    case decodingError
    case noDataError
}


enum ContentType: String {
    case json = "application/json"
    case accept = "*/*"
    case acceptEncoding = "gzip, deflate, br"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

struct RequestModel<T: Codable>  {
    let url : EndPoint
    let typeObj : RequestType = .POST
    var querryItems : [URLQueryItem]?
    var httpBody : T?
    
    init(url: EndPoint, httpBody: T){
        self.url = url
        self.httpBody = httpBody
    }
}

enum APIError: Error {
    case unauthorized          //Status code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case timedOut               //Status code 408
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case serviceFailureError(errorCode: String, errorMessage: String)
    case noInternet(erroMessage:String)
    case jsonConversionFailure
}
