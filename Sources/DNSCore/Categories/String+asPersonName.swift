//
//  String+dnsMD5.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension String {
    var asPersonName: PersonNameComponents {
        PersonNameComponents.dnsBuildName(with: self) ?? PersonNameComponents()
    }
}
