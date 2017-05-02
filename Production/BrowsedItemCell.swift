//
//  BrowsedItemCell.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

class BrowsedItemCell:NSTextFieldCell
	{
	override init()
		{
		super.init()
		}
//		
//	init(textCell string:String)
//		{
//		super.init(textCell:string)
//		self.stringValue = string
//		}

	required init(coder aDecoder: NSCoder) 
		{
	    fatalError("init(coder:) has not been implemented")
		}

	override func titleRectForBounds(bounds:NSRect) -> NSRect
		{
		var rect:NSRect
		
		rect = bounds
		rect.origin.x += 2
		rect.size.width -= 4
		return(super.titleRectForBounds(bounds))
		}
	
	override func cellSizeForBounds(bounds:NSRect) -> NSSize
		{
		var size:NSSize
		
		size = super.cellSizeForBounds(bounds)
		size.width += 4
		size.height = 24
		return(size)
		}

	override func drawInteriorWithFrame(frame:NSRect,inView view:NSView)
		{
		var newRect:NSRect
		
		backgroundColor!.set()
		NSRectFillUsingOperation(frame,NSCompositingOperation.CompositeSourceOver)
		newRect = frame
		newRect.origin.x += 2
		newRect.size.width -= 4
		super.drawInteriorWithFrame(newRect,inView:view)
		}
		
	override func drawWithExpansionFrame(cellFrame:NSRect,inView view:NSView)
		{
		super.drawInteriorWithFrame(cellFrame,inView:view)
		}
	}