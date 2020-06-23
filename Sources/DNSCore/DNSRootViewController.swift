//
//  DNSRootViewController.swift
//  DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import UIKit

public class DNSRootViewController: UIViewController, DNSAppConstantsRootProtocol, UITextFieldDelegate {
    @objc
    public func checkBoxPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textField.tag != -1
    }
}
