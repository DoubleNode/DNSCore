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
    func jsonArray(from jsonString: String?) -> [Any] {
        guard let jsonString else { return [] }
        guard !jsonString.isEmpty else { return [] }
        let jsonData = Data.init(base64Encoded: jsonString) ?? Data(jsonString.utf8)
        return self.array(from: jsonData)
    }
    func jsonArray(from jsonData: Data?) -> [Any] {
        guard let jsonData else { return [] }
        guard !jsonData.isEmpty else { return [] }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is [Any] else { return [jsonObject] }
            return jsonObject as! [Any] // swiftlint:disable:this force_cast
        } catch {
            return []
        }
    }
    func jsonString(from array: DNSDataArray?) -> String {
        guard let array else { return "" }
        guard !array.isEmpty else { return "" }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array)
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
    func jsonString(from dictionary: DNSDataDictionary?) -> String {
        guard let dictionary else { return "" }
        guard !dictionary.isEmpty else { return "" }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary)
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
