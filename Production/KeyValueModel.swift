//
//  KeyValueModel.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import Foundation.NSKeyValueCoding

@objc protocol KeyValueModel
	{
	func valueForKeyPath(key:String) -> AnyObject
	func setValue(value:AnyObject?,forKeyPath:String)
	func addDependent(object:NSObject)
	func removeDependent(object:NSObject)
	}