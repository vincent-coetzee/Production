//
//  TextFileStream.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class TextFileStream:TextStream
	{
	private var filename:String = ""
	private var handle:UnsafeMutablePointer<FILE>
	private var indent:String = ""
	private var indentDepth:Int = 0
	
	init(name:String)
		{
		var aName:NSString
		
		filename = name
		aName = name as NSString
		handle = fopen(aName.UTF8String,"wt")
		}
		
	func incrementIndent()
		{
		indent = ""
		indentDepth++
		for index in 0..<indentDepth
			{
			indent += "\t"
			}
		}
		
	func decrementIndent()
		{
		indent = ""
		indentDepth--
		for index in 0..<indentDepth
			{
			indent += "\t"
			}
		}
		
	func nextPutString(string:String)
		{
		var output:NSString
		
		output = NSString(format:"%@%@\n",indent,string)
		fputs(output.UTF8String,handle)
		}
		
	func close()
		{
		fflush(handle)
		fclose(handle)
		}
	}