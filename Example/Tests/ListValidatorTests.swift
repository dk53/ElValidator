//
//  ListValidatorTests.swift
//  ElValidator
//
//  Created by jerome morissard on 25/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import ElValidator

class ListValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func test_listValidator() {
        let validatedTextfield = TextFieldValidator()

        let listValidator = ListValidator(correctValues: ["swift","swift3.0","swift3.0.1","swift3.0.2"])
        validatedTextfield.add(validator: listValidator)
        
        validatedTextfield.text = "swift"
        XCTAssert(validatedTextfield.isValid(), "swift is a valid value")
        
        validatedTextfield.text = "swift3.0"
        XCTAssert(validatedTextfield.isValid(), "swift3.0 is a valid value")
        
        validatedTextfield.text = "swift3.0.1"
        XCTAssert(validatedTextfield.isValid(), "swift3.0.1 is a valid value")
        
        validatedTextfield.text = "swift3.0.2"
        XCTAssert(validatedTextfield.isValid(), "swift3.0.2 is a valid value")
        
        validatedTextfield.text = "objc"
        XCTAssert(validatedTextfield.isValid() == false, "objc is not a valid value")
    }
}
