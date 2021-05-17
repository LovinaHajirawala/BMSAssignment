//
//  ErrorParser.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 16/05/21.
//

import Foundation

let COMMON_ERROR_MESSAGE = "Something went wrong. Please try again later."

class ErrorParser: NSObject {
    
    class func getErrorMessage(error: Error) -> String{
        // 1
        guard let apiError = error as? APIError else {
            return COMMON_ERROR_MESSAGE
        }
        // 2
        switch apiError {
        case .noInternet(let errorMessage):
            return errorMessage
            
        case .serviceFailureError(let errorCode, let errorMessage):
            
            if(!errorCode.isEmpty){
                return errorMessage
            }
            else{
                return COMMON_ERROR_MESSAGE
            }
        default:
            return COMMON_ERROR_MESSAGE
            
        }
    }

}
