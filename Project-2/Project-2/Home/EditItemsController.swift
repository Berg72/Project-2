//
//  EditItemsController.swift
//  Project-2
//
//  Created by Mark bergeson on 3/7/21.
//

import UIKit
import PhotosUI

class EditItemsController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var item: Item
    private var tableViewBottomAnchor: NSLayoutConstraint?
   
    @available(iOS 14, *)
    private lazy var photoController: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        return picker
    }()
    
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

private extension EditItemsController {
    
    func setupView() {
        
        view.backgroundColor = .white
        navigationItem.title = "Edit Items"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonAction))
        saveButton.tintColor = .black
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 55.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(AddImageCell.self, forCellReuseIdentifier: AddImageCell.reuseIdentifier())
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseIdentifier())
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        tableViewBottomAnchor?.isActive = true
        
    }
}

private extension EditItemsController {
    
    @objc
    func saveButtonAction() {
        if Datasource.shared.items.contains(where: { $0.id == item.id }) {
            Datasource.shared.items = Datasource.shared.items.filter({ $0.id != item.id })
            Datasource.shared.items.append(item)
        } else {
            Datasource.shared.items.append(item)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    @available(iOS 14, *)
    @objc
    func addMediaButtonAction() {
        if PHPhotoLibrary.authorizationStatus() != .authorized || PHPhotoLibrary.authorizationStatus() != .limited {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized || status == .limited {
                    DispatchQueue.main.async {
                        self.present(self.photoController, animated: true, completion: nil)
                    }
                }
            }
        } else {
                present(photoController, animated: true, completion: nil)
            }
        }
    
}
extension EditItemsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddImageCell.reuseIdentifier(), for: indexPath)
            
            if let cell = cell as? AddImageCell {
                cell.configure(image: self.item.image)
            }
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseIdentifier(), for: indexPath)
                
            if let cell = cell as? DescriptionCell {
                cell.configure(text: self.item.text, placeHolder: "Title", tableView: tableView) { (text) in
                    self.item.text = text
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseIdentifier(), for: indexPath)
                
            if let cell = cell as? DescriptionCell {
                cell.configure(text: self.item.description, placeHolder: "Description", tableView: tableView) { (text) in
                    self.item.description = text
                }
            }
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
        if indexPath.row == 0 {
            addMediaButtonAction()
        }
            
    }
    
}

@available(iOS 14, *)
extension EditItemsController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        var count = 0
        for result in results {
            guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                if count == results.count {
                    tableView.reloadData()
                    picker.dismiss(animated: true, completion: nil)
                }
                continue
            }
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self?.item.image = image
                    } else {
                        
                        // was probably an error...
                    }
                    count += 1
                    if count == results.count {
                        self?.tableView.reloadData()
                        picker.dismiss(animated: true, completion: nil)
                        
                    }
                    
                }
                    
            }
        }
        
    }
}

private extension EditItemsController {
    
    @objc func keyboardAppeared(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let anitmationCurveRaw = animationCurveRawNSN?.uintValue ??
                UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: anitmationCurveRaw)
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.tableViewBottomAnchor?.constant = 0.0
            } else {
                let offset = UIScreen.main.bounds.size.height - endFrameY
                self.tableViewBottomAnchor?.constant = -offset + view.safeAreaInsets.bottom
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations:  { self.view.layoutIfNeeded() },
                           completion:  nil)
                           
        }
    }

}
