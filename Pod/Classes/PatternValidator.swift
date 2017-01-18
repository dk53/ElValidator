//
//  ELVPatternValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 02/12/2015.
//
//

import Foundation

public enum PatternValidatorRegex : String {
    case mail = "(^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$)"
    case alphaNumeric = "(^[a-zA-Z0-9]*$)"
    case numeric = "(^[0-9]*$)"
    case phone = "(^[0-9+]*$)"
    case decimal = "(^[0-9]*,?([0-9]{1,2})?$)"
    case decimalReal = "(^-?[0-9]*,?([0-9]{1,2})?$)"
}


open class PatternValidator : Validator {
    var internalExpression: NSRegularExpression?

    public init (validationEvent: ValidatorEvents = .atEnd, pattern: PatternValidatorRegex) {
        do {
            try self.internalExpression = NSRegularExpression(pattern: pattern.rawValue, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print(error)
        }

        super.init(validationEvent: validationEvent)
    }

    public init (validationEvent: ValidatorEvents = .atEnd, customPattern: String) {
        do {
            self.internalExpression = try NSRegularExpression(pattern: customPattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print(error)
        }

        super.init(validationEvent: validationEvent)
    }

    open override func validate(value: String) throws {
        guard let internalExpression = self.internalExpression,
            internalExpression.numberOfMatches(in: value, options: .reportProgress, range: NSMakeRange(0, value.characters.count)) > 0 else {
                throw ValidatorError.textDoNotMatchRegex
        }
    }
}
