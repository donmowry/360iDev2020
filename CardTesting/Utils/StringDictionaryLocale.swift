//
//  Copyright © 2020 Don Mowry
//

import Foundation

typealias LocaleDictionary = [String: String]

extension LocaleDictionary {
    
    func string(forLocale locale: String) -> String? {
        if let string = self[locale] {
            return string
        }
        
        //fall back to English, or nil""
        return self["en"]
    }
    
    func stringForCurrentLanguage() -> String? {
        guard let locale = Locale.current.languageCode?.split(separator: "_").first else {
            return nil
        }
        return string(forLocale: String(locale))
    }
}
