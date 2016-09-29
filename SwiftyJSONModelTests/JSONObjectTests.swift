//
//  JSONObjectTypeTests.swift
//  SwiftyJSONModel
//
//  Created by Oleksii on 19/09/16.
//  Copyright © 2016 Oleksii Dykan. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import SwiftyJSONModel

class JSONObjectTests: XCTestCase {
    typealias PersonKey = Person.PropertyKey
    
    func testJSONObjectThrowableValueForKey() {
        XCTAssertEqual(try? Data.jsonObject.value(for: .firstName), Data.person.firstName)
        XCTAssertEqual(try? Data.jsonObject.value(for: .lastName), Data.person.lastName)
        XCTAssertEqual(try? Data.jsonObject.value(for: .age), Data.person.age)
        XCTAssertEqual(try? Data.jsonObject.value(for: .isMarried), Data.person.isMarried)
        XCTAssertEqual(try? Data.jsonObject.value(for: .height), Data.person.height)
        
        XCTAssertThrowsError(try JSONObject<Person.PropertyKey>(json: JSON(5)), "Init with non object hould fail") { error in
            XCTAssertEqual(error as? JSONModelError, .jsonIsNotAnObject)
        }
        
        XCTAssertThrowsError(try Data.emptyJsonObject.value(for: .firstName) as String) { error in
            XCTAssertEqual(error as? JSONModelError, .invalidValueFor(key: PersonKey.firstName.rawValue, .invalidElement))
        }
        
        XCTAssertThrowsError(try Data.emptyJsonObject.value(for: .lastName) as String) { error in
            XCTAssertEqual(error as? JSONModelError, .invalidValueFor(key: PersonKey.lastName.rawValue, .invalidElement))
        }
        
        XCTAssertThrowsError(try Data.emptyJsonObject.value(for: .age) as Int) { error in
            XCTAssertEqual(error as? JSONModelError, .invalidValueFor(key: PersonKey.age.rawValue, .invalidElement))
        }
        
        XCTAssertThrowsError(try Data.emptyJsonObject.value(for: .isMarried) as Double) { error in
            XCTAssertEqual(error as? JSONModelError, .invalidValueFor(key: PersonKey.isMarried.rawValue, .invalidElement))
        }
        
        XCTAssertThrowsError(try Data.emptyJsonObject.value(for: .height) as Double) { error in
            XCTAssertEqual(error as? JSONModelError, .invalidValueFor(key: PersonKey.height.rawValue, .invalidElement))
        }
        
        XCTAssertThrowsError(try Data.jsonObject.value(for: .firstName) as Double) { error in
            XCTAssertEqual(error as? JSONModelError, .invalidValueFor(key: PersonKey.firstName.rawValue, .invalidElement))
        }
    }
    
    func testJSONObjectOptionalValueForKey() {
        let jsonObject = try! JSONObject<Person.PropertyKey>(json: Data.person.jsonValue)
        let emptyJsonObject = try! JSONObject<Person.PropertyKey>(json: JSON([String: JSON]()))
        
        let firstName: String? = jsonObject.value(for: .firstName)
        let lastName: String? = jsonObject.value(for: .lastName)
        let age: Int? = jsonObject.value(for: .age)
        let isMarried: Bool? = jsonObject.value(for: .isMarried)
        let height: Double? = jsonObject.value(for: .height)
        let hobbies: [String]? = jsonObject.value(for: .hobbies)
        
        let nilFirstName: Double? = jsonObject.value(for: .firstName)
        let emptyFirstName: String? = emptyJsonObject.value(for: .firstName)
        let emptyLastName: String? = emptyJsonObject.value(for: .lastName)
        let emptyAge: Int? = emptyJsonObject.value(for: .age)
        let emptyIsMarried: Bool? = emptyJsonObject.value(for: .isMarried)
        let emptyHeight: Double? = emptyJsonObject.value(for: .height)
        let emptyHobbies: [String]? = emptyJsonObject.value(for: .hobbies)
        
        XCTAssertEqual(firstName, Data.person.firstName)
        XCTAssertEqual(lastName, Data.person.lastName)
        XCTAssertEqual(age, Data.person.age)
        XCTAssertEqual(isMarried, Data.person.isMarried)
        XCTAssertEqual(height, Data.person.height)
        XCTAssertEqual(hobbies!, Data.person.hobbies)
        XCTAssertNil(nilFirstName)
        XCTAssertNil(emptyFirstName)
        XCTAssertNil(emptyLastName)
        XCTAssertNil(emptyAge)
        XCTAssertNil(emptyIsMarried)
        XCTAssertNil(emptyHeight)
        XCTAssertNil(emptyHobbies)
    }
}
