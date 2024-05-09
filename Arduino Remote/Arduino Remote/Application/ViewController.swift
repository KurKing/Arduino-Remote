//
//  ViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 22.04.2024.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var toggle = false
    
    private let ipRouter = IPInputRouter()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ApiManager.shared.configure(with: "192.168.0.125")
        
        ApiManager.shared.healthCheck
            .subscribe(onNext: { [weak self] result in
                
                self?.view.backgroundColor = .darkMidnightBlue
            }, onError: { [weak self] error in
                
                self?.view.backgroundColor = .red
            }).disposed(by: disposeBag)
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(viewTapped))
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
    }
    
    @objc private func viewTapped() {
        
        toggle.toggle()
        
        ApiManager.shared.ledRequest(isOn: toggle)
            .subscribe(onNext: { [weak self] _ in
                
                self?.view.backgroundColor = [UIColor.yellow, 
                                              UIColor.blue,
                                              UIColor.green].randomElement()!
            }, onError: { [weak self] _ in
                
                self?.view.backgroundColor = .red
            }).disposed(by: disposeBag)
    }
}
