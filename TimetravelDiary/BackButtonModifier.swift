//
//  BackButtonModifier.swift
//  TimetravelDiary
//
//  Created by 최민경 on 2/8/25.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationBar.topItem?.backBarButtonItem?.tintColor = .white
    }
}
