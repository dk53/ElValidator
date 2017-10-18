//
//  ELVLengthValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 01/12/2015.
//
//

import Foundation

open class LenghtValidator : Validator {
    let min:Int
    let max:Int

    open override func validate(value: String) throws {
        let chrts = value.characters.count

        guard chrts <= max && chrts >= min else {
            throw ValidatorError.textTooLong
        }
    }

    public init(validationEvent: ValidatorEvents, min: Int = 0, max: Int = NSIntegerMax) {
        self.max = max
        self.min = min
        super.init(validationEvent: validationEvent)
    }
}

