//
//  CombinedValidatorsTests.swift
//  ElValidator
//
//  Created by jerome morissard on 25/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import ElValidator

class CombinedValidatorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_combinedValidators_lenght_and_list() {
        let validatedTextfield = TextFieldValidator()
        let lengthValidator = LenghtValidator(validationEvent: .atEnd, min: 0, max: 8)
        validatedTextfield.add(validator: lengthValidator)
        
        let listValidator = ListValidator(correctValues: ["swift","swift3.0","swift3.0.1","swift3.0.2"])
        validatedTextfield.add(validator: listValidator)
    
        validatedTextfield.text = "swift"
        XCTAssert(validatedTextfield.isValid(), "swift is a valid value")

        validatedTextfield.text = "swift3.0.2"
        XCTAssert(validatedTextfield.isValid() == false, "swift3.0.2 is not a valid value - too long")
    }
}
