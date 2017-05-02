//
//  ProductionRule.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

func ==(lhs:Rule,rhs:Rule) -> Bool
	{
	return(lhs.hashValue == rhs.hashValue)
	}
	
class Rule:AbstractModel,Hashable,Equatable,KeyValueModel,Navigable
	{
	var ruleType:Atom = Atom.nilAtom()
	var conditions:[RuleCondition] = [RuleCondition]()
	var actions:[RuleAction] = [RuleAction]()
	var satisfiedByMemoryElement:MemoryElement?
		
	override var hashValue:Int
		{
		var newHash:Int
		
		newHash = ruleType.hashValue
		for condition in conditions
			{
			newHash *= 31 + condition.hashValue
			}
		return(newHash)
		}
		
	func writeOnTextStream(file:TextStream)
		{
		file.nextPutString("rule \(ruleType) begin")
		file.incrementIndent()
		file.nextPutString("conditions begin")
		file.incrementIndent()
		for condition in conditions
			{
			condition.writeOnTextStream(file)
			}
		file.decrementIndent()
		file.nextPutString("end")
		file.nextPutString("actions begin")
		file.incrementIndent()
		for action in actions
			{
			action.writeOnTextStream(file)
			}
		file.decrementIndent()
		file.nextPutString("end")
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	var name:String
		{
		return("\(ruleType)")
		}
		
	var childCount:Int
		{
		return(2)
		}
		
	var isLeaf:Bool
		{
		return(false)
		}
		
	var isExpandable:Bool
		{
		return(true)
		}
		
	var fieldCount:Int
		{
		return(0)
		}
		
	func executeActionsOnMemory(memory:Memory)
		{
		for action in actions
			{
			action.executeOnMemory(memory);
			}
		}
		
	func childAtIndex(index:Int) -> Navigable?
		{
		if index == 0
			{
			var set:ConditionsItem = ConditionsItem()
			set.conditions = conditions
			return(set)
			}
		else
			{
			var set:ActionsItem = ActionsItem()
			set.actions = actions
			return(set)
			}
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
		
	override func valueForKeyPath(key:String) -> AnyObject
		{
		return(super.valueForKeyPath(key))!
		}
		
	override func setValue(value:AnyObject?,forKeyPath:String)
		{
		super.setValue(value,forKeyPath:forKeyPath)
		}
		
	var ruleTypeString:String
		{
		return(ruleType.stringValue)
		}
		
	init(coder:NSCoder)
		{
		ruleType = coder.decodeObjectForKey("ruleType") as! Atom
		conditions = coder.decodeObjectForKey("conditions") as! [RuleCondition]
		actions = coder.decodeObjectForKey("actions") as! [RuleAction]
		}
		
	func encodeWithCoder(coder:NSCoder!)
		{
		coder.encodeObject(ruleType,forKey: "ruleType")
		coder.encodeObject(conditions,forKey:"conditions")
		coder.encodeObject(actions,forKey:"actions")
		}
		
	func dump()
		{
		}
		
	init(_ type:Atom)
		{
		self.ruleType = type
		}
		
	func addAction(anAction:RuleAction)
		{
		actions.append(anAction)
		}
		
	internal func addCondition(attribute:Atom,value:Value)
		{
		conditions.append(RuleCondition(attribute: attribute,value:value))
		}
		
	internal func addConditionString(string:String,value:Value)
		{
		conditions.append(RuleCondition(attribute: Atom(string),value:value))
		}
	}
	