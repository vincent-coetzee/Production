//
//  NSTextField-ValueModels.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

class TextDelegateProxy:NSObject,NSTextDelegate,NSTextFieldDelegate
	{
	var textField:NSValueModelTextField
	
	func textDidChange(notification:NSNotification)
		{
		textField.updateTextValue()
		}
		
	init(field:NSValueModelTextField)
		{
		textField = field
		super.init()
		textField.delegate = self
		}
	}
	
class NSValueModelTextField:NSTextField
	{
	override init(frame:NSRect)
		{
		super.init(frame:frame)
		proxy = TextDelegateProxy(field: self)
		}

	required init?(coder: NSCoder) 
		{
	    fatalError("init(coder:) has not been implemented")
		}
		
//	required init?(coder: NSCoder)
//		{
//		super.init(coder:coder)
//		proxy = TextDelegateProxy(field: self)
//		}
		
	private var valueModel:ValueModel?
	private var proxy:TextDelegateProxy?
	
	var model:ValueModel
		{
		get
			{
			return(valueModel!)
			}
		set
			{
			valueModel = newValue
			valueModel!.addDependent(self)
			self.stringValue = valueModel!.value as! String
			}
		}
		
	func updateTextValue()
		{
		valueModel!.removeDependent(self)
		valueModel!.value = stringValue
		valueModel!.addDependent(self)
		}
		
	func update(aspect:Atom,withObject:AnyObject,from:AnyObject)
		{
		stringValue = valueModel!.value as! String
		}
		
	
	}