//
//  MemoryElementList.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

struct CollectionGenerator<T>: GeneratorType 
	{
    var items: Slice<T>
	
    mutating func next() -> T? 
		{
        if items.isEmpty 
			{ return .None }
        let item = items[0]
        items = items[1..<items.count]
        return item
		}
	}
	
class MemoryElementList:NSObject,Navigable,SequenceType
	{
	var elementType:Atom
	var elements:[MemoryElement]
	
	var isEmpty:Bool
		{
		return(elements.count == 0)
		}
	
	func generate() -> CollectionGenerator<MemoryElement>
		{
		return CollectionGenerator(items: elements[0..<elements.endIndex])
		}
		
	init(coder:NSCoder)
		{
		elementType = coder.decodeObjectForKey("elementType") as! Atom
		elements = coder.decodeObjectForKey("elements") as! [MemoryElement]
		}
		
	func encodeWithCoder(encoder:NSCoder!)
		{
		encoder.encodeObject(elementType,forKey: "elementType")
		encoder.encodeObject(elements,forKey:"elements")
		}
		
	init(_ type:Atom)
		{
		elements = [MemoryElement]()
		self.elementType = type
		}
		
	var childCount:Int
		{
		return(elements.count)
		}
		
	var isLeaf:Bool
		{
		return(false)
		}
		
	var isExpandable:Bool
		{
		return(self.childCount > 0)
		}
		
	var fieldCount:Int
		{
		return(1)
		}
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(elements[index])
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(elementType.stringValue)
		}
		
	func dump()
		{
		println("\tLIST(\(elementType))")
		for element in elements
			{
			element.dump()
			}
		}
		
	var name:String
		{
		return("List of \(elementType.stringValue)")
		}
		
	func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("element-list \(elementType) begin")
		file.incrementIndent()
		for element in elements
			{
			element.writeOnTextStream(file)
			}
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	func append(e:MemoryElement)
		{
		elements.append(e)
		}
		
	func assertRule(rule:Rule,memory:Memory) -> Bool
		{
		var anElement:MemoryElement?
		
		for element in elements
			{
			if element.satisfiesConditions(rule.conditions)
				{
				anElement = element
				rule.satisfiedByMemoryElement = anElement
				rule.executeActionsOnMemory(memory);
				return(true)
				}
			}
		return(false)
		}
	}