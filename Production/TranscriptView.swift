//
//  TranscriptView.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/24.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation
import AppKit

var TheTranscript:TranscriptView? = nil

class Transcript
	{
	class func nextPutAll(someText:String)
		{
		TranscriptView.nextPutAll(someText)
		}
	}
	
class TranscriptView:NSTextField
	{
	internal var text:String
	
	class func nextPutAll(moreText:String)
		{
		if self.transcript() != nil
			{
			self.transcript()!.nextPutAll(moreText)
			}
		}
		
	class func transcript() -> TranscriptView?
		{
		return(TheTranscript)
		}

	override init(frame:NSRect)
		{
		text = ""
		super.init(frame: frame)
		TheTranscript = self
		}
		
	required init?(coder: NSCoder!) 
		{
		text = ""
		super.init(coder:coder)
		}
		
	func nextPutAll(moreString:String)
		{
		text += moreString + "\n"
		self.stringValue = text
		}
		
	}