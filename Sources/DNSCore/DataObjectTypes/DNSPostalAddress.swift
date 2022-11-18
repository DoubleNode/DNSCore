//
//  DNSPostalAddress.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Contacts
import Foundation

open class DNSPostalAddress: CNMutablePostalAddress, Codable {
    static let xlt = DNSDataTranslation()
    static let formatter = CNPostalAddressFormatter()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case city, country, isoCountryCode, postalCode, state, street, subAdministrativeArea, subLocality
    }

    // name formatted output
    public var mailingAddress: String { self.dnsFormatAddress(style: .mailingAddress) }

    public func dnsFormatAddress(style: CNPostalAddressFormatterStyle = .mailingAddress) -> String {
        Self.formatter.string(from: self)
    }

    required public init(_ street: String = "",
                         subLocality: String = "",
                         city: String = "",
                         subAdministrativeArea: String = "",
                         state: String = "",
                         postalCode: String = "",
                         country: String = "",
                         isoCountryCode: String = "") {
        super.init()
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
        try container.encode(self.street, forKey: .street)
        try container.encode(self.subLocality, forKey: .subLocality)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.postalCode, forKey: .postalCode)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.isoCountryCode, forKey: .isoCountryCode)
    }

    // Equatable protocol methods
    public static func == (lhs: DNSPostalAddress, rhs: DNSPostalAddress) -> Bool {
        lhs.street == rhs.street &&
        lhs.subLocality == rhs.subLocality &&
        lhs.city == rhs.city &&
        lhs.subAdministrativeArea == rhs.subAdministrativeArea &&
        lhs.state == rhs.state &&
        lhs.postalCode == rhs.postalCode &&
        lhs.country == rhs.country &&
        lhs.isoCountryCode == rhs.isoCountryCode
    }

    // NSCopying protocol methods
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copy = DNSPostalAddress(from: self)
        return copy
    }
}
