//
//  AspectAdaptor.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class AspectAdaptor:AbstractModel,Dependent,ValueModel
	{
	private var aspect:Atom
	private var model:KeyValueModel
	private var cachedValue:Any
	override var value:Any
		{
		get
			{
			return(cachedValue)
			}
		set
			{
			cachedValue = newValue
			model.removeDependent(self)
			model.setValue(newValue,forKeyPath:aspect.stringValue)
			model.addDependent(self)
			}
		}
		
	func update(anAspect:Atom,withObject:AnyObject,from:AnyObject)
		{
		if (anAspect == aspect)
			{
			cachedValue = model.valueForKeyPath(aspect.stringValue)
			changed(Atom("value"),withObject:withObject,from:from)
			}
		}
		
	init(aspect:Atom,onModel:KeyValueModel)
		{
		self.aspect = aspect
		self.model = onModel
		cachedValue = model.valueForKeyPath(aspect.stringValue)
		super.init()
		model.addDependent(self as NSObject)
		}
		
	deinit
		{
		model.removeDependent(self)
		}
	}