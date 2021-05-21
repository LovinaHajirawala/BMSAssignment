//
//  Extension+URL.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import Foundation
extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }
       

        //1 Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        //2 Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        //3 Append the new query item in the existing query items array
        queryItems.append(queryItem)

        //4 Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        //5 Returns the url from new url components
        self = urlComponents.url!
    }
}
// end of extension
