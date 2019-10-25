//
//  Resume.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import Foundation

struct Resume : Decodable {
    
    let name: String
    let phoneNumber: String
    let email: String
    let city: String
    let province: String
    let country: String
    let pdfVersionURL: String
    let linkedInURL: String
    let githubURL: String
    let profileDescription: String
    let experience: [WorkExperience]
    let education: [Education]
    let languages: [Language]
    
}
