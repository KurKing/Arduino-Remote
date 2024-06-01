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
                
        return viewController
    }
}

class SchemesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SchemesListViewModelProtocol!
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
}

// MARK: - Actions
extension SchemesListViewController {
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.addItem()
    }
    
    private func onSelect(item: SchemesListItem) {
        navigationController?.pushViewController(SchemeViewController.instantiate(),
                                                 animated: true)
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
        
        guard let item = viewModel.items.value[safe: indexPath.row] else { return }
        onSelect(item: item)
    }
    
    func tableView(_ tableView: UITableView, 
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
