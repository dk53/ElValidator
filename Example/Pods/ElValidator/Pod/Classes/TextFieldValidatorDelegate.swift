//
//  ELVTextFieldDelegate.swift
//  Pods
//
//  Created by Victor Carmouze on 30/11/2015.
//
//

import Foundation

open class TextFieldValidatorDelegate: NSObject, UITextFieldDelegate {
    var finalDelegate: UITextFieldDelegate?

    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return finalDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    open func textFieldDidBeginEditing(_ textField: UITextField) {
        finalDelegate?.textFieldDidBeginEditing?(textField)
    }

    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return finalDelegate?.textFieldShouldReturn?(textField) ?? true
    }

    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return finalDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    open func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? TextFieldValidator {

            var errors: [Error] = []
            textField.validators.forEach {
                do {
                    try $0.validate(value: textField.text ?? "")
                } catch {
                    errors.append(error)
                }
            }

            textField.validationBlock?(errors)
            finalDelegate?.textFieldDidEndEditing?(textField)
        }
    }


    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let textField = textField as? TextFieldValidator,
            let textString = textField.text as? NSString {

            let fullString = textString.replacingCharacters(in: range, with:string)

            var textFieldHasChanged = false

            for validator in textField.validators {
                if (validator.validationEvent.contains(.perCharacter) || validator.validationEvent.contains(.allowBadCharacters)) {
                    do {
                        textFieldHasChanged = true
                        try validator.validate(value: fullString)
                    } catch {
                        if !validator.validationEvent.contains(.allowBadCharacters) {
                            textField.validationBlock?([error])
                        }
                        return !(validator.validationEvent.contains(.allowBadCharacters))
                    }
                }
            }

            if (textFieldHasChanged) {
                textField.validationBlock?([])
            }
        }
        
        return (finalDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)) ?? true
    }
}
