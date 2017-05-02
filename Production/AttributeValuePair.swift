//
//  AttributeValuePair.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

func ==(lhs:AttributeValuePair,rhs:AttributeValuePair) -> Bool
	{
	return(lhs.hashValue == rhs.hashValue)
	}
	
class AttributeValuePair:AbstractModel,Printable,Hashable,Equatable,Navigable,KeyValueModel
	{
	var attribute:Atom = Atom.nilAtom()
	var boundValue:Value = Value.undefinedValue()
	
	func valueForKeyPath(key:String) -> AnyObject
		{
		return(super.valueForKeyPath(key))!
		}
		
	func setValue(value:AnyObject?,forKeyPath:String)
		{
		super.setValue(value,forKeyPath:forKeyPath)
		}
		
	func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("attribute-value-pair \(attribute) begin")
		file.incrementIndent()
		boundValue.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	var name:String
		{
		return("\(attribute):\(value)")
		}
		
	init(coder:NSCoder)
		{
		attribute = coder.decodeObjectForKey("attribute") as! Atom
		boundValue = coder.decodeObjectForKey("value") as! Value
		}
		
	init(string:String,value:Value)
		{
		self.attribute = Atom(string)
		self.boundValue = value
		}
		
	func encodeWithCoder(encoder:NSCoder!)
		{
		encoder.encodeObject(attribute,forKey: "attribute")
		encoder.encodeObject(boundValue,forKey:"value")
		}
		
	override var description:String
		{
		return("(\(attribute):\(value))")
		}
		
	var attributeValueDescription:String
		{
		return("\(attribute):\(value)")
		}
		
	override var hashValue:Int
		{
		return(attribute.hashValue*31 + boundValue.hashValue)
		}
		
	init(_ atom:Atom,value:Value)
		{
		attribute = atom
		self.boundValue = value
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
		return(2)
		}
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(nil)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		if index == 0
			{
			return("ATTRIBUTE:\(attribute)")
			}
		else
			{
			return("VALUE:\(value)")
			}
		}
			
	func dump()
		{
		println("\t\t\t(ATTRIBUTE:\(attribute),VALUE:\(value))")
		}
	}