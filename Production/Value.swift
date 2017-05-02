//
//  Value.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

var UndefinedValue:Value = Value()
	
func ==(lhs:Value,rhs:Value) -> Bool
	{
	return(lhs.hashValue == rhs.hashValue)
	}
	
class Value:NSObject,Hashable,Equatable,Printable
	{
	override init()
		{
		}
		
	var name:String
		{
		return("Value")
		}
		
	class func undefinedValue() -> Value
		{
		return(UndefinedValue)
		}
		
	override var description:String
		{
		return("VALUE()")
		}
		
	init(coder:NSCoder)
		{
		}
		
	func encodeWithCoder(coder:NSCoder!)
		{
		}
		
	func doesMatch(anotherValue:Value) -> Bool
		{
		return((self.evaluate()).equivalentTo(anotherValue.evaluate()))
		}
		
	func matches(value:BooleanExpressionValue) -> Bool
		{
		if value.operationType == OperationType.OperationNOT
			{
			return(false)
			}
		else if value.operationType == OperationType.OperationAND
			{
			return(doesMatch(value.operand1) && doesMatch(value.operand2))
			}
		else
			{
			return(doesMatch(value.operand1) || doesMatch(value.operand2))
			}
		}
		
	func evaluate() -> Value
		{
		return(self)
		}
		
	func equivalentTo(anotherValue:Value) -> Bool
		{
		return(false)
		}
		
	func equivalentToAtomValue(value:AtomValue) -> Bool
		{
		return(false)
		}
		
	func equivalentToBooleanExpressionValue(value:BooleanExpressionValue) -> Bool
		{
		var value1:Value
		var value2:Value
		
		Transcript.nextPutAll(NSString(format:"equivalentToBooleanExpressionValue") as String)
		Transcript.nextPutAll(NSString(format:"testing %@ against %@",self,value) as String)
		value1 = value.operand1.evaluate() as Value
		if value.operationType == OperationType.OperationNOT
			{
			return(!doesMatch(value1))
			}
		else
			{
			value2 = value.operand2.evaluate()
			if (value.operationType == OperationType.OperationAND)
				{
				return(doesMatch(value1) && doesMatch(value2))
				}
			else
				{
				return(doesMatch(value1) || doesMatch(value2)) 
				}
			}
		}
		
	func equivalentToRangeValue(value:RangeValue) -> Bool
		{
		return(false)
		}
		
	override var hashValue:Int
		{
		return(1)
		}
		
	func AND(value:Value) -> Value
		{
		return(BooleanExpressionValue(self,op: OperationType.OperationAND,opd2: value))
		}
		
	func NOT() -> Value
		{
		return(BooleanExpressionValue(OperationType.OperationNOT,opd2: self))
		}
		
	func OR(value:Value) -> Value
		{
		return(BooleanExpressionValue(self,op: OperationType.OperationOR,opd2: value))
		}
		
	func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("value begin end")
		}
	}
	
class RangeValue:Value
	{
	var lower:Value
	var upper:Value
	
	override var hashValue:Int
		{
		return(lower.hashValue*31 + upper.hashValue)
		}
		
	override init(coder:NSCoder)
		{
		lower = coder.decodeObjectForKey("lower") as! Value
		upper = coder.decodeObjectForKey("upper") as! Value
		super.init(coder: coder)
		}
		
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("rangeValue")
		file.incrementIndent()
		file.nextPutString("lower")
		file.incrementIndent()
		lower.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		file.nextPutString("upper")
		file.incrementIndent()
		lower.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(lower,forKey:"lower")
		coder.encodeObject(lower,forKey:"upper")
		}
		
	override var description:String
		{
		return("RANGE(\(lower),\(upper))")
		}
		
	init(_ lower:Value,upper:Value)
		{
		self.lower = lower
		self.upper = upper
		super.init()
		}
		
	override func equivalentTo(anotherValue:Value) -> Bool
		{
		return(anotherValue.equivalentToRangeValue(self))
		}
		
	override func equivalentToRangeValue(value:RangeValue) -> Bool
		{
		return(lower == value.lower && upper == value.upper)
		}
	}
	
