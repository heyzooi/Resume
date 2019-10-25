//
//  ResumeViewController.swift
//  Resume
//
//  Created by Victor Hugo Carvalho Barros on 2019-10-24.
//  Copyright © 2019 HZ Apps. All rights reserved.
//

import UIKit
import Combine

enum ResumeSections: Int, CaseIterable {
    
    case head
    case profile
    case experience
    case education
    case language
    
}

class ResumeViewController : UITableViewController {
    
    var resume: Resume? = nil {
        didSet {
            if resume != nil {
                callback?()
            }
            tableView.reloadData()
        }
    }
    
    var callback: (() -> Void)?
    
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancellable = APIClient.sharedClient.loadResume()
            .delay(for: 1, scheduler: DispatchQueue.main)
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        self.present(alertController, animated: true)
                    }
                },
                receiveValue: { self.resume = $0 }
            )
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch ResumeSections(rawValue: section)! {
        case .head:
            return nil
        case .profile:
            return "Profile"
        case .experience:
            return "Work Experience"
        case .education:
            return "Education"
        case .language:
            return "Language"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return resume != nil ? ResumeSections.allCases.count : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ResumeSections(rawValue: section)! {
        case .head:
            return 6
        case .profile:
            return 1
        case .experience:
            return resume?.experience.count ?? 0
        case .education:
            return resume?.education.count ?? 0
        case .language:
            return resume?.languages.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String
        switch ResumeSections(rawValue: indexPath.section)! {
        case .head:
            identifier = "Head"
        case .profile:
            identifier = "Profile"
        case .experience:
            identifier = "Work Experience"
        case .education:
            identifier = "Education"
        case .language:
            identifier = "Language"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        guard let resume = resume else {
            return cell
        }
        switch ResumeSections(rawValue: indexPath.section)! {
        case .head:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = resume.name
            case 1:
                cell.textLabel?.text = resume.phoneNumber
            case 2:
                cell.textLabel?.text = resume.email
            case 3:
                cell.textLabel?.text = "\(resume.city), \(resume.province), \(resume.country)"
            case 4:
                cell.textLabel?.text = resume.linkedInURL
            case 5:
                cell.textLabel?.text = resume.pdfVersionURL
            default:
                break
            }
        case .profile:
            cell.textLabel?.text = resume.profileDescription
        case .experience:
            guard let workExperienceCell = cell as? WorkExperienceCell else {
                return cell
            }
            let experience = resume.experience[indexPath.row]
            workExperienceCell.companyLabel.text = experience.companyName
            workExperienceCell.logoCancellable?.cancel()
            workExperienceCell.logoImageView?.image = nil
            workExperienceCell.logoActivityIndicatorView.startAnimating()
            if let logoURL = experience.logoURL, let url = URL(string: logoURL) {
                workExperienceCell.logoCancellable = APIClient.sharedClient.loadImage(url: url).sink(
                    receiveCompletion: { _ in },
                    receiveValue: {
                        workExperienceCell.logoImageView?.image = $0
                        workExperienceCell.logoActivityIndicatorView.stopAnimating()
                    }
                )
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yyyy"
            workExperienceCell.descriptionLabel.text = """
                \(experience.title)
                \(dateFormatter.string(from: experience.startDate)) - \(experience.endDate.map { dateFormatter.string(from: $0) } ?? "Present")
                
                \(experience.shortDescription)

                Some technologies used: \(experience.tecnhologies.joined(separator: ", "))
                """
        case .education:
            let education = resume.education[indexPath.row]
            cell.textLabel?.text = """
                \(education.school)
                \(education.degree) in \(education.course), \(education.graudationYear.map { String($0) } ?? "In Progress")
                """
        case .language:
            let language = resume.languages[indexPath.row]
            cell.textLabel?.text = "\(language.language)\nProficiency: \(language.proficiency.prettyName)"
        }
        return cell
    }
    
}
