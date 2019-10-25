//
//  WorkExperienceCell.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import UIKit
import Combine

class WorkExperienceCell : UITableViewCell {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var logoActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var logoCancellable: AnyCancellable?
    
}
