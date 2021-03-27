//
//  IconCell.swift
//  Project-2
//
//  Created by Mark bergeson on 3/10/21.
//

import UIKit

class IconCell: UITableViewCell {
    
    
    
    private let containerView = UIView()
    private let iconImage = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: Item) {
        iconImage.image = item.image
        titleLabel.text = item.text
        descriptionLabel.text = item.description
    }
        
}

private extension IconCell {
    
    func setupView() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        accessoryType = .disclosureIndicator

        
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.contentMode = .scaleAspectFill
        iconImage.layer.masksToBounds = true
        iconImage.clipsToBounds = true
        contentView.addSubview(iconImage)
        
        iconImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14.0).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 14.0).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -14.0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 48.0).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        contentView.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor,constant: 14.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4.0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor,constant: 14.0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -25.0).isActive = true
        
    }
}
