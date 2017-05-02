//
//  AbstractModel.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class AbstractModel
	{
	private var dependents:Dictionary<NSObject,Bool> = Dictionary<NSObject,Bool>()
			
	init()
		{
		}
		
	func addDependent(object:NSObject)
		{
		let truthValue = dependents[object]
		if (truthValue == nil)
			{
			dependents[object] = true
			}
		}
		
	func removeDependent(object:NSObject)
		{
		let truthValue = dependents[object]
		if (truthValue != nil)
			{
			dependents[object] = nil
			}
		}
		
	func changed(aspect:Atom,withObject:AnyObject?,from:AnyObject?)
		{
		var object:NSObject
		
		for (key,value) in dependents
			{
			key.update(aspect,with:withObject,from:from)
			}
		}
	}