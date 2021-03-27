//
//  DetailsController.swift
//  Project-2
//
//  Created by Mark bergeson on 3/7/21.
//

import UIKit

class ItemDetailsController: UIViewController {
    
    
    private let iconImage = UIImageView()
    private let seperator = UIImageView()
    private let appTitle = UILabel()
    private let appDescription = UILabel()
    private var item: Item
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    
}

extension ItemDetailsController {
    func setupView() {
        
        view.backgroundColor = .white
        navigationItem.title = "Item Details"
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonAction))
        editButton.tintColor = .black
        navigationItem.rightBarButtonItem = editButton
        
        let iconImage = UIImageView(image: item.image)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.contentMode = .scaleAspectFill
        iconImage.layer.masksToBounds = true
        iconImage.clipsToBounds = true
        view.addSubview(iconImage)
        
        iconImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = .lightGray
        view.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 14.0).isActive = true
        seperator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7.0).isActive = true
        seperator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7.0).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        appTitle.text = item.text
        appTitle.textColor = UIColor.black
        view.addSubview(appTitle)
        
        appTitle.topAnchor.constraint(equalTo: seperator.topAnchor, constant: 14.0).isActive = true
        appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14.0).isActive = true
        
        
        appDescription.translatesAutoresizingMaskIntoConstraints = false
        appDescription.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        appDescription.text = item.description
        appDescription.textColor = UIColor.black
        view.addSubview(appDescription)
        
        appDescription.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 8.0).isActive = true
        appDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14.0).isActive = true
        
    }
}

private extension ItemDetailsController {
    
    @objc
    func editButtonAction() {
        let vc = EditItemsController(item: item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
