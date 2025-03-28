//
//  DNSDevice.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation
import LocalAuthentication
#if os(macOS)
import AppKit
#else
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
    // deviceType - eg: "iPhone"
    public class var deviceType: String {
#if !os(macOS)
        return UIDevice.current.model
#else
        return ProcessInfo.processInfo.hostName // TODO: Might be right or wrong
#endif
    }
    // deviceType - eg: "iPhone12,5"
    public class var model: String {
        return Self.utilityModelCode()
    }
    // deviceType - eg: "iPhone 11 Pro Max"
    public class var modelName: String {
        return Self.utilityModelName(from: Self.model)
    }
#if !os(macOS)
    public class var safeAreaInsets: UIEdgeInsets {
        return (UIApplication.dnsCurrentScene() as? UIWindowScene)?.windows.first?.safeAreaInsets ?? UIEdgeInsets.zero
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

    public class var isIpad: Bool {
#if !os(macOS)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
#else
        return false
#endif
    }
    public class var isIphone: Bool {
#if !os(macOS)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
#else
        return false
#endif
    }
    public class var isTv: Bool {
#if !os(macOS)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.tv
#else
        return false
#endif
    }
    public class var isCarPlay: Bool {
#if !os(macOS)
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.carPlay
#else
        return false
#endif
    }
    public class var isMac: Bool {
#if !os(macOS)
        return false
#else
        return true
#endif
    }
#if !os(macOS)
    public class var tallPhone: Bool {
        return self.isIphone && self.screenHeight >= 1136
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
extension DNSDevice {
    public class func utilityModelName(from model: String) -> String {
        return Self.deviceModels
            .first { (_/* key */, value) in value == model }
            .map { $0.key } ?? "Unknown Device"
    }
    public class func utilityModelCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String.init(validatingUTF8: ptr)
            }
        }
        return modelCode ?? "Unknown"
    }

    static var deviceModels: [String: String] = [
        "AirPods (1st generation)": "AirPods1,1",
        "AirPods (2nd generation)": "AirPods2,1",
        "AirPods Pro": "iProd8,1",
        "AirPods Max": "iProd8,6",
        "AirPort Express 802.11n (1st generation)": "AirPort4,107",
        "AirPort Express 802.11n (2nd generation)": "AirPort10,115",
        "AirTag": "AirTag1,1",
        "Apple TV (1st generation)": "AppleTV1,1",
        "Apple TV (2nd generation)": "AppleTV2,1",
        "Apple TV (3rd generation, Early 2012)": "AppleTV3,1",
        "Apple TV (3rd generation, Early 2013)": "AppleTV3,2",
        "Apple TV HD": "AppleTV5,3",
        "Apple TV 4K (1st generation)": "AppleTV6,2",
        "Apple TV 4K (2nd generation)": "AppleTV11,1",
        "Apple Watch 38mm": "Watch1,1",
        "Apple Watch 42mm": "Watch1,2",
        "Apple Watch Series 2 38mm": "Watch2,3",
        "Apple Watch Series 2 42mm": "Watch2,4",
        "Apple Watch Series 1 38mm": "Watch2,6",
        "Apple Watch Series 1 42mm": "Watch2,7",
        "Apple Watch Series 3 (GPS + Cellular) 38mm": "Watch3,1",
        "Apple Watch Series 3 (GPS + Cellular) 42mm": "Watch3,2",
        "Apple Watch Series 3 (GPS) 38mm": "Watch3,3",
        "Apple Watch Series 3 (GPS) 42mm (GPS)": "Watch3,4",
        "Apple Watch Series 4 (GPS) 40mm": "Watch4,1",
        "Apple Watch Series 4 (GPS) 44mm": "Watch4,2",
        "Apple Watch Series 4 (GPS + Cellular) 40mm": "Watch4,3",
        "Apple Watch Series 4 (GPS + Cellular) 44mm": "Watch4,4",
        "Apple Watch Series 5 (GPS) 40mm": "Watch5,1",
        "Apple Watch Series 5 (GPS) 44mm": "Watch5,2",
        "Apple Watch Series 5 (GPS + Cellular) 40mm": "Watch5,3",
        "Apple Watch Series 5 (GPS + Cellular) 44mm": "Watch5,4",
        "Apple Watch SE (GPS) 40mm": "Watch5,9",
        "Apple Watch SE (GPS) 44mm": "Watch5,10",
        "Apple Watch SE (GPS + Cellular) 40mm": "Watch5,11",
        "Apple Watch SE (GPS + Cellular) 44mm": "Watch5,12",
        "Apple Watch Series 6 (GPS) 40mm": "Watch6,1",
        "Apple Watch Series 6 (GPS) 44mm": "Watch6,2",
        "Apple Watch Series 6 (GPS + Cellular) 40mm": "Watch6,3",
        "Apple Watch Series 6 (GPS + Cellular) 44mm": "Watch6,4",
        "Apple Watch Series 7 (GPS) 41mm": "Watch6,6",
        "Apple Watch Series 7 (GPS) 45mm": "Watch6,7",
        "Apple Watch Series 7 (GPS + Cellular) 41mm": "Watch6,8",
        "Apple Watch Series 7 (GPS + Cellular) 45mm": "Watch6,9",
        "Apple Studio Display": "AppleDisplay2,1",
        "HomePod": "AudioAccessory1,1",
        "HomePod (Revision)": "AudioAccessory1,2",
        "HomePod Mini": "AudioAccessory5,1",
        "iMac (24-inch, Early 2009)": "iMac9,1",
        "iMac (20-inch, Early 2009)": "iMac9,1",
        "iMac (27-inch, Late 2009)": "iMac10,1",
        "iMac (21.5-inch, Late 2009)": "iMac10,1",
        "iMac (27-inch, Late 2009, Intel Core i5)": "iMac11,1",
        "iMac (21.5-inch, Mid 2010)": "iMac11,2",
        "iMac (27-inch, Mid 2010)": "iMac11,3",
        "iMac (21.5-inch, Mid 2011)": "iMac12,1",
        "iMac (27-inch, Mid 2011)": "iMac12,2",
        "iMac (21.5-inch, Late 2012)": "iMac13,1",
        "iMac (27-inch, Late 2012)": "iMac13,2",
        "iMac (21.5-inch, Late 2013)": "iMac14,1",
        "iMac (27-inch, Late 2013)": "iMac14,2",
        "iMac (21.5-inch, Mid 2014, Dual Graphics)": "iMac14,3",
        "iMac (21.5-inch, Mid 2014)": "iMac14,4",
        "iMac (Retina 5K, 27-inch, Late 2014)": "iMac15,1",
        "iMac (Retina 5K, 27-inch, Mid 2015)": "iMac15,1",
        "iMac (21.5-inch, Late 2015)": "iMac16,1",
        "iMac (Retina 4K, 21.5-inch, Late 2015)": "iMac16,2",
        "iMac (Retina 5K, 27-inch, Late 2015)": "iMac17,1",
        "iMac (21.5-inch, 2017)": "iMac18,1",
        "iMac (Retina 4K, 21.5-inch, 2017)": "iMac18,2",
        "iMac (Retina 5K, 27-inch, 2017)": "iMac18,3",
        "iMac (Retina 5K, 27-inch, 2019)": "iMac19,1",
        "iMac (Retina 4K, 21.5-inch, 2019)": "iMac19,2",
        "iMac (Retina 5K, 27-inch, 2020)": "iMac20,1",
        "iMac (Retina 5K, 27-inch, 2020, Radeon Pro 5700/XT)": "iMac20,2",
        "iMac (24-inch, M1, 2021, 4 Ports)": "iMac21,1",
        "iMac (24-inch, M1, 2021, 2 Ports)": "iMac21,2",
        "iMac Pro": "iMacPro1,1",
        "iPad": "iPad1,1",
        "iPad 3G": "iPad1,2",
        "iPad 2": "iPad2,1",
        "iPad 2 (GSM)": "iPad2,2",
        "iPad 2 (CDMA)": "iPad2,3",
        "iPad 2 (Revision)": "iPad2,4",
        "iPad mini": "iPad2,5",
        "iPad mini (LTE + GSM)": "iPad2,6",
        "iPad mini (LTE + CDMA)": "iPad2,7",
        "iPad (3rd generation)": "iPad3,1",
        "iPad (3rd generation, CDMA)": "iPad3,2",
        "iPad (3rd generation, GSM)": "iPad3,3",
        "iPad (4th generation)": "iPad3,4",
        "iPad (4th generation, LTE + GSM)": "iPad3,5",
        "iPad (4th generation, LTE + CDMA)": "iPad3,6",
        "iPad Air Wi-Fi": "iPad4,1",
        "iPad Air Wi-Fi + Cellular": "iPad4,2",
        "iPad Air Wi-Fi + Cellular (China)": "iPad4,3",
        "iPad mini 2 Wi-Fi": "iPad4,4",
        "iPad mini 2 Wi-Fi + Cellular": "iPad4,5",
        "iPad mini 2 Wi-Fi + Cellular (China)": "iPad4,6",
        "iPad mini 3 Wi-Fi": "iPad4,7",
        "iPad mini 3 Wi-Fi + Cellular": "iPad4,8",
        "iPad mini 3 Wi-Fi + Cellular (China)": "iPad4,9",
        "iPad mini 4 Wi-Fi": "iPad5,1",
        "iPad mini 4 Wi-Fi + Cellular": "iPad5,2",
        "iPad Air 2 Wi-Fi": "iPad5,3",
        "iPad Air 2 Wi-Fi + Cellular": "iPad5,4",
        "iPad Pro (9.7 inch) Wi-Fi": "iPad6,3",
        "iPad Pro (9.7 inch) Wi-Fi + Cellular": "iPad6,4",
        "iPad Pro (12.9 inch) Wi-Fi": "iPad6,7",
        "iPad Pro (12.9 inch) Wi-Fi + Cellular": "iPad6,8",
        "iPad (5th generation) Wi-Fi": "iPad6,12",
        "iPad (5th generation) Wi-Fi + Cellular": "iPad6,12",
        "iPad Pro (2nd generation) Wi-Fi": "iPad7,1",
        "iPad Pro (2nd generation) Wi-Fi + Cellular": "iPad7,2",
        "iPad Pro 10.5-inch Wi-Fi": "iPad7,3",
        "iPad Pro 10.5-inch Wi-Fi + Cellular": "iPad7,4",
        "iPad (6th generation) Wi-Fi": "iPad7,5",
        "iPad (6th generation) Wi-Fi + Cellular": "iPad7,6",
        "iPad (7th generation) Wi-Fi": "iPad7,11",
        "iPad (7th generation) Wi-Fi + Cellular": "iPad7,12",
        "iPad Pro 11 inch (1st generation) Wi-Fi": "iPad8,1",
        "iPad Pro 11 inch (1st generation) Wi-Fi (1TB)": "iPad8,2",
        "iPad Pro 11 inch (1st generation) Wi-Fi + Cellular": "iPad8,3",
        "iPad Pro 11 inch (1st generation) Wi-Fi + Cellular (1TB)": "iPad8,4",
        "iPad Pro 12.9 inch (3rd generation) Wi-Fi": "iPad8,5",
        "iPad Pro 12.9 inch (3rd generation) Wi-Fi (1TB)": "iPad8,6",
        "iPad Pro 12.9 inch (3rd generation) Wi-Fi + Cellular": "iPad8,7",
        "iPad Pro 12.9 inch (3rd generation) Wi-Fi + Cellular (1TB)": "iPad8,8",
        "iPad Pro 11 inch (2nd generation) Wi-Fi": "iPad8,9",
        "iPad Pro 11 inch (2nd generation) Wi-Fi + Cellular": "iPad8,10",
        "iPad Pro 12.9 inch (4th generation) Wi-Fi": "iPad8,11",
        "iPad Pro 12.9 inch (4th generation) Wi-Fi + Cellular": "iPad8,12",
        "iPad mini (5th generation) Wi-Fi": "iPad11,1",
        "iPad mini (5th generation) Wi-Fi + Cellular": "iPad11,2",
        "iPad Air (3rd generation) Wi-Fi": "iPad11,3",
        "iPad Air (3rd generation) Wi-Fi + Cellular": "iPad11,4",
        "iPad (8th generation) Wi-Fi": "iPad11,6",
        "iPad (8th generation) Wi-Fi + Cellular": "iPad11,7",
        "iPad (9th generation) Wi-Fi": "iPad12,1",
        "iPad (9th generation) Wi-Fi + Cellular": "iPad12,2",
        "iPad Air (4th generation) Wi-Fi": "iPad13,1",
        "iPad Air (4th generation) Wi-Fi + Cellular": "iPad13,2",
        "iPad Pro 11 inch (3rd generation) Wi-Fi": "iPad13,4",
        "iPad Pro 11 inch (3rd generation) Wi-Fi + Cellular (US)": "iPad13,5",
        "iPad Pro 11 inch (3rd generation) Wi-Fi + Cellular (Global)": "iPad13,6",
        "iPad Pro 11 inch (3rd generation) Wi-Fi + Cellular (China)": "iPad13,7",
        "iPad Pro 12.9 inch (5th generation) Wi-Fi": "iPad13,8",
        "iPad Pro 12.9 inch (5th generation) Wi-Fi + Cellular (US)": "iPad13,9",
        "iPad Pro 12.9 inch (5th generation) Wi-Fi + Cellular (Global)": "iPad13,10",
        "iPad Pro 12.9 inch (5th generation) Wi-Fi + Cellular (China)": "iPad13,11",
        "iPad Air (5th generation) Wi-Fi": "iPad13,16",
        "iPad Air (5th generation) Wi-Fi + Cellular": "iPad13,17",
        "iPad mini (6th generation) Wi-Fi": "iPad14,1",
        "iPad mini (6th generation) Wi-Fi + Cellular": "iPad14,2",
        "iPhone": "iPhone1,1",
        "iPhone 3G": "iPhone1,2",
        "iPhone 3GS": "iPhone2,1",
        "iPhone 4 (GSM)": "iPhone3,1",
        "iPhone 4 (GSM, Revision A)": "iPhone3,2",
        "iPhone 4 (CDMA)": "iPhone3,3",
        "iPhone 4S": "iPhone4,1",
        "iPhone 5 (GSM)": "iPhone5,1",
        "iPhone 5 (Global)": "iPhone5,2",
        "iPhone 5C (GSM)": "iPhone5,3",
        "iPhone 5C (Global)": "iPhone5,4",
        "iPhone 5S (GSM)": "iPhone6,1",
        "iPhone 5S (Global)": "iPhone6,2",
        "iPhone 6 Plus": "iPhone7,1",
        "iPhone 6": "iPhone7,2",
        "iPhone 6s": "iPhone8,1",
        "iPhone 6s Plus": "iPhone8,2",
        "iPhone SE (GSM)": "iPhone8,4",
        "iPhone 7 (GSM)": "iPhone9,1",
        "iPhone 7 Plus (GSM)": "iPhone9,2",
        "iPhone 7 (Global)": "iPhone9,3",
        "iPhone 7 Plus (Global)": "iPhone9,4",
        "iPhone 8 (GSM)": "iPhone10,1",
        "iPhone 8 Plus (GSM)": "iPhone10,2",
        "iPhone X (Global)": "iPhone10,3",
        "iPhone 8 (Global)": "iPhone10,4",
        "iPhone 8 Plus (Global)": "iPhone10,5",
        "iPhone X (GSM)": "iPhone10,6",
        "iPhone XS": "iPhone11,2",
        "iPhone XS Max (unreleased)": "iPhone11,4",
        "iPhone XS Max": "iPhone11,6",
        "iPhone XR": "iPhone11,8",
        "iPhone 11": "iPhone12,1",
        "iPhone 11 Pro": "iPhone12,3",
        "iPhone 11 Pro Max": "iPhone12,5",
        "iPhone SE (2nd generation)": "iPhone12,8",
        "iPhone 12 Mini": "iPhone13,1",
        "iPhone 12": "iPhone13,2",
        "iPhone 12 Pro": "iPhone13,3",
        "iPhone 12 Pro Max": "iPhone13,4",
        "iPhone 13 Pro": "iPhone14,2",
        "iPhone 13 Pro Max": "iPhone14,3",
        "iPhone 13 Mini": "iPhone14,4",
        "iPhone 13": "iPhone14,5",
        "iPhone SE (3rd generation)": "iPhone14,6",
        "iPod touch (1st generation)": "iPod1,1",
        "iPod touch (2nd generation)": "iPod2,1",
        "iPod touch (3rd generation)": "iPod3,1",
        "iPod touch (4th generation)": "iPod4,1",
        "iPod touch (5th generation)": "iPod5,1",
        "iPod touch (6th generation)": "iPod7,1",
        "iPod touch (7th generation)": "iPod9,1",
        "MacBook (13-inch, Mid 2009, Unibody)": "MacBook5,1",
        "MacBook (13-inch, Mid 2009)": "MacBook5,2",
        "MacBook (13-inch, Early 2009)": "MacBook5,2",
        "MacBook (13-inch, Late 2009)": "MacBook6,1",
        "MacBook (13-inch, Mid 2010)": "MacBook7,1",
        "MacBook (Retina, 12-inch, Early 2015)": "MacBook8,1",
        "MacBook (Retina, 12-inch, Early 2016)": "MacBook9,1",
        "MacBook (Retina, 12-inch, 2017)": "MacBook10,1",
        "MacBook Air (Mid 2009)": "MacBookAir2,1",
        "MacBook Air (11-inch, Late 2010)": "MacBookAir3,1",
        "MacBook Air (13-inch, Late 2010)": "MacBookAir3,2",
        "MacBook Air (11-inch, Mid 2011)": "MacBookAir4,1",
        "MacBook Air (13-inch, Mid 2011)": "MacBookAir4,2",
        "MacBook Air (11-inch, Mid 2012)": "MacBookAir5,1",
        "MacBook Air (13-inch, Mid 2012)": "MacBookAir5,2",
        "MacBook Air (11-inch, Early 2014)": "MacBookAir6,1",
        "MacBook Air (11-inch, Mid 2013)": "MacBookAir6,1",
        "MacBook Air (13-inch, Early 2014)": "MacBookAir6,2",
        "MacBook Air (13-inch, Mid 2013)": "MacBookAir6,2",
        "MacBook Air (11-inch, Early 2015)": "MacBookAir7,1",
        "MacBook Air (13-inch, 2017)": "MacBookAir7,2",
        "MacBook Air (13-inch, Early 2015)": "MacBookAir7,2",
        "MacBook Air (Retina, 13-inch, 2018)": "MacBookAir8,1",
        "MacBook Air (Retina, 13-inch, 2019)": "MacBookAir8,2",
        "MacBook Air (Retina, 13-inch, 2020)": "MacBookAir9,1",
        "MacBook Air (M1, 2020)": "MacBookAir10,1",
        "MacBook Pro (17-inch, Early 2008)": "MacBookPro4,1",
        "MacBook Pro (15-inch, Early 2008)": "MacBookPro4,1",
        "MacBook Pro (15-inch, Late 2008)": "MacBookPro5,1",
        "MacBook Pro (17-inch, Mid 2009)": "MacBookPro5,2",
        "MacBook Pro (17-inch, Early 2009)": "MacBookPro5,2",
        "MacBook Pro (15-inch, Mid 2009)": "MacBookPro5,3",
        "MacBook Pro (15-inch, 2.53GHz, Mid 2009)": "MacBookPro5,3",
        "MacBook Pro (13-inch, Mid 2009)": "MacBookPro5,5",
        "MacBook Pro (17-inch, Mid 2010)": "MacBookPro6,1",
        "MacBook Pro (15-inch, Mid 2010)": "MacBookPro6,2",
        "MacBook Pro (13-inch, Mid 2010)": "MacBookPro7,1",
        "MacBook Pro (13-inch, Late 2011)": "MacBookPro8,1",
        "MacBook Pro (13-inch, Early 2011)": "MacBookPro8,1",
        "MacBook Pro (15-inch, Late 2011)": "MacBookPro8,2",
        "MacBook Pro (15-inch, Early 2011)": "MacBookPro8,2",
        "MacBook Pro (17-inch, Late 2011)": "MacBookPro8,3",
        "MacBook Pro (17-inch, Early 2011)": "MacBookPro8,3",
        "MacBook Pro (15-inch, Mid 2012)": "MacBookPro9,1",
        "MacBook Pro (13-inch, Mid 2012)": "MacBookPro9,2",
        "MacBook Pro (Retina, 15-inch, Early 2013)": "MacBookPro10,1",
        "MacBook Pro (Retina, 15-inch, Mid 2012)": "MacBookPro10,1",
        "MacBook Pro (Retina, 13-inch, Early 2013)": "MacBookPro10,2",
        "MacBook Pro (Retina, 13-inch, Late 2012)": "MacBookPro10,2",
        "MacBook Pro (Retina, 13-inch, Mid 2014)": "MacBookPro11,1",
        "MacBook Pro (Retina, 13-inch, Late 2013)": "MacBookPro11,1",
        "MacBook Pro (Retina, 15-inch, Mid 2014)": "MacBookPro11,2",
        "MacBook Pro (Retina, 15-inch, Late 2013)": "MacBookPro11,2",
        "MacBook Pro (Retina, 15-inch, Mid 2014, Dual Graphics)": "MacBookPro11,3",
        "MacBook Pro (Retina, 15-inch, Late 2013, Dual Graphics)": "MacBookPro11,3",
        "MacBook Pro (Retina, 15-inch, Mid 2015)": "MacBookPro11,4",
        "MacBook Pro (Retina, 15-inch, Mid 2015, Dual Graphics)": "MacBookPro11,5",
        "MacBook Pro (Retina, 13-inch, Early 2015)": "MacBookPro12,1",
        "MacBook Pro (13-inch, 2016, Two Thunderbolt 3 ports)": "MacBookPro13,1",
        "MacBook Pro (13-inch, 2016, Four Thunderbolt 3 ports)": "MacBookPro13,2",
        "MacBook Pro (15-inch, 2016)": "MacBookPro13,3",
        "MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)": "MacBookPro14,1",
        "MacBook Pro (13-inch, 2017, Four Thunderbolt 3 ports)": "MacBookPro14,2",
        "MacBook Pro (15-inch, 2017)": "MacBookPro14,3",
        "MacBook Pro (15-inch, 2019)": "MacBookPro15,1",
        "MacBook Pro (15-inch, 2018)": "MacBookPro15,1",
        "MacBook Pro (13-inch, 2019, Four Thunderbolt 3 ports)": "MacBookPro15,2",
        "MacBook Pro (13-inch, 2018, Four Thunderbolt 3 ports)": "MacBookPro15,2",
        "MacBook Pro (15-inch, 2019, Vega)": "MacBookPro15,3",
        "MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports)": "MacBookPro15,4",
        "MacBook Pro (16-inch, 2019)": "MacBookPro16,1",
        "MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)": "MacBookPro16,2",
        "MacBook Pro (13-inch, 2020, Two Thunderbolt 3 ports)": "MacBookPro16,3",
        "MacBook Pro (16-inch, 2019, AMD Radeon Pro 5600M)": "MacBookPro16,4",
        "MacBook Pro (13-inch, 2020, M1)": "MacBookPro17,1",
        "MacBook Pro (16-inch, 2021, M1 Pro)": "MacBookPro18,1",
        "MacBook Pro (16-inch, 2021, M1 Max)": "MacBookPro18,2",
        "MacBook Pro (14-inch, 2021, M1 Pro)": "MacBookPro18,3",
        "MacBook Pro (14-inch, 2021, M1 Max)": "MacBookPro18,4",
        "Mac mini (Late 2009)": "Macmini3,1",
        "Mac mini (Early 2009)": "Macmini3,1",
        "Mac mini (Mid 2010)": "Macmini4,1",
        "Mac mini (Mid 2011)": "Macmini5,1",
        "Mac mini (Mid 2011, Intel Core i7)": "Macmini5,2",
        "Mac mini (Mid 2011, Server)": "Macmini5,3",
        "Mac mini (Late 2012)": "Macmini6,1",
        "Mac mini (Late 2012, 1TB)": "Macmini6,2",
        "Mac mini (Late 2014)": "Macmini7,1",
        "Mac mini (2018)": "Macmini8,1",
        "Mac mini (M1, 2020)": "Macmini9,1",
        "Mac Pro (2019)": "MacPro7,1",
        "Mac Pro (Rack, 2019)": "MacPro7,1",
        "Mac Pro (Late 2013)": "MacPro6,1",
        "Mac Pro (Mid 2012)": "MacPro5,1",
        "Mac Pro Server (Mid 2012)": "MacPro5,1",
        "Mac Pro (Mid 2010)": "MacPro5,1",
        "Mac Pro Server (Mid 2010)": "MacPro5,1",
        "Mac Pro (Early 2009)": "MacPro4,1",
        "Mac Studio (2022, M1 Max)": "Mac13,1",
        "Mac Studio (2022, M1 Ultra)": "Mac13,2",
    ]
} // swiftlint:disable:this file_length
