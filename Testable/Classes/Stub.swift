//
//  Stub.swift
//  Pods
//
//  Created by Pim on 19-05-17.
//
//

import Foundation


public class Stub: Spy {
    
    struct Rule {
        var returnValue: Any?
        var onCall: Int?
    }
    
    
    var rules: [Rule] = []
    var partialRule: Rule?

    /// Makes the stub return the provided value.
    ///
    /// - Parameter value: The value the stub should return.
    public func returns(_ value: Any?) {
        var rule = partialRule ?? Rule()
        rule.returnValue = value
        rules.append(rule)
        partialRule = nil
    }
    
    /// Defines the behavior of the stub on the first call.
    ///
    /// - Returns: The stub itself.
    public func onFirstCall() -> Self {
        return onCall(0)
    }
    
    /// Defines the behavior of the stub on the second call.
    ///
    /// - Returns: The stub itself.
    public func onSecondCall() -> Self {
        return onCall(1)
    }
    
    /// Defines the behavior of the stub on the third call.
    ///
    /// - Returns: The stub itself.
    public func onThirdCall() -> Self {
        return onCall(2)
    }
    
    /// Defines the behavior of the stub on the nth call.
    ///
    /// - Parameter call: An integer representing the number of the call.
    /// - Returns: The stub itself.
    public func onCall(_ call: Int) -> Self {
        if partialRule == nil {
            partialRule = Rule()
        }
        partialRule?.onCall = call
        return self
    }

}