class AtomValue:Value
	{
	var atom:Atom
	override var hashValue:Int
		{
		return(atom.hashValue)
		}
		
	override init(coder:NSCoder)
		{
		atom = coder.decodeObjectForKey("atom") as! Atom
		super.init(coder: coder)
		}
		
	init(_ string:String)
		{
		atom = Atom(string)
		super.init()
		}
		
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("atom-value \(atom)")
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(atom,forKey:"atom")
		}
		
	override var description:String
		{
		return("\(atom)")
		}
		
	internal init(atom:Atom)
		{
		self.atom = atom
		super.init()
		}
		
	override func equivalentTo(anotherValue:Value) -> Bool
		{
		return(anotherValue.equivalentToAtomValue(self))
		}
		
	override func equivalentToAtomValue(value:AtomValue) -> Bool
		{
		return(atom == value.atom)
		}
	}
	
class VariableValue:Value
	{
	var variableName:Atom
	
	override var hashValue:Int
		{
		return(variableName.hashValue)
		}
		
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("variable-value \(variableName)")
		}
		
	override var description:String
		{
		return("_\(variableName.stringValue)")
		}
		
	init(_ aName:Atom)
		{
		variableName = aName
		super.init()
		}
		
	override init(coder:NSCoder)
		{
		variableName = coder.decodeObjectForKey("variableName") as! Atom
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(variableName,forKey:"variableName")
		}
		
	override func equivalentTo(anotherValue:Value) -> Bool
		{
		var variable:Variable
		
		variable = Variable.variableNamed(variableName)
		variable.value = anotherValue
		Transcript.nextPutAll("LET \(variableName) = \(anotherValue)")
		return(true)
		}
	}
	
class BooleanExpressionValue:Value
	{
	var operationType:OperationType
	var operand1:Value
	var operand2:Value
	
	init(_ opd1:Value,op:OperationType,opd2:Value)
		{
		operationType = op
		operand1 = opd1
		operand2 = opd2
		super.init()
		}
		
	init(_ op:OperationType,opd2:Value)
		{
		operationType = op
		operand1 = opd2
		operand2 = Value.undefinedValue()
		super.init()
		}
		
	override init(coder:NSCoder)
		{
		operand1 = coder.decodeObjectForKey("operand1") as! Value
		operand2 = coder.decodeObjectForKey("operand1") as! Value
		operationType = OperationType(rawValue: UInt(coder.decodeInt32ForKey("operationType")))!
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(operand1,forKey:"operand1")
		coder.encodeObject(operand2,forKey:"operand2")
		coder.encodeInt32(Int32(operationType.rawValue),forKey:"operationType")
		}
		
	override func equivalentTo(anotherValue:Value) -> Bool
		{
		return(anotherValue.equivalentToBooleanExpressionValue(self))
		}
		
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("boolean-expression-value ")
		file.incrementIndent()
		file.nextPutString("operand")
		file.incrementIndent()
		operand1.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		file.nextPutString("operation \(operationType.name)")
		file.nextPutString("operand")
		file.incrementIndent()
		operand2.writeOnTextStream(file)
		file.decrementIndent()
		file.nextPutString("end")
		file.decrementIndent()
		file.nextPutString("end")
		}
		
	override var description:String
		{
		return("(\(operand1)\(operationType.name)\(operand2))")
		}
	}
	
class IntValue:Value
	{
	var theInt:Int
		
	init(_ anInt:Int)
		{
		theInt = anInt
		super.init()
		}
		
	override var description:String
		{
		return("\(theInt)")
		}
		
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("int-value \(theInt)")
		}
		
	override init(coder:NSCoder)
		{
		theInt = Int(coder.decodeIntForKey("theInt"))
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeInt(Int32(theInt),forKey:"theInt")
		}
	}
	
class BooleanValue:Value
	{
	var theBool:Bool
		
	init(_ aBool:Bool)
		{
		theBool = aBool
		super.init()
		}
		
	override var description:String
		{
		return("\(theBool)")
		}
	
	override func writeOnTextStream(_ file:TextStream)
		{
		file.nextPutString("boolean-value \(theBool)")
		}	
	
	override init(coder:NSCoder)
		{
		theBool = coder.decodeBoolForKey("theBool")
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder!)
		{
		super.encodeWithCoder(coder)
		coder.encodeBool(theBool,forKey:"theBool")
		}
	}

class TestValue:Value
	{
	}
