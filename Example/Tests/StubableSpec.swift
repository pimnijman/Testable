//
//  StubableSpec.swift
//  Testable
//
//  Created by Pim on 19-05-17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import Testable

class StubableSpec: QuickSpec {
    override func spec() {
        
        describe("the Stubable protocol") {
            
            it("should extend the Spyable protocol") {
                class SomeClass: Stubable { }
                let someObject =  SomeClass()
                expect(someObject as Spyable).toNot(beNil())
            }
        
            context("an object who's class extends the Stubable protocol calls recordCall() from it's method and returns it's value") {
                class SomeClass: Stubable {
                    func someMethod() -> String? {
                        return recordCall() as? String
                    }
                }
                var someObject: SomeClass!
                beforeEach {
                    someObject = SomeClass()
                }
                
                describe("stub(forMethod:)") {
                    
                    context("stub(forMethod:) is called") {
                        var stub: Stub!
                        beforeEach {
                            stub = someObject.stub(forMethod: "someMethod()")
                        }
                        
                        it("should return a stub with the expected declaration name") {
                            expect(stub.declarationName) == "someMethod()"
                        }
                    }
                    
                    context("stub(forMethod:) is called twice with the same method name") {
                        var firstStub: Stub!
                        var secondStub: Stub!
                        beforeEach {
                            firstStub = someObject.stub(forMethod: "someMethod()")
                            secondStub = someObject.stub(forMethod: "someMethod()")
                        }
                        
                        it("should return the same stub twice") {
                            expect(secondStub) === firstStub
                        }
                    }
                    
                    context("stub(forMethod:) is called twice with different method names") {
                        var firstStub: Stub!
                        var secondStub: Stub!
                        beforeEach {
                            firstStub = someObject.stub(forMethod: "someMethod()")
                            secondStub = someObject.stub(forMethod: "someOtherMethod()")
                        }
                        
                        it("should return the two different stubs with the expected declaration names") {
                            expect(secondStub) !== firstStub
                            expect(firstStub.declarationName) == "someMethod()"
                            expect(secondStub.declarationName) == "someOtherMethod()"
                        }
                    }
                    
                }
                
                describe("recordCall()") {
                    
                    context("the expected return value is not set") {
                        context("one of the object's methods gets called thrice") {
                            var returnValues: [Any?] = []
                            beforeEach {
                                returnValues = [
                                    someObject.someMethod(),
                                    someObject.someMethod(),
                                    someObject.someMethod()
                                ]
                            }
                            
                            it("should create a spy for this method") {
                                expect(someObject.stubs.count) == 1
                                expect(someObject.stubs.first?.declarationName) == "someMethod()"
                            }
                            
                            it("should increment the number of calls on this spy by one") {
                                expect(someObject.stubs.first?.calls.count) == 3
                            }
                            
                            it("should return nil every time") {
                                expect(returnValues[0]).to(beNil())
                                expect(returnValues[1]).to(beNil())
                                expect(returnValues[2]).to(beNil())
                            }
                        }
                    }
                    
                    context("the expected return value is set") {
                        beforeEach {
                            someObject.stub(forMethod: "someMethod()").returns("foo")
                        }
                        
                        context("one of the object's methods gets called thrice") {
                            var returnValues: [Any?] = []
                            beforeEach {
                                returnValues = [
                                    someObject.someMethod(),
                                    someObject.someMethod(),
                                    someObject.someMethod()
                                ]
                            }
                            
                            it("should always return the expected return value") {
                                expect(returnValues[0] as? String) == "foo"
                                expect(returnValues[1] as? String) == "foo"
                                expect(returnValues[2] as? String) == "foo"
                            }
                        }
                    }
                    
                    context("the expected return value is set twice") {
                        beforeEach {
                            let stub = someObject.stub(forMethod: "someMethod()")
                            stub.returns("foo")
                            stub.returns("bar")
                        }
                        
                        context("one of the object's methods gets called thrice") {
                            var returnValues: [Any?] = []
                            beforeEach {
                                returnValues = [
                                    someObject.someMethod(),
                                    someObject.someMethod(),
                                    someObject.someMethod()
                                ]
                            }
                            
                            it("should always return the second expected return value") {
                                expect(returnValues[0] as? String) == "bar"
                                expect(returnValues[1] as? String) == "bar"
                                expect(returnValues[2] as? String) == "bar"
                            }
                        }
                    }
                    
                    context("the expected return value is set for a specific call") {
                        beforeEach {
                            someObject.stub(forMethod: "someMethod()").onSecondCall().returns("foo")
                        }
                        
                        context("one of the object's methods gets called thrice") {
                            var returnValues: [Any?] = []
                            beforeEach {
                                returnValues = [
                                    someObject.someMethod(),
                                    someObject.someMethod(),
                                    someObject.someMethod()
                                ]
                            }
                            
                            it("should return the expected return value on the second call") {
                                expect(returnValues[0] as? String).to(beNil())
                                expect(returnValues[1] as? String) == "foo"
                                expect(returnValues[2] as? String).to(beNil())
                            }
                        }
                    }
                    
                    context("the expected return value is set for a specific call and overridden") {
                        beforeEach {
                            let stub = someObject.stub(forMethod: "someMethod()")
                            stub.onSecondCall().returns("foo")
                            stub.returns("bar")
                        }
                        
                        context("one of the object's methods gets called thrice") {
                            var returnValues: [Any?] = []
                            beforeEach {
                                returnValues = [
                                    someObject.someMethod(),
                                    someObject.someMethod(),
                                    someObject.someMethod()
                                ]
                            }
                            
                            it("should always return the second expected return value") {
                                expect(returnValues[0] as? String) == "bar"
                                expect(returnValues[1] as? String) == "bar"
                                expect(returnValues[2] as? String) == "bar"
                            }
                        }
                    }
                    
                    context("the expected return value is set and overridden for a specific call") {
                        beforeEach {
                            let stub = someObject.stub(forMethod: "someMethod()")
                            stub.returns("foo")
                            stub.onSecondCall().returns("bar")
                        }
                        
                        context("one of the object's methods gets called thrice") {
                            var returnValues: [Any?] = []
                            beforeEach {
                                returnValues = [
                                    someObject.someMethod(),
                                    someObject.someMethod(),
                                    someObject.someMethod()
                                ]
                            }
                            
                            it("should return the second expected return value on the second call and the first expected value every on other call") {
                                    expect(returnValues[0] as? String) == "foo"
                                    expect(returnValues[1] as? String) == "bar"
                                    expect(returnValues[2] as? String) == "foo"
                            }
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
