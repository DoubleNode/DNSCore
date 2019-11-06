//
//  DNSDataTranslation.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation

public extension DNSDataTranslation {
    // MARK: - Json Translations
    func array(from jsonString: String?) -> [Any]? {
        guard (jsonString?.count ?? 0) > 0 else { return nil }

        do {
            let jsonData    = Data.init(base64Encoded: jsonString!)
            let jsonObject  = try JSONSerialization.jsonObject(with: jsonData!)
            guard jsonObject is [Any] else { return [jsonObject] }

            return jsonObject as? [Any]
        } catch {
            return [ ]
        }
    }
    func dictionary(from jsonString: String?) -> [String: Any]? {
        guard (jsonString?.count ?? 0) > 0 else { return nil }

        do {
            let jsonData    = Data.init(base64Encoded: jsonString!)
            let jsonObject  = try JSONSerialization.jsonObject(with: jsonData!)
            guard jsonObject is [String: Any] else { return ["array": jsonObject] }

            return jsonObject as? [String: Any]
        } catch {
            return [:]
        }
    }
}
