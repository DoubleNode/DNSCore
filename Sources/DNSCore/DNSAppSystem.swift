//
//  DNSAppSystem.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation
import UIKit

public class DNSAppSystem {
    public enum Status {
        case green, yellow, red
    }

    var code: String
    var name: String
    var status: Status = .green

    required init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}
