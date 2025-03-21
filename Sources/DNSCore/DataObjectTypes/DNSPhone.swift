//
//  DNSPhone.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import AtomicSwift
import Contacts
import Foundation
import PhoneNumberKit

open class DNSPhone: Codable {
    static let xlt = DNSDataTranslation()
    // MARK: - Properties -
    internal static func field(_ from: CodingKeys) -> String { return from.rawValue }
    enum CodingKeys: String, CodingKey {
        case phone
    }

    static let utility = PhoneNumberUtility()

    private var phone: PhoneNumber?

    public var countryCode: UInt64? {
        phone?.countryCode
    }
    public var leadingZero: Bool? {
        phone?.leadingZero
    }
    public var nationalNumber: UInt64? {
        phone?.nationalNumber
    }
    public var numberExtension: String? {
        phone?.numberExtension
    }
    public var numberString: String? {
        phone?.numberString
    }
    public var regionID: String? {
        phone?.regionID
    }
    public var type: PhoneNumberType? {
        phone?.type
    }

    required public init(_ phoneStr: String = "",
                         withRegion region: String = PhoneNumberUtility.defaultRegionCode(),
                         ignoreType: Bool = false) {
        self.parse(phoneStr, withRegion: region, ignoreType: ignoreType)
    }

    // MARK: - Object copy methods -
    required public init(from object: DNSPhone) {
        self.update(from: object)
    }
    open func update(from object: DNSPhone) {
        self.phone = object.phone
    }

    public func format(toType formatType: PhoneNumberFormat,
                       withPrefix prefix: Bool = true) -> String {
        guard let phone else { return "" }
        return Self.utility.format(phone, toType: formatType, withPrefix: prefix)
    }
    public func parse(_ numberString: String,
                      withRegion region: String = PhoneNumberUtility.defaultRegionCode(),
                      ignoreType: Bool = false) {
        self.phone = try? Self.utility.parse(numberString, withRegion: region, ignoreType: ignoreType)
    }

    // MARK: - Codable protocol methods -
    required public init?(coder: NSCoder) {
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.phone = try container.decodeIfPresent(PhoneNumber.self, forKey: .phone)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.phone, forKey: .phone)
    }

    // NSCopying protocol methods
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = DNSPhone(from: self)
        return copy
    }
    open func isDiffFrom(_ rhs: Any?) -> Bool {
        guard let rhs = rhs as? DNSPhone else { return true }
        let lhs = self
        return
            lhs.phone != rhs.phone
    }

    // MARK: - Equatable protocol methods -
    static public func != (lhs: DNSPhone, rhs: DNSPhone) -> Bool {
        lhs.isDiffFrom(rhs)
    }
    static public func == (lhs: DNSPhone, rhs: DNSPhone) -> Bool {
        !lhs.isDiffFrom(rhs)
    }
}
