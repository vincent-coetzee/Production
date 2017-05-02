//
//  Expressions.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

enum OperationType:UInt
	{
	case OperationAND
	case OperationOR
	case OperationNOT
	
	var name:String
		{
		switch(self)
			{
		case(OperationAND):
			return("AND")
		case(OperationOR):
			return("OR")
		case(OperationNOT):
			return("NOT")
		default:
			return("UNKNOWN")
			}
		}
	}
	
class Expression
	{
	var name:String
		{
		return("Expression")
		}
		
	func AND(operand:Expression) -> Expression
		{
		return(BinaryBooleanExpression(op1: self,op: OperationType.OperationAND,op2: operand))
		}
		
	func NOT() -> Expression
		{
		return(UnaryBooleanExpression(op: OperationType.OperationNOT,opd: self))
		}
		
	func OR(operand:Expression) -> Expression
		{
		return(BinaryBooleanExpression(op1: self,op: OperationType.OperationOR,op2: operand))
		}	
	
	init()
		{
		}
		
	init(coder:NSCoder)
		{
		}
		
	func encodeWithCoder(coder:NSCoder)
		{
		}
	}
	
class UnaryExpression:Expression
	{
	var operationType:OperationType?
	var operand:Expression?
	
	override init(coder:NSCoder)
		{
		operand = coder.decodeObjectForKey("operand") as! Expression
		operationType = OperationType(rawValue: UInt(coder.decodeInt32ForKey("operationType")))!
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(operand!,forKey:"operand")
		coder.encodeInt32(Int32(operationType!.rawValue),forKey:"operationType")
		}
		
	init(op:OperationType,opd:Expression)
		{
		super.init()
		operationType = op
		operand = opd
		}
	}
	
class UnaryBooleanExpression:UnaryExpression
	{
	}
	
class BinaryExpression:Expression
	{
	var operationType:OperationType?
	var lhs:Expression?
	var rhs:Expression?
	
	override init()
		{
		super.init()
		}
		
	override init(coder:NSCoder)
		{
		lhs = coder.decodeObjectForKey("lhs") as! Expression
		rhs = coder.decodeObjectForKey("rhs") as! Expression
		operationType = OperationType(rawValue:UInt(coder.decodeInt32ForKey("operationType")))
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(lhs!,forKey:"lhs")
		coder.encodeObject(rhs!,forKey:"rhs")
		coder.encodeInt32(Int32(operationType!.rawValue),forKey:"operationType")
		}
	}
	
class BinaryBooleanExpression:BinaryExpression
	{
	var operand1:Expression?
	var operand2:Expression?
	
	init(op1:Expression,op:OperationType,op2:Expression)
		{
		operand1 = op1
		operand2 = op2
		super.init()
		operationType = op
		}
		
	override init(coder:NSCoder)
		{
		operand1 = coder.decodeObjectForKey("operand1") as! Expression
		operand2 = coder.decodeObjectForKey("operand2") as! Expression
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(operand1!,forKey:"operand1")
		coder.encodeObject(operand2!,forKey:"operand2")
		}
	}
	
class ValueExpression:Expression
	{
	var value:Value?
	
	init(_ value:Value)
		{
		self.value = value
		super.init()
		}
		
	override init(coder:NSCoder)
		{
		value = coder.decodeObjectForKey("value") as! Value
		super.init(coder: coder)
		}
		
	override func encodeWithCoder(coder:NSCoder)
		{
		super.encodeWithCoder(coder)
		coder.encodeObject(value!,forKey:"value")
		}
	}