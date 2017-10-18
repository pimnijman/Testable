//
//  SpySpec.swift
//  Testable
//
//  Created by Pim on 12-04-17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import Testable

class SpySpec: QuickSpec {
    override func spec() {
        
        describe("a Spy object") {
            
            var spy: Spy!
            beforeEach {
                spy = Spy(declarationName: "someMethod", verb: nil)
            }
            
            describe("recordCall()") {
                beforeEach {
                    spy.recordCall()
                }
                    
                it("should add a call without any arguments to the spy's array of calls") {
                    expect(spy.calls.count) == 1
                    expect(spy.calls[0].args.count) == 0
                }
                
                context("recordCall() is called again") {
                    beforeEach {
                        spy.recordCall()
                    }
                    
                    it("should add another call without any arguments to the spy's array of calls") {
                        expect(spy.calls.count) == 2
                        expect(spy.calls[1].args.count) == 0
                    }
                }
                
            }
            
            describe("recordCall(withArgs:)") {
                beforeEach {
                    spy.recordCall(withArgs: [ "Test", 1 ] )
                }
                
                it("should add a call with the supplied arguments to spy's array of calls") {
                    expect(spy.calls.count) == 1
                    expect(spy.calls[0].args.count) == 2
                    expect(spy.calls[0].args[0] as? String) == "Test"
                    expect(spy.calls[0].args[1] as? Int) == 1
                }
                
                context("recordCall(withArgs:) is called again") {
                    beforeEach {
                        spy.recordCall(withArgs: [ nil, true ])
                    }
                    
                    it("should add another call with the supplied arguments to the spy's array of calls") {
                        expect(spy.calls.count) == 2
                        expect(spy.calls[1].args.count) == 2
                        expect(spy.calls[1].args[0]).to(beNil())
                        expect(spy.calls[1].args[1] as? Bool) == true
                    }
                }
            }
            
            describe("recordCall(withValue:)") {
                beforeEach {
                    spy.recordCall(withValue: "Test" )
                }
                
                it("should add a call with the supplied value as argument to spy's array of calls") {
                    expect(spy.calls.count) == 1
                    expect(spy.calls[0].args.count) == 1
                    expect(spy.calls[0].args[0] as? String) == "Test"
                }
                
                context("recordCall(withValue:) is called again") {
                    beforeEach {
                        spy.recordCall(withValue: nil)
                    }
                    
                    it("should add another call with the supplied value as argument to the spy's array of calls") {
                        expect(spy.calls.count) == 2
                        expect(spy.calls[1].args.count) == 1
                        expect(spy.calls[1].args[0]).to(beNil())
                    }
                }
            }
            
            context("a Spy has no recorded calls") {
                describe("callCount") {
                    it("should return 0") {
                        expect(spy.callCount) == 0
                    }
                }
                
                describe("called") {
                    it("should return false") {
                        expect(spy.called) == false
                    }
                }
                
                describe("notCalled") {
                    it("should return false") {
                        expect(spy.notCalled) == true
                    }
                }
                
                describe("calledOnce") {
                    it("should return false") {
                        expect(spy.calledOnce) == false
                    }
                }
                
                describe("calledTwice") {
                    it("should return false") {
                        expect(spy.calledTwice) == false
                    }
                }
                
                describe("calledThrice") {
                    it("should return false") {
                        expect(spy.calledThrice) == false
                    }
                }
                
                describe("firstCall") {
                    it("should return nil") {
                        expect(spy.firstCall).to(beNil())
                    }
                }
                
                describe("secondCall") {
                    it("should return nil") {
                        expect(spy.secondCall).to(beNil())
                    }
                }
                
                describe("thirdCall") {
                    it("should return nil") {
                        expect(spy.thirdCall).to(beNil())
                    }
                }
                
                describe("lastCall") {
                    it("should return nil") {
                        expect(spy.lastCall).to(beNil())
                    }
                }
            }
            
            context("a Spy has one recorded call") {
                
                context("the call was recorded with a single argument") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "First" ])
                    }
                    
                    describe("callCount") {
                        it("should return 1") {
                            expect(spy.callCount) == 1
                        }
                    }
                    
                    describe("called") {
                        it("should return true") {
                            expect(spy.called) == true
                        }
                    }
                    
                    describe("notCalled") {
                        it("should return false") {
                            expect(spy.notCalled) == false
                        }
                    }
                    
                    describe("calledOnce") {
                        it("should return true") {
                            expect(spy.calledOnce) == true
                        }
                    }
                    
                    describe("calledTwice") {
                        it("should return false") {
                            expect(spy.calledTwice) == false
                        }
                    }
                    
