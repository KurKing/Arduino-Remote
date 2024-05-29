//
//  ButtonEditViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 25.05.2024.
//

import UIKit

extension ButtonEditViewController {
    
    class func instantiate() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Guidance", bundle: nil)
        let identifier = "ButtonEditViewController"
        
        let viewContoller = storyboard.instantiateViewController(withIdentifier: identifier)
                                as! ButtonEditViewController
        return viewContoller
    }
}

class ButtonEditViewController: UIViewController {
    
    @IBOutlet weak var pinPickerView: UIPickerView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pinPickerView.delegate = self
        pinPickerView.dataSource = self
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
}
