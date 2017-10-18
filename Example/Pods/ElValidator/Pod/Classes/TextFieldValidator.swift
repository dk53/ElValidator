//
//  ELVTextField.swift
//  Pods
//
//  Created by Victor Carmouze on 30/11/2015.
//
//

import Foundation

open class TextFieldValidator: UITextField {
    open var validationBlock: (([Error]) -> Void)?

    var validators: [Validator]  = []
    var delegateInterceptor :TextFieldValidatorDelegate?

    override open var delegate: UITextFieldDelegate? {
        get { return delegateInterceptor?.finalDelegate }
        set {
            self.delegateInterceptor = TextFieldValidatorDelegate()
            self.delegateInterceptor?.finalDelegate = newValue
            super.delegate = delegateInterceptor
        }
    }

    open func add(validator:Validator) {
        validators.append(validator)
    }

    open func validate() {
        var errors: [Error] = []

        validators.forEach {
            do {
                try $0.validate(value: text ?? "")
            } catch {
                errors.append(error)
            }
        }

        validationBlock?(errors)
    }
    
    open func isValid() -> Bool {
        return validators.filter {
            if (try? $0.validate(value: text ?? "")) == nil {
                return true
            }
            return false
        }.count == 0
    }

    open func resetValidators() {
        validators = []
    }
}
