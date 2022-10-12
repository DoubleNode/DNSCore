//
//  DNSDataTranslation+Data.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - data...
    func data<K>(from container: KeyedDecodingContainer<K>,
                 forKey key: KeyedDecodingContainer<K>.Key) -> Data? where K: CodingKey {
        do { return data(from: try container.decodeIfPresent(Data.self, forKey: key)) } catch { }
        return nil
    }
    // swiftlint:disable:next cyclomatic_complexity
    func data(from any: Any?) -> Data? {
        guard let any else { return nil }
        return self.data(from: any as? Data)
    }
    func data(from data: Data?) -> Data? {
        guard let data else { return nil }
        return data
    }
}
