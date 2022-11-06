//
//  UIStackView+Extensions.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/10.
//

import UIKit

extension UIStackView {
    func removeSubview(_ view: UIView) {
        self.removeArrangedSubview(view)
        view.isHidden = true
    }
    
    func find(label: String) -> UIView? {
        let labelList = self.arrangedSubviews.compactMap {
            $0 as? UILabel
        }.filter {
            $0.text == label
        }
        guard let uiview = labelList.first else {
            return nil
        }
        return uiview
    }
}
