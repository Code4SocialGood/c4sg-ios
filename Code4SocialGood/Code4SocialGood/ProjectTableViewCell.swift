//
//  ProjectTableViewCell.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/22/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ProjectTableViewCell: BaseTableViewCell {
    
    // Private properties
    let defaultImageName = "C4SGLogoDark"
    @IBOutlet private weak var projectImageView: AlignedImageView!
    @IBOutlet private weak var projectName: UILabel!
    @IBOutlet private weak var projectDescription: UILabel!
    
    // Public project properties
    public weak var project: Project? = nil {
        didSet {
            if let project = project {
                DispatchQueue.main.async {
                    // Set project name
                    if let name = project.name {
                        self.projectName.text = name
                    }
                    else if let name = project.id {
                        self.projectName.text = "Project \(String(name))"
                    }
                    else {
                        self.projectName.text = "No project name"
                    }
                    
                    // Set project image
                    if let imageUrl = project.imageUrl {
                        self.projectImageView.loadAsyncImageFrom(url: imageUrl, withPlaceholder: UIImage(named: self.defaultImageName))
                    }
                    else {
                        self.projectImageView.image = UIImage(named: self.defaultImageName)!
                    }
                    
                    // Set project description
                    if let description = project.projectDescription {
                        self.projectDescription.text = description
                    }
                    else {
                        self.projectDescription.text = "No project description"
                    }
                }
            }
            else {
                projectImageView.image = nil
                projectName.text = nil
                projectDescription.text = nil
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Factory Method
    
    internal static func dequeue(fromTableView tableView: UITableView, withIdentifier identifier: String, atIndexPath indexPath: IndexPath) -> ProjectTableViewCell {
        guard let cell: ProjectTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ProjectTableViewCell else {
            fatalError("Failed to dequeue ProjectTableViewCell")
        }
        return cell
    }
    
}
