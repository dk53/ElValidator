//
//  ELVTextFieldDelegate.swift
//  Pods
//
//  Created by Victor Carmouze on 30/11/2015.
//
//

import Foundation

public class TextFieldValidatorDelegate: NSObject, UITextFieldDelegate {
    var finalDelegate: UITextFieldDelegate?

    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return finalDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    public func textFieldDidBeginEditing(textField: UITextField) {
        finalDelegate?.textFieldDidBeginEditing?(textField)
    }

    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        return finalDelegate?.textFieldShouldReturn?(textField) ?? true
    }

    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return finalDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    public func textFieldDidEndEditing(textField: UITextField) {
        if let textField = textField as? TextFieldValidator {

            for validator in textField.validators {
                if (validator.validationEvent.contains(.ValidationAtEnd)) {
                    do {
                        try validator.validateValue(textField.text!)
                        textField.validationBlock?(nil)
                    } catch {
                        textField.validationBlock?(error)
                    }
                }
            }

            finalDelegate?.textFieldDidEndEditing?(textField)
        }
    }

    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let textField = textField as! TextFieldValidator
        let fullString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString:string)

        var textFieldHasChanged = false
        for validator in textField.validators {
            if (validator.validationEvent.contains(.ValidationPerCharacter) || validator.validationEvent.contains(.ValidationAllowBadCharacters)) {
                do {
                    textFieldHasChanged = true
                    try validator.validateValue(fullString)
                } catch {
                    textField.validationBlock?(error)
                    return !(validator.validationEvent.contains(.ValidationAllowBadCharacters))
                }
            }
        }

        if (textFieldHasChanged) {
            textField.validationBlock?(nil)
        }

        finalDelegate?.textField?(textField, shouldChangeCharactersInRange: range, replacementString: string)
        
        return true;
    }
    
}