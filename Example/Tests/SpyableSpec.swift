//
//  SpyableSpec.swift
//  Testable
//
//  Created by Pim on 09-04-17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import Testable

class SpyableSpec: QuickSpec {
    override func spec() {
        
        describe("the Spyable protocol") {
            
            context("an object who's class extends the Spyable protocol calls recordCall() from it's methods") {
                class SomeClass: Spyable {
                    func someMethod() {
                        recordCall()
                    }
                    func someOtherMethod() {
                        recordCall()
                    }
                }
                
                var someObject: SomeClass!
                beforeEach {
                    someObject = SomeClass()
                }
                
                describe("recordCall()") {
                    
                    context("one of the object's methods gets called") {
                        beforeEach {
                            someObject.someMethod()
                        }
                        
                        it("should create a spy for this method") {
                            expect(someObject.spies.count) == 1
                            expect(someObject.spies[0].declarationName) == "someMethod()"
                        }
                        
                        it("should increment the number of calls on this spy by one") {
                            expect(someObject.spies[0].calls.count) == 1
                        }
                    }
                    
                    context("one of the object's methods gets called twice") {
                        beforeEach {
                            someObject.someMethod()
                            someObject.someMethod()
                        }
                        
                        it("should create a spy for this method") {
                            expect(someObject.spies.count) == 1
                            expect(someObject.spies[0].declarationName) == "someMethod()"
                        }
                        
                        it("should increment the number of calls on this spy by two") {
                            expect(someObject.spies[0].calls.count) == 2
                        }
                    }
                    
                    context("both of the object's methods get called") {
                        beforeEach {
                            someObject.someMethod()
                            someObject.someOtherMethod()
                        }
                        
                        it("should create a spy for both methods") {
                            expect(someObject.spies.count) == 2
                            expect(someObject.spies[0].declarationName) == "someMethod()"
                            expect(someObject.spies[1].declarationName)  == "someOtherMethod()"
                        }
                        
                        it("should increment the number of calls on these spies by one") {
                            expect(someObject.spies[0].calls.count) == 1
                            expect(someObject.spies[1].calls.count)  == 1
                        }
                    }
                    
                    context("both of the object's methods get called, one of them twice") {
                        beforeEach {
                            someObject.someMethod()
                            someObject.someOtherMethod()
                            someObject.someMethod()
                        }
                        
                        it("should create a spy for both methods") {
                            expect(someObject.spies.count) == 2
                            expect(someObject.spies[0].declarationName) == "someMethod()"
                            expect(someObject.spies[1].declarationName)  == "someOtherMethod()"
                        }
                        
                        it("should increment the number of calls on these spies accordingly") {
                            expect(someObject.spies[0].calls.count) == 2
                            expect(someObject.spies[1].calls.count)  == 1
                        }
                    }
                    
                }
                
                describe("spy(forMethod:)") {
                    
                    context("both of the object's methods get called") {
                        beforeEach {
                            someObject.someMethod()
                            someObject.someOtherMethod()
                        }
                        
                        it("should return the spies that were created when the methods were called") {
                            expect(someObject.spy(forMethod: "someMethod()")) === someObject.spies[0]
                            expect(someObject.spy(forMethod: "someOtherMethod()")) === someObject.spies[1]
                        }
                    }
                    
                }
            }
            
            context("an object who's class extends the Spyable protocol calls recordCall(withArgs:) from it's method") {
                class SomeClass: Spyable {
                    func someMethod(foo: Any?, bar: Any?) {
                        recordCall(withArgs: foo as Any, bar as Any)
                    }
                }
                
                var someObject: SomeClass!
                beforeEach {
                    someObject = SomeClass()
                }
                
                describe("recordCall(withArgs:)") {
                    
                    context("the object's method gets called with a string and an integer") {
                        beforeEach {
                            someObject.someMethod(foo: "The meaning of life", bar: 42)
                        }
                        
                        it("should create a spy for this method") {
                            expect(someObject.spies.count) == 1
                            expect(someObject.spies[0].declarationName) == "someMethod(foo:bar:)"
                        }
                        
                        it("should increment the number of calls on this spy by one") {
                            expect(someObject.spies[0].calls.count) == 1
                        }
                        
                        it("should store the passed arguments as an array") {
                            expect(someObject.spies[0].calls[0].args.count) == 2
                            expect(someObject.spies[0].calls[0].args[0] as? String) == "The meaning of life"
                            expect(someObject.spies[0].calls[0].args[1] as? Int) == 42
                        }
                    }
                    
                    context("the object's method gets called twice with different values") {
                        beforeEach {
                            someObject.someMethod(foo: true, bar: false)
                            someObject.someMethod(foo: nil, bar: nil)
                        }
                        
                        it("should create a spy for this method") {
                            expect(someObject.spies.count) == 1
                            expect(someObject.spies[0].declarationName) == "someMethod(foo:bar:)"
                        }
                        
                        it("should increment the number of calls on this spy by two") {
                            expect(someObject.spies[0].calls.count) == 2
                        }
                        
                        it("should store the passed arguments as arrays") {
                            expect(someObject.spies[0].calls[0].args.count) == 2
                            expect(someObject.spies[0].calls[0].args[0] as? Bool) == true
                            expect(someObject.spies[0].calls[0].args[1] as? Bool) == false
                            
                            expect(someObject.spies[0].calls[1].args.count) == 2
                            expect(someObject.spies[0].calls[1].args[0]).to(beNil())
                            expect(someObject.spies[0].calls[1].args[1]).to(beNil())
                        }
                    }
                    
                }
            }
            
            context("an object who's class extends the Spyable protocol calls recordGetProperty() and recordSetProperty(withValue:) from it's propery getters and setters") {
                class SomeClass: Spyable {
                    var someProperty: String {
                        get { recordGetProperty(); return "" }
                        set { recordSetProperty(withValue: newValue) }
                    }
                    var someOtherProperty: Any? {
                        get { recordGetProperty(); return nil }
                        set { recordSetProperty(withValue: newValue) }
                    }
                }
                
                var someObject: SomeClass!
                beforeEach {
                    someObject = SomeClass()
                }
                
                context("the object's properties get called multiple times and set with a variaty of values") {
                    beforeEach {
                        _ = someObject.someProperty
                        _ = someObject.someProperty
                        _ = someObject.someOtherProperty
                        someObject.someProperty = "First"
                        someObject.someProperty = "Last"
                        someObject.someOtherProperty = 1
                        someObject.someOtherProperty = nil
                        someObject.someOtherProperty = true
                    }
                    
                    describe("recordGetProperty()") {
                        it("should create spies for these properties and verbs") {
                            expect(someObject.spies.count) == 4
                            
                            expect(someObject.spies[0].declarationName) == "someProperty"
                            expect(someObject.spies[0].verb) == .get
                            
                            expect(someObject.spies[1].declarationName) == "someOtherProperty"
                            expect(someObject.spies[1].verb) == .get
                            
                            expect(someObject.spies[2].declarationName) == "someProperty"
                            expect(someObject.spies[2].verb) == .set
                            
                            expect(someObject.spies[3].declarationName) == "someOtherProperty"
                            expect(someObject.spies[3].verb) == .set
                        }
                        
                        it("should increment the number of calls on these spies accordingly") {
                            expect(someObject.spies[0].calls.count) == 2
                            expect(someObject.spies[1].calls.count) == 1
                            expect(someObject.spies[2].calls.count) == 2
                            expect(someObject.spies[3].calls.count) == 3
                        }
                        
                        it("should store the passed vallues when the properties are set") {
                            expect(someObject.spies[2].calls[0].args.count) == 1
                            expect(someObject.spies[2].calls[0].args[0] as? String) == "First"
                            
                            expect(someObject.spies[2].calls[1].args.count) == 1
                            expect(someObject.spies[2].calls[1].args[0] as? String) == "Last"
                            
                            expect(someObject.spies[3].calls[0].args.count) == 1
                            expect(someObject.spies[3].calls[0].args[0] as? Int) == 1
                            
                            expect(someObject.spies[3].calls[1].args.count) == 1
                            expect(someObject.spies[3].calls[1].args[0]).to(beNil())
                            
                            expect(someObject.spies[3].calls[2].args.count) == 1
                            expect(someObject.spies[3].calls[2].args[0] as? Bool) == true
                        }
                    }
                    
                    describe("spy(forGetProperty:)") {
                        it("should return the spies that were created when the properties were called") {
                            expect(someObject.spy(forGetProperty: "someProperty")) === someObject.spies[0]
                            expect(someObject.spy(forGetProperty: "someOtherProperty")) === someObject.spies[1]
                        }
                    }
                    
                    describe("spy(forSetProperty:)") {
                        it("should return the spies that were created when the properties were set") {
                            expect(someObject.spy(forSetProperty: "someProperty")) === someObject.spies[2]
                            expect(someObject.spy(forSetProperty: "someOtherProperty")) === someObject.spies[3]
                        }
                    }
                }
            }
            
        }
        
    }
}
