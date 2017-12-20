//
//  Stubable.swift
//  Pods
//
//  Created by Pim on 19-05-17.
//
//

import Foundation


private struct AssociatedKeys {
    static var stubs = "Testable_Stubs"
}


public protocol Stubable: Spyable { }


extension Stubable {
    
    var stubs: [Stub] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.stubs) as? [Stub] ?? [] }
        set { objc_setAssociatedObject(self, &AssociatedKeys.stubs, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public func recordCall(toMethod methodName: String = #function, withArgs args: Any...) -> Any? {
        let stub = self.stub(forMethod: methodName)
		
		stub.recordCall(withArgs: args)
        
        let validRules = stub.rules.filter {
			if
				let expectedArgs = $0.withArgs,
				let expectedCallCount = $0.onCall == nil ? nil : $0.onCall! + 1
			{
				// This rule expects specific arguments and a specific callcount
				if stub.lastCall?.calledWith(args: expectedArgs) ?? false {
					return stub.callCount(withArgs: args) == expectedCallCount
				} else {
					return false
				}
					
			} else if let expectedArgs = $0.withArgs {
				// This rule expects specific arguments
				return stub.lastCall?.calledWith(args: expectedArgs) ?? false
				
			} else if let expectedCallCount = $0.onCall == nil ? nil : $0.onCall! + 1 {
				// This rule expects a specific callcount
				return stub.callCount == expectedCallCount
				
			} else {
				// This rule has no expectations.
				return true
			}
			// TODO: Refactor this ugly piece of **** code
        }
        let returnValue = validRules.last?.returnValue
        
        return returnValue
    }
    
    public func stub(forMethod methodName: String) -> Stub {
        return stub(forDeclaration: methodName)
    }
	
	public func stub(forProperty propertyName: String) -> Stub {
		return stub(forDeclaration: propertyName)
	}
    
    private func stub(forDeclaration declarationName: String) -> Stub {
        var stub: Stub!
        let index = stubs.index {
            return  $0.declarationName == declarationName
        }
        if let index = index {
            stub = stubs[index]
        } else {
            stub = Stub(declarationName: declarationName)
            stubs.append(stub)
        }
        return stub
    }
    
}
