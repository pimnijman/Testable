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
        return stub.rules.last?.returnValue
    }
    
    public func stub(forMethod methodName: String) -> Stub {
        return stub(forDeclaration: methodName)
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
