//
//  LoadingIndicator.swift
//  Arduino Remote
//
//  Created by Oleksii on 13.05.2024.
//

import Foundation
import SVProgressHUD

protocol LoadingIndicator {
    func show()
    func hide()
}

class SVProgressHUDLoadingIndicator: LoadingIndicator {
    
    init() {
        
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.black)
        
        SVProgressHUD.setMinimumSize(.init(width: 60, height: 60))
        SVProgressHUD.setCornerRadius(8)
        
        SVProgressHUD.setBackgroundColor(UIColor.mediumSkyBlue)
    }
    
    func show() {
        SVProgressHUD.show()
    }
    
    func hide() {
        SVProgressHUD.dismiss()
    }
}
