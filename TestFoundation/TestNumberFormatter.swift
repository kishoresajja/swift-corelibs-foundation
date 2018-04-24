// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

#if DEPLOYMENT_RUNTIME_OBJC || os(Linux)
    import Foundation
    import XCTest
#else
    import SwiftFoundation
    import SwiftXCTest
#endif

class TestNumberFormatter: XCTestCase {

    static var allTests: [(String, (TestNumberFormatter) -> () throws -> Void)] {
        return [
            ("test_currencyCode", test_currencyCode),
            ("test_decimalSeparator", test_decimalSeparator),
            ("test_currencyDecimalSeparator", test_currencyDecimalSeparator),
            ("test_alwaysShowDecimalSeparator", test_alwaysShowDecimalSeparator),
            ("test_groupingSeparator", test_groupingSeparator),
            ("test_percentSymbol", test_percentSymbol),
            ("test_zeroSymbol", test_zeroSymbol),
            ("test_notANumberSymbol", test_notANumberSymbol),
            ("test_positiveInfinitySymbol", test_positiveInfinitySymbol),
            ("test_minusSignSymbol", test_minusSignSymbol),
            ("test_plusSignSymbol", test_plusSignSymbol),
            ("test_currencySymbol", test_currencySymbol),
            ("test_exponentSymbol", test_exponentSymbol),
            ("test_decimalMinimumIntegerDigits", test_decimalMinimumIntegerDigits),
            ("test_currencyMinimumIntegerDigits", test_currencyMinimumIntegerDigits),
            ("test_percentMinimumIntegerDigits", test_percentMinimumIntegerDigits),
            ("test_scientificMinimumIntegerDigits", test_scientificMinimumIntegerDigits),
            ("test_spellOutMinimumIntegerDigits", test_spellOutMinimumIntegerDigits),
            ("test_ordinalMinimumIntegerDigits", test_ordinalMinimumIntegerDigits),
            ("test_currencyPluralMinimumIntegerDigits", test_currencyPluralMinimumIntegerDigits),
            ("test_currencyISOCodeMinimumIntegerDigits", test_currencyISOCodeMinimumIntegerDigits),
            ("test_currencyAccountingMinimumIntegerDigits", test_currencyAccountingMinimumIntegerDigits),
            ("test_maximumIntegerDigits", test_maximumIntegerDigits),
            ("test_minimumFractionDigits", test_minimumFractionDigits),
            ("test_maximumFractionDigits", test_maximumFractionDigits),
            ("test_groupingSize", test_groupingSize),
            ("test_secondaryGroupingSize", test_secondaryGroupingSize),
            ("test_roundingMode", test_roundingMode),
            ("test_roundingIncrement", test_roundingIncrement),
            ("test_formatWidth", test_formatWidth),
            ("test_formatPosition", test_formatPosition),
            ("test_multiplier", test_multiplier),
            ("test_positivePrefix", test_positivePrefix),
            ("test_positiveSuffix", test_positiveSuffix),
            ("test_negativePrefix", test_negativePrefix),
            ("test_negativeSuffix", test_negativeSuffix),
            ("test_internationalCurrencySymbol", test_internationalCurrencySymbol),
            ("test_currencyGroupingSeparator", test_currencyGroupingSeparator),
            ("test_lenient", test_lenient),
            ("test_minimumSignificantDigits", test_minimumSignificantDigits),
            ("test_maximumSignificantDigits", test_maximumSignificantDigits),
            ("test_stringFor", test_stringFor),
            ("test_numberFrom", test_numberFrom),
            //("test_en_US_initialValues", test_en_US_initialValues)
        ]
    }
    
    func test_currencyCode() {
        // Disabled due to [SR-250]
        /*
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.currencyCode = "T"
        numberFormatter.currencyDecimalSeparator = "_"
        let formattedString = numberFormatter.stringFromNumber(42)
        XCTAssertEqual(formattedString, "T 42_00")
         */
    }

