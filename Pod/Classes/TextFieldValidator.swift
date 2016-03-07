//
//  ELVTextField.swift
//  Pods
//
//  Created by Victor Carmouze on 30/11/2015.
//
//

import Foundation

public class TextFieldValidator: UITextField {
    public var validationBlock: (ErrorType? -> Void)?

    var validators: [Validator]  = []
    var delegateInterceptor :TextFieldValidatorDelegate?

    override public var delegate: UITextFieldDelegate? {
        get { return (self.delegate as? TextFieldValidatorDelegate)?.finalDelegate }
        set {
            self.delegateInterceptor = TextFieldValidatorDelegate()
            self.delegateInterceptor?.finalDelegate = newValue
            super.delegate = delegateInterceptor
        }
    }

    public func addValidator(validator:Validator) {
        validators.append(validator)
    }

    func validate() {
        for (_, validator) in validators.enumerate() {
            do {
                try validator.validateValue(text ?? "")
                validationBlock?(nil)
            } catch {
                validationBlock?(error)
            }
            
        }
    }
    
    public func isValid() -> Bool {
        for (_, validator) in validators.enumerate() {
            if (try? validator.validateValue(text ?? "")) == nil {
                return false
            }
        }
        return true
    }

    public func resetValidators() {
        validators = []
    }
}
