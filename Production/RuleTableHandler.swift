//
//  RuleTableHandler.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

class RuleTableHandler:NSObject,NSTableViewDataSource,NSTableViewDelegate
	{
	var ruleModel:AspectAdaptor?
		
	func numberOfRowsInTableView(aTableView: NSTableView!) -> Int
		{
		var rules:[Rule]
		
		rules = ruleModel!.value as! [Rule]
		println("\(rules.count) rows in table")
		return(rules.count)
		}
		
	func tableView(aTableView: NSTableView!,objectValueForTableColumn aTableColumn: NSTableColumn!,row rowIndex: Int) -> AnyObject!
		{
		var rule:Rule
		var rules:[Rule]
		
		rules = ruleModel!.value as! [Rule]
		println("lookup value for row \(rowIndex)")
		rule = rules[rowIndex] as Rule
		println("\(rule.ruleType.stringValue)")
		return(rule.ruleType.stringValue)
		}
		
	func tableView(tableView: NSTableView!,rowViewForRow row: Int) -> NSTableRowView!
		{
		var view:RuleTableRowView
		var rect:NSRect
		var rule:Rule
		
		rect = tableView.bounds
		rule = ruleModel!.value[row] as! Rule
		view = RuleTableRowView(frame:NSRect(x:0,y:0,width: rect.size.width,height: RuleTableRowView.calculateRowHeightForRule(rule)))
		view.setRuleModel(rule)
		view.layoutSubviews()
		println("Table row view for row \(row) is \(view)")
		return(view)
		}
		
	func tableView(tableView: NSTableView!,heightOfRow row: Int) -> CGFloat
		{
		var height:CGFloat
		
		height = RuleTableRowView.calculateRowHeightForRule(ruleModel!.value[row] as! Rule)
		println("height of row \(row) is \(height)")
		return(height)
		}
	}