    func test_decimalSeparator() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let separator = "-"
        numberFormatter.decimalSeparator = separator
        XCTAssertEqual(numberFormatter.decimalSeparator, separator)

        let formattedString = numberFormatter.string(from: 42.42)
        XCTAssertEqual(formattedString, "42-42")
    }
    
    func test_currencyDecimalSeparator() {
        // Disabled due to [SR-250]
        /*
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.currencyDecimalSeparator = "-"
        numberFormatter.currencyCode = "T"
        let formattedString = numberFormatter.stringFromNumber(42.42)
        XCTAssertEqual(formattedString, "T 42-42")
        */
    }
    
    func test_alwaysShowDecimalSeparator() {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = "-"
        numberFormatter.alwaysShowsDecimalSeparator = true
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "42-")
    }
    
    func test_groupingSeparator() {
        let decFormatter1 = NumberFormatter()
        XCTAssertEqual(decFormatter1.groupingSize, 0)
        decFormatter1.numberStyle = .decimal
        XCTAssertEqual(decFormatter1.groupingSize, 3)

        let decFormatter2 = NumberFormatter()
        XCTAssertEqual(decFormatter2.groupingSize, 0)
        decFormatter2.groupingSize = 1
        decFormatter2.numberStyle = .decimal
        XCTAssertEqual(decFormatter2.groupingSize, 1)

        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = "_"
        XCTAssertEqual(numberFormatter.groupingSize, 0)
        numberFormatter.groupingSize = 3
        let formattedString = numberFormatter.string(from: 42_000)
        XCTAssertEqual(formattedString, "42_000")
    }
    
    func test_percentSymbol() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.percentSymbol = "💯"
        let formattedString = numberFormatter.string(from: 0.42)
        XCTAssertEqual(formattedString, "42💯")
    }
    
    func test_zeroSymbol() {
        let numberFormatter = NumberFormatter()
        numberFormatter.zeroSymbol = "⚽️"
        let formattedString = numberFormatter.string(from: 0)
        XCTAssertEqual(formattedString, "⚽️")
    }
    var unknownZero: Int = 0
    
    func test_notANumberSymbol() {
        let numberFormatter = NumberFormatter()
        numberFormatter.notANumberSymbol = "👽"
        let number: Double = -42
        let numberObject = NSNumber(value: sqrt(number))
        let formattedString = numberFormatter.string(from: numberObject)
        XCTAssertEqual(formattedString, "👽")
    }
    
    func test_positiveInfinitySymbol() {
        let numberFormatter = NumberFormatter()
        numberFormatter.positiveInfinitySymbol = "🚀"

        let numberObject = NSNumber(value: Double(42.0) / Double(0))
        let formattedString = numberFormatter.string(from: numberObject)
        XCTAssertEqual(formattedString, "🚀")
    }
    
    func test_minusSignSymbol() {
        let numberFormatter = NumberFormatter()
        numberFormatter.minusSign = "👎"
        let formattedString = numberFormatter.string(from: -42)
        XCTAssertEqual(formattedString, "👎42")
    }
    
    func test_plusSignSymbol() {
        // ex. 1.0E+1 in scientific notation
        let numberFormatter = NumberFormatter()
        let format = "#E+0"
        numberFormatter.format = format
        XCTAssertEqual(numberFormatter.format, format)

        let sign = "👍"
        numberFormatter.plusSign = sign
        XCTAssertEqual(numberFormatter.plusSign, sign)

#if !os(Android)
        let formattedString = numberFormatter.string(from: 420000000000000000)
        XCTAssertNotNil(formattedString)
        XCTAssertEqual(formattedString, "4.2E👍17")
#endif

        // Verify a negative exponent does not have the 👍
        let noPlusString = numberFormatter.string(from: -0.420)
        XCTAssertNotNil(noPlusString)
        if let fmt = noPlusString {
            let contains: Bool = fmt.contains(sign)
            XCTAssertFalse(contains, "Expected format of -0.420 (-4.2E-1) shouldn't have a plus sign which was set as \(sign)")
        }
    }

    func test_currencySymbol() {
        // Disabled due to [SR-250]
        /*
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.currencySymbol = "🍯"
        numberFormatter.currencyDecimalSeparator = "_"
        let formattedString = numberFormatter.stringFromNumber(42)
        XCTAssertEqual(formattedString, "🍯 42_00")
        */
    }
    
    func test_exponentSymbol() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .scientific
        numberFormatter.exponentSymbol = "⬆️"
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "4.2⬆️1")
    }
    
    func test_decimalMinimumIntegerDigits() {
        let numberFormatter1 = NumberFormatter()
        XCTAssertEqual(numberFormatter1.minimumIntegerDigits, 0)
        numberFormatter1.minimumIntegerDigits = 3
        numberFormatter1.numberStyle = .decimal
        XCTAssertEqual(numberFormatter1.minimumIntegerDigits, 3)

        let numberFormatter = NumberFormatter()
        XCTAssertEqual(numberFormatter.minimumIntegerDigits, 0)
        numberFormatter.numberStyle = .decimal
        XCTAssertEqual(numberFormatter.minimumIntegerDigits, 1)
        numberFormatter.minimumIntegerDigits = 3
        var formattedString = numberFormatter.string(from: 0)
        XCTAssertEqual(formattedString, "000")

        numberFormatter.numberStyle = .decimal
        XCTAssertEqual(numberFormatter.minimumIntegerDigits, 3)
        formattedString = numberFormatter.string(from: 0.1)
        XCTAssertEqual(formattedString, "000.1")
    }

    func test_currencyMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .currency
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "$.00")
        XCTAssertEqual(formatter.string(from: 1.23), "$1.23")
        XCTAssertEqual(formatter.string(from: 123.4), "$123.40")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .currency
        XCTAssertEqual(formatter2.minimumIntegerDigits, 1)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.001), "$0.00")
        XCTAssertEqual(formatter2.string(from: 1.234), "$1.23")
        XCTAssertEqual(formatter2.string(from: 123456.7), "$123,456.70")
    }

    func test_percentMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .percent
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "0%")
        XCTAssertEqual(formatter.string(from: 1.234), "123%")
        XCTAssertEqual(formatter.string(from: 123.4), "12,340%")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .percent
        XCTAssertEqual(formatter2.minimumIntegerDigits, 1)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.01), "1%")
        XCTAssertEqual(formatter2.string(from: 1.234), "123%")
        XCTAssertEqual(formatter2.string(from: 123456.7), "12,345,670%")
    }

    func test_scientificMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .scientific
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "0E0")
        XCTAssertEqual(formatter.string(from: 1.23), "1.23E0")
        XCTAssertEqual(formatter.string(from: 123.4), "1.234E2")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .scientific
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.01), "1E-2")
        XCTAssertEqual(formatter2.string(from: 1.234), "1.234E0")
        XCTAssertEqual(formatter2.string(from: 123456.7), "1.234567E5")
    }

    func test_spellOutMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .spellOut
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "zero")
        XCTAssertEqual(formatter.string(from: 1.23), "one point two three")
        XCTAssertEqual(formatter.string(from: 123.4), "one hundred twenty-three point four")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .spellOut
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.01), "zero point zero one")
        XCTAssertEqual(formatter2.string(from: 1.234), "one point two three four")
        XCTAssertEqual(formatter2.string(from: 123456.7), "one hundred twenty-three thousand four hundred fifty-six point seven")
    }

    func test_ordinalMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .ordinal
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "0th")
        XCTAssertEqual(formatter.string(from: 1.23), "1st")
        XCTAssertEqual(formatter.string(from: 123.4), "123rd")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .ordinal
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.01), "0th")
        XCTAssertEqual(formatter2.string(from: 4.234), "4th")
        XCTAssertEqual(formatter2.string(from: 42), "42nd")
    }

    func test_currencyPluralMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .currencyPlural
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "0.00 US dollars")
        XCTAssertEqual(formatter.string(from: 1.23), "1.23 US dollars")
        XCTAssertEqual(formatter.string(from: 123.4), "123.40 US dollars")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .currencyPlural
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.01), "0.01 US dollars")
        XCTAssertEqual(formatter2.string(from: 1.234), "1.23 US dollars")
        XCTAssertEqual(formatter2.string(from: 123456.7), "123,456.70 US dollars")
    }

    func test_currencyISOCodeMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .currencyISOCode
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "USD.00")
        XCTAssertEqual(formatter.string(from: 1.23), "USD1.23")
        XCTAssertEqual(formatter.string(from: 123.4), "USD123.40")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .currencyISOCode
        XCTAssertEqual(formatter2.minimumIntegerDigits, 1)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0.01), "USD0.01")
        XCTAssertEqual(formatter2.string(from: 1.234), "USD1.23")
        XCTAssertEqual(formatter2.string(from: 123456.7), "USD123,456.70")
    }

    func test_currencyAccountingMinimumIntegerDigits() {
        // If .minimumIntegerDigits is set to 0 before .numberStyle change, preserve the value
        let formatter = NumberFormatter()
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.minimumIntegerDigits = 0
        formatter.numberStyle = .currencyAccounting
        XCTAssertEqual(formatter.minimumIntegerDigits, 0)
        formatter.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter.string(from: 0), "$.00")
        XCTAssertEqual(formatter.string(from: 1.23), "$1.23")
        XCTAssertEqual(formatter.string(from: 123.4), "$123.40")

        // If .minimumIntegerDigits is not set before .numberStyle change, update the value
        let formatter2 = NumberFormatter()
        XCTAssertEqual(formatter2.minimumIntegerDigits, 0)
        formatter2.numberStyle = .currencyAccounting
        XCTAssertEqual(formatter2.minimumIntegerDigits, 1)
        formatter2.locale = Locale(identifier: "en_US")
        XCTAssertEqual(formatter2.string(from: 0), "$0.00")
        XCTAssertEqual(formatter2.string(from: 1.23), "$1.23")
        XCTAssertEqual(formatter2.string(from: 123.4), "$123.40")
    }

    func test_maximumIntegerDigits() {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 3
        let formattedString = numberFormatter.string(from: 1_000)
        XCTAssertEqual(formattedString, "000")
    }
    
    func test_minimumFractionDigits() {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 3
        numberFormatter.decimalSeparator = "-"
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "42-000")
    }
    
    func test_maximumFractionDigits() {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 3
        numberFormatter.decimalSeparator = "-"
        let formattedString = numberFormatter.string(from: 42.4242)
        XCTAssertEqual(formattedString, "42-424")
    }
    
    func test_groupingSize() {
        let numberFormatter = NumberFormatter()
        XCTAssertEqual(numberFormatter.groupingSize, 0)
        numberFormatter.groupingSize = 4
        numberFormatter.groupingSeparator = "_"
        numberFormatter.usesGroupingSeparator = true
        let formattedString = numberFormatter.string(from: 42_000)
        XCTAssertEqual(formattedString, "4_2000")
    }
    
    func test_secondaryGroupingSize() {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSize = 3
        numberFormatter.secondaryGroupingSize = 2
        numberFormatter.groupingSeparator = "_"
        numberFormatter.usesGroupingSeparator = true
        let formattedString = numberFormatter.string(from: 42_000_000)
        XCTAssertEqual(formattedString, "4_20_00_000")
    }
    
    func test_roundingMode() {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.roundingMode = .ceiling
        let formattedString = numberFormatter.string(from: 41.0001)
        XCTAssertEqual(formattedString, "42")
    }
    
    func test_roundingIncrement() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingIncrement = 0.2
        let formattedString = numberFormatter.string(from: 4.25)
        XCTAssertEqual(formattedString, "4.2")
    }
    
    func test_formatWidth() {
        let numberFormatter = NumberFormatter()
        numberFormatter.paddingCharacter = "_"
        numberFormatter.formatWidth = 5
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "___42")
    }
    
    func test_formatPosition() {
        let numberFormatter = NumberFormatter()
        numberFormatter.paddingCharacter = "_"
        numberFormatter.formatWidth = 5
        numberFormatter.paddingPosition = .afterPrefix
        let formattedString = numberFormatter.string(from: -42)
        XCTAssertEqual(formattedString, "-__42")
    }
    
    func test_multiplier() {
        let numberFormatter = NumberFormatter()
        numberFormatter.multiplier = 2
        let formattedString = numberFormatter.string(from: 21)
        XCTAssertEqual(formattedString, "42")
    }
    
    func test_positivePrefix() {
        let numberFormatter = NumberFormatter()
        numberFormatter.positivePrefix = "👍"
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "👍42")
    }
    
    func test_positiveSuffix() {
        let numberFormatter = NumberFormatter()
        numberFormatter.positiveSuffix = "👍"
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "42👍")
    }
    
    func test_negativePrefix() {
        let numberFormatter = NumberFormatter()
        numberFormatter.negativePrefix = "👎"
        let formattedString = numberFormatter.string(from: -42)
        XCTAssertEqual(formattedString, "👎42")
    }
    
    func test_negativeSuffix() {
        let numberFormatter = NumberFormatter()
        numberFormatter.negativeSuffix = "👎"
        let formattedString = numberFormatter.string(from: -42)
        XCTAssertEqual(formattedString, "-42👎")
    }
    
    func test_internationalCurrencySymbol() {
        // Disabled due to [SR-250]
        /*
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .CurrencyPluralStyle
        numberFormatter.internationalCurrencySymbol = "💵"
        numberFormatter.currencyDecimalSeparator = "_"
        let formattedString = numberFormatter.stringFromNumber(42)
        XCTAssertEqual(formattedString, "💵 42_00")
        */
    }
    
    func test_currencyGroupingSeparator() {
        // Disabled due to [SR-250]
        /*
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.currencyGroupingSeparator = "_"
        numberFormatter.currencyCode = "T"
        numberFormatter.currencyDecimalSeparator = "/"
        let formattedString = numberFormatter.stringFromNumber(42_000)
        XCTAssertEqual(formattedString, "T 42_000/00")
        */
    }

    func test_lenient() {
        let numberFormatter = NumberFormatter()
        // Not lenient by default
        XCTAssertFalse(numberFormatter.isLenient)

        // Lenient allows wrong style -- not lenient here
        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.numberStyle, .spellOut)
