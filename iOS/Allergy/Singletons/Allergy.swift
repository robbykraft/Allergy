//
//  Allergy.swift
//  Allergy
//
//  Created by Robby on 4/10/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import Foundation

class Allergy {
	static let shared = Allergy()
	
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
