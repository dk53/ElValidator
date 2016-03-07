//
//  ELVLengthValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 01/12/2015.
//
//

import Foundation

public class LenghtValidator : Validator {
    let min:Int
    let max:Int
    
    public override func validateValue(value: String) throws {
        guard ((min...max).contains(value.characters.count)) else {
            throw ValidatorError.TextTooLong
        }
    }
    
    public init(validationEvent: ValidatorEvents, min: Int = 0 , max: Int = NSIntegerMax) {
        self.max = max
        self.min = min
        super.init(validationEvent: validationEvent)
    }
}

