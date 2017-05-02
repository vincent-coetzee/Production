//
//  Set.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

struct Set<T: Hashable>: SequenceType, Hashable {
 
    var container :Dictionary<T, Bool>
    
    var description: String {
    get {
        let items = self.toArray()
        return "Set: \(items)"
    }
    }
    
    var count: Int {
    get {
        return container.count
    }
    }
    
    var isEmpty: Bool {
    get {
        return container.count == 0
    }
    }
    
    var hashValue: Int {
    get {
        var hash = 0
        for object in self {
            hash ^= object.hashValue
        }
        return hash
    }
    }
    
    var debugDescription: String {
    get {
        return self.description
    }
    }
    
    init(minimumCapacity: Int = 2)
    {
        container = Dictionary<T, Bool>(minimumCapacity: minimumCapacity)
    }
    
    init(array: Array<T>)
    {
        if array.count < 2 {
            self.init()
        }
        else {
            self.init(minimumCapacity: array.count)
        }
 
        for item in array
        {
            container[item] = true
        }
    }
 
    func member(object: T) -> Bool
    {
        return container.indexForKey(object) != nil
    }
    
    mutating func add(object: T) {
        container[object] = true
    }
 
    mutating func add(array: Array<T>)
    {
        for object in array {
            container[object] = true
        }
    }
    
    mutating func remove(object: T) {
        container.removeValueForKey(object)
    }
    
    mutating func removeAll(keepCapacity: Bool = true)
    {
        container.removeAll(keepCapacity: keepCapacity)
    }
    
    func filter(predicate: T -> Bool) -> Set<T>
    {
        var result = Set<T>()
        for object in self {
            if predicate(object) {
                result.add(object)
            }
        }
        return result
    }
    
    func map<U>(transform: T -> U) -> Set<U> {
        var result = Set<U>(minimumCapacity: self.count)
        for object in self {
            result.add(transform(object))
        }
        return result
    }
    
    func iter(action: T -> ()) {
        for object in self {
            action(object)
        }
    }
    
    func reduce<U>(initial: U, combine: (U, T) -> U) -> U {
        var acc = initial
        for object in self {
            acc = combine(acc, object)
        }
        return acc
    }
    
    func toArray() -> Array<T> {
        var array = Array<T>()
        for key in container.keys {
            array.append(key)
        }
        
        return array
    }
    
    func generate() -> IndexingGenerator<Array<T>> {
        let items = self.toArray()
        
        return items.generate()
    }
    
    func union(set: Set<T>) -> Set<T> {
        var result = Set<T>(array: self.toArray())
        result.add(set.toArray())
        return result
    }
    
    func minus(set: Set<T>) -> Set<T>{
        var result = Set<T>(array: self.toArray())
        for object in set {
            result.remove(object)
        }
        return result
    }
    
    func intersect(set: Set<T>) -> Set<T>{
        var result = Set<T>(array: self.toArray())
        for object in result {
            if !set.member(object) {
                result.remove(object)
            }
        }
        return result
    }
}
 
func ==<T> (left: Set<T>, right: Set<T>) -> Bool {
    return left.count == right.count && left.minus(right).isEmpty
}
 
 
func +<T> (left: Set<T>, right: Set<T>) -> Set<T> {
    return left.union(right)
}
 
func -<T> (left: Set<T>, right: Set<T>) -> Set<T> {
    return left.minus(right)
}
 
func ^<T> (left: Set<T>, right: Set<T>) -> Set<T> {
    return left.intersect(right)
}