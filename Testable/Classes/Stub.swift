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
        let returnValue: Any?
        let onCall: Int?
    }
    
    
    var rules: [Rule] = []

    /// Makes the stub return the provided value.
    ///
    /// - Parameter value: The value the stub should return.
    public func returns(_ value: Any?) {
        rules.append(Rule(returnValue: value, onCall: nil))
    }

}