                    describe("calledThrice") {
                        it("should return false") {
                            expect(spy.calledThrice) == false
                        }
                    }
                    
                    describe("firstCall") {
                        it("should return the first call") {
                            expect(spy.firstCall?.args[0] as? String) == "First"
                        }
                    }
                    
                    describe("secondCall") {
                        it("should return nil") {
                            expect(spy.secondCall).to(beNil())
                        }
                    }
                    
                    describe("thirdCall") {
                        it("should return nil") {
                            expect(spy.thirdCall).to(beNil())
                        }
                    }
                    
                    describe("lastCall") {
                        it("should return the last call") {
                            expect(spy.lastCall?.args[0] as? String) == "First"
                        }
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "First")).to(equal(1))
                            expect(spy.callCount(withArgs: "Second")).to(equal(0))
                            expect(spy.callCount(withArgs: "Third")).to(equal(0))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "First")).to(beTrue())
                            expect(spy.called(withArgs: "Second")).to(beFalse())
                            expect(spy.called(withArgs: "Third")).to(beFalse())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "First")).to(beTrue())
                            expect(spy.alwaysCalled(withArgs: "Second")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "Third")).to(beFalse())
                        }
                    }
                }
                
                context("the call was recorded with multiple arguments") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "First", 42, true ])
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "First", 42, true, "Second")).to(equal(0))
                            expect(spy.callCount(withArgs: "First", 42, true)).to(equal(1))
                            expect(spy.callCount(withArgs: "First", 42, false)).to(equal(0))
                            expect(spy.callCount(withArgs: "First", 42)).to(equal(1))
                            expect(spy.callCount(withArgs: "First", 99)).to(equal(0))
                            expect(spy.callCount(withArgs: "First")).to(equal(1))
                            expect(spy.callCount(withArgs: "Second")).to(equal(0))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "First", 42, true, "Second")).to(beFalse())
                            expect(spy.called(withArgs: "First", 42, true)).to(beTrue())
                            expect(spy.called(withArgs: "First", 42, false)).to(beFalse())
                            expect(spy.called(withArgs: "First", 42)).to(beTrue())
                            expect(spy.called(withArgs: "First", 99)).to(beFalse())
                            expect(spy.called(withArgs: "First")).to(beTrue())
                            expect(spy.called(withArgs: "Second")).to(beFalse())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "First", 42, true, "Second")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "First", 42, true)).to(beTrue())
                            expect(spy.alwaysCalled(withArgs: "First", 42, false)).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "First", 42)).to(beTrue())
                            expect(spy.alwaysCalled(withArgs: "First", 99)).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "First")).to(beTrue())
                            expect(spy.alwaysCalled(withArgs: "Second")).to(beFalse())
                        }
                    }
                }
            }
            
            context("a Spy has two recorded calls") {
                
                context("all calls were recorded with different arguments") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "First" ])
                        spy.recordCall(withArgs: [ "Second" ])
                    }
                    
                    describe("callCount") {
                        it("should return 2") {
                            expect(spy.callCount) == 2
                        }
                    }
                    
                    describe("called") {
                        it("should return true") {
                            expect(spy.called) == true
                        }
                    }
                    
                    describe("notCalled") {
                        it("should return false") {
                            expect(spy.notCalled) == false
                        }
                    }
                    
                    describe("calledOnce") {
                        it("should return false") {
                            expect(spy.calledOnce) == false
                        }
                    }
                    
                    describe("calledTwice") {
                        it("should return true") {
                            expect(spy.calledTwice) == true
                        }
                    }
                    
                    describe("calledThrice") {
                        it("should return false") {
                            expect(spy.calledThrice) == false
                        }
                    }
                    
                    describe("firstCall") {
                        it("should return the first call") {
                            expect(spy.firstCall?.args[0] as? String) == "First"
                        }
                    }
                    
                    describe("secondCall") {
                        it("should return the second call") {
                            expect(spy.secondCall?.args[0] as? String) == "Second"
                        }
                    }
                    
                    describe("thirdCall") {
                        it("should return nil") {
                            expect(spy.thirdCall).to(beNil())
                        }
                    }
                    
                    describe("lastCall") {
                        it("should return the last call") {
                            expect(spy.lastCall?.args[0] as? String) == "Second"
                        }
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "First")).to(equal(1))
                            expect(spy.callCount(withArgs: "Second")).to(equal(1))
                            expect(spy.callCount(withArgs: "Third")).to(equal(0))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "First")).to(beTrue())
                            expect(spy.called(withArgs: "Second")).to(beTrue())
                            expect(spy.called(withArgs: "Third")).to(beFalse())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "First")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "Second")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "Third")).to(beFalse())
                        }
                    }
                }
                
                context("all calls were recorded with the same arguments") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "Test" ])
                        spy.recordCall(withArgs: [ "Test" ])
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "Test")).to(equal(2))
                            expect(spy.callCount(withArgs: "Other")).to(equal(0))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "Test")).to(beTrue())
                            expect(spy.called(withArgs: "Other")).to(beFalse())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "Test")).to(beTrue())
                            expect(spy.alwaysCalled(withArgs: "Other")).to(beFalse())
                        }
                    }
                }
                
            }
            
            context("a Spy has three recorded calls") {
                
                context("all calls were recorded with different arguments") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "First" ])
                        spy.recordCall(withArgs: [ "Second" ])
                        spy.recordCall(withArgs: [ "Third" ])
                    }
                    
                    describe("callCount") {
                        it("should return 3") {
                            expect(spy.callCount) == 3
                        }
                    }
                    
                    describe("called") {
                        it("should return true") {
                            expect(spy.called) == true
                        }
                    }
                    
                    describe("notCalled") {
                        it("should return false") {
                            expect(spy.notCalled) == false
                        }
                    }
                    
                    describe("calledOnce") {
                        it("should return false") {
                            expect(spy.calledOnce) == false
                        }
                    }
                    
                    describe("calledTwice") {
                        it("should return false") {
                            expect(spy.calledTwice) == false
                        }
                    }
                    
                    describe("calledThrice") {
                        it("should return true") {
                            expect(spy.calledThrice) == true
                        }
                    }
                    
                    describe("firstCall") {
                        it("should return the first call") {
                            expect(spy.firstCall?.args[0] as? String) == "First"
                        }
                    }
                    
                    describe("secondCall") {
                        it("should return the second call") {
                            expect(spy.secondCall?.args[0] as? String) == "Second"
                        }
                    }
                    
                    describe("thirdCall") {
                        it("should return the third call") {
                            expect(spy.thirdCall?.args[0] as? String) == "Third"
                        }
                    }
                    
                    describe("lastCall") {
                        it("should return the last call") {
                            expect(spy.lastCall?.args[0] as? String) == "Third"
                        }
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "First")).to(equal(1))
                            expect(spy.callCount(withArgs: "Second")).to(equal(1))
                            expect(spy.callCount(withArgs: "Third")).to(equal(1))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "First")).to(beTrue())
                            expect(spy.called(withArgs: "Second")).to(beTrue())
                            expect(spy.called(withArgs: "Third")).to(beTrue())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "First")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "Second")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "Third")).to(beFalse())
                        }
                    }
                }
                
                context("some calls were recorded with the same arguments") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "Test" ])
                        spy.recordCall(withArgs: [ "Other" ])
                        spy.recordCall(withArgs: [ "Test" ])
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "Test")).to(equal(2))
                            expect(spy.callCount(withArgs: "Other")).to(equal(1))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "Test")).to(beTrue())
                            expect(spy.called(withArgs: "Other")).to(beTrue())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "Test")).to(beFalse())
                            expect(spy.alwaysCalled(withArgs: "Other")).to(beFalse())
                        }
                    }
                }
                
                context("all calls were recorded with the same arguments") {
                    beforeEach {
                        spy.recordCall(withArgs: [ "Test" ])
                        spy.recordCall(withArgs: [ "Test" ])
                        spy.recordCall(withArgs: [ "Test" ])
                    }
                    
                    describe("callCount(withArgs:)") {
                        it("should return the number of times a call was recorded with the provided arguments") {
                            expect(spy.callCount(withArgs: "Test")).to(equal(3))
                            expect(spy.callCount(withArgs: "Other")).to(equal(0))
                        }
                    }
                    
                    describe("called(withArgs:)") {
                        it("should return true when a call was recorded with the provided arguments") {
                            expect(spy.called(withArgs: "Test")).to(beTrue())
                            expect(spy.called(withArgs: "Other")).to(beFalse())
                        }
                    }
                    
                    describe("alwaysCalled(withArgs:)") {
                        it("should return true when all calls were recorded with the provided arguments") {
                            expect(spy.alwaysCalled(withArgs: "Test")).to(beTrue())
                            expect(spy.alwaysCalled(withArgs: "Other")).to(beFalse())
                        }
                    }
                }
            }
            
            describe("reset()") {
                beforeEach {
                    spy.recordCall()
                    spy.recordCall()
                    spy.recordCall()
                    
                    spy.reset()
                }
                
                it("should remove all it's recorded calls") {
                    expect(spy.calls.count) == 0
                }
            }
            
        }
        
    }
}
