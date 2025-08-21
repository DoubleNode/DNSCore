//
//  DNSAppConstants+DictionaryLookups.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
#if !os(macOS)
import UIKit
#endif

// MARK: - Sendable data structures for UI operations
private struct SendableOptionData: Sendable {
    let label: String
    let index: Int  // Use index to reference original option
}

extension DNSAppConstants {
    class func dictionaryLookup(fromConstant constant: String, for key: String) -> String? {
        var selectionData: [String: Any] = self.plistConfigValue(for: constant) as? [String: Any] ?? [:]

        guard selectionData[C.AppConstants.options] == nil else {
            selectionData = dictionaryLookup(fromOptions: selectionData, for: constant) as? [String: Any] ?? [:]
            return selectionData[key] as? String? ?? ""
        }
        guard selectionData[C.AppConstants.toggles] == nil else {
            selectionData = dictionaryLookup(fromToggles: selectionData, for: constant) as? [String: Any] ?? [:]
            return (selectionData[key] as? [String: Any] ?? [:])[C.AppConstants.state] as? String? ?? ""
        }

        let selectionSubData = selectionData[key]
        if selectionSubData is [String: Any] {
            return (selectionSubData as? [String: Any] ?? [:])[C.AppConstants.state] as? String? ?? ""
        }
        return selectionData[key] as? String? ?? ""
    }

    // swiftlint:disable:next function_body_length
    class func dictionaryLookup(fromOptions optionsData: [String: Any], for key: String) -> Any {
        var noUI = translator.bool(from: DNSCore.appSetting(for: C.AppConstants.appConstantsNoUI,
                                                            withDefault: false)) ?? false
#if os(macOS)
        return dictionaryLookupWithoutUI(fromOptions: optionsData, for: key)
#else
        // Use a helper function to check UI availability on main thread
        if !noUI {
            let hasAppDelegate = MainActor.assumeIsolated {
                DNSCore.appDelegate != nil
            }
            if !hasAppDelegate {
                noUI = true
            }
        }

        if !noUI {
            let hasRootController = MainActor.assumeIsolated {
                DNSCore.appDelegate?.rootViewController() is (any DNSAppConstantsRootProtocol)
            }
            if !hasRootController {
                noUI = true
            }
        }

        if !noUI && Thread.isMainThread {
            noUI = true
        }
        if !noUI && translator.bool(from: optionsData[C.AppConstants.noUI]) ?? false {
            noUI = true
        }
        if noUI {
            return dictionaryLookupWithoutUI(fromOptions: optionsData, for: key)
        }

        // Create a class to hold mutable state in a Sendable way
        final class ResultHolder: @unchecked Sendable {
            private let lock = NSLock()
            private var _result: Any?

            func setResult(_ result: Any) {
                lock.lock()
                defer { lock.unlock() }
                _result = result
            }

            func getResult() -> Any? {
                lock.lock()
                defer { lock.unlock() }
                return _result
            }
        }

        // Extract Sendable values before passing to closures
        let title = translator.string(from: optionsData[C.AppConstants.title]) ?? "\(key)_TITLE_NOT_SPECIFIED"
        let message = translator.string(from: optionsData[C.AppConstants.message]) ?? "\(key)_MESSAGE_NOT_SPECIFIED"
        let options = optionsData[C.AppConstants.options] as? [[String: Any]] ?? []

        // Create a Sendable wrapper for the options array
        struct SendableOptionsWrapper: @unchecked Sendable {
            let options: [[String: Any]]

            init(_ options: [[String: Any]]) {
                self.options = options
            }
        }

        let sendableOptionsWrapper = SendableOptionsWrapper(options)

        // Extract only Sendable data for closure capture
        let sendableOptions: [SendableOptionData] = options.enumerated().map { index, option in
            let label = translator.string(from: option[C.AppConstants.label]) ?? "\(key)_OPTION_LABEL_NOT_SPECIFIED"
            return SendableOptionData(label: label, index: index)
        }

        let resultHolder = ResultHolder()
        let semaphore = DNSSemaphoreGate()

        DNSUIThread.run { [title, message, sendableOptions, key, sendableOptionsWrapper, resultHolder] in
            MainActor.assumeIsolated {
                let alertController = UIAlertController.init(title: title,
                                                             message: message,
                                                             preferredStyle: UIAlertController.Style.alert)
                for optionData in sendableOptions {
                    alertController.addAction(UIAlertAction.init(title: optionData.label,
                                                                 style: UIAlertAction.Style.default)
                    { [optionData, sendableOptionsWrapper, resultHolder] (_: UIAlertAction) in
                        // Use the index to get the original option from the stored array
                        resultHolder.setResult(sendableOptionsWrapper.options[optionData.index])
                        _ = semaphore.done()
                    })
                }

                DNSCore.appDelegate?.rootViewController().present(alertController,
                                                                  animated: true,
                                                                  completion: nil)
            }
        }

        _ = semaphore.wait()
        return self.plistConfigValue(replace: key, with: resultHolder.getResult()!)
#endif
    }

