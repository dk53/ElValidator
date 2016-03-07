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
    
    var validationBlock:((error: ErrorType?) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        validationBlock = { (error: ErrorType?) -> Void in
            if let error = error {
                print(error)
                self.activeTextField?.textColor = UIColor.redColor();
            } else {
                self.activeTextField?.textColor = UIColor.greenColor()
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
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField as? TextFieldValidator
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        activeTextField?.resignFirstResponder()
        activeTextField = nil;
        
        return true
    }
    
    func configureDateTextField() {
        textFieldDate.delegate = self
        let df = NSDateFormatter()
        df.dateStyle = NSDateFormatterStyle.ShortStyle
        textFieldDate.addValidator(DateValidator( validationEvent: .ValidationPerCharacter, dateFormatter: df))
        textFieldDate.validationBlock = validationBlock
    }
    
    func configureNumericTextField()
    {
        textFieldNumeric.delegate = self;
        textFieldNumeric.addValidator(PatternValidator(validationEvent: [.ValidationPerCharacter, .ValidationAllowBadCharacters], pattern: .Numeric))
        textFieldNumeric.validationBlock = validationBlock
    }
    
    func configureMaxTextField() {
        textFieldMax.delegate = self
        textFieldMax.addValidator(LenghtValidator(validationEvent: .ValidationPerCharacter, max: 10))
        textFieldMax.validationBlock = validationBlock
    }
    
    func configureListTextField() {
        textFieldList.delegate = self
        textFieldList.addValidator(ListValidator(validationEvent: .ValidationPerCharacter, correctValues: ["Swift", "ObjectiveC"]))
        textFieldList.validationBlock = validationBlock
    }
    
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

