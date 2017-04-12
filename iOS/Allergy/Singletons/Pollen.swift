//
//  Allergy.swift
//  Allergy
//
//  Created by Robby on 4/10/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import Foundation

class Pollen {
	static let shared = Pollen()
	
	// fill on boot
	var types:[String:Any] = [:]
	// this is a mirror of the "types" entry in the database
	// keys are abbreviation of pollen names, values are dictionaries
	
	var notifications:[String:Any] = [:]{
		// "enabled": BOOL
		// "level: 0,1,2,3 (none, low, med, heavy, very heavy)
		didSet{
			let defaults = UserDefaults.standard
			defaults.setValue(self.notifications, forKey: "notifications")
		}
	}
	
	var myAllergies:[String:Bool] = [:]{
		// pollen-key, T/F
		didSet{
			let defaults = UserDefaults.standard
			defaults.setValue(self.myAllergies, forKey: "allergies")
		}
	}
	
	func boot(completionHandler: ((_ success:Bool) -> ())? ){
		self.getPollenTypes { (success) in
			if(success){
				self.refreshUserDefaults()
				if(completionHandler != nil){
					completionHandler!(true)
				}
			} else{
				// throw an error
			}
		}
	}
	
	func refreshUserDefaults(){
		let defaults = UserDefaults.standard
		// allergies
		if var allergies = defaults.object(forKey:"allergies") as? [String:Bool] {
			let keys:[String] = Array(self.types.keys)
			for key in keys{
				if(allergies[key] == nil){
					allergies[key] = true
				}
			}
			self.myAllergies = allergies
		} else{
			let keys:[String] = Array(self.types.keys)
			var emptyAllergies:[String:Bool] = [:]
			for key in keys{
				emptyAllergies[key] = true
			}
			self.myAllergies = emptyAllergies
		}
		// push notification preferences
		if var pnPrefs = defaults.object(forKey:"notifications") as? [String:Any] {
			if (pnPrefs["enabled"] == nil){
				pnPrefs["enabled"] = true
			}
			if (pnPrefs["level"] == nil){
				pnPrefs["level"] = 2
			}
			self.notifications = pnPrefs
		} else{
			let pnPrefs:[String:Any] = [
				"enabled" : true,
				"level" : 2
				]
			self.notifications = pnPrefs
		}
		
	}
	
	
	func getPollenTypes(completionHandler: ((_ success:Bool) -> ())? ){
		Fire.shared.getData("types") { (data) in
			if let types = data as? [String:Any]{
				self.types = types
				if(completionHandler != nil){
					completionHandler!(true)
				}
			}
		}
	}
	
	func getAllPollenNames() -> [String]{
		var nameArray:[String] = [];
		let keys = Array(self.types.keys)
		for key in keys{
			if let thisType = self.types[key] as? [String:Any]{
				if let thisName = thisType["name"] as? String{
					nameArray.append(thisName)
				}
			}
		}
		return nameArray
	}
	
	// daysPast is expecting a positive number. ("5" means 5 days ago)
	func makeDateCode(daysPast:Int) -> String{
//		var GMTCalendar = Calendar.current
//		GMTCalendar.timeZone = TimeZone.init(secondsFromGMT: 0)!
		var deltaDate = DateComponents()
		deltaDate.day = -daysPast
		let dateIterate:Date = (Calendar.current as NSCalendar).date(byAdding: deltaDate, to: Date(), options: NSCalendar.Options.matchFirst)!
		
		let yearNumber:Int = Calendar.current.component(.year, from: dateIterate)
		let monthNumber:Int = Calendar.current.component(.month, from: dateIterate)
		let dayNumber:Int = Calendar.current.component(.day, from: dateIterate)
		return "\(yearNumber)" + String(format: "%02d", monthNumber) + String(format: "%02d", dayNumber)
	}
	
	func loadRecentData(numberOfDays:Int, completionHandler: ((_ entry:Sample) -> ())? ){
		
		var tries = 0
		var successes = 0
		func queryDatabase(){
			let dateString = makeDateCode(daysPast: tries)
			tries += 1
			Fire.shared.getData("collections/" + dateString) { (data) in
				if(data == nil && tries < 30){
					print("no entry for " + dateString + ". trying again")
					queryDatabase()
				} else if let d = data as? [String:Any]{
					let sample = Sample()
					sample.setFromDatabase(d)
					if(completionHandler != nil){
						completionHandler!(sample)
					}
					successes += 1
					if successes < numberOfDays{
						queryDatabase()
					}
				}
			}
		}
		
		// run the function
		queryDatabase()
	}

}
