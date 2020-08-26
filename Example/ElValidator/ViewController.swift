//
//  ViewController.swift
//  ElValidator
//
//  Created by Victor Carmouze on 11/30/2015.
//  Copyright (c) 2015 Victor Carmouze. All rights reserved.
//

import UIKit
import ElValidator

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldDate: TextFieldValidator!
    @IBOutlet weak var textFieldNumeric: TextFieldValidator!
    @IBOutlet weak var textFieldMax: TextFieldValidator!
    @IBOutlet weak var textFieldList: TextFieldValidator!

    @IBOutlet weak var scrollView: UIScrollView!
    var activeTextField: TextFieldValidator?

    var validationBlock:((_: [Error]) -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()

        validationBlock = { [weak self] (errors: [Error]) -> Void in
            if let error = errors.first {
                print(error)
                self?.activeTextField?.textColor = .red;
            } else {
                self?.activeTextField?.textColor = .green
            }
        }

        configureDateTextField()
        configureNumericTextField()
        configureMaxTextField()
        configureListTextField()
        // Do any additional setup after loading the view, typically from a nib.

        scrollView.alwaysBounceVertical = true
        registerForKeyboardNotifications()
    }

    func registerForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillBeShown),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillBeHidden),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField as? TextFieldValidator
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField?.resignFirstResponder()
        activeTextField = nil;

        return true
    }

    func configureDateTextField() {
        textFieldDate.delegate = self
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        textFieldDate.add(validator: DateValidator( validationEvent: .perCharacter, dateFormatter: df))
        textFieldDate.validationBlock = validationBlock
    }

    func configureNumericTextField()
    {
        textFieldNumeric.delegate = self;
        textFieldNumeric.add(validator: PatternValidator(validationEvent: [.perCharacter, .allowBadCharacters], pattern: .numeric))
        textFieldNumeric.validationBlock = validationBlock
    }

    func configureMaxTextField() {
        textFieldMax.delegate = self
        textFieldMax.add(validator: LenghtValidator(validationEvent: .perCharacter, max: 10))
        textFieldMax.validationBlock = validationBlock
    }

    func configureListTextField() {
        textFieldList.delegate = self
        textFieldList.add(validator: ListValidator(validationEvent: .perCharacter, correctValues: ["Swift", "ObjectiveC"]))
        textFieldList.validationBlock = validationBlock
    }

    @objc func keyboardWillBeShown(sender: NSNotification) {
        if let info = sender.userInfo,
            let value = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardSize = value.cgRectValue.size
            let contentInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }

    @objc func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

