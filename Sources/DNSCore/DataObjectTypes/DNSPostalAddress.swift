//
//  DNSPostalAddress.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import AtomicSwift
import Contacts
import Foundation

open class DNSPostalAddress: CNMutablePostalAddress, Codable {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case city, country, isoCountryCode, nickname, postalCode, state, street, subAdministrativeArea, subLocality
    }

    public var nickname: String = ""
    
    public var isEmpty: Bool { self == DNSPostalAddress() }

    // name formatted output
    public var asString: String {
        self.dnsFormatAddress(style: .mailingAddress)
            .replacingOccurrences(of: "\n", with: ", ")
    }
    public var mailingAddress: String { self.dnsFormatAddress(style: .mailingAddress) }

    public func dnsFormatAddress(style: CNPostalAddressFormatterStyle = .mailingAddress) -> String {
        var retval = CNPostalAddressFormatter.string(from: self, style: style)
        switch style {
        case .mailingAddress:
            if !nickname.isEmpty {
                retval = "\(nickname)\n\(retval)"
            }
        default:
            if !nickname.isEmpty {
                retval = "\(nickname), \(retval)"
            }
        }
        return retval
    }

    required public init(_ nickname: String = "",
                         street: String = "",
                         subLocality: String = "",
                         city: String = "",
                         subAdministrativeArea: String = "",
                         state: String = "",
                         postalCode: String = "",
                         country: String = "",
                         isoCountryCode: String = "") {
        super.init()
        self.nickname = nickname
        self.street = street
        self.subLocality = subLocality
        self.city = city
        self.subAdministrativeArea = subAdministrativeArea
        self.state = state
        self.postalCode = postalCode
        self.country = country
        self.isoCountryCode = isoCountryCode
    }

    // MARK: - Object copy methods -
    required public init(from object: DNSPostalAddress) {
        super.init()
        self.update(from: object)
    }
    open func update(from object: DNSPostalAddress) {
        self.nickname = object.nickname
        self.street = object.street
        self.subLocality = object.subLocality
        self.city = object.city
        self.subAdministrativeArea = object.subAdministrativeArea
        self.state = object.state
        self.postalCode = object.postalCode
        self.country = object.country
        self.isoCountryCode = object.isoCountryCode
    }

    // MARK: - Codable protocol methods -
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    required public init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        self.street = try container.decodeIfPresent(String.self, forKey: .street) ?? ""
        self.subLocality = try container.decodeIfPresent(String.self, forKey: .subLocality) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.subAdministrativeArea = try container.decodeIfPresent(String.self, forKey: .subAdministrativeArea) ?? ""
        self.state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.isoCountryCode = try container.decodeIfPresent(String.self, forKey: .isoCountryCode) ?? ""
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.nickname, forKey: .nickname)
        try container.encode(self.street, forKey: .street)
        try container.encode(self.subLocality, forKey: .subLocality)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.postalCode, forKey: .postalCode)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.isoCountryCode, forKey: .isoCountryCode)
    }

    // NSCopying protocol methods
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copy = DNSPostalAddress(from: self)
        return copy
    }
    open func isDiffFrom(_ rhs: Any?) -> Bool {
        guard let rhs = rhs as? DNSPostalAddress else { return true }
        let lhs = self
        return lhs != rhs ||
            lhs.nickname != rhs.nickname
    }

    // MARK: - Equatable protocol methods -
    static public func !=(lhs: DNSPostalAddress, rhs: DNSPostalAddress) -> Bool {
        lhs.isDiffFrom(rhs)
    }
    public static func == (lhs: DNSPostalAddress, rhs: DNSPostalAddress) -> Bool {
        lhs.nickname == rhs.nickname &&
        lhs.street == rhs.street &&
        lhs.subLocality == rhs.subLocality &&
        lhs.city == rhs.city &&
        lhs.subAdministrativeArea == rhs.subAdministrativeArea &&
        lhs.state == rhs.state &&
        lhs.postalCode == rhs.postalCode &&
        lhs.country == rhs.country &&
        lhs.isoCountryCode == rhs.isoCountryCode
    }
}
