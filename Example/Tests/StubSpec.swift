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
			
			describe("withArgs(_:)") {
				
				context("there is no partial rule yet") {
					var stub: Stub!
					beforeEach {
						stub = Stub(declarationName: "someMethod()")
					}
					it("should return the stub itself with a partial rule") {
						let returnedStub = stub.withArgs("The meaning of life", 42)
						expect(returnedStub) === stub
						expect(returnedStub.partialRule?.onCall).to(beNil())
						expect(returnedStub.partialRule?.withArgs?[0] as? String) == "The meaning of life"
						expect(returnedStub.partialRule?.withArgs?[1] as? Int) == 42
					}
				}
				context("there is already a partial rule") {
					var stub: Stub!
					beforeEach {
						stub = Stub(declarationName: "someMethod()").onCall(42)
					}
					it("should return the stub itself with the partial rule extended") {
						let returnedStub = stub.withArgs("The meaning of life", 42)
						expect(returnedStub) === stub
						expect(returnedStub.partialRule?.onCall) == 42
						expect(returnedStub.partialRule?.withArgs?[0] as? String) == "The meaning of life"
						expect(returnedStub.partialRule?.withArgs?[1] as? Int) == 42
					}
				}
				
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
                
                context("there is no partial rule yet") {
					var stub: Stub!
					beforeEach {
						stub = Stub(declarationName: "someMethod()")
					}
					it("should return the stub itself with a partial rule") {
						let returnedStub = stub.onCall(42)
						expect(returnedStub) === stub
						expect(returnedStub.partialRule?.onCall) == 42
					}
				}
				context("there is already a partial rule") {
					var stub: Stub!
					beforeEach {
						stub = Stub(declarationName: "someMethod()").withArgs("The meaning of life", 42)
					}
					it("should return the stub itself with the partial rule extended") {
						let returnedStub = stub.onCall(42)
						expect(returnedStub) === stub
						expect(returnedStub.partialRule?.onCall) == 42
						expect(returnedStub.partialRule?.withArgs?[0] as? String) == "The meaning of life"
						expect(returnedStub.partialRule?.withArgs?[1] as? Int) == 42
					}
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
						stub.partialRule = Stub.Rule(returnValue: nil, onCall: 42, withArgs: ["The meaning of life", 42])
                    }
                    
                    context("returns(_:) is called") {
                        beforeEach {
                            stub.returns("foo")
                        }
                        
                        it("should add a rule to the rules array containing values from the partial rule") {
                            expect(stub.rules.count) == 1
                            expect(stub.rules.first?.returnValue as? String) == "foo"
                            expect(stub.rules.first?.onCall) == 42
							expect(stub.rules.first?.withArgs?[0] as? String) == "The meaning of life"
							expect(stub.rules.first?.withArgs?[1] as? Int) == 42
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
