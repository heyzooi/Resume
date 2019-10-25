//
//  ViewController.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Resume":
            let resumeViewController = segue.destination as? ResumeViewController
            resumeViewController?.callback = {
                self.activityIndicator.stopAnimating()
            }
        default:
            break
        }
    }


}

