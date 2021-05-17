//
//  NetworkConnectivity.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 16/05/21.
//

import Foundation
import SystemConfiguration

public class NetworkConnectivity {

    public static func isConnectedToNetwork() -> Bool {
        // 1
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        // 2
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            // 3
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {

                SCNetworkReachabilityCreateWithAddress(nil, $0)

            }

        }) else {
            // 4
            return false
        }
        // 5
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        // 6
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        // 7
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        // 8
        return (isReachable && !needsConnection)
    }

}
