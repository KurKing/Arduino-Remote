//
//  IPInputViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 28.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

extension IPInputViewController {
    
    class func createInstance() -> IPInputViewController {
        
        let storyboard = UIStoryboard(name: "IPInputView", bundle: nil)
        let identifier = "IPInputViewController"
        
        let viewController = storyboard
            .instantiateViewController(withIdentifier: identifier) as! IPInputViewController
        
        viewController.modalPresentationStyle = .fullScreen
        
        viewController.viewModel = IPInputViewModel()
        
        return viewController
    }
}

class IPInputViewController: UIViewController {
    
    private enum Sizes {
        static let buttonBottomPadding: CGFloat = 16
    }
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var completeButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    private var viewModel: IPInputViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        setupKeyboard()
        setupActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        inputTextField.becomeFirstResponder()
    }
}

// MARK: Setup
private extension IPInputViewController {
    
    func setupUI() {
        
        completeButton.layer.cornerRadius = 8
        
        inputTextField.delegate = self
        inputTextField.addTarget(self,
                                 action: #selector(inputTextFieldDidChange(_:)),
                                 for: .editingChanged)
        
        viewModel.isCompleteButtonEnabled
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] isEnabled in
                
                guard let button = self?.completeButton else { return }
                
                if isEnabled {
                    button.alpha = 1.0
                } else {
                    button.alpha = 0.5
                }
            }).disposed(by: disposeBag)
    }
    
    func setupKeyboard() {
        
        keyboardRect
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] rect in
                
                guard let self = self,
                      let constraint = self.completeButtonBottomConstraint else { return }
                let height = rect.height
                
                if height < Sizes.buttonBottomPadding {
                    constraint.constant = Sizes.buttonBottomPadding
                } else {
                    constraint.constant = height
                }
                
                self.view.layoutIfNeeded()
            }).disposed(by: disposeBag)
    }
}

// MARK: - Actions
private extension IPInputViewController {
    
    func setupActions() {
        
        completeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.onComplete()
        }).disposed(by: disposeBag)
    }
    
    func onComplete() {
        
        guard let viewModel = viewModel,
              viewModel.isCompleteButtonEnabled.value else {
            
            inputTextField.shake()
            return
        }
        
        inputTextField.resignFirstResponder()
        viewModel.complete()
    }
}

// MARK: - UITextFieldDelegate
extension IPInputViewController: UITextFieldDelegate {
    
    @objc func inputTextFieldDidChange(_ textField: UITextField) {
        
        let text = (textField.text ?? "").trimmed
        viewModel.ipAddress.accept(text)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
                
        guard let text = textField.text,
              let range = Range(range, in: text) else { return true }
        
        let newText = text.replacingCharacters(in: range, with: string)
        if newText.count >= 16 { return false }
        
        let string = string.trimmed
        
        return string.isEmpty || string.containsOnlyNumbersAndDots
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if viewModel.isCompleteButtonEnabled.value {
            onComplete()
            return true
        }
        
        textField.shake()
        return false
    }
}
