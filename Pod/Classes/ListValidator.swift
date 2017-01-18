//
//  ELVListValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 02/12/2015.
//
//

import Foundation

open class ListValidator : Validator {
    open var correctValues:[String]

    public init(validationEvent: ValidatorEvents = ValidatorEvents.perCharacter, correctValues:[String]) {
        self.correctValues = correctValues
        super.init(validationEvent: validationEvent)
    }

    open override func validate(value: String) throws {
        guard (self.correctValues.contains(value)) else {
            throw ValidatorError.textNotInList
        }
    }
}
