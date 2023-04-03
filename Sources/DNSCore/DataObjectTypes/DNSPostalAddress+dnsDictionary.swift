//
//  DNSPostalAddress+dnsDictionary.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import UIKit

public extension DNSPostalAddress {
    convenience init?(from data: DNSDataDictionary) {
        guard !data.isEmpty else { return nil }
        let nickname = Self.xlt.string(from: data[Self.field(.nickname)] as Any?) ?? ""
        let street = Self.xlt.string(from: data[Self.field(.street)] as Any?) ?? ""
        let subLocality = Self.xlt.string(from: data[Self.field(.subLocality)] as Any?) ?? ""
        let city = Self.xlt.string(from: data[Self.field(.city)] as Any?) ?? ""
        let subAdministrativeArea = Self.xlt.string(from: data[Self.field(.subAdministrativeArea)] as Any?) ?? ""
        let state = Self.xlt.string(from: data[Self.field(.state)] as Any?) ?? ""
        let postalCode = Self.xlt.string(from: data[Self.field(.postalCode)] as Any?) ?? ""
        let country = Self.xlt.string(from: data[Self.field(.country)] as Any?) ?? ""
        let isoCountryCode = Self.xlt.string(from: data[Self.field(.isoCountryCode)] as Any?) ?? ""
        self.init(street, subLocality: subLocality, city: city, subAdministrativeArea: subAdministrativeArea,
                  state: state, postalCode: postalCode, country: country, isoCountryCode: isoCountryCode)
        self.nickname = nickname
    }
    var asDictionary: DNSDataDictionary {
        var retval = DNSDataDictionary()
        retval.merge([
            Self.field(.nickname): self.nickname,
            Self.field(.street): self.street,
            Self.field(.subLocality): self.subLocality,
            Self.field(.city): self.city,
            Self.field(.subAdministrativeArea): self.subAdministrativeArea,
            Self.field(.state): self.state,
            Self.field(.postalCode): self.postalCode,
            Self.field(.country): self.country,
            Self.field(.isoCountryCode): self.isoCountryCode,
        ]) { (current, _) in current }
        return retval
    }
}
