//
//  ELVDateValidator.swift
//  Pods
//
//  Created by Victor Carmouze on 02/12/2015.
//
//

import Foundation

open class DateValidator : Validator {
    let dateFormatter:DateFormatter
    let minDate:Date?
    let maxDate:Date?

    public init(validationEvent: ValidatorEvents = .atEnd, dateFormatter: DateFormatter, minDate:Date = Date(timeIntervalSince1970: -DBL_MAX), maxDate:Date = Date(timeIntervalSinceNow: DBL_MAX)) {

        self.dateFormatter = dateFormatter
        self.minDate = minDate
        self.maxDate = maxDate
        super.init(validationEvent: validationEvent)
    }


    open override func validate(value:String) throws {
        let date = dateFormatter.date(from: value)

        if date == nil {
            throw ValidatorError.dateFormatIsNotCorrect
        }

        if let minDate = minDate {
            if date?.compare(minDate) == ComparisonResult.orderedAscending {
                throw ValidatorError.dateInferiorToMinDate
            }
        }

        if let maxDate = maxDate {
            if date?.compare(maxDate) == ComparisonResult.orderedDescending {
                throw ValidatorError.dateSuperiorToMaxDate
            }
        }
    }
}
