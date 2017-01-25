import UIKit
import XCTest
import ElValidator

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_lengthValidator() {
        let validatedTextfield = TextFieldValidator()
        let lengthValidator = LenghtValidator(validationEvent: .atEnd, min: 0, max: 20)
        validatedTextfield.add(validator: lengthValidator)
        validatedTextfield.text = ""
        XCTAssert(validatedTextfield.isValid(), "lenght 0 is a valid length")
        
        validatedTextfield.text = "aaaaaaaaaaaaaaaaaaaa"
        XCTAssert(validatedTextfield.isValid(), "lenght 20 is a valid length")

        validatedTextfield.text = "aaaaaaaaaaaaaaaaaaaaa"
        XCTAssert(validatedTextfield.isValid() == false, "lenght 21 is not a valid length")
    }
}
