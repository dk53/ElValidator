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


public class PatternValidator : Validator {
    var internalExpression: NSRegularExpression?
    
    public init (validationEvent: ValidatorEvents = .ValidationAtEnd, pattern: PatternValidatorRegex) {
        do {
            try self.internalExpression = NSRegularExpression(pattern: pattern.rawValue, options: NSRegularExpressionOptions.CaseInsensitive)
        } catch {
            print(error)
        }
        
        super.init(validationEvent: validationEvent)
    }
    
    public init (validationEvent: ValidatorEvents = .ValidationAtEnd, customPattern: String) {
        do {
             self.internalExpression = try NSRegularExpression(pattern: customPattern, options: NSRegularExpressionOptions.CaseInsensitive)
        } catch {
            print(error)
        }
        
        super.init(validationEvent: validationEvent)
    }
    
    public override func validateValue(value: String) throws {
        guard self.internalExpression?.numberOfMatchesInString(value, options: .ReportProgress, range: NSMakeRange(0, value.characters.count)) > 0 else {
            throw ValidatorError.TextDoNotMatchRegex
        }
    }
}