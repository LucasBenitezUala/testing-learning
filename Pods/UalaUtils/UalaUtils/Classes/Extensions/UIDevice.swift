//
//  UIDevice.swift
//  UalaUtils
//
//  Created by uala on 21/04/22.
//
// swiftlint:disable numbers_smell
// swiftlint:disable colon

import Foundation

public extension UIDevice {
    
    public enum PhoneModel: String {
        case simulator          = "simulator",
             iPhone4            = "iPhone 4",
             iPhone4S           = "iPhone 4S",
             iPhone5            = "iPhone 5",
             iPhone5S           = "iPhone 5S",
             iPhone5C           = "iPhone 5C",
             iPhone6            = "iPhone 6",
             iPhone6Plus        = "iPhone 6 Plus",
             iPhone6S           = "iPhone 6S",
             iPhone6SPlus       = "iPhone 6S Plus",
             iPhoneSE           = "iPhone SE",
             iPhone7            = "iPhone 7",
             iPhone7Plus        = "iPhone 7 Plus",
             iPhone8            = "iPhone 8",
             iPhone8Plus        = "iPhone 8 Plus",
             iPhoneX            = "iPhone X",
             iPhoneXS           = "iPhone XS",
             iPhoneXSMax        = "iPhone XS Max",
             iPhoneXR           = "iPhone XR",
             iPhone11           = "iPhone 11",
             iPhone11Pro        = "iPhone 11 Pro",
             iPhone11ProMax     = "iPhone 11 Pro Max",
             iPhoneSE2          = "iPhone SE 2nd gen",
             iPhone12Mini       = "iPhone 12 Mini",
             iPhone12           = "iPhone 12",
             iPhone12Pro        = "iPhone 12 Pro",
             iPhone12ProMax     = "iPhone 12 Pro Max",
             iPhone13Mini       = "iPhone 13 Mini",
             iPhone13           = "iPhone 13",
             iPhone13Pro        = "iPhone 13 Pro",
             iPhone13ProMax     = "iPhone 13 Pro Max",
             iPhoneSE3          = "iPhone SE 3nd gen",
             iPhone14           = "iPhone 14",
             iPhone14Plus       = "iPhone 14 Plus",
             iPhone14Pro        = "iPhone 14 Pro",
             iPhone14ProMax     = "iPhone 14 Pro Max",
             unrecognized       = "unrecognized"
    }

    public static var modelType: PhoneModel {
        var systemInfo: utsname = utsname()
        uname(&systemInfo)
        let modelCode: String? = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in String.init(validatingUTF8: ptr) }
        }
    
        let modelMap : [String: PhoneModel] = [
            "i386"      :  .simulator,
            "x86_64"    :  .simulator,
            "iPhone3,1" :  .iPhone4,
            "iPhone3,2" :  .iPhone4,
            "iPhone3,3" :  .iPhone4,
            "iPhone4,1" :  .iPhone4S,
            "iPhone5,1" :  .iPhone5,
            "iPhone5,2" :  .iPhone5,
            "iPhone5,3" :  .iPhone5C,
            "iPhone5,4" :  .iPhone5C,
            "iPhone6,1" :  .iPhone5S,
            "iPhone6,2" :  .iPhone5S,
            "iPhone7,1" :  .iPhone6Plus,
            "iPhone7,2" :  .iPhone6,
            "iPhone8,1" :  .iPhone6S,
            "iPhone8,2" :  .iPhone6SPlus,
            "iPhone8,4" :  .iPhoneSE,
            "iPhone9,1" :  .iPhone7,
            "iPhone9,3" :  .iPhone7,
            "iPhone9,2" :  .iPhone7Plus,
            "iPhone9,4" :  .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone12,8" : .iPhoneSE2,
            "iPhone13,1" : .iPhone12Mini,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            "iPhone14,4" : .iPhone13Mini,
            "iPhone14,5" : .iPhone13,
            "iPhone14,2" : .iPhone13Pro,
            "iPhone14,3" : .iPhone13ProMax,
            "iPhone14,6" : .iPhoneSE3,
            "iPhone14,7" : .iPhone14,
            "iPhone14,8" : .iPhone14Plus,
            "iPhone15,2" : .iPhone14Pro,
            "iPhone15,3" : .iPhone14ProMax
        ]
    
        guard let mcode = modelCode, let map = String(validatingUTF8: mcode), let model = modelMap[map] else {
            return PhoneModel.unrecognized
        }
        if model == .simulator {
            if let simulatorModelCode: String = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                if let simulatorMap: String = String(validatingUTF8: simulatorModelCode),
                    let simulatorModel: PhoneModel = modelMap[simulatorMap] {
                    return simulatorModel
                }
            }
        }
        return model
    }
    
    public enum ScreenType {
        case lowResolution
        case midResolution
        case highResolution
        case maxResolution
        
        public static var currentModelType: ScreenType {
            switch UIDevice.modelType {
            case .iPhone4, .iPhone4S,
                    .iPhone5, .iPhone5C, .iPhone5S, .iPhoneSE:
                return .lowResolution
            case .iPhone6, .iPhone7, .iPhone8,
                    .iPhoneSE2, .iPhoneSE3:
                return .midResolution
            case .iPhone7Plus, .iPhone8Plus,
                    .iPhoneX, .iPhoneXS, .iPhoneXR,
                    .iPhone11, .iPhone11Pro, .iPhone12Mini, .iPhone12, .iPhone12Pro,
                    .iPhone13Mini, .iPhone13, .iPhone13Pro, .iPhone14, .iPhone14Pro:
                return .highResolution
            case .iPhoneXSMax, .iPhone11ProMax, .iPhone12ProMax, .iPhone13ProMax, .iPhone14Plus, .iPhone14ProMax:
                return .maxResolution
            default:
                return .lowResolution
            }
        }
    }

    public static var isLowerResolutionDevice: Bool {
        UIDevice.ScreenType.currentModelType == .lowResolution
    }
    
    public static var isMidResolutionDevice: Bool {
        UIDevice.ScreenType.currentModelType == .midResolution
    }
    
    public static var isHighResolutionDevice: Bool {
        UIDevice.ScreenType.currentModelType == .highResolution
    }
    
    public static var isMaxResolutionDevice: Bool {
        UIDevice.ScreenType.currentModelType == .maxResolution
    }
}
