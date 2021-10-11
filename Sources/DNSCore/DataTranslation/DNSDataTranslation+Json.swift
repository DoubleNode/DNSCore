//
//  DNSDataTranslation+Json.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public extension DNSDataTranslation {
    // MARK: - Json Translations
    func array(from jsonString: String?) -> [Any]? {
        guard (jsonString?.count ?? 0) > 0 else { return nil }
        do {
            let jsonData    = Data.init(base64Encoded: jsonString!) ?? Data(jsonString!.utf8)
            let jsonObject  = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is [Any] else { return [jsonObject] }
            return jsonObject as? [Any]
        } catch {
            return []
        }
    }
    func dictionary(from jsonString: String?) -> [String: Any]? {
        guard (jsonString?.count ?? 0) > 0 else { return nil }
        do {
            let jsonData    = Data.init(base64Encoded: jsonString!) ?? Data(jsonString!.utf8)
            let jsonObject  = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is [String: Any] else { return ["array": jsonObject] }
            return jsonObject as? [String: Any]
        } catch {
            return [:]
        }
    }
}
