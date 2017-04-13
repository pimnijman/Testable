//
//  Spyable.swift
//  Pods
//
//  Created by Pim on 09-04-17.
//
//

import Foundation


private struct AssociatedKeys {
    static var spies = "Testable_Spies"
}


public protocol Spyable: class { }

extension Spyable {
    
    var spies: [Spy] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.spies) as? [Spy] ?? [] }
        set { objc_setAssociatedObject(self, &AssociatedKeys.spies, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public func recordCall(toMethod methodName: String = #function, withArgs args: Any...) {
        self.spy(forMethod: methodName).recordCall(withArgs: args)
    }
    
    public func recordGetProperty(_ propertyName: String = #function) {
        self.spy(forGetProperty: propertyName).recordCall()
    }
    
    public func recordSetProperty(_ propertyName: String = #function, withValue value: Any?) {
        self.spy(forSetProperty: propertyName).recordCall(withValue: value)
    }
    
    public func spy(forMethod methodName: String) -> Spy {
        return spy(forDeclaration: methodName)
    }

    public func spy(forGetProperty propertyName: String) -> Spy {
        return spy(forDeclaration: propertyName, verb: .get)
    }
    
    public func spy(forSetProperty propertyName: String) -> Spy {
        return spy(forDeclaration: propertyName, verb: .set)
    }
    
    private func spy(forDeclaration declarationName: String, verb: Spy.Verb? = nil) -> Spy {
        var spy: Spy!
        let index = spies.index {
            return  $0.declarationName == declarationName && $0.verb == verb
        }
        if let index = index {
            spy = spies[index]
        } else {
            spy = Spy(declarationName: declarationName, verb: verb)
            spies.append(spy)
        }
        return spy
    }
    
}
