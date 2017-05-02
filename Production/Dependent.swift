//
//  Dependent.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

protocol Dependent:Hashable
	{
	func update(aspect:Atom,with:AnyObject?,from:AnyObject);
	}