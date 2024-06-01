//
//  SchemesListViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit

extension SchemesListViewController {
    
    class func instantiate() -> SchemesListViewController {
        
        let storyboard = UIStoryboard(name: "SchemesList", bundle: nil)
        let identifier = "SchemesListViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! SchemesListViewController
                
        return viewController
    }
}

class SchemesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
    }
}

// MARK: - Actions
extension SchemesListViewController {
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        items += 1
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SchemesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "SchemeListItemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, 
                                                 for: indexPath) as! SchemeListItemTableViewCell
        
        cell.setup(with: "Item #\(indexPath.row)")
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SchemesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        navigationController?.pushViewController(SchemeViewController.instantiate(),
                                                 animated: true)
    }
    
    func tableView(_ tableView: UITableView, 
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
