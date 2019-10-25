//
//  Language.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import Foundation

enum LanguageProficiency : String, Decodable {
    
    case elementary
    case limitedWorking
    case professionalWorking
    case fullProfessional
    case nativeOrBilingual
    
    var prettyName: String {
        switch self {
        case .elementary:
            return "Elementary"
        case .limitedWorking:
            return "Limited Working"
        case .professionalWorking:
            return "Professional Working"
        case .fullProfessional:
            return "Full Professional"
        case .nativeOrBilingual:
            return "Native or Bilingual"
        }
    }
    
}

struct Language : Decodable {
    
    let language: String
    let proficiency: LanguageProficiency
    
}
