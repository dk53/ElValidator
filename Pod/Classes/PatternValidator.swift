//
//  ELVPatternValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 02/12/2015.
//
//

import Foundation

public enum PatternValidatorRegex : String {
    case Mail = "(^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$)"
    case AlphaNumeric = "(^[a-zA-Z0-9]*$)"
    case Numeric = "(^[0-9]*$)"
    case Phone = "(^[0-9+]*$)"
    case Decimal = "(^[0-9]*,?([0-9]{1,2})?$)"
    case DecimalReal = "(^-?[0-9]*,?([0-9]{1,2})?$)"
}


open class PatternValidator : Validator {
    var internalExpression: NSRegularExpression?

    public init (validationEvent: ValidatorEvents = .ValidationAtEnd, pattern: PatternValidatorRegex) {
        do {
            try self.internalExpression = NSRegularExpression(pattern: pattern.rawValue, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print(error)
        }

        super.init(validationEvent: validationEvent)
    }

    public init (validationEvent: ValidatorEvents = .ValidationAtEnd, customPattern: String) {
        do {
            self.internalExpression = try NSRegularExpression(pattern: customPattern, options: NSRegularExpression.Options.caseInsensitive)
        } catch {
            print(error)
        }

        super.init(validationEvent: validationEvent)
    }

    open override func validateValue(_ value: String) throws {
        guard let internalExpression = self.internalExpression,
            internalExpression.numberOfMatches(in: value, options: .reportProgress, range: NSMakeRange(0, value.characters.count)) > 0 else {
                throw ValidatorError.textDoNotMatchRegex
        }
    }
}
