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
            
            describe("onFirstCall(_:)") {
                
                it("should return the stub itself with a partial rule") {
                    let stub = Stub(declarationName: "someMethod()")
                    let returnedStub = stub.onFirstCall()
                    expect(returnedStub) === stub
                    expect(returnedStub.partialRule?.onCall) == 0
                }
                
            }
            
            describe("onSecondCall(_:)") {
                
                it("should return the stub itself with a partial rule") {
                    let stub = Stub(declarationName: "someMethod()")
                    let returnedStub = stub.onSecondCall()
                    expect(returnedStub) === stub
                    expect(returnedStub.partialRule?.onCall) == 1
                }
                
            }
            
            describe("onThirdCall(_:)") {
                
                it("should return the stub itself with a partial rule") {
                    let stub = Stub(declarationName: "someMethod()")
                    let returnedStub = stub.onThirdCall()
                    expect(returnedStub) === stub
                    expect(returnedStub.partialRule?.onCall) == 2
                }
                
            }
            
            describe("onCall(_:)") {
                
                it("should return the stub itself with a partial rule") {
                    let stub = Stub(declarationName: "someMethod()")
                    let returnedStub = stub.onCall(42)
                    expect(returnedStub) === stub
                    expect(returnedStub.partialRule?.onCall) == 42
                }
                
            }
            
            describe("returns(_:)") {
                
                context("a stub with no partial rule") {
                    var stub: Stub!
                    beforeEach {
                        stub = Stub(declarationName: "someMethod()")
                    }
                    
                    context("returns(_:) is called") {
                        beforeEach {
                            stub.returns("foo")
                        }
                        
                        it("should add a rule to the rules array") {
                            expect(stub.rules.count) == 1
                            expect(stub.rules.first?.returnValue as? String) == "foo"
                            expect(stub.rules.first?.onCall).to(beNil())
                        }
                    }
                }
                
                context("a stub with a partial rule") {
                    var stub: Stub!
                    beforeEach {
                        stub = Stub(declarationName: "someMethod()")
                        stub.partialRule = Stub.Rule(returnValue: nil, onCall: 42)
                    }
                    
                    context("returns(_:) is called") {
                        beforeEach {
                            stub.returns("foo")
                        }
                        
                        it("should add a rule to the rules array containing values from the partial rule") {
                            expect(stub.rules.count) == 1
                            expect(stub.rules.first?.returnValue as? String) == "foo"
                            expect(stub.rules.first?.onCall) == 42
                        }
                        
                        it("should have removed the partial rule") {
                            expect(stub.partialRule).to(beNil())
                        }
                    }
                }
                
            }
            
        }
        
    }
}
