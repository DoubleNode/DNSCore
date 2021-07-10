//
//  DNSDataTranslationErrors.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import DNSError
import Foundation

public enum DNSDataTranslationError: Error
{
    case reentered(_ codeLocation: DNSCodeLocation)
}
extension DNSDataTranslationError: DNSError {
    public static let domain = "DATATRANSLATION"
    public enum Code: Int
    {
        case reentered = 1001
    }
    
    public var nsError: NSError! {
        switch self {
        case .reentered(let codeLocation):
            var userInfo = codeLocation.userInfo
            userInfo[NSLocalizedDescriptionKey] = self.errorString
            return NSError.init(domain: Self.domain,
                                code: Self.Code.reentered.rawValue,
                                userInfo: userInfo)
        }
    }
    public var errorDescription: String? {
        return self.errorString
    }
    public var errorString: String {
        switch self {
        case .reentered:
            return String(format: NSLocalizedString("DATATRANSLATION-Reentered Error%@", comment: ""),
                          " (\(Self.domain):\(Self.Code.reentered.rawValue))")
        }
    }
    public var failureReason: String? {
        switch self {
        case .reentered(let codeLocation):
            return codeLocation.failureReason
        }
    }
}
