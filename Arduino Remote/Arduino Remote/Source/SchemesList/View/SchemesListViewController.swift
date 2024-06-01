//
//  SchemesListViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit
import RxSwift

extension SchemesListViewController {
    
    class func instantiate() -> SchemesListViewController {
        
        let storyboard = UIStoryboard(name: "SchemesList", bundle: nil)
        let identifier = "SchemesListViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! SchemesListViewController
        
        viewController.viewModel = SchemesListViewModel()
        viewController.router = SchemeListRouter()
                
        return viewController
    }
}

class SchemesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SchemesListViewModelProtocol!
    private var router: RouterProtocol!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        
        viewModel.items
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
}

// MARK: - Actions
extension SchemesListViewController {
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        presentRequestNameAlert { [weak self] name in
            
            self?.viewModel.addItem(with: name)
        }
    }
    
    private func onSelect(index: Int) {
        
        guard let item = viewModel.items.value[safe: index] else { return }
        
        router.route(to: .scheme, self, item)
    }
}

// MARK: - Alerts
extension SchemesListViewController {
    
    private func presentRequestNameAlert(with completion: ((String)->())?) {
        
        let alertController = UIAlertController(title: "Enter Scheme Name",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Scheme Name"
            textField.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        }
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { [weak self] _ in
            
            let name = alertController.textFields?.first?.text.map({ $0.trimmed }) ?? ""
            
            if name.isEmpty {
                
                self?.presentRequestNameAlert(with: completion)
                return
            }
            
            completion?(name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension SchemesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = viewModel.items.value[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let identifier = "SchemeListItemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, 
                                                 for: indexPath) as! SchemeListItemTableViewCell
        
        cell.setup(with: item)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SchemesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        onSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, 
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction =
        UIContextualAction(style: .destructive,
                           title: "Delete") { [weak self] (_, _, completionHandler) in
            
            self?.viewModel.removeItem(with: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
