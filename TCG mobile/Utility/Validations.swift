//
//  Helper.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 24/04/23.
//

class ValidationsHelper {
    static func isValidUsername(name: String) -> Bool {
        return name != ""
    }
    
    static func isValidPassword(pass: String )-> Bool {
        return pass.count > 7
    }
}
