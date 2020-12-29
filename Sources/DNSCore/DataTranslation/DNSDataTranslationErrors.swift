//
//  DNSDataTranslationErrors.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public enum DNSDataTranslationError: Error
{
    case reentered(domain: String, file: String, line: String, method: String)
}
extension DNSDataTranslationError: DNSError {
    public static let domain = "DATATRANSLATION"
    public enum Code: Int
    {
        case reentered = 1001
    }
    
    public var nsError: NSError! {
        switch self {
        case .reentered(let domain, let file, let line, let method):
            let userInfo: [String : Any] = [
                "DNSDomain": domain, "DNSFile": file, "DNSLine": line, "DNSMethod": method,
                NSLocalizedDescriptionKey: self.errorDescription ?? "Reentered Error"
            ]
            return NSError.init(domain: Self.domain,
                                code: Self.Code.reentered.rawValue,
                                userInfo: userInfo)
        }
    }
    public var errorDescription: String? {
        switch self {
        case .reentered:
            return NSLocalizedString("DATATRANSLATION-Reentered Error", comment: "")
                + " (\(Self.domain):\(Self.Code.reentered.rawValue))"
        }
    }
    public var failureReason: String? {
        switch self {
        case .reentered(let domain, let file, let line, let method):
            return "\(domain):\(file):\(line):\(method)"
        }
    }
}

