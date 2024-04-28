//
//  ViewController.swift
//  Arduino Remote
//
//  Created by Oleksii on 22.04.2024.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = .cyan
        
        AF.request("http://192.168.0.125/led?is_on=true")
            .validate()
            .response { data in
                print(data)
            }
    }
}
