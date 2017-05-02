//
//  RuleTableRowView.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

class RuleTableRowView:NSTableRowView
	{
	var rule:Rule?
	var heading:NSValueModelTextField
	var fields:[NSValueModelTextField] = [NSValueModelTextField]()
	var headingHeight:CGFloat = 0
	var regularHeight:CGFloat = 0
	
	override init(frame:NSRect)
		{
		heading = NSValueModelTextField(frame:NSRect(x: 4,y: 4,width: frame.size.width,height: frame.size.height))
		heading.wantsLayer = true
		heading.layer!.shadowOpacity = 0.5
		heading.layer!.shadowOffset = CGSize(width: -1,height: -1)
		heading.layer!.shadowColor = NSColor.whiteColor().CGColor
		heading.layer!.shadowRadius = 0.5
		super.init(frame:frame)
		addSubview(heading)
		wantsLayer = true
		layer!.borderWidth = CGFloat(1.0)
		layer!.cornerRadius = CGFloat(1.5)
		layer!.borderColor = NSColor.darkGrayColor().CGColor
		}

	required init?(coder: NSCoder) 
		{
		heading = NSValueModelTextField(frame:NSRect(x: 4,y: 4,width: 10,height: 10))
		super.init(coder:coder)
		wantsLayer = true
		heading.frame = NSRect(x: 4,y: 4,width: frame.size.width,height: frame.size.height)
		addSubview(heading)
		}
		
	func layoutSubviews()
		{
		var headingSize:CGSize
		var regularSize:CGSize
		var rect:NSRect
		var outerBounds:NSRect
		
		outerBounds = bounds
		headingSize = StylePalette.sizeStringInBoldFontOfSize("pJ",size:StylePalette.headingPointSize())
		regularSize = StylePalette.sizeStringInRegularFontOfSize("pJ",size:StylePalette.regularPointSize())
		rect = NSRect(x: 2,y:0,width: outerBounds.size.width,height: headingSize.height)
		heading.frame = rect
		rect.size.height = regularSize.height + 4
		rect.origin.y += headingSize.height - 4
		rect.origin.x += 20
		for textField in fields
			{
			textField.frame = rect
			textField.bordered = false
			textField.bezeled = false
			rect.origin.y += regularSize.height;
			}
		}
		
	func setRuleModel(rule:Rule)
		{
		self.rule = rule
//		heading.model = AspectAdaptor(aspect:"ruleTypeString",onModel:rule)
		heading.font = StylePalette.boldFontOfSize(StylePalette.headingPointSize())
		heading.textColor = StylePalette.headingColor()
		heading.bordered = false
		heading.bezeled = false
		heading.stringValue = rule.ruleType.stringValue
		heading.drawsBackground = false
		initRuleFields()
		}
	
	func initRuleFields()
		{
//		var field:NSValueModelTextField
//		
//		for pair in element!.pairs
//			{
//			field = NSValueModelTextField(frame:NSRect(x:0,y: 0,width: 10,height: 10))
//			field.model = AspectAdaptor(aspect:"attributeValueDescription",onModel:pair)
//			field.font = StylePalette.regularFontOfSize(StylePalette.regularPointSize())
//			field.textColor = StylePalette.regularColor()
//			addSubview(field)
//			fields.append(field)
//			field.drawsBackground = false
//			}
		}
		
	class func calculateRowHeightForRule(rule:Rule) -> CGFloat
		{
		var count:Int
		var headingSize:CGSize
		var regularSize:CGSize
		var paddingHeight:CGFloat = 0
		var totalHeight:CGFloat
		
		count = rule.conditions.count + 1 + rule.actions.count
		headingSize = StylePalette.sizeStringInBoldFontOfSize("pJ",size:StylePalette.headingPointSize())
		regularSize = StylePalette.sizeStringInRegularFontOfSize("pJ",size:StylePalette.regularPointSize())
		totalHeight = CGFloat(count)*paddingHeight + headingSize.height + CGFloat(count-1)*CGFloat(regularSize.height)
		return(totalHeight)
		}
	}