//
//  DNSDevice.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2021 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
#if !os(macOS)
import UIKit
#endif

public class DNSDevice {
    public class var osVersion: String {
#if !os(macOS)
        return UIDevice.current.systemVersion
#else
        return ProcessInfo.processInfo.operatingSystemVersionString
#endif
    }
#if !os(macOS)
    public class var safeAreaInsets: UIEdgeInsets {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets ?? UIEdgeInsets.zero
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
#endif

    public class var iPad: Bool {
#if !os(macOS)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
#else
        return false
#endif
    }
    public class var iPhone: Bool {
#if !os(macOS)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
#else
        return false
#endif
    }
#if !os(macOS)
    public class var tallPhone: Bool {
        return self.iPhone && self.screenHeight >= 1136
    }
#endif

#if !os(macOS)
    public class var activeWindowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
    public class var activeWindow: UIWindow? {
        return self.activeWindowScene?.windows.first
    }
#endif

    public class var landscape: Bool {
        #if os(tvOS)
            return true
        #elseif os(iOS)
            if self.activeWindowScene?.interfaceOrientation == .landscapeLeft ||
                self.activeWindowScene?.interfaceOrientation == .landscapeRight {
                return true
            }
        #endif
        return false
    }
    public class var portrait: Bool {
        #if os(tvOS)
            return false
        #elseif os(iOS)
            if self.activeWindowScene?.interfaceOrientation == .portrait ||
                self.activeWindowScene?.interfaceOrientation == .portraitUpsideDown {
                return true
            }
        #endif
        return false
    }
    public class var biometricIdAvailable: Bool {
        if #available(iOS 13, *) {
            guard NSClassFromString("LAContext") != nil else { return false }
            guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                return false
            }
            
            return true
        } else {
            return false
        }
    }
    public class var faceIdAvailable: Bool {
        #if os(tvOS)
            return false
        #elseif os(iOS)
            guard NSClassFromString("LAContext") != nil else { return false }
            guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                return false
            }
            guard #available(iOS 11, *) else { return false }
            guard LAContext.init().biometryType == LABiometryType.faceID else { return false }
        
            return true
        #else
            return false
        #endif
    }
    public class var touchIdAvailable: Bool {
        #if os(tvOS)
            return false
        #elseif os(iOS)
            guard NSClassFromString("LAContext") != nil else { return false }
            guard LAContext.init().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                return false
            }
            if #available(iOS 11, *) {
                guard LAContext.init().biometryType == LABiometryType.touchID else { return false }
            }

            return true
        #else
            return false
        #endif
    }
    public class var applicationDocumentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.allDomainsMask, true).last!
    }
}
