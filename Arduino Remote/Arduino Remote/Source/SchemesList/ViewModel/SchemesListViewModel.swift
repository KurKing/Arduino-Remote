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
    func addItem()
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
    
    func addItem() {
        
        var value = items.value
        value.append(.init(id: UUID().uuidString, 
                           title: "Item #\(Int.random(in: 0...10))"))
        items.accept(value)
    }
}
