//
//  DNSDataTranslation+PersonName.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation

public extension DNSDataTranslation {
    // MARK: - string...
    func personName<K>(from container: KeyedDecodingContainer<K>,
                       forKey key: KeyedDecodingContainer<K>.Key) -> PersonNameComponents? where K: CodingKey {
        do { return personName(from: try container.decodeIfPresent(PersonNameComponents.self, forKey: key)) } catch { }
        do { return personName(from: try container.decodeIfPresent([String: String].self, forKey: key)) } catch { }
        do { return personName(from: try container.decodeIfPresent(String.self, forKey: key)) } catch { }
        return nil
    }
    func personName(from any: Any?) -> PersonNameComponents? {
        guard let any else { return nil }
        if any is PersonNameComponents {
            return self.personName(from: any as? PersonNameComponents)
        } else if any is [String: String] {
            return self.personName(from: any as? [String: String])
        }
        return self.personName(from: any as? String)
    }
    func personName(from data: [String: String]?) -> PersonNameComponents? {
        guard let data else { return nil }
        return PersonNameComponents(from: data)
    }
    func personName(from string: String?) -> PersonNameComponents? {
        guard let string else { return nil }
        return PersonNameComponents.dnsBuildName(with: string)
    }
    func personName(from personName: PersonNameComponents?) -> PersonNameComponents? {
        guard let personName else { return nil }
        return personName
    }
}
