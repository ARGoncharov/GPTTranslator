//
//  Extension.swift
//  GPTTranslator
//
//  Created by Алексей  on 20.03.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
