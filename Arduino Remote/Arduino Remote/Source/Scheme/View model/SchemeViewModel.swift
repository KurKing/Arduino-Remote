//
//  SchemeViewModel.swift
//  Arduino Remote
//
//  Created by Oleksii on 01.06.2024.
//

import UIKit
import RxSwift
import RxRelay

protocol SchemeViewModelProtocol {
    
    var mode: BehaviorRelay<SchemeMode> { get }
    var title: String { get }
    
    func viewDidDisappear()
    func playButtonPressed()
}

class SchemeViewModel: SchemeViewModelProtocol {
    
    let mode: BehaviorRelay<SchemeMode> = .init(value: .edit)
    var title: String { item.title }
    
    private let item: SchemesListItem
    private let model: SchemeModelProtocol
    private weak var presenter: UIViewController?
    private weak var scene: ContollerScene?
    
    init(item: SchemesListItem,
         model: SchemeModelProtocol = SchemeModel()) {
        self.item = item
        self.model = model
    }
    
    func attach(view: UIViewController, scene: ContollerScene) {
        
        self.presenter = view
        self.scene = scene
        
        scene.touchesDelegateStrategy = EditModeTouchesDelegateStrategy(presenter: view)
    }
    
    func playButtonPressed() {

        guard let presenter = presenter else { return }
        
        let mode = self.mode.value.inverted
        
        scene?.touchesDelegateStrategy = {
            switch mode {
            case .action:
                return ActionModeTouchesDelegateStrategy()
            case .edit:
                return EditModeTouchesDelegateStrategy(presenter: presenter)
            }
        }()
        
        if mode == .action {
            saveButtonsLocally()
        }
        
        self.mode.accept(mode)
    }
    
    func viewDidDisappear() {
        saveButtonsLocally()
    }
}

// MARK: - Local save
private extension SchemeViewModel {
    
    func saveButtonsLocally() {

        item.buttons = (scene?.children ?? [])
            .compactMap({ $0 as? ButtonNode })
            .map({ ButtonModel(node: $0) })
        
        model.save(item: item)
    }
}
