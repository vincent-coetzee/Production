//
//  MemoryElement.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

struct ConditionResult
	{
	var condition:RuleCondition
	var result:Bool
	
	init(_ cond:RuleCondition,result:Bool)
		{
		condition = cond
		self.result = result
		}
	}
	
class MemoryElement:AbstractModel,Navigable,KeyValueModel,Printable
	{
	var elementType:Atom = Atom.nilAtom()
	var pairs:[AttributeValuePair] = [AttributeValuePair]()
	
	override func valueForKeyPath(key:String) -> AnyObject
		{
		return(super.valueForKeyPath(key))!
		}
		
	override func setValue(value:AnyObject?,forKeyPath:String)
		{
		super.setValue(value,forKeyPath:forKeyPath)
		}
		
	func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("memory-element \(elementType) begin")
		file.incrementIndent()
		for pair in pairs
			{
			pair.writeOnTextStream(file)
			}
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	func pairWithAttribute(atom:Atom) -> AttributeValuePair?
		{
		for pair in pairs
			{
			if pair.attribute == atom
				{
				return(pair)
				}
			}
		return(nil)
		}
		
	var name:String
		{
		var pairWithName:AttributeValuePair?
		
		pairWithName = pairWithAttribute(Atom("name"))
		if pairWithName != nil
			{
			return("\(elementType.stringValue)(\(pairWithName!.value))")
			}
		else
			{
			return("\(elementType.stringValue)")
			}
		}
		
	override var description:String
		{
		var string:String
		
		string = ""
		for pair in pairs
			{
			string += "\(pair)"
			}
		return("WME(\(string))")
		}
		
	var elementTypeString:String
		{
		return(elementType.stringValue)
		}
		
	var childCount:Int
		{
		return(pairs.count)
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
		return(pairs[index])
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(elementType.stringValue)
		}
		
	init(_ aType:Atom)
		{
		elementType = aType
		}
		
	init(_ aType:Atom,newPairs:[AttributeValuePair])
		{
		elementType = aType
		pairs = newPairs
		}
		
	init(coder:NSCoder)
		{
		elementType = coder.decodeObjectForKey("elementType") as! Atom
		pairs = coder.decodeObjectForKey("pairs") as! [AttributeValuePair]
		}
		
	func encodeWithCoder(encoder:NSCoder!)
		{
		encoder.encodeObject(elementType,forKey: "elementType")
		encoder.encodeObject(pairs,forKey:"pairs")
		}
		
	func addPair(pair:AttributeValuePair) -> AttributeValuePair
		{
		pairs.append(pair)
		return(pair)
		}
		
	func addPair(attribute:Atom,value:Value) -> AttributeValuePair
		{
		return(addPair(AttributeValuePair(attribute,value:value)))
		}
		
	func dump()
		{
		println("\t\tWME(\(elementType))")
		for pair in pairs
			{
			pair.dump()
			}
		}
		
	func findPairForConditionAttribute(attribute:Atom) -> AttributeValuePair?
		{
		for pair in pairs
			{
			if pair.attribute == attribute
				{
				return(pair)
				}
			}
		return(nil)
		}
		
	func satisfiesConditions(conditions:[RuleCondition]) -> Bool
		{
		var results:[ConditionResult] = [ConditionResult]()
		var pair:AttributeValuePair?
		var tuple:(RuleCondition,Bool)
		
		for condition in conditions
			{
			pair = findPairForConditionAttribute(condition.attribute)
			if let thePair = pair
				{
				if !condition.matchAgainstPair(thePair)
					{
					return(false)
					}
				else
					{
					results.append(ConditionResult(condition,result: true))
					}
				}
			else
				{
				results.append(ConditionResult(condition,result: false))
				}
			}
		return(true)
		}
	}