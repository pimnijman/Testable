//
//  StubSpec.swift
//  Testable
//
//  Created by Pim on 19-05-17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import Testable

class StubSpec: QuickSpec {
    override func spec() {
        
        describe("a Stub object") {
            
            it("should extend the Spy object") {
                let stub = Stub(declarationName: "someMethod()")
                expect(stub as Spy).toNot(beNil())
            }
            
        }
        
    }
}
