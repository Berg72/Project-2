//
//  ViewController.swift
//  Project-2
//
//  Created by Mark bergeson on 3/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

private extension ViewController {
    func setupView() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Items"
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonAction))
        addButton.tintColor = .black
       
        navigationItem.rightBarButtonItem = addButton
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 55.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(IconCell.self, forCellReuseIdentifier: IconCell.reuseIdentifier())
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        

    }
}

    private extension ViewController {
        
    
    @objc
    func addButtonAction() {
        let vc = EditItemsController(item: Item(id: UUID().uuidString, image: nil, text: nil, description: nil))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datasource.shared.items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IconCell.reuseIdentifier(), for: indexPath)
        let item = Datasource.shared.items[indexPath.row]
        if let cell = cell as? IconCell {
            cell.configure(item: item)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
        let item = Datasource.shared.items[indexPath.row]
            let vc = ItemDetailsController(item: item)
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
