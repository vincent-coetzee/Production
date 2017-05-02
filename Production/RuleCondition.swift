//
//  AttributeValuePair.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

func ==(lhs:RuleCondition,rhs:RuleCondition) -> Bool
	{
	return(lhs.hashValue == rhs.hashValue)
	}
	
class RuleCondition:NSObject,Hashable,Equatable,Navigable
	{
	var attribute:Atom = Atom.nilAtom()
	var boundValue:Value = Value.undefinedValue()
	
	func writeOnTextStream(file:TextStream)
		{
		file.nextPutString("condition \(attribute) begin")
		file.incrementIndent()
		boundValue.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	var name:String
		{
		return("\(attribute) == \(boundValue)")
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(nil)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
		
	override var hashValue:Int
		{
		return(attribute.hashValue*31 + boundValue.hashValue)
		}
		
	init(attribute:Atom,value:Value)
		{
		self.attribute = attribute
		self.boundValue = value
		}
		
	func matchAgainstPair(pair:AttributeValuePair) -> Bool
		{
		var outcome:Bool = boundValue.doesMatch(pair.boundValue)
		Transcript.nextPutAll("\tMatching \(boundValue) against \(pair.value) OUTCOME \(outcome)")
		return(outcome)
		}
		
	init(coder:NSCoder)
		{
		attribute = coder.decodeObjectForKey("attribute") as! Atom
		boundValue = coder.decodeObjectForKey("value") as! Value
		}
		
	func encodeWithCoder(coder:NSCoder!)
		{
		coder.encodeObject(attribute,forKey:"attribute")
		coder.encodeObject(boundValue,forKey:"value")
		}
	}