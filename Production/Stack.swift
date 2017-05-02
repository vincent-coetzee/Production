//
//  Stack.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/10/01.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class Stack<T>
	{
	private var elements:[T]
	
	var depth:Int
		{
		return(elements.count)
		}
		
	init()
		{
		elements = [T]()
		}
		
	func push(object:T) -> T
		{
		elements.append(object)
		return(object)
		}
		
	func pop() -> T?
		{
		if elements.count > 0
			{
			return(elements.removeLast())
			}
		return(nil)
		}
	}