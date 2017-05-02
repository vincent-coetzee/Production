//
//  RuleSet.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

@objc class PairItem:Navigable
	{
	init(pair:AttributeValuePair)
		{
		self.pair = pair
		}
		
	var pair:AttributeValuePair
	
	@objc var name:String
		{
		return("pair")
		}
		
	@objc var childCount:Int
		{
		return(1)
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(pair)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}
	
@objc class IndexItem:Navigable
	{
	init(index:Int)
		{
		self.index = index
		}
		
	var index:Int
	
	var name:String
		{
		return("index:\(index)")
		}
		
	var childCount:Int
		{
		return(0)
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(nil)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}
	
@objc class ElementItem:Navigable
	{
	init(element:MemoryElement)
		{
		self.element = element
		}
		
	var element:MemoryElement
	
	var name:String
		{
		return("element")
		}
		
	var childCount:Int
		{
		return(1)
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(element)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}
	
@objc class RulesItem:Navigable
	{
	var rules:[Rule] = [Rule]()
	
	var name:String
		{
		return("rules")
		}
		
	var childCount:Int
		{
		return(rules.count)
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(rules[index] as Navigable)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}
	
@objc class ConditionsItem:Navigable
	{
	var conditions:[RuleCondition] = [RuleCondition]()
	
	var name:String
		{
		return("conditions")
		}
		
	var childCount:Int
		{
		return(conditions.count)
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(conditions[index] as Navigable)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}
	
@objc class ActionsItem:Navigable
	{
	var actions:[RuleAction] = [RuleAction]()
	
	var name:String
		{
		return("actions")
		}
		
	var childCount:Int
		{
		return(actions.count)
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
		
	func childAtIndex(index:Int) -> Navigable?
		{
		return(actions[index] as Navigable)
		}
		
	func fieldAtIndex(index:Int) -> AnyObject
		{
		return(NSObject())
		}
	}