//
//  ELVListValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 02/12/2015.
//
//

import Foundation

public class ListValidator : Validator {
    public var correctValues:[String]
    
    public init(validationEvent: ValidatorEvents = ValidatorEvents.ValidationPerCharacter, correctValues:[String]) {
        self.correctValues = correctValues
        super.init(validationEvent: validationEvent)
    }
    
    public override func validateValue(value: String) throws {
        guard (self.correctValues.contains(value)) else {
            throw ValidatorError.TextNotInList
        }
    }
}