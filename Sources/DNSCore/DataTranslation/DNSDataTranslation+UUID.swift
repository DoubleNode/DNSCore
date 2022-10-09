//
//  DNSDataTranslation+UUID.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - uuid...
    // swiftlint:disable:next cyclomatic_complexity
    func uuid(from any: Any?) -> UUID? {
        guard let any else { return nil }
        if any is UUID {
            return self.uuid(from: any as? UUID)
        }
        return self.uuid(from: any as? String)
    }
    func uuid(from string: String?) -> UUID? {
        guard var string else { return nil }
        guard !string.isEmpty else { return nil }
        return UUID(uuidString: string)
    }
    func uuid(from uuid: UUID?) -> UUID? {
        guard var uuid else { return nil }
        return uuid
    }
}
