//
//  WorkingMemoryBrowserController.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

class WorkingMemoryBrowserController:NSViewController,NSTableViewDataSource,NSTableViewDelegate,Dependent,NSKeyedArchiverDelegate,NSBrowserDelegate
	{
	required init?(coder: NSCoder) 
		{
		system = ProductionSystem()
		elementModel = AspectAdaptor(aspect: Atom("workingElements"),onModel:system!.memory)
		super.init(coder:coder)
		elementModel!.addDependent(self)
		ruleTableHandler = RuleTableHandler()
		ruleTableHandler!.ruleModel = AspectAdaptor(aspect:Atom("rules"),onModel:system!)
		}
		
	@IBOutlet weak var theToolbar:NSToolbar?
	@IBOutlet weak var theContentView:NSView?
	@IBOutlet weak var theBrowser:NSBrowser?
	@IBOutlet weak var transcriptWindow:NSWindow?
	
	var system:ProductionSystem?
	var selectedElement:MemoryElement?
	var selectedRow:Int?
	var selectedView:NSView?
	var elementModel:AspectAdaptor?
	var ruleTableHandler:RuleTableHandler?

	
	override var hashValue:Int
		{
		return(self.hash)
		}
		
	func update(aspect:Atom,withObject:AnyObject,from:AnyObject)
		{
		}
		
	@IBAction func onNewRule(sender:AnyObject)
		{
		println("onNewRule(sender)")
		}
		
	override func awakeFromNib()
		{
		self.view.needsLayout = true
		theBrowser!.backgroundColor = NSColor(red:230,green:230,blue:240)
		theBrowser!.delegate = self
		theBrowser!.loadColumnZero()
		theBrowser!.setCellClass(BrowserCell.self)
		}
		
	func resizeBrowserCellHeight(column:Int)
		{
		var matrix:NSMatrix
		var size:NSSize
		var index:Int
		
		for index = 0; index <= column; index++
			{
			matrix = theBrowser!.matrixInColumn(index)!
			size = matrix.cellSize
			size.height = 24
			matrix.cellSize = size
			matrix.sizeToCells()
			}
		}
		
	func browser(browser:NSBrowser,didChangeLastColumn old:Int,toColumn newCol:Int)
		{
		resizeBrowserCellHeight(newCol)
		}
		
	func browser(browser: NSBrowser!,heightOfRow row: Int,inColumn columnIndex: Int) -> CGFloat
		{
		return(20)
		}
		
	@IBAction func onSolve(sender:AnyObject)
		{
		var transcript:TranscriptView?
		
		transcript = TranscriptView.transcript()
		if transcript != nil
			{
			transcript!.backgroundColor = StylePalette.transcriptBackgroundColor()
			transcript!.textColor = StylePalette.transcriptTextColor()
			transcript!.font = StylePalette.transcriptFont()
			self.system!.produce()
			theBrowser!.loadColumnZero()
			}
		}
		
	@IBAction func onNewCondition(sender:AnyObject)
		{
		}
		
	@IBAction func onNewAction(sender:AnyObject)
		{
		}	
		
	@IBAction func onOpen(sender:AnyObject)
		{
		var panel:NSOpenPanel
		
		panel = NSOpenPanel()
		panel.allowedFileTypes = ["xml"]
		panel.beginSheetModalForWindow(self.view.window!,completionHandler:
			{
			(returnCode:Int) -> Void in
				if returnCode == NSFileHandlingPanelOKButton
					{
					var parser:SystemFileParser
					
					parser = SystemFileParser(filename: panel.URL!.path!)
					parser.parse()
					}
			})
		}
		
	@IBAction func onSave(sender:AnyObject)
		{
		var savePanel:NSSavePanel
		var window:NSWindow
		
		savePanel = NSSavePanel()
		window = self.view.window!
		savePanel.beginSheetModalForWindow(window,completionHandler: 
			{
			(returnCode:Int) -> Void in 
				if (returnCode == NSFileHandlingPanelOKButton)
					{
					var file:TextFileStream
					var filename:String

					filename = savePanel.URL!.path!
					file = TextFileStream(name: filename)
					self.system!.writeOnTextStream(file)
					file.close()
					}
			})
		}
		
	func archiver(archiver:NSKeyedArchiver,didEncodeObject:AnyObject?)
		{
		println("Encoded object \(didEncodeObject)")
		}
		
	@IBAction func onNewValuePair(sender:AnyObject)
		{
		}
		
	func frameOfCurrentlySelectedCell() -> NSRect
		{
		var column:Int
		var row:Int
		
		column = theBrowser!.selectedColumn
		row = theBrowser!.selectedRowInColumn(column)
		return(theBrowser!.frameOfRow(row,inColumn:column))
		}
		
	func browser(_ sender: NSBrowser!,willDisplayCell cell: AnyObject!,atRow row: Int,column column: Int)
		{
		var object:Navigable
		var browserCell:NSBrowserCell
		var previousColumn:Int
		var previousCell:NSBrowserCell
		var parent:Navigable
		var child:Navigable
		
		browserCell = cell as! NSBrowserCell
		browserCell.font = StylePalette.browserCellFont()
		if column == 0
			{
			if (row == 0)
				{
				browserCell.stringValue = "Memory"
				browserCell.leaf = false
				browserCell.loaded = true
				browserCell.representedObject = system!.memory
				}
			else if row == 1
				{
				browserCell.stringValue = "Rules"
				browserCell.leaf = false
				browserCell.loaded = true
				browserCell.representedObject = system!.rulesItem()
				}
			return
			}
		previousColumn = column - 1
		previousCell = theBrowser!.selectedCellInColumn(previousColumn) as! NSBrowserCell
		parent = previousCell.representedObject as! Navigable
		child = parent.childAtIndex(row)!
		browserCell.stringValue = child.name
		browserCell.leaf = child.isLeaf
		browserCell.loaded = true
		browserCell.representedObject = child
		}
		
	func browser(_ sender: NSBrowser!,numberOfRowsInColumn column: Int) -> Int
		{
		var previousColumn:Int
		var cell:NSBrowserCell
		var parent:Navigable
		
		if (column == 0)
			{
			return(2)
			}
		previousColumn = column - 1
		cell = theBrowser!.selectedCellInColumn(previousColumn) as! NSBrowserCell
		parent = cell.representedObject as! Navigable
		return(parent.childCount)
		}
		
	func tableViewSelectionDidChange(notification:NSNotification)
		{
//		selectedRow = theMemoryTable!.selectedRow
//		selectedElement = elementModel!.value[selectedRow!] as MemoryElement
//		selectedView = theMemoryTable!.rowViewAtRow(selectedRow!,makeIfNecessary:false) as NSView
		}
		
	func numberOfRowsInTableView(aTableView: NSTableView!) -> Int
		{
		return(elementModel!.value.count)
		}
		
	func tableView(aTableView: NSTableView!,objectValueForTableColumn aTableColumn: NSTableColumn!,row rowIndex: Int) -> AnyObject!
		{
		var anElement:MemoryElement
		
		anElement = elementModel!.value[rowIndex] as! MemoryElement
		return(anElement.elementType.stringValue)
		}
		
	func tableView(tableView: NSTableView!,rowViewForRow row: Int) -> NSTableRowView!
		{
		var view:MemoryElementView
		var rect:NSRect
		var anElement:MemoryElement
		
		rect = tableView.bounds
		anElement = elementModel!.value[row] as! MemoryElement
		view = MemoryElementView(frame:NSRect(x:0,y:0,width: rect.size.width,height: MemoryElementView.calculateRowHeightForElement(anElement)))
		view.setMemoryElement(anElement)
		view.layoutSubviews()
		return(view)
		}
		
	func tableView(tableView: NSTableView!,heightOfRow row: Int) -> CGFloat
		{
		return(MemoryElementView.calculateRowHeightForElement(elementModel!.value[row] as! MemoryElement))
		}
	}