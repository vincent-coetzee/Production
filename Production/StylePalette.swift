//
//  StylePalette.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/18.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

extension NSColor
	{
	convenience init(red:Int,green:Int,blue:Int)
		{
		let max:CGFloat = 255
		var newRed:CGFloat = CGFloat(red)/max
		var newGreen:CGFloat = CGFloat(green)/max
		var newBlue:CGFloat = CGFloat(blue)/max
		self.init(red:newRed,green:newGreen,blue:newBlue,alpha:CGFloat(1))
		}
	}
	
var RegularFontName = "SunSansSemiBold"
var BoldFontName = "SunSansHeavy"
var TranscriptFontName = "SunSansSemiBold"

class StylePalette:NSObject
	{	
	class func dumpAllFontNames()
		{
		var allNames:[String] = [String]()

		for familyName in NSFontManager.sharedFontManager().availableFonts
			{
			allNames.append(familyName as! String)
			}
		allNames.sort(){$0 < $1}
		for name in allNames
			{
			println(name)
			}
		}
		
	class func transcriptBackgroundColor() -> NSColor
		{
		return(NSColor(red:240,green:240,blue:250))
		}
		
	class func headingFont() -> NSFont
		{
		return(self.boldFontOfSize(15.0))
		}
		
	class func regularFont() -> NSFont
		{
		return(self.regularFontOfSize(14.0))
		}
		
	class func browserCellFont() -> NSFont
		{
		return(self.regularFontOfSize(16.0))
		}
		
	class func transcriptTextColor() -> NSColor
		{
		return(NSColor(red:80,green:80,blue:80))
		}
		
	class func transcriptPointSize() -> CGFloat
		{
		return(10.0)
		}
		
	class func transcriptFont() -> NSFont
		{
		var font:NSFont
		
		font = NSFont(name:TranscriptFontName,size:CGFloat(12.0))!
		println(font)
		return(font)
		}
	
	class func headingColor() -> NSColor
		{
		return(NSColor(red:80,green:80,blue:80))
		}
		
	class func regularColor() -> NSColor
		{
		return(NSColor(red:110,green:110,blue:110))
		}
		
	class func defaultBackgroundColor() -> NSColor
		{
		return(NSColor(red:243,green:236,blue:226))
		}
		
	class func highlightColor() -> NSColor
		{
		return(NSColor(red:243,green:120,blue:75))
		}
		
	class func headingPointSize() -> CGFloat
		{
		return(15.0)
		}
		
	class func regularPointSize() -> CGFloat
		{
		return(11.0)
		}
		
	class func sizeStringInBoldFontOfSize(string:String,size:CGFloat) -> CGSize
		{
		var attrString:NSAttributedString
		var attributes:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>()
		
		attributes[NSFontAttributeName] = self.boldFontOfSize(size)
		attrString = NSAttributedString(string:string,attributes:attributes)
		return(attrString.size)
		}
		
	class func boldFontOfSize(size:CGFloat) -> NSFont
		{
		return(NSFont(name:BoldFontName,size:size))!
		}
		
	class func sizeStringInRegularFontOfSize(string:String,size:CGFloat) -> CGSize
		{
		var attrString:NSAttributedString
		var attributes:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>()
		
		attributes[NSFontAttributeName] = self.regularFontOfSize(size)
		attrString = NSAttributedString(string:string,attributes:attributes)
		return(attrString.size)
		}
		
	class func regularFontOfSize(size:CGFloat) -> NSFont
		{
		return(NSFont(name:RegularFontName,size:size))!
		}
	}