//
//  URL+dnsBasedOn.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension URL {
    func basedOn(_ baseUrl: URL) -> URL? {
        let renamingPath = self.absoluteString.replacingOccurrences(of: baseUrl.absoluteString,
                                                                    with: "")
        if isFileURL {
            return URL(fileURLWithPath: renamingPath,
                       relativeTo: baseUrl)
        }
        return URL(string: renamingPath,
                   relativeTo: baseUrl)
    }
}
