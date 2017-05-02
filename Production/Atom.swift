//
//  Atom.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

var AtomTable:Dictionary<String,Int> = Dictionary<String,Int>()
var AtomList:[String] = [String]()
var NilAtom:Atom = Atom("nil")
var AllAtoms:Dictionary<String,Atom> = Dictionary<String,Atom>()

func ==(lhs:Atom,rhs:Atom) -> Bool
	{
	return(lhs.atomIndex == rhs.atomIndex)
	}
	
class Atom:NSObject,Printable,Hashable,Equatable,DebugPrintable
	{
	typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
	
	internal var atomIndex:Int
	
	class func convertFromExtendedGraphemeClusterLiteral(value: ExtendedGraphemeClusterLiteralType) -> Self 
		{
        return self(value)
		}

    class func convertFromStringLiteral(value: StringLiteralType) -> Self 
		{
        return self(value)
		}
		
	class func atom(string:String)
		{
		}
		
	internal required init(coder:NSCoder)
		{
		var stringValue:String
		
		stringValue = coder.decodeObjectForKey("stringValue") as! String
		if let index = AtomTable[stringValue]
			{
			atomIndex = index
			}
		else
			{
			atomIndex = AtomList.count
			AtomTable[stringValue] = atomIndex
			AtomList.append(stringValue)
			}
		}
		
	func encodeWithCoder(encoder:NSCoder!)
		{
		encoder.encodeObject(self.stringValue,forKey:"stringValue")
		}
	
	class func allStrings() -> [String]
		{
		return(AtomList)
		}
		
	override var description:String
		{
		return("#\(AtomList[atomIndex])")
		}
		
	override var debugDescription:String
		{
		return("ATOM(\(atomIndex),\(self.stringValue))")
		}
		
	var stringValue:String
		{
		return(AtomList[atomIndex])
		}
		
	override var hashValue:Int
		{
		return(atomIndex)
		}
		
	class func nilAtom() -> Atom
		{
		return(NilAtom)
		}
		
	required init(_ stringValue:String)
		{
		atomIndex = 0
		if let index = AtomTable[stringValue]
			{
			atomIndex = index
			}
		else
			{
			atomIndex = AtomList.count
			AtomTable[stringValue] = atomIndex
			AtomList.append(stringValue)
			}
		}
	}
	
extension String
	{
	func asAtom() -> Atom
		{
		return(Atom(self))
		}
	}