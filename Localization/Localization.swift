//
//  Localization.swift
//  Meniny
//
//  Created by Meniny on 3/12/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

fileprivate let lproj = "lproj"

open class Localization: Bundle {
    
    public enum Language: String {
        case arabic = "ar"
        case german = "de"
        case greek = "el"
        case english = "en"
        case spanish = "es"
        case spanishLatinAmeraica = "es-419"
        case spanishMexico = "es-MX"
        case finnish = "fi"
        case french = "fr"
        case italian = "it"
        case japanese = "ja"
        case korean = "ko"
        case dutch = "nl"
        case polish = "pl"
        case russian = "ru"
        case turkish = "tr"
        case ukrainia = "uk"
        case portugueseBrazil = "pt-BR"
        case portuguesePortugal = "pt-PT"
        case danish = "da"
        case norwegianBokmål = "nb"
        case swedish = "sv"
        case thai = "th"
        case czech = "cs"
        case hungarian = "hu"
        case catalan = "ca"
        case croatian = "ht"
        case hebrew = "he"
        case slovak = "sk"
        case indonesia = "id"
        case malay = "ms"
        case vietnamese = "vi"
        case simplifiedChinese = "zh-Hans"
        case traditionalChinese = "zh-Hant"
        
        public init?(code c: String) {
            if c == "ar" {
                self = .arabic
            } else if c == "de" {
                self = .german
            } else if c == "el" {
                self = .greek
            } else if c == "en" {
                self = .english
            } else if c == "es" {
                self = .spanish
            } else if c == "es-419" {
                self = .spanishLatinAmeraica
            } else if c == "es-MX" {
                self = .spanishMexico
            } else if c == "fi" {
                self = .finnish
            } else if c == "fr" {
                self = .french
            } else if c == "it" {
                self = .italian
            } else if c == "ja" {
                self = .japanese
            } else if c == "ko" {
                self = .korean
            } else if c == "nl" {
                self = .dutch
            } else if c == "pl" {
                self = .polish
            } else if c == "ru" {
                self = .russian
            } else if c == "tr" {
                self = .turkish
            } else if c == "uk" {
                self = .ukrainia
            } else if c == "pt-BR" {
                self = .portugueseBrazil
            } else if c == "pt-PT" {
                self = .portuguesePortugal
            } else if c == "da" {
                self = .danish
            } else if c == "nb" {
                self = .norwegianBokmål
            } else if c == "sv" {
                self = .swedish
            } else if c == "th" {
                self = .thai
            } else if c == "cs" {
                self = .czech
            } else if c == "hu" {
                self = .hungarian
            } else if c == "ca" {
                self = .catalan
            } else if c == "ht" {
                self = .croatian
            } else if c == "he" {
                self = .hebrew
            } else if c == "sk" {
                self = .slovak
            } else if c == "id" {
                self = .indonesia
            } else if c == "ms" {
                self = .malay
            } else if c == "vi" {
                self = .vietnamese
            } else if c.hasPrefix("zh-Hans") {
                self = .simplifiedChinese
            } else if c.hasPrefix("zh-Hant") {
                self = .traditionalChinese
            } else {
                return nil
            }
        }
        
        public var name: String {
            switch self {
            case .arabic: return "Arabic"
            case .german: return "German"
            case .greek: return "Greek"
            case .english: return "English"
            case .spanish: return "Spanish"
            case .spanishLatinAmeraica: return "Spanish Latin Ameraica"
            case .spanishMexico: return "SpanishMexico"
            case .finnish: return "Finnish"
            case .french: return "French"
            case .italian: return "Italian"
            case .japanese: return "Japanese"
            case .korean: return "Korean"
            case .dutch: return "Dutch"
            case .polish: return "Polish"
            case .russian: return "Russian"
            case .turkish: return "Turkish"
            case .ukrainia: return "Ukrainia"
            case .portugueseBrazil: return "Portuguese Brazil"
            case .portuguesePortugal: return "Portuguese Portugal"
            case .danish: return "Danish"
            case .norwegianBokmål: return "Rorwegian Bokmål"
            case .swedish: return "Awedish"
            case .thai: return "Thai"
            case .czech: return "Czech"
            case .hungarian: return "Hungarian"
            case .catalan: return "Catalan"
            case .croatian: return "Croatian"
            case .hebrew: return "Hebrew"
            case .slovak: return "Slovak"
            case .indonesia: return "Indonesia"
            case .malay: return "Malay"
            case .vietnamese: return "Vietnamese"
            case .simplifiedChinese: return "Simplified Chinese"
            case .traditionalChinese: return "Traditional Chinese"
            }
        }
        
        public var code: String {
            return rawValue
        }
            
    }
    
    private static let kLocalizationLanguageSelectionKey = "kLocalizationLanguageSelectionKey"
    
    /// System languages
    open static var systemPreferredLanguages: [String] {
        return Locale.preferredLanguages
    }
    
    /// Selecc language
    open static var preferredLanguage: String {
        get{
            return UserDefaults.standard.string(forKey: Localization.kLocalizationLanguageSelectionKey) ?? NSLocale.preferredLanguages[0]
        }
        set{
            UserDefaults.standard.set(newValue, forKey: Localization.kLocalizationLanguageSelectionKey)
            UserDefaults.standard.synchronize()
            
            // used to get notification when language change (if you have somthing to do)
            NotificationCenter.default.post(name: NSNotification.Name.LocalizationLanguageDidChange, object: nil)
        }
    }
    
    // overide localized string function
    override open func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Localization.bundleForLanguage(nil) {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
    
    open static var bundleForLanguage: (_ language: String?) -> Bundle? = { language in
        if let path = Bundle.main.path(forResource: language ?? Localization.preferredLanguage, ofType: lproj),
            let bundle = Bundle(path: path) {
            return bundle
        }
        return nil
    }
    
    open static func startObserve(with observer: NSObject, selector aSelector: Selector) {
        NotificationCenter.default.addObserver(observer,
                                               selector: aSelector,
                                               name: LocalizationLanguageDidChangeNotification,
                                               object: nil)
    }
    
    open static func stopObserve(with observer: NSObject) {
        NotificationCenter.default.removeObserver(observer,
                                                  name: LocalizationLanguageDidChangeNotification,
                                                  object: nil)
    }
}

public typealias LocalizableLanguage = Localization.Language
public typealias LocalizationLanguage = Localization.Language

// MARK: NSNotification.Name extension
extension NSNotification.Name {
    // used to get notification when language change (if you have somthing to do)
    public static var LocalizationLanguageDidChange: NSNotification.Name {
        return NSNotification.Name.init("LocalizationLanguageDidChangeNotificationName")
    }
}

public var LocalizationLanguageDidChangeNotification: NSNotification.Name {
    return NSNotification.Name.LocalizationLanguageDidChange
}

// MARK: String extension
extension String {
    
    public var localizedString: String {
        return localized()
    }
    
    /// used to localize string from code
    public func localized(in language: String? = nil) -> String {
        guard let bundle = Localization.bundleForLanguage(nil) else {
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
    }
}
