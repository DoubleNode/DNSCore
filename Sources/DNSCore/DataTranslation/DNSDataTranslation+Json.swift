//
//  DNSDataTranslation+Json.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension DNSDataTranslation {
    // MARK: - Json Translations
    func array(from jsonString: String?) -> [Any]? {
        guard let jsonString = jsonString else { return nil }
        guard !jsonString.isEmpty else { return nil }
        do {
            let jsonData    = Data.init(base64Encoded: jsonString) ?? Data(jsonString.utf8)
            let jsonObject  = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is [Any] else { return [jsonObject] }
            return jsonObject as? [Any]
        } catch {
            return []
        }
    }
    func dictionary(from jsonString: String?) -> DNSDataDictionary {
        guard let jsonString = jsonString else { return [:] }
        guard !jsonString.isEmpty else { return [:] }
        do {
            let jsonData    = Data.init(base64Encoded: jsonString) ?? Data(jsonString.utf8)
            let jsonObject  = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is DNSDataDictionary else { return ["array": jsonObject] }
            return jsonObject as? DNSDataDictionary ?? [:]
        } catch {
            return [:]
        }
    }
}
