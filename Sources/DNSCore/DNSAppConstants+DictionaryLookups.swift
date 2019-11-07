//
//  DNSAppConstants+DictionaryLookups.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import Foundation
import UIKit

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
        if (selectionSubData as? [String: Any]) != nil {
            return (selectionSubData as? [String: Any] ?? [:])[C.AppConstants.state] as? String? ?? ""
        }
        return selectionData[key] as? String? ?? ""
    }
    class func dictionaryLookup(fromOptions optionsData: [String: Any], for key: String) -> Any {
        var noUI = translator.bool(from: DNSCore.appSetting(for: C.AppConstants.appConstantsNoUI,
                                                            withDefault: false)) ?? false
        if Thread.isMainThread {
            noUI = true
        }
        if translator.bool(from: optionsData[C.AppConstants.noUI]) ?? false {
            noUI = true
        }
        if noUI {
            return dictionaryLookupWithoutUI(fromOptions: optionsData, for: key)
        }

        var retval: Any?

        let semaphore = DNSSemaphoreGate()
        DNSUIThread.run {
            let title   = translator.string(from: optionsData[C.AppConstants.title]) ?? "\(key)_TITLE_NOT_SPECIFIED"
            let message = translator.string(from: optionsData[C.AppConstants.message]) ?? "\(key)_MESSAGE_NOT_SPECIFIED"
            let options = optionsData[C.AppConstants.options] as? [[String: Any]] ?? []

            let alertController = UIAlertController.init(title: "S: \(title)",
                                                         message: message,
                                                         preferredStyle: UIAlertController.Style.alert)
            for option: [String: Any] in options {
                let label = translator.string(from: option[C.AppConstants.label]) ??
                                "\(key)_OPTION_LABEL_NOT_SPECIFIED"

                alertController.addAction(UIAlertAction.init(title: label,
                                                             style: UIAlertAction.Style.default)
                { (_: UIAlertAction) in
                    retval = option
                    _ = semaphore.done()
                })
            }

            DNSCore.appDelegate.rootViewController().present(alertController,
                                                             animated: true,
                                                             completion: nil)
        }

        _ = semaphore.wait()

        return self.plistConfigValue(replace: key, with: retval!)
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

    private class func dictionaryLookupCreateCheckbox(forState state: Bool) -> UIButton {
        let targetController: DNSAppConstantsRootProtocol =
            // swiftlint:disable:next force_cast
            DNSCore.appDelegate.rootViewController() as! DNSAppConstantsRootProtocol

        let checkbox = UIButton.init(type: UIButton.ButtonType.custom)

        checkbox.frame      = CGRect.init(x: 2, y: 2, width: 18, height: 18)
        checkbox.tag        = 1
        checkbox.isSelected = state
        checkbox.addTarget(targetController,
                           action: #selector(DNSAppConstantsRootProtocol.checkBoxPressed),
                           for: UIControl.Event.touchUpInside)

        checkbox.imageView?.contentMode = .scaleAspectFit
        checkbox.setImage(UIImage.init(named: C.AppConstants.iconCheckmarkOff), for: UIControl.State.normal)
        checkbox.setImage(UIImage.init(named: C.AppConstants.iconCheckmarkOn), for: UIControl.State.selected)
        checkbox.setImage(UIImage.init(named: C.AppConstants.iconCheckmarkOn), for: UIControl.State.highlighted)
        checkbox.adjustsImageWhenHighlighted = true

        return checkbox
    }

    private class func dictionaryLookupDisplayToggles(fromToggles togglesData: [String: Any],
                                                      for key: String,
                                                      completionBlock: @escaping DNSBlock)
        -> [String: [String: Any]] {

        var retval: [String: [String: Any]] = [:]

        DNSUIThread.run {
            let targetController: DNSAppConstantsRootProtocol =
                // swiftlint:disable:next force_cast
                DNSCore.appDelegate.rootViewController() as! DNSAppConstantsRootProtocol

            let title   = translator.string(from: togglesData[C.AppConstants.title]) ?? "\(key)_TITLE_NOT_SPECIFIED"
            let message = translator.string(from: togglesData[C.AppConstants.message]) ?? "\(key)_MESSAGE_NOT_SPECIFIED"
            let toggles = togglesData[C.AppConstants.toggles] as? [[String: Any]] ?? []

            let alertController = UIAlertController.init(title: "\(title)",
                                                         message: message,
                                                         preferredStyle: UIAlertController.Style.alert)
            for var toggle: [String: Any] in toggles {
                let key     = translator.string(from: toggle[C.AppConstants.key]) ?? "\(key)_TOGGLE_KEY_NOT_SPECIFIED"
                let label   = translator.string(from: toggle[C.AppConstants.label]) ??
                                "\(key)_TOGGLE_LABEL_NOT_SPECIFIED"
                let state   = translator.bool(from: toggle[C.AppConstants.default]) ?? false

                toggle[C.AppConstants.state] = translator.string(from: state) ?? C.AppConstants.false
                retval[key]     = toggle

                alertController.addTextField { (textField: UITextField) in
                    let checkbox = dictionaryLookupCreateCheckbox(forState: state)

                    toggle[C.AppConstants.button] = checkbox

                    textField.clearButtonMode   = .always
                    textField.rightViewMode     = .always
                    textField.rightView         = checkbox
                    textField.tag               = -1
                    textField.delegate          = targetController
                    textField.text              = label

                    retval[key]     = toggle
                }
            }

            alertController.addAction(UIAlertAction.init(title: NSLocalizedString("OK", comment: "OK"),
                                                         style: UIAlertAction.Style.default)
            { (_: UIAlertAction) in
                completionBlock()
            })

            DNSCore.appDelegate.rootViewController().present(alertController,
                                                             animated: true,
                                                             completion: nil)
        }

        return retval
    }

    private class func dictionaryLookup(fromToggles togglesData: [String: Any], for key: String) -> Any {
        var noUI = translator.bool(from: DNSCore.appSetting(for: C.AppConstants.appConstantsNoUI,
                                                            withDefault: false)) ?? false
        if Thread.isMainThread {
            noUI = true
        }
        if translator.bool(from: togglesData[C.AppConstants.noUI]) ?? false {
            noUI = true
        }
        if noUI {
            return dictionaryLookupWithoutUI(fromToggles: togglesData, for: key)
        }

        let semaphore = DNSSemaphoreGate()

        var retval = dictionaryLookupDisplayToggles(fromToggles: togglesData, for: key, completionBlock: {
            _ = semaphore.done()
        })

        _ = semaphore.wait()

        DNSUIThread.run {
            for key: String in retval.keys {
                var object      = retval[key]!
                let checkbox    = object[C.AppConstants.button] as? UIButton ?? nil
                if checkbox?.isSelected ?? false {
                    object[C.AppConstants.state] = C.AppConstants.true
                } else {
                    object[C.AppConstants.state] = C.AppConstants.false
                }
                retval[key]     = object
            }
        }

        return self.plistConfigValue(replace: key, with: retval)
    }
    private class func dictionaryLookupWithoutUI(fromToggles togglesData: [String: Any], for key: String) -> Any {
        let toggles     = togglesData[C.AppConstants.toggles] as? [[String: Any]] ?? []

        var retval: [String: [String: Any]] = [:]

        for var toggle: [String: Any] in toggles {
            let key     = translator.string(from: toggle[C.AppConstants.key]) ?? "\(key)_TOGGLE_KEY_NOT_SPECIFIED"
            let state   = translator.bool(from: toggle[C.AppConstants.default]) ?? false

            toggle[C.AppConstants.state] = translator.string(from: state) ?? C.AppConstants.false
            retval[key]     = toggle
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
