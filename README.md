# ElValidator

[![CI Status](http://img.shields.io/travis/dk53/ElValidator.svg?style=flat)](https://travis-ci.org/dk53/ElValidator)
[![Version](https://img.shields.io/cocoapods/v/ElValidator.svg?style=flat)](http://cocoapods.org/pods/ElValidator)
[![License](https://img.shields.io/cocoapods/l/ElValidator.svg?style=flat)](http://cocoapods.org/pods/ElValidator)
[![Platform](https://img.shields.io/cocoapods/p/ElValidator.svg?style=flat)](http://cocoapods.org/pods/ElValidator)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Require iOS 8 minimum. Use Swift 3

## Latest Version

1.1.2

## Installation

ElValidator is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ElValidator"
```

## Author

Victor Carmouze, victor.carmouze@gmail.com

## Screenshot

![Exemple](https://raw.githubusercontent.com/dk53/ElValidator/master/Screenshot.png)

## Exemple

![Exemple](https://raw.githubusercontent.com/dk53/ElValidator/master/example.png)

## Usage

###Basic usage
You must use TextFieldValidator who unherited UITextField to add validators.

```swift
var textField: TextFieldValidator
```

Then simply add the validators you likes.
```swift
textField.delegate = self
textField.add(validator: LenghtValidator(validationEvent: .validationPerCharacter, max: 10))
textField.validationBlock = validationBlock
```

The you use the validation block to manage feedbacks
```swift
var validationBlock:((_: [Error]) -> Void)?

validationBlock = { [weak self] (errors: [Error]) -> Void in
    if let error = errors.first {
        print(error)
        self?.activeTextField?.textColor = .red;
    } else {
        self?.activeTextField?.textColor = .green
    }
}
```

###Validators
A bunch of validators are included with the framework

- **Date validator**
- **Lenght validator**
- **Regex validator**
- **List validator**

###Parameters
You can use two events to call your validation block

- **validationAtEnd** 
- **validationPerCharacter**

Whom are passed to the validator.

You can additionate them with **validationAllowBadCharacters** who will block the user entry if one character is bad -ie: who type a numeric character instead of a decimal one-.

### Adding validators
You can add any validators you like by subclassing the Validator class and overriding the validate method.

## License

ElValidator is available under the MIT license. See the LICENSE file for more info.

