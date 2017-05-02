//
//  ProductionSystem.swift
//  Production
//
//  Created by Vincent Coetzee on 2014/09/17.
//  Copyright (c) 2014 MacSemantics. All rights reserved.
//

import Foundation

class ProductionSystem:AbstractModel,KeyValueModel
	{
	var	memory:Memory
	var rules:[Rule]
	var firstRule:Rule?
	var name:Atom
	
	override init()
		{
		name = Atom("System")
		memory = Memory()
		rules = [Rule]()
		super.init()
		populateDatabase()
		testAssertRule()
		}
		
	override func valueForKeyPath(key:String) -> AnyObject
		{
		return(super.valueForKeyPath(key))!
		}
		
	override func setValue(value:AnyObject?,forKeyPath:String)
		{
		super.setValue(value,forKeyPath:forKeyPath)
		}
		
	func testAssertRule()
		{
		assertRule(firstRule!)
		}
		
	func rulesItem() -> RulesItem
		{
		var set:RulesItem
		
		set = RulesItem()
		set.rules = rules
		return(set)
		}
		
	func encodeWithCoder(encoder:NSCoder!)
		{
		encoder!.encodeObject(memory,forKey:"memory")
		encoder!.encodeObject(rules,forKey:"rules")
		}
		
	init(coder:NSCoder)
		{
		name = Atom("System")
		memory = coder.decodeObjectForKey("memory") as! Memory
		rules = coder.decodeObjectForKey("rules") as! [Rule]
		}
		
	func dumpDatabase()
		{
		memory.dumpDatabase()
		for rule in rules
			{
			rule.dump()
			}
		}
		
	func addRule(aRule:Rule)
		{
		rules.append(aRule)
		}
		
	func addMemoryElement(anElement:MemoryElement)
		{
		memory.addElement(anElement)
		}
		
	func populateDatabase()
		{
		populateMemory()
		populateRules()
		}
	
	func populateMemory()
		{
		populatePeople()
		initClientFacts()
		initClientContactDetails()
		initWineOntology()
		initSentences();
		}
		
	func initSentences()
		{
		var element:MemoryElement
		var sentenceAtom:Atom = Atom("sentence")
		var nounsAtom:Atom = Atom("nouns")
		var pronounsAtom:Atom = Atom("pronouns")
		
		element = MemoryElement(sentenceAtom)
		element.addPair(AttributeValuePair(Atom("noun"),value:AtomValue("account")))
		element.addPair(AttributeValuePair(Atom("noun"),value:AtomValue("loan")))
		element.addPair(AttributeValuePair(Atom("noun"),value:AtomValue("credit card")))
		element.addPair(AttributeValuePair(Atom("noun"),value:AtomValue("debt")))
		element.addPair(AttributeValuePair(Atom("verb"),value:AtomValue("pay")))
		element.addPair(AttributeValuePair(Atom("adverb"),value:AtomValue("can't")))
		element.addPair(AttributeValuePair(Atom("verb"),value:AtomValue("repay")))
		element.addPair(AttributeValuePair(Atom("verb"),value:AtomValue("settle")))
		element.addPair(AttributeValuePair(Atom("verb"),value:AtomValue("sort out")))
		element.addPair(AttributeValuePair(Atom("verb"),value:AtomValue("finalise")))
		element.addPair(AttributeValuePair(Atom("verb"),value:AtomValue("clear")))
		element.addPair(AttributeValuePair(Atom("response"),value:AtomValue("are you having trouble paying your account this month")))
		addMemoryElement(element)
		}
		
	func populatePeople()
		{
		var element:MemoryElement
		var personAtom:Atom = Atom("person")
		var townAtom:Atom = Atom("town")
		var businessAtom:Atom = Atom("business")
		
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("scientist")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("james")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("red")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(28)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("lawyer")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("penny")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("red")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(28)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("female")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("musician")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("peter")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("blonde")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(50)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("programmer")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("martin")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("brown")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(49)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("architect")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("vincent")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(49)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("computer-scientist")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("anton")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("gray")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(42)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("artist")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("harem")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("blonde")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(35)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("designer")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("christo")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("blonde")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(40)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("male")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("business-person")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("jen")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(40)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("female")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("brunette")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("shop-owner")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("angie")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("blonde")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(42)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(false)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("female")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("artist")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("greta")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("blonde")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(40)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("female")))
		addMemoryElement(element)
		element = MemoryElement(personAtom)
		element.addPair(AttributeValuePair(Atom("profession"),value:AtomValue("business-person")))
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("vanessa")))
		element.addPair(AttributeValuePair(Atom("hair-color"),value:AtomValue("blonde")))
		element.addPair(AttributeValuePair(Atom("age"),value:IntValue(49)))
		element.addPair(AttributeValuePair(Atom("has-dog"),value:BooleanValue(false)))
		element.addPair(AttributeValuePair(Atom("gender"),value:AtomValue("female")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("cape town")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("western cape")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("johannesburg")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("gauteng")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("durban")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("natal")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("bloemfontein")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("free state")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("riebeeck")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("western cape")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("stellenbosch")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("western cape")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		addMemoryElement(element)
		element = MemoryElement(businessAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("fireworkx")))
		element.addPair(AttributeValuePair(Atom("staff-count"),value:IntValue(17)))
		element.addPair(AttributeValuePair(Atom("industry"),value:AtomValue("design")))
		element.addPair(AttributeValuePair(Atom("town"),value:AtomValue("cape town")))
		addMemoryElement(element)
		element = MemoryElement(businessAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("olamide")))
		element.addPair(AttributeValuePair(Atom("staff-count"),value:IntValue(50)))
		element.addPair(AttributeValuePair(Atom("industry"),value:AtomValue("software")))
		element.addPair(AttributeValuePair(Atom("town"),value:AtomValue("port louis")))
		addMemoryElement(element)
		element = MemoryElement(businessAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("discovery")))
		element.addPair(AttributeValuePair(Atom("staff-count"),value:IntValue(10000)))
		element.addPair(AttributeValuePair(Atom("industry"),value:AtomValue("financial-services")))
		element.addPair(AttributeValuePair(Atom("town"),value:AtomValue("sandton")))
		addMemoryElement(element)
		element = MemoryElement(businessAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("rmb")))
		element.addPair(AttributeValuePair(Atom("staff-count"),value:IntValue(1200)))
		element.addPair(AttributeValuePair(Atom("industry"),value:AtomValue("financial-services")))
		element.addPair(AttributeValuePair(Atom("town"),value:AtomValue("sandton")))
		addMemoryElement(element)
		element = MemoryElement(businessAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("mxit")))
		element.addPair(AttributeValuePair(Atom("staff-count"),value:IntValue(200)))
		element.addPair(AttributeValuePair(Atom("industry"),value:AtomValue("social-media")))
		element.addPair(AttributeValuePair(Atom("town"),value:AtomValue("stellenbosch")))
		addMemoryElement(element)
		element = MemoryElement(businessAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("global dynamix")))
		element.addPair(AttributeValuePair(Atom("staff-count"),value:IntValue(150)))
		element.addPair(AttributeValuePair(Atom("industry"),value:AtomValue("software")))
		element.addPair(AttributeValuePair(Atom("town"),value:AtomValue("cape town")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("new york")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("new york state")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("usa")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("san francisco")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("california")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("usa")))
		element.addPair(AttributeValuePair(Atom("risk"),value:AtomValue("earthquake")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("london")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("wessex")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("uk")))
		element.addPair(AttributeValuePair(Atom("risk"),value:AtomValue("weather")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("paris")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("longines")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("france")))
		element.addPair(AttributeValuePair(Atom("risk"),value:AtomValue("french people")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("rome")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("laccitone")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("italy")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("venice")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("dunnowa")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("italy")))
		element.addPair(AttributeValuePair(Atom("risk"),value:AtomValue("flooding")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("austin")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("texas")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(false)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("usa")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("miami")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("florida")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("usa")))
		element.addPair(AttributeValuePair(Atom("risk"),value:AtomValue("sunburn")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("dublin")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("cork")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("ireland")))
		addMemoryElement(element)
		element = MemoryElement(townAtom)
		element.addPair(AttributeValuePair(Atom("name"),value:AtomValue("sydney")))
		element.addPair(AttributeValuePair(Atom("province"),value:AtomValue("new south wales")))
		element.addPair(AttributeValuePair(Atom("ocean"),value:BooleanValue(true)))
		element.addPair(AttributeValuePair(Atom("country"),value:AtomValue("australia")))
		addMemoryElement(element)
		}
		
	func initWineOntology()
		{
		var element:MemoryElement
		
		element = MemoryElement(Atom("wine"))
		element.addPair(AttributeValuePair(string: "maker-kind",value:AtomValue("string")))
		element.addPair(AttributeValuePair(string: "grapes-kind",value:AtomValue("red").OR(AtomValue("white"))))
		element.addPair(AttributeValuePair(string: "suger-content-kind",value:AtomValue("integer")))
		element.addPair(AttributeValuePair(string: "body-kind",value:AtomValue("integer")))
		element.addPair(AttributeValuePair(string: "flavor-kind",value:AtomValue("integer")))
		element.addPair(AttributeValuePair(string: "color-kind",value:AtomValue("atom")))
		element.addPair(AttributeValuePair(string: "location-kind",value:AtomValue("region")))
		element.addPair(AttributeValuePair(string: "vintage-year-kind",value:AtomValue("integer")))
		addMemoryElement(element)
		element = MemoryElement(Atom("vintage-year"))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2000)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2001)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2002)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2003)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2004)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2005)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2006)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2007)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2008)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2009)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2010)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2011)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2012)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2013)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2014)))
		element.addPair(AttributeValuePair(string: "year",value:IntValue(2015)))
		addMemoryElement(element)
		}
		
	func initClientFacts()
		{
		var element:MemoryElement
		
		element = MemoryElement(Atom("client-category"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("excellent")))
		element.addPair(AttributeValuePair(string: "percentage-paid",value:IntValue(90)))
		element.addPair(AttributeValuePair(string: "reward-band",value:AtomValue("4")))
		element.addPair(AttributeValuePair(string: "contact",value:BooleanValue(false)))
		element.addPair(AttributeValuePair(string: "contact-frequency",value:AtomValue("monthly")))
		addMemoryElement(element)
		element = MemoryElement(Atom("client-category"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("good")))
		element.addPair(AttributeValuePair(string: "percentage-paid",value:IntValue(80)))
		element.addPair(AttributeValuePair(string: "reward-band",value:AtomValue("3")))
		element.addPair(AttributeValuePair(string: "contact",value:BooleanValue(false)))
		element.addPair(AttributeValuePair(string: "contact-frequency",value:AtomValue("monthly")))
		addMemoryElement(element)
		element = MemoryElement(Atom("client-category"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("average")))
		element.addPair(AttributeValuePair(string: "percentage-paid",value:IntValue(50)))
		element.addPair(AttributeValuePair(string: "reward-band",value:AtomValue("2")))
		element.addPair(AttributeValuePair(string: "contact",value:BooleanValue(true)))
		element.addPair(AttributeValuePair(string: "contact-frequency",value:AtomValue("weekly")))
		addMemoryElement(element)
		element = MemoryElement(Atom("client-category"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("poor")))
		element.addPair(AttributeValuePair(string: "percentage-paid",value:IntValue(25)))
		element.addPair(AttributeValuePair(string: "reward-band",value:AtomValue("1")))
		element.addPair(AttributeValuePair(string: "contact",value:BooleanValue(true)))
		element.addPair(AttributeValuePair(string: "contact-frequency",value:AtomValue("weekly")))
		addMemoryElement(element)
		element = MemoryElement(Atom("client-category"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("delinquent")))
		element.addPair(AttributeValuePair(string: "percentage-paid",value:IntValue(0)))
		element.addPair(AttributeValuePair(string: "reward-band",value:AtomValue("0")))
		element.addPair(AttributeValuePair(string: "contact",value:BooleanValue(true)))
		element.addPair(AttributeValuePair(string: "contact-frequency",value:AtomValue("daily")))
		addMemoryElement(element)
		}
		
	func initClientContactDetails()
		{
		var element:MemoryElement
		
		element = MemoryElement(Atom("client-response-rating"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("most-valued")))
		element.addPair(AttributeValuePair(string: "status",value:AtomValue("excellent").OR(AtomValue("good"))))
		element.addPair(AttributeValuePair(string: "phone-in-frequency",value:RangeValue(IntValue(1),upper: IntValue(5))))
		element.addPair(AttributeValuePair(string: "delay-call",value:BooleanValue(true)))
		element.addPair(AttributeValuePair(string: "call-agent-class",value:AtomValue("supervisor")))
		addMemoryElement(element)
		element = MemoryElement(Atom("client-response-rating"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("average")))
		element.addPair(AttributeValuePair(string: "status",value:AtomValue("average")))
		element.addPair(AttributeValuePair(string: "phone-in-frequency",value:RangeValue(IntValue(0),upper: IntValue(1))))
		element.addPair(AttributeValuePair(string: "delay-call",value:BooleanValue(false)))
		element.addPair(AttributeValuePair(string: "call-agent-class",value:AtomValue("agent")))
		addMemoryElement(element)
		element = MemoryElement(Atom("client-response-rating"))
		element.addPair(AttributeValuePair(string: "name",value:AtomValue("bad")))
		element.addPair(AttributeValuePair(string: "status",value:AtomValue("poor").OR(AtomValue("delinquent"))))
		element.addPair(AttributeValuePair(string: "phone-in-frequency",value:RangeValue(IntValue(0),upper: IntValue(0))))
		element.addPair(AttributeValuePair(string: "delay-call",value:BooleanValue(false)))
		element.addPair(AttributeValuePair(string: "call-agent-class",value:AtomValue("available")))
		addMemoryElement(element)
		}
		
	func populateRules()
		{
		var rule:Rule
		var rule2:Rule
		var element:MemoryElement
		var pair:AttributeValuePair
		
		rule = Rule(Atom("person"))
		rule.addConditionString("profession",value: AtomValue("business-person"))
		rule.addConditionString("gender",value: AtomValue("female"))
		addRule(rule)
		rule = Rule(Atom("sentence"))
		rule.addConditionString("verb",value: AtomValue("pay"))
		rule.addConditionString("noun",value: AtomValue("loan").OR(AtomValue("account")))
		rule.addConditionString("response",value: VariableValue(Atom("AppropriateResponse")))
		rule.addConditionString("adverb",value: AtomValue("can't").OR(AtomValue("unable")).OR(AtomValue("won't")).OR(AtomValue("struggle")).OR(AtomValue("battle")))
		addRule(rule)
		rule2 = Rule(Atom("person"))
		rule2.addConditionString("gender",value: AtomValue("female"))
		rule2.addConditionString("hair-color",value: AtomValue("blonde").OR(AtomValue("red")))
		rule2.addConditionString("name",value: VariableValue(Atom("RedHeadedFemaleName")))
		rule2.addConditionString("age",value: VariableValue(Atom("RedHeadedFemaleAge")))
		addRule(rule2)
		firstRule = rule2
		rule = Rule(Atom("business"))
		rule.addConditionString("town",value: AtomValue("cape town"))
		rule.addConditionString("industry",value: AtomValue("software"))
		element = MemoryElement(Atom("town-has-software-developers"))
		element.addPair(AttributeValuePair(Atom("town"),value:BooleanValue(true)))
		rule.addAction(RuleActionAdd(elem:element))
		addRule(rule)
		}
		
	func assertRule(rule:Rule) -> Bool
		{
		var list:MemoryElementList
		
		list = memory.elementsMatchingType(rule.ruleType)
		if list.isEmpty
			{
			return(false)
			}
		return(list.assertRule(rule,memory: memory))
		}
		
	func writeOnTextStream(file:TextStream)
		{
		file.nextPutString("system: \(name)")
		memory.writeOnTextStream(file)
		for rule in rules
			{
			rule.writeOnTextStream(file)
			}
		}
		
		
	func produce()
		{
		var satisfiedRules:[Rule]
		var remainingRules:[Rule]
		var iteration:Int = 0
		
		Transcript.nextPutAll("\nStaring Solve")
		remainingRules = rules
		Transcript.nextPutAll("\tFound \(remainingRules.count) potential rules to assert") 
		do
			{
			Transcript.nextPutAll("Iteration \(iteration)")
			iteration++
			satisfiedRules = [Rule]()
			for rule in remainingRules
				{
				Transcript.nextPutAll("\tAsserting rule \(rule)")
				if assertRule(rule)
					{
					satisfiedRules.append(rule)
					Transcript.nextPutAll("\tRule \(rule.ruleType) satisfied by element \(rule.satisfiedByMemoryElement)")
					let index:Int = find(remainingRules,rule)!
					remainingRules.removeAtIndex(index)
					}
				else
					{
					Transcript.nextPutAll("\tAssertion failed rule")
					}
				}
			Transcript.nextPutAll("\tFound \(remainingRules.count) potential rules for next iteration")
			}
		while (satisfiedRules.count > 0)
		Variable.dumpVariablesToTranscript()
		}
	}