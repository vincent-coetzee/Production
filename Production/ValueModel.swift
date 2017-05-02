//
//  ValueModel.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

@objc protocol ValueModel
	{
	var value:AnyObject { get set }
	func addDependent(object:NSObject)
	func removeDependent(object:NSObject)
	}