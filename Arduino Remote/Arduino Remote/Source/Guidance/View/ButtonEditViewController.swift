//
//  ButtonEditViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 25.05.2024.
//

import UIKit
import RxSwift
import RxRelay

extension ButtonEditViewController {
    
    class func instantiate(selectedMode: ButtonNodeMode, pin: Int) -> ButtonEditViewController {
        
        let storyboard = UIStoryboard(name: "Guidance", bundle: nil)
        let identifier = "ButtonEditViewController"
        
        let viewContoller = storyboard.instantiateViewController(withIdentifier: identifier)
                                as! ButtonEditViewController
        viewContoller.selectedMode.accept(selectedMode)
        viewContoller.selectedPin.accept(pin)
        return viewContoller
    }
}

class ButtonEditViewController: UIViewController {
    
    @IBOutlet weak var pinPickerView: UIPickerView!
    @IBOutlet weak var segmentedViewController: UISegmentedControl!
    
    private let disposeBag = DisposeBag()
    
    let selectedMode = BehaviorRelay(value: ButtonNodeMode.oneClick)
    let selectedPin = BehaviorRelay(value: 0)
    let deleteEvent = PublishSubject<Void>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pinPickerView.delegate = self
        pinPickerView.dataSource = self
        pinPickerView.selectRow(selectedPin.value, inComponent: 0, animated: false)
        
        segmentedViewController.selectedSegmentIndex = selectedMode.value.intIndex
        segmentedViewController.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                self?.selectedMode.accept(.mode(for: index))
        }).disposed(by: disposeBag)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteEvent.onNext(())
        deleteEvent.onCompleted()
    }
}

// MARK: - UIPickerView Delegate / DataSource
extension ButtonEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        15
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        
        .init(string: "Pin #\(row)",
              attributes: [
                .font: UIFont(name: "HelveticaNeue-Bold", size: 26.0)!
              ])
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        selectedPin.accept(row)
    }
}
