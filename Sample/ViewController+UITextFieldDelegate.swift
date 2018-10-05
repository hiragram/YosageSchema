//
//  ViewController+UITextFieldDelegate.swift
//  Sample
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString

        proxy.modify { (storedObject) in
            storedObject.message = .some(text.replacingCharacters(in: range, with: string) as String)
        }

        return true
    }
}
