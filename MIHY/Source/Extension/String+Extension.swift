//
//  String+Extension.swift
//  MIHY
//
//  Created by 송황호 on 2022/09/28.
//

import Foundation

extension String {
    // URL check
    func isValidUrl() -> Bool {
         let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
         let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
         return urlTest.evaluate(with: self)
    }
}
