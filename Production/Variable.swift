//
//  Variable.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/10/01.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

var AllVariables:[Atom:Variable] = [Atom:Variable]()

class Variable
	{
	class func variableNamed(name:Atom) -> Variable
		{
		var variable:Variable?
		
		variable = AllVariables[name]
		if variable == nil
			{
			variable = Variable(name: name)
			AllVariables[name] = variable
			}
		return(variable!)
		}
		
	class func dumpVariablesToTranscript()
		{
		for (key,value) in AllVariables
			{
			Transcript.nextPutAll("\(key) = \(value.value)")
			}
		}
		
	var value:Value = Value.undefinedValue()
	var name:Atom
	
	init(name:Atom)
		{
		self.name = name
		}
	}