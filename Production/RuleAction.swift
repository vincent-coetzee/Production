//
//  RuleAction.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class RuleAction:NSObject,Navigable
	{
	override init()
		{
		}
		
	init(coder:NSCoder)
		{
		}
		
	func encodeWithCoder(coder:NSCoder)
		{
		}
		
	var name:String
		{
		return("action")
		}
		
	var childCount:Int
		{
		return(0)
		}
		
	var isLeaf:Bool
		{
		return(true)
		}
		
	var isExpandable:Bool
		{
		return(false)
		}
		
	var fieldCount:Int
		{
		return(0)
		}
		
	func executeOnMemory(memory:Memory)
		{
		}
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(nil)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
		
	func writeOnTextStream(file:TextStream)
		{
		file.nextPutString("<ruleAction/>")
		}
	}
	
class RuleActionAdd:RuleAction
	{		
	var element:MemoryElement
	
	override var name:String
		{
		return("add-action")
		}
		
	override var childCount:Int
		{
		return(1)
		}
		
	override var isLeaf:Bool
		{
		return(false)
		}
		
	override var isExpandable:Bool
		{
		return(true)
		}
		
	override var fieldCount:Int
		{
		return(0)
		}
		
	override func childAtIndex(index:Int) -> Navigable?
		{
		return(ElementItem(element: element))
		}
		
	override func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
		
	override func executeOnMemory(memory:Memory)
		{
		memory.addElement(element);
		}
		
	init(elem:MemoryElement)
		{
		element = elem
		super.init()
		}
		
	override init(coder:NSCoder)
		{
		element = coder.decodeObjectForKey("element") as! MemoryElement
		super.init(coder:coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(element,forKey: "element")
		}
		
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("add-action begin")
		file.incrementIndent()
		element.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		}
	}
	
class RuleActionRemove:RuleAction
	{
	var index:Int
	
	override var name:String
		{
		return("remove-action")
		}
		
	init(anIndex:Int)
		{
		index = anIndex
		super.init()
		}
		
	override init(coder:NSCoder)
		{
		index = Int(coder.decodeInt64ForKey("index"))
		super.init(coder:coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeInt64(Int64(index),forKey: "index")
		}
		
	override var childCount:Int
		{
		return(1)
		}
		
	override var isLeaf:Bool
		{
		return(false)
		}
		
	override var isExpandable:Bool
		{
		return(true)
		}
		
	override var fieldCount:Int
		{
		return(0)
		}
		
	override func childAtIndex(index:Int) -> Navigable?
		{
		return(IndexItem(index: index))
		}
		
	override func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
		
	override func writeOnTextStream(file:TextStream)
		{
		file.nextPutString("remove-action \(index)")
		}
	}
	
class RuleActionModify:RuleAction
	{
	var index:Int
	var pair:AttributeValuePair
	
	override var name:String
		{
		return("modify-action")
		}
		
	override init(coder:NSCoder)
		{
		index = Int(coder.decodeInt64ForKey("index"))
		pair = coder.decodeObjectForKey("pair") as! AttributeValuePair
		super.init(coder:coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeInt64(Int64(index),forKey: "index")
		coder.encodeObject(pair,forKey:"pair")
		}
		
	init(anIndex:Int,aPair:AttributeValuePair)
		{
		index = anIndex
		pair = aPair
		super.init()
		}
		
	override func writeOnTextStream(file:TextStream)
		{
		file.nextPutString("modify-action \(index) begin")
		file.incrementIndent()
		pair.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	override var childCount:Int
		{
		return(2)
		}
		
	override var isLeaf:Bool
		{
		return(false)
		}
		
	override var isExpandable:Bool
		{
		return(true)
		}
		
	override var fieldCount:Int
		{
		return(0)
		}
		
	override func childAtIndex(index:Int) -> Navigable?
		{
		if index == 0
			{
			return(IndexItem(index:index))
			}
		else
			{
			return(PairItem(pair:pair))
			}
		}
		
	override func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}