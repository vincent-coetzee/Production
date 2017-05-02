//
//  Stream.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/10/01.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

protocol TextStream
	{
	func nextPutString(string:String)
	func incrementIndent()
	func decrementIndent()
	}