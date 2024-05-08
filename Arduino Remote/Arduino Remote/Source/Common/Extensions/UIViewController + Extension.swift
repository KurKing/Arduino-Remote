//
//  UIViewController + Extension.swift
//  Arduino Remote
//
//  Created by Oleksii on 08.05.2024.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    
    var keyboardRect: Observable<CGRect> {
        
        Observable.from([
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                .map { notification -> CGRect in
                    (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
                        .cgRectValue ?? CGRect.zero
                },
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                .map { _ -> CGRect in
                    CGRect.zero
                }
        ])
        .merge()
    }
}
