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
    static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case familyName, givenName, middleName, namePrefix, nameSuffix, nickname
    }

    init?(from data: DNSDataDictionary) {
        guard !data.isEmpty else { return nil }
        self = PersonNameComponents()
        self.familyName =  Self.xlt.string(from: data[Self.field(.familyName)] as Any?) ?? ""
        self.givenName =  Self.xlt.string(from: data[Self.field(.givenName)] as Any?) ?? ""
        self.middleName =  Self.xlt.string(from: data[Self.field(.middleName)] as Any?) ?? ""
        self.namePrefix =  Self.xlt.string(from: data[Self.field(.namePrefix)] as Any?) ?? ""
        self.nameSuffix =  Self.xlt.string(from: data[Self.field(.nameSuffix)] as Any?) ?? ""
        self.nickname =  Self.xlt.string(from: data[Self.field(.nickname)] as Any?) ?? ""
    }
    var asDictionary: DNSDataDictionary {
        var retval = DNSDataDictionary()
        if let familyName = self.familyName {
            if !familyName.isEmpty {
                retval.merge([
                    Self.field(.familyName): self.familyName ?? "",
                ]) { (current, _) in current }
            }
        }
        if let givenName = self.givenName {
            if !givenName.isEmpty {
                retval.merge([
                    Self.field(.givenName): self.givenName ?? "",
                ]) { (current, _) in current }
            }
        }
        if let middleName = self.middleName {
            if !middleName.isEmpty {
                retval.merge([
                    Self.field(.middleName): self.middleName ?? "",
                ]) { (current, _) in current }
            }
        }
        if let namePrefix = self.namePrefix {
            if !namePrefix.isEmpty {
                retval.merge([
                    Self.field(.namePrefix): self.namePrefix ?? "",
                ]) { (current, _) in current }
            }
        }
        if let nameSuffix = self.nameSuffix {
            if !nameSuffix.isEmpty {
                retval.merge([
                    Self.field(.nameSuffix): self.nameSuffix ?? "",
                ]) { (current, _) in current }
            }
        }
        if let nickname = self.nickname {
            if !nickname.isEmpty {
                retval.merge([
                    Self.field(.nickname): self.nickname ?? "",
                ]) { (current, _) in current }
            }
        }
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

    // Equatable protocol methods
    static func == (lhs: PersonNameComponents, rhs: PersonNameComponents) -> Bool {
        (lhs.namePrefix ?? "") == (rhs.namePrefix ?? "") &&
        (lhs.givenName ?? "") == (rhs.givenName ?? "") &&
        (lhs.middleName ?? "") == (rhs.middleName ?? "") &&
        (lhs.familyName ?? "") == (rhs.familyName ?? "") &&
        (lhs.nameSuffix ?? "") == (rhs.nameSuffix ?? "") &&
        (lhs.nickname ?? "") == (rhs.nickname ?? "") &&
        lhs.phoneticRepresentation == rhs.phoneticRepresentation
    }
}
