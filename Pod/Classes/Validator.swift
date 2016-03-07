//
//  ELVValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 30/11/2015.
//
//

import Foundation

public enum ValidatorError: ErrorType {
    case TextTooLong
    case TextNotInList
    case TextDoNotMatchRegex
    case DateInferiorToMinDate
    case DateSuperiorToMaxDate
    case DateFormatIsNotCorrect
}

public struct ValidatorEvents: OptionSetType {
    public let rawValue: Int

    static let None                                 = ValidatorEvents(rawValue: 0)
    public static let ValidationPerCharacter        = ValidatorEvents(rawValue: 1 << 0)
    public static let ValidationAtEnd               = ValidatorEvents(rawValue: 1 << 1)
    public static let ValidationAllowBadCharacters  = ValidatorEvents(rawValue: 1 << 2)

    public init(rawValue:Int) {self.rawValue = rawValue}
}

public class Validator {
    public var validationEvent = ValidatorEvents.ValidationAtEnd

    public func validateValue(value:String) throws {
        print("To override")
    }

    public init(validationEvent:ValidatorEvents) {
        self.validationEvent = validationEvent
    }
}