//        let nilNumber = numberFormatter.number(from: "2.22")
        // FIXME: Not nil on Linux?
        //XCTAssertNil(nilNumber)
        // Lenient allows wrong style
        numberFormatter.isLenient = true
        XCTAssertTrue(numberFormatter.isLenient)
        let number = numberFormatter.number(from: "2.22")
        XCTAssertEqual(number, 2.22)

        // TODO: Add some tests with currency after [SR-250] resolved
//        numberFormatter.numberStyle = .currency
//        let nilNumberBeforeLenient = numberFormatter.number(from: "42")
//
//        XCTAssertNil(nilNumberBeforeLenient)
//        numberFormatter.isLenient = true
//        let numberAfterLenient = numberFormatter.number(from: "42.42")
//        XCTAssertEqual(numberAfterLenient, 42.42)
    }
    
    func test_minimumSignificantDigits() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumSignificantDigits = 3
        let formattedString = numberFormatter.string(from: 42)
        XCTAssertEqual(formattedString, "42.0")
    }
    
    func test_maximumSignificantDigits() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        var formattedString = numberFormatter.string(from: 987654321)
        XCTAssertEqual(formattedString, "987,654,321")
        
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = 3
        formattedString = numberFormatter.string(from: 42.42424242)
        XCTAssertEqual(formattedString, "42.4")
    }

    func test_stringFor() {
        let numberFormatter = NumberFormatter()
        XCTAssertEqual(numberFormatter.string(for: 10)!, "10")
        XCTAssertEqual(numberFormatter.string(for: 3.14285714285714)!, "3")
        XCTAssertEqual(numberFormatter.string(for: true)!, "1")
        XCTAssertEqual(numberFormatter.string(for: false)!, "0")
        XCTAssertNil(numberFormatter.string(for: [1,2]))
        XCTAssertEqual(numberFormatter.string(for: NSNumber(value: 99.1))!, "99")
        XCTAssertNil(numberFormatter.string(for: "NaN"))
        XCTAssertNil(numberFormatter.string(for: NSString(string: "NaN")))

        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.string(for: 234), "two hundred thirty-four")
        XCTAssertEqual(numberFormatter.string(for: 2007), "two thousand seven")
        XCTAssertEqual(numberFormatter.string(for: 3), "three")
        XCTAssertEqual(numberFormatter.string(for: 0.3), "zero point three")

        numberFormatter.numberStyle = .decimal
        XCTAssertEqual(numberFormatter.string(for: 234.5678), "234.568")
        
        numberFormatter.locale = Locale(identifier: "zh_CN")
        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.string(from: 11.4), "十一点四")

        numberFormatter.locale = Locale(identifier: "fr_FR")
        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.string(from: 11.4), "onze virgule quatre")

    }

    func test_numberFrom() {
        let numberFormatter = NumberFormatter()
        XCTAssertEqual(numberFormatter.number(from: "10"), 10)
        XCTAssertEqual(numberFormatter.number(from: "3.14"), 3.14)
        XCTAssertEqual(numberFormatter.number(from: "0.01"), 0.01)
        XCTAssertEqual(numberFormatter.number(from: ".01"), 0.01)

        // These don't work unless lenient/style set
        numberFormatter.numberStyle = .decimal
        XCTAssertEqual(numberFormatter.number(from: "1,001"), 1001)
        XCTAssertEqual(numberFormatter.number(from: "1,050,001"), 1050001)

        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.number(from: "two thousand and seven"), 2007)
        XCTAssertEqual(numberFormatter.number(from: "one point zero"), 1.0)
        XCTAssertEqual(numberFormatter.number(from: "one hundred million"), 1E8)

        numberFormatter.locale = Locale(identifier: "zh_CN")
        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.number(from: "十一点四"), 11.4)

        numberFormatter.locale = Locale(identifier: "fr_FR")
        numberFormatter.numberStyle = .spellOut
        XCTAssertEqual(numberFormatter.number(from: "onze virgule quatre"), 11.4)
    }

    func test_en_US_initialValues() {
        // Symbols should be extractable
        // At one point, none of this passed!

        let numberFormatter = NumberFormatter();
        numberFormatter.locale = Locale(identifier: "en_US")

        // TODO: Check if this is true for all versions...
        XCTAssertEqual(numberFormatter.format, "#;0;#")

        XCTAssertEqual(numberFormatter.plusSign, "+")
        XCTAssertEqual(numberFormatter.minusSign, "-")
        XCTAssertEqual(numberFormatter.decimalSeparator, ".")
        XCTAssertEqual(numberFormatter.groupingSeparator, ",")
        XCTAssertEqual(numberFormatter.nilSymbol, "")
        XCTAssertEqual(numberFormatter.notANumberSymbol, "NaN")
        XCTAssertEqual(numberFormatter.positiveInfinitySymbol, "+∞")
        XCTAssertEqual(numberFormatter.negativeInfinitySymbol, "-∞")
        XCTAssertEqual(numberFormatter.positivePrefix, "")
        XCTAssertEqual(numberFormatter.negativePrefix, "-")
        XCTAssertEqual(numberFormatter.positiveSuffix, "")
        XCTAssertEqual(numberFormatter.negativeSuffix, "")
        XCTAssertEqual(numberFormatter.percentSymbol, "%")
        XCTAssertEqual(numberFormatter.perMillSymbol, "‰")
        XCTAssertEqual(numberFormatter.exponentSymbol, "E")
        XCTAssertEqual(numberFormatter.groupingSeparator, ",")
        XCTAssertEqual(numberFormatter.paddingCharacter, " ")
    }
}

