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
    func array(from jsonString: String?) -> [Any] {
        guard let jsonString else { return [] }
        guard !jsonString.isEmpty else { return [] }
        let jsonData = Data.init(base64Encoded: jsonString) ?? Data(jsonString.utf8)
        return self.array(from: jsonData)
    }
    func array(from jsonString: String?) -> DNSDataArray {
        guard let jsonString else { return DNSDataArray.empty }
        guard !jsonString.isEmpty else { return DNSDataArray.empty }
        let jsonData = Data.init(base64Encoded: jsonString) ?? Data(jsonString.utf8)
        return self.array(from: jsonData)
    }
    func dictionary(from jsonString: String?) -> DNSDataDictionary {
        guard let jsonString else { return DNSDataDictionary.empty }
        guard !jsonString.isEmpty else { return DNSDataDictionary.empty }
        let jsonData = Data.init(base64Encoded: jsonString) ?? Data(jsonString.utf8)
        return self.dictionary(from: jsonData)
    }
    func array(from jsonData: Data?) -> [Any] {
        guard let jsonData else { return [] }
        guard !jsonData.isEmpty else { return [] }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is [Any] else { return [jsonObject] }
            return jsonObject as! [Any]
        } catch {
            return []
        }
    }
    func array(from jsonData: Data?) -> DNSDataArray {
        guard let jsonData else { return DNSDataArray.empty }
        guard !jsonData.isEmpty else { return DNSDataArray.empty }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is DNSDataArray else {
                guard jsonObject is DNSDataDictionary else {
                    return [["array": jsonObject]]
                }
                return [jsonObject as! DNSDataDictionary]
            }
            return jsonObject as! DNSDataArray
        } catch {
            return DNSDataArray.empty
        }
    }
    func dictionary(from jsonData: Data?) -> DNSDataDictionary {
        guard let jsonData else { return DNSDataDictionary.empty }
        guard !jsonData.isEmpty else { return DNSDataDictionary.empty }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData)
            guard jsonObject is DNSDataDictionary else { return ["array": jsonObject] }
            return jsonObject as! DNSDataDictionary
        } catch {
            return DNSDataDictionary.empty
        }
    }
}
