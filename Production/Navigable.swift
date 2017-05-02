//
//  Navigable.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

@objc protocol Navigable
	{
	var name:String { get }
	var childCount:Int { get }
	var isLeaf:Bool { get }
	var isExpandable:Bool { get }
	var fieldCount:Int { get }
	func childAtIndex(index:Int) -> Navigable?
	func fieldAtIndex(index:Int) -> AnyObject
	}