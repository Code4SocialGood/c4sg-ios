//
//  ProjectTableViewCell.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/22/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

class ProjectTableViewCell: BaseTableViewCell {
    
    // Public properties
    public static let nibName = "ProjectTableViewCell"
    
    // Private properties
    let defaultImageName = "C4SGLogoDark"
    @IBOutlet private weak var projectImageView: AlignedImageView!
    @IBOutlet private weak var projectName: UILabel!
    @IBOutlet private weak var projectDescription: UILabel!
    
    // Public project properties
    public weak var project: Project? = nil {
        didSet {
            if let project = project {
                // Set project name
                if let name = project.name {
                    projectName.text = name
                }
                else if let name = project.id {
                    projectName.text = "Project \(String(name))"
                }
                else {
                    projectName.text = "No project name"
                }
                
                // Set project image
                if let imageUrl = project.imageUrl {
                    projectImageView.loadAsyncImageFrom(url: imageUrl, withPlaceholder: UIImage(named: defaultImageName))
                }
                else {
                    projectImageView.image = UIImage(named: defaultImageName)!
                }
                
                // Set project description
                if let description = project.projectDescription {
                    projectDescription.text = description
                }
                else {
                    projectDescription.text = "No project description"
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
