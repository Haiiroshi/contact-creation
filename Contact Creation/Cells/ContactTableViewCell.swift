//
//  ContactTableViewCell.swift
//  Contact Creation
//
//  Created by Hiroshi Melendez on 2/24/21.
//

import UIKit
import Kingfisher

fileprivate let photoImageViewSize: CGFloat = 100 - 12*2

class ContactTableViewCell: UITableViewCell {
    
    static let identifier: String = ContactTableViewCell.description()
  
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.darkGray
        return label
    }()
    
//    private let deleteButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = UIColor.red
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("-", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.clipsToBounds = true
//        button.layer.cornerRadius = 16
//        return button
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
//        contentView.addSubview(deleteButton)
        setupLayout()
    }
    
    func setupLayout(){
        photoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: photoImageViewSize).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: photoImageViewSize).isActive = true
        

        photoImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 12).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        phoneLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 16).isActive = true
        phoneLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 12).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
    }


    
    func setContact(contact: Contact){
        if let imageURL = contact.imageURL{
            photoImageView.kf.setImage(with: imageURL)
        }
        nameLabel.text = contact.fullName
        phoneLabel.text = contact.phoneNumber
        
//        deleteButton.isHidden = self.editingStyle != .delete
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
