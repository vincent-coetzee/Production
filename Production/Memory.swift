//
//  Memory.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class Memory:AbstractModel,KeyValueModel,Navigable
	{
	private var elements:Dictionary<Atom,MemoryElementList> = Dictionary<Atom,MemoryElementList>()
	private var sortedKeys:[String] = [String]()
	
	func addElement(elem:MemoryElement)
		{
		var list:MemoryElementList?
		
		list = elements[elem.elementType]
		if list == nil
			{
			list = MemoryElementList(elem.elementType)
			list!.append(elem)
			elements[elem.elementType] = list
			sortedKeys = keysAsSortedStrings()
			changed(Atom("sortedKeys"),withObject:elem.elementType,from:self)
			}
		else
			{
			list!.append(elem)
			}
		changed(Atom("workingElements"),withObject: elem,from: self)
		}
		
	var name:String
		{
		return("memory")
		}
		
	func encodeWithCoder(encoder:NSCoder!)
		{
		encoder.encodeObject(elements,forKey:"elements")
		encoder.encodeObject(sortedKeys,forKey:"sortedKeys")
		}
		
	func writeOnTextStream(_ file:TextStream)
		{
		for (atom,list) in elements
			{
			list.writeOnTextStream(file)
			}
		}
		
	override init()
		{
		super.init()
		}
		
	init(coder:NSCoder)
		{
		elements = coder.decodeObjectForKey("elements") as! Dictionary<Atom,MemoryElementList>
		sortedKeys = coder.decodeObjectForKey("sortedKeys") as! [String]
		}
		
	override func valueForKeyPath(key:String) -> AnyObject
		{
		return(super.valueForKeyPath(key))!
		}
		
	override func setValue(value:AnyObject?,forKeyPath:String)
		{
		super.setValue(value,forKey:forKeyPath)
		}
		
	func workingElements() -> [MemoryElement]
		{
		return(allWorkingElements())
		}
		
	func allWorkingElements() -> [MemoryElement]
		{
		var array:[MemoryElement] = [MemoryElement]()
		
		for (key,list) in elements
			{
			for element in list
				{
				array.append(element)
				}
			}
		return(array)
		}
		
	func keysAsSortedStrings() -> [String]
		{
		var strings:[String] = [String]()
		for key in elements.keys
			{
			strings.append(key.stringValue)
			}
		strings.sort {$0 < $1}
		return(strings)
		}
		
	var childCount:Int
		{
		return(sortedKeys.count)
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
		var list:MemoryElementList
		
		list = elements[Atom(sortedKeys[index])]!
		return(list)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return("Working Memory")
		}
		
	func dumpDatabase()
		{
		for (key,list) in elements
			{
			list.dump()
			}
		}
		
	func elementsMatchingType(aType:Atom) -> MemoryElementList
		{
		var list:MemoryElementList?
		
		for (key,value) in elements
			{
			println(key)
			println(value)
			}
		list = elements[aType]
		if list == nil
			{
			return(MemoryElementList(aType))
			}
		else
			{
			return(list!)
			}
		}
	}