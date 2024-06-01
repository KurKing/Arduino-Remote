//
//  SchemesListViewModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import Foundation
import RxSwift
import RxRelay

protocol SchemesListViewModelProtocol {
    
    var items: BehaviorRelay<[SchemesListItem]> { get }
    
    func viewWillAppear()
    func addItem(with title: String)
    func removeItem(with index: Int)
}

class SchemesListViewModel: SchemesListViewModelProtocol {
    
    let items: BehaviorRelay<[SchemesListItem]> = .init(value: [])
    
    private let model: SchemesListModelProtocol
    private let disposeBag = DisposeBag()
    
    init(model: SchemesListModelProtocol = SchemesListModel()) {
        self.model = model
    }
    
    func viewWillAppear() {
        
        model.loadItems()
            .subscribe(onNext: { [weak self] items in
                self?.items.accept(items)
            }).disposed(by: disposeBag)
    }
    
    func addItem(with title: String) {
        
        var value = items.value
        value.append(.init(id: UUID().uuidString, 
                           title: title))
        items.accept(value)
    }
    
    func removeItem(with index: Int) {
        
        var value = items.value
        
        model.delete(item: value[index])
        value.remove(at: index)
        
        items.accept(value)
    }
}
