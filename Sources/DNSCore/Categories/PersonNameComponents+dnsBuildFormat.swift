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

    static func dnsBuildName(with name: String = "",
                             and nickname: String? = nil) -> PersonNameComponents? {
        var retval = PersonNameComponents()
        do {
            if #available(iOS 15.0, *) {
                retval = try PersonNameComponents(name)
            } else {
                let formatter = PersonNameComponentsFormatter()
                retval = formatter.personNameComponents(from: name) ?? retval
            }
        } catch { }
        retval.nickname = nickname
        return retval
    }
    @available(iOS 15.0, *)
    func dnsFormatName(style: PersonNameComponents.FormatStyle.Style = .long) -> String {
        self.formatted(.name(style: style))
    }
    func dnsFormatName(style: PersonNameComponentsFormatter.Style = .default) -> String {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = style
        return formatter.string(from: self)
    }
}
