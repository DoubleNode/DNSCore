//
//  DNSRootNavigationController.swift
//  DNSCore
//
//  Created by Darren Ehlers on 8/14/19.
//  Copyright © 2019 DoubleNode.com. All rights reserved.
//

import Foundation
import UIKit

public class DNSRootNavigationController: UINavigationController, DNSAppConstantsRootProtocol, UITextFieldDelegate {
    @objc
    public func checkBoxPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textField.tag != -1
    }
}
