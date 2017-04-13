//
//  Spy.swift
//  Pods
//
//  Created by Pim on 09-04-17.
//
//

import Foundation


public class Spy {
    
    enum Verb {
        case get
        case set
    }
    
    public struct Call {
        let args: [Any?]
    }
    
    
    let declarationName: String
    let verb: Verb?
    var calls: [Call] = []
    
    /// The number of recorded calls.
    public var callCount: Int {
        return calls.count
    }
    /// A Boolean value indicating whether at least one call was recorded.
    public var called: Bool {
        return callCount > 0
    }
    /// A Boolean value indicating whether no calls were recorded.
    public var notCalled: Bool {
        return callCount == 0
    }
    /// A Boolean value indicating whether exactly one call was recorded.
    public var calledOnce: Bool {
        return callCount == 1
    }
    /// A Boolean value indicating whether exactly two calls were recorded.
    public var calledTwice: Bool {
        return callCount == 2
    }
    /// A Boolean value indicating whether exactly three calls were recorded.
    public var calledThrice: Bool {
        return callCount == 3
    }
    /// The first call that was recorded.
    public var firstCall: Call? {
        return calls.first
    }
    /// The second call that was recorded.
    public var secondCall: Call? {
        let index = 1
        return calls.indices.contains(index) ? calls[index] : nil
    }
    /// The third call that was recorded.
    public var thirdCall: Call? {
        let index = 2
        return calls.indices.contains(index) ? calls[index] : nil
    }
    /// The last call that was recorded.
    public var lastCall: Call? {
        return calls.last
    }
    
    init(declarationName: String, verb: Verb?) {
        self.declarationName = declarationName
        self.verb = verb
    }
    
    func recordCall(withArgs args: [Any?] = []) {
        calls.append(Call(args: args))
    }
    
    func recordCall(withValue value: Any?) {
        calls.append(Call(args: [ value ]))
    }
    
    /// Reset the state of the spy.
    public func reset() {
        calls.removeAll()
    }
    
}