    private class func dictionaryLookupWithoutUI(fromOptions optionsData: [String: Any], for key: String) -> Any {
        let defaultKey  = translator.string(from: optionsData[C.AppConstants.default]) ?? ""
        let options     = optionsData[C.AppConstants.options] as? [[String: Any]] ?? []

        var retval: Any?

        for option: [String: Any] in options {
            let optionKey   = translator.string(from: option[C.AppConstants.key]) ?? "\(key)_OPTION_KEY_NOT_SPECIFIED"

            if optionKey == defaultKey {
                retval = option
            }
        }

        return self.plistConfigValue(replace: key, with: retval!)
    }

#if !os(macOS)
    private class func dictionaryLookupCreateCheckbox(forState state: Bool) -> UIButton {
        return MainActor.assumeIsolated {
            let targetController: (any DNSAppConstantsRootProtocol)? =
            DNSCore.appDelegate?.rootViewController() as? (any DNSAppConstantsRootProtocol)

            let checkbox = UIButton.init(type: UIButton.ButtonType.custom)

            checkbox.frame      = CGRect.init(x: 2, y: 2, width: 18, height: 18)
            checkbox.tag        = 1
            checkbox.isSelected = state
            checkbox.addTarget(targetController,
                               action: #selector((any DNSAppConstantsRootProtocol).checkBoxPressed),
                               for: UIControl.Event.touchUpInside)

            checkbox.imageView?.contentMode = .scaleAspectFit
            checkbox.setImage(UIImage.init(named: C.AppConstants.dnsCheckmarkOff), for: UIControl.State.normal)
            checkbox.setImage(UIImage.init(named: C.AppConstants.dnsCheckmarkOn), for: UIControl.State.selected)
            checkbox.setImage(UIImage.init(named: C.AppConstants.dnsCheckmarkOn), for: UIControl.State.highlighted)
    //        checkbox.adjustsImageWhenHighlighted = true

            return checkbox
        }
    }

    @MainActor
    private class func dictionaryLookupDisplayToggles(fromToggles togglesData: [String: Any],
                                                      for key: String,
                                                      completionBlock: @escaping @Sendable () -> Void)
        -> [String: [String: Any]] {

        var retval: [String: [String: Any]] = [:]

            let targetController: (any DNSAppConstantsRootProtocol)? =
            DNSCore.appDelegate?.rootViewController() as? (any DNSAppConstantsRootProtocol)

        // Extract Sendable values
        let title = translator.string(from: togglesData[C.AppConstants.title]) ?? "\(key)_TITLE_NOT_SPECIFIED"
        let message = translator.string(from: togglesData[C.AppConstants.message]) ?? "\(key)_MESSAGE_NOT_SPECIFIED"
        let toggles = togglesData[C.AppConstants.toggles] as? [[String: Any]] ?? []

        let alertController = UIAlertController.init(title: title,
                                                     message: message,
                                                     preferredStyle: UIAlertController.Style.alert)
        for var toggle: [String: Any] in toggles {
            let toggleKey = translator.string(from: toggle[C.AppConstants.key]) ?? "\(key)_TOGGLE_KEY_NOT_SPECIFIED"
            let label   = translator.string(from: toggle[C.AppConstants.label]) ??
                            "\(key)_TOGGLE_LABEL_NOT_SPECIFIED"
            let state   = translator.bool(from: toggle[C.AppConstants.default]) ?? false

            toggle[C.AppConstants.state] = translator.string(from: state) ?? C.AppConstants.false
            retval[toggleKey] = toggle

            alertController.addTextField { (textField: UITextField) in
                let checkbox = dictionaryLookupCreateCheckbox(forState: state)

                var updatedToggle = toggle
                updatedToggle[C.AppConstants.button] = checkbox

                textField.clearButtonMode   = .always
                textField.rightViewMode     = .always
                textField.rightView         = checkbox
                textField.tag               = -1
                textField.delegate          = targetController
                textField.text              = label

                retval[toggleKey] = updatedToggle
            }
        }

        alertController.addAction(UIAlertAction.init(title: NSLocalizedString("OK", comment: "OK"),
                                                     style: UIAlertAction.Style.default)
        { (_: UIAlertAction) in
            completionBlock()
        })

        DNSCore.appDelegate?.rootViewController().present(alertController,
                                                          animated: true,
                                                          completion: nil)

        return retval
    }
#endif

    // swiftlint:disable:next function_body_length
    private class func dictionaryLookup(fromToggles togglesData: [String: Any], for key: String) -> Any {
        var noUI = translator.bool(from: DNSCore.appSetting(for: C.AppConstants.appConstantsNoUI,
                                                            withDefault: false)) ?? false
#if os(macOS)
        return dictionaryLookupWithoutUI(fromToggles: togglesData, for: key)
#else
        // Check UI availability on main thread
        if !noUI {
            let hasAppDelegate = MainActor.assumeIsolated {
                DNSCore.appDelegate != nil
            }
            if !hasAppDelegate {
                noUI = true
            }
        }

