// Copyright (c) 2021 Benjamin Robinson.
// All Rights Reserved.

/// Allows only one set of code to obtain passage at once.
public struct Gatekeeper<Value> {
    private var value: Value
}

// MARK: - Bool

extension Gatekeeper where Value == Bool {
    public init() {
        value = true
    }
    
    @discardableResult
    public mutating func attemptPassage() -> Bool {
        if value {
            value = false
            return true
        }
        return false
    }
    
    public func passageAllowed() -> Bool {
        return value
    }
    
    public mutating func endPassage() {
        reset()
    }
    
    public mutating func reset() {
        value = true
    }
}

// MARK: - SetAlgebra

extension Gatekeeper where Value: SetAlgebra {
    public init() {
        value = []
    }
    
    @discardableResult
    public mutating func attemptPassage(for option: Value.Element) -> Bool {
        if !value.contains(option) {
            value.insert(option)
            return true
        }
        return false
    }
    
    public func passageAllowed(for option: Value.Element) -> Bool {
        return !value.contains(option)
    }
    
    public mutating func endPassage(for option: Value.Element) {
        reset(for: option)
    }
    
    public mutating func reset(for option: Value.Element) {
        value.remove(option)
    }
}

// MARK: - ChangedValueGatekeeper

/// Allows passage only if the value has changed.
public struct ChangedValueGatekeeper<Value> where Value: Equatable {
    private var value: Value
    
    public init(defaultValue: Value) {
        self.value = defaultValue
    }
    
    @discardableResult
    public mutating func attemptPassage(_ newVal: Value) -> Bool {
        if value != newVal {
            value = newVal
            return true
        }
        return false
    }
    
    public mutating func set(_ newVal: Value) {
        value = newVal
    }
}

// MARK: - GreaterValueGatekeeper

/// Allows passage only if the value is now greater (e.g. `Date`)
public struct GreaterValueGatekeeper<Value> where Value: Comparable {
    private var value: Value
    
    public init(defaultValue: Value) {
        self.value = defaultValue
    }
    
    @discardableResult
    public mutating func attemptPassage(_ newVal: Value) -> Bool {
        if value < newVal {
            value = newVal
            return true
        }
        return false
    }
    
    public mutating func set(_ newVal: Value) {
        value = newVal
    }
}

// MARK: - AuthenticationGatekeeper

public struct AuthenticationGatekeeper {
    private var value: Bool
    
    public init(defaultValue: Bool = false) {
        self.value = defaultValue
    }
    
    public mutating func attemptPassage() -> Bool {
        return value
    }
    
    public mutating func authenticate() {
        value = true
    }
    
    public mutating func deauthenticate() {
        value = false
    }
}
