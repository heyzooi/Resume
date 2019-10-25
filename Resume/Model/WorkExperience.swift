//
//  WorkExperience.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import Foundation

struct WorkExperience : Decodable {
    
    let companyName: String
    let logoURL: String?
    let title: String
    let startDate: Date
    let endDate: Date?
    let shortDescription: String
    let tecnhologies: [String]
    
}
