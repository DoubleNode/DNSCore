//
//  DNSDevice.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit

public class DNSDevice {
    public class var osVersion: String {
        return UIDevice.current.systemVersion
    }
    public class var screenHeight: CGFloat {
        return UIScreen.main.bounds.height * UIScreen.main.scale
    }
    public class var screenHeightUnits: CGFloat {
        return UIScreen.main.bounds.height
    }
    public class var screenSize: CGSize {
        return CGSize.init(width: self.screenWidth, height: self.screenHeight)
    }
    public class var screenSizeUnits: CGSize {
        return CGSize.init(width: self.screenWidthUnits, height: self.screenHeightUnits)
    }
    public class var screenWidth: CGFloat {
        return UIScreen.main.bounds.width * UIScreen.main.scale
    }
    public class var screenWidthUnits: CGFloat {
        return UIScreen.main.bounds.width
    }

    public class var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    public class var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    public class var tallPhone: Bool {
        return self.iPhone && self.screenHeight >= 1136
    }

    public class var activeWindowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
    public class var activeWindow: UIWindow? {
        return self.activeWindowScene?.windows.first
    }

    public class var landscape: Bool {
        if self.activeWindowScene?.interfaceOrientation == .landscapeLeft ||
            self.activeWindowScene?.interfaceOrientation == .landscapeRight {
            return true
        }
        return false
    }
    public class var portrait: Bool {
        if self.activeWindowScene?.interfaceOrientation == .portrait ||
            self.activeWindowScene?.interfaceOrientation == .portraitUpsideDown {
            return true
        }
        return false
    }

    public class var biometricIdAvailable: Bool {
        guard NSClassFromString("LAContext") != nil else { return false }
        guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
            return false
        }

        return true
    }
    public class var faceIdAvailable: Bool {
        guard NSClassFromString("LAContext") != nil else { return false }
        guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
            return false
        }
        guard #available(iOS 11, *) else { return false }
        guard LAContext.init().biometryType == LABiometryType.faceID else { return false }

        return true
    }
    public class var touchIdAvailable: Bool {
        guard NSClassFromString("LAContext") != nil else { return false }
        guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
            return false
        }
        if #available(iOS 11, *) {
            guard LAContext.init().biometryType == LABiometryType.touchID else { return false }
        }

        return true
    }

    public class var applicationDocumentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.allDomainsMask, true).last!
    }
}
