//
//  ELVDateValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 02/12/2015.
//
//

import Foundation

public class DateValidator : Validator {
    let dateFormatter:NSDateFormatter
    let minDate:NSDate?
    let maxDate:NSDate?

    public init(validationEvent: ValidatorEvents = ValidatorEvents.ValidationAtEnd, dateFormatter: NSDateFormatter, minDate:NSDate = NSDate(timeIntervalSince1970: -DBL_MAX), maxDate:NSDate = NSDate(timeIntervalSinceNow: DBL_MAX)) {

        self.dateFormatter = dateFormatter
        self.minDate = minDate
        self.maxDate = maxDate
        super.init(validationEvent: validationEvent)
    }


    public override func validateValue(value:String) throws {
        let date = dateFormatter.dateFromString(value)

        if date == nil {
            throw ValidatorError.DateFormatIsNotCorrect
        }

        if let minDate = minDate {
            if date?.compare(minDate) == NSComparisonResult.OrderedAscending {
                throw ValidatorError.DateInferiorToMinDate
            }
        }

        if let maxDate = maxDate {
            if date?.compare(maxDate) == NSComparisonResult.OrderedDescending {
                throw ValidatorError.DateSuperiorToMaxDate
            }
        }
    }
}