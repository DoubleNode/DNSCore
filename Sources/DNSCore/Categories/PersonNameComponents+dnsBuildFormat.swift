//
//  PersonNameComponents+dnsBuildFormat.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension PersonNameComponents {
    static let xlt = DNSDataTranslation()
    init?(from data: DNSDataDictionary) {
        guard !data.isEmpty else { return nil }
        let name = Self.xlt.string(from: data["long"] as Any?) ?? ""
        let nickname =  Self.xlt.string(from: data["nickname"] as Any?) ?? ""
        guard let retval = PersonNameComponents.dnsBuildName(with: name, and: nickname) else { return nil }
        self = retval
    }
    var asDictionary: DNSDataDictionary {
        var retval = DNSDataDictionary()
        retval.merge([
            "long": self.dnsFormatName(style: .long),
            "nickname": self.nickname ?? "",
        ]) { (current, _) in current }
        return retval
    }

    var dnsSortableName: String {
        var retval = self.familyName ?? ""
        if retval.isEmpty {
            return self.dnsFormatName(style: .long)
        }
        if let givenName = self.givenName {
            retval += ", \(givenName)"
            if let middleName = self.middleName {
                retval += " \(middleName)"
            }
            if let nickname = self.nickname {
                retval += " (\(nickname))"
            }
        } else if let nickname = self.nickname {
            retval += ", \(nickname)"
        }
        return retval
    }
    
    static func dnsBuildName(with name: String = "",
                             and nickname: String? = nil) -> PersonNameComponents? {
        var retval = PersonNameComponents()
        do {
            retval = try PersonNameComponents(name)
        } catch { }
        retval.nickname = nickname
        return retval
    }
    func dnsFormatName(style: PersonNameComponents.FormatStyle.Style = .long) -> String {
        self.formatted(.name(style: style))
    }
}
