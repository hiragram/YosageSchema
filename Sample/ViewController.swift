//
//  ViewController.swift
//  Sample
//
//  Created by yuya-hirayama on 2018/10/04.
//  Copyright © 2018年 hiragram. All rights reserved.
//

import UIKit
import YosageSchema

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tapCountLabel: UILabel!
    @IBAction func buttonTap(_ sender: Any) {
        tapCountLabel.text = String(proxy.storedObject.tapCount + 1)
        proxy.modify { (storedObject) in
            storedObject.tapCount += 1
        }
    }

    // prepare proxy
    let proxy = UserDefaultsStorageProxy<Schema.Latest>.init(storage: UserDefaults.standard)

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self

        let storedObject: Schema.Latest = proxy.storedObject
        switch storedObject.message {
        case .some(let text):
            textField.text = text
        default:
            textField.text = nil
        }

        tapCountLabel.text = "\(storedObject.tapCount)"
    }

}

