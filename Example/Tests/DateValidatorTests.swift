//
//  DateValidatorTests.swift
//  ElValidator
//
//  Created by jerome morissard on 25/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
import ElValidator

class DateValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_dateValidator() {
        let validatedTextfield = TextFieldValidator()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy"
        let dateValidator = DateValidator(dateFormatter: dateFormater)
        validatedTextfield.add(validator: dateValidator)
        
        validatedTextfield.text = "1992"
        XCTAssert(validatedTextfield.isValid(), "1992 is a valid date")
        
        validatedTextfield.text = "1992-11"
        XCTAssert(validatedTextfield.isValid() == false, "1992-11 is not a valid date")
      }
}