        if !noUI {
            let hasRootController = MainActor.assumeIsolated {
                DNSCore.appDelegate?.rootViewController() is (any DNSAppConstantsRootProtocol)
            }
            if !hasRootController {
                noUI = true
            }
        }

        if !noUI && Thread.isMainThread {
            noUI = true
        }
        if !noUI && translator.bool(from: togglesData[C.AppConstants.noUI]) ?? false {
            noUI = true
        }
        if noUI {
            return dictionaryLookupWithoutUI(fromToggles: togglesData, for: key)
        }

        final class TogglesHolder: @unchecked Sendable {
            private let lock = NSLock()
            private var _toggles: [String: [String: Any]] = [:]
            private var _checkboxStates: [String: Bool] = [:]

            func setToggles(_ toggles: [String: [String: Any]]) {
                lock.lock()
                defer { lock.unlock() }
                _toggles = toggles
            }

            func getToggles() -> [String: [String: Any]] {
                lock.lock()
                defer { lock.unlock() }
                return _toggles
            }

            func setCheckboxState(_ key: String, _ state: Bool) {
                lock.lock()
                defer { lock.unlock() }
                _checkboxStates[key] = state
            }

            func getCheckboxStates() -> [String: Bool] {
                lock.lock()
                defer { lock.unlock() }
                return _checkboxStates
            }
        }

        let semaphore = DNSSemaphoreGate()
        let holder = TogglesHolder()

        // Create a Sendable wrapper for togglesData
        struct SendableTogglesDataWrapper: @unchecked Sendable {
            let data: [String: Any]

            init(_ data: [String: Any]) {
                self.data = data
            }
        }

        let sendableTogglesData = SendableTogglesDataWrapper(togglesData)

        DNSUIThread.run { [sendableTogglesData, key, holder] in
            MainActor.assumeIsolated {
                let toggles = dictionaryLookupDisplayToggles(fromToggles: sendableTogglesData.data, for: key, completionBlock: {
                    MainActor.assumeIsolated {
                        // Extract checkbox states when the UI is dismissed
                        let currentToggles = holder.getToggles()
                        for toggleKey: String in currentToggles.keys {
                            let object = currentToggles[toggleKey]!
                            let checkbox = object[C.AppConstants.button] as? UIButton
                            holder.setCheckboxState(toggleKey, checkbox?.isSelected ?? false)
                        }
                    }
                    _ = semaphore.done()
                })
                holder.setToggles(toggles)
            }
        }

        _ = semaphore.wait()

        // Process the results
        var retval: [String: [String: Any]] = [:]
        let toggles = holder.getToggles()
        let checkboxStates = holder.getCheckboxStates()

        for toggleKey: String in toggles.keys {
            var object = toggles[toggleKey]!
            let isSelected = checkboxStates[toggleKey] ?? false

            if isSelected {
                object[C.AppConstants.state] = C.AppConstants.true
            } else {
                object[C.AppConstants.state] = C.AppConstants.false
            }
            retval[toggleKey] = object
        }

        return self.plistConfigValue(replace: key, with: retval)
#endif
    }

    private class func dictionaryLookupWithoutUI(fromToggles togglesData: [String: Any], for key: String) -> Any {
        let toggles = togglesData[C.AppConstants.toggles] as? [[String: Any]] ?? []

        var retval: [String: [String: Any]] = [:]

        for var toggle: [String: Any] in toggles {
            let toggleKey = translator.string(from: toggle[C.AppConstants.key]) ?? "\(key)_TOGGLE_KEY_NOT_SPECIFIED"
            let state   = translator.bool(from: toggle[C.AppConstants.default]) ?? false

            toggle[C.AppConstants.state] = translator.string(from: state) ?? C.AppConstants.false
            retval[toggleKey] = toggle
        }

        return self.plistConfigValue(replace: key, with: retval)
    }

    class func dictionarySelection(from values: [String: Any], for key: String) -> Any {
        var selectionData: [String: Any] = values

        if selectionData[C.AppConstants.options] != nil {
            selectionData = self.dictionaryLookup(fromOptions: selectionData, for: key) as? [String: Any] ?? [:]
            if selectionData[C.AppConstants.key] != nil {
                return selectionData[C.AppConstants.key]!
            } else if selectionData[C.AppConstants.label] != nil {
                return selectionData[C.AppConstants.label]!
            }
            return "\(key)_OPTION_KEY_NOT_SPECIFIED"
        }
        if selectionData[C.AppConstants.toggles] != nil {
            selectionData = self.dictionaryLookup(fromToggles: selectionData, for: key) as? [String: Any] ?? [:]
            if selectionData[C.AppConstants.key] != nil {
                return selectionData[C.AppConstants.key]!
            } else if selectionData[C.AppConstants.label] != nil {
                return selectionData[C.AppConstants.label]!
            }
            return "\(key)_TOGGLE_KEY_NOT_SPECIFIED"
        }

        if selectionData[C.AppConstants.key] != nil {
            return selectionData[C.AppConstants.key]!
        }
        return selectionData
    }
}
