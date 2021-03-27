//
//  AddImageCell.swift
//  Project-2
//
//  Created by Mark bergeson on 3/17/21.
//

import UIKit

class AddImageCell: UITableViewCell {
    
    private let appImage = UIImageView()
    
    
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
    
    func configure(image: UIImage?) {
        if let image = image {
            appImage.image = image
        } else {
            appImage.image = UIImage(named: "Money")
        }
        
    }
    
//    func configure(urlString: String) {
//        imageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil)
//    }
    
}

private extension AddImageCell {
    
    func setupView() {
        appImage.translatesAutoresizingMaskIntoConstraints = false
        appImage.contentMode = .scaleAspectFill
        appImage.image = UIImage(named: "Money")
        appImage.layer.masksToBounds = true
        appImage.clipsToBounds = true
        contentView.addSubview(appImage)
        
        appImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        appImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        appImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        appImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        appImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
}
