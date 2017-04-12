//
//  Sample.swift
//  Allergy
//
//  Created by Robby on 4/10/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class Sample: NSObject {
	
	var summary:String?
	
	var date:Date?
	
	var ash:Int?
	var birch:Int?
	var cedar:Int?
	var cottonWood:Int?
	var elm:Int?
	var grass:Int?
	var hackberry:Int?
	var molds:Int?
	var mullberry:Int?
	var oak:Int?
	var poplar:Int?
	var privet:Int?
	var sycamore:Int?
	var walnut:Int?
	var willow:Int?
	
	func setFromDatabase(_ data:[String:Any]){
		if let counts = data["counts"] as? [String:Any]{
			for item in Array(counts.keys) {
				if let itemValue = counts[item]{
					var v:Int?
					if let valueInt = itemValue as? Int{
						v = valueInt
//					} else if let valueString = itemValue as? String{
					} else if itemValue is String{
//						v = -1
						// big question here, should we report trace amounts, or
						// count them the same as an unread sample.
						// remember this is just for the public
					}
					if let value = v{
						switch item {
						case "ash" : self.ash = value
						case "bir" : self.birch = value
						case "cdr" : self.cedar = value
						case "cot" : self.cottonWood = value
						case "elm" : self.elm = value
						case "grs" : self.grass = value
						case "hck" : self.hackberry = value
						case "mld" : self.molds = value
						case "mul" : self.mullberry = value
						case "oak" : self.oak = value
						case "pop" : self.poplar = value
						case "prv" : self.privet = value
						case "syc" : self.sycamore = value
						case "wal" : self.walnut = value
						case "wil" : self.willow = value
						default: print("DATABASE PROBLEM: no entry for: " + item)
						}
					}
				}
			}
		}
		if let allergy = data["allergy"] as? [String:Any]{
			self.summary = allergy["summary"] as? String
		}
		if let unixTime = data["date"] as? Double{
			self.date = Date.init(timeIntervalSince1970: unixTime)
		}
	}
	
	func count() -> Int{
		var count = 0
		if (ash != nil){ count += 1 }
		if (birch != nil){ count += 1 }
		if (cedar != nil){ count += 1 }
		if (cottonWood != nil){ count += 1 }
		if (elm != nil){ count += 1 }
		if (grass != nil){ count += 1 }
		if (hackberry != nil){ count += 1 }
		if (molds != nil){ count += 1 }
		if (mullberry != nil){ count += 1 }
		if (oak != nil){ count += 1 }
		if (poplar != nil){ count += 1 }
		if (privet != nil){ count += 1 }
		if (sycamore != nil){ count += 1 }
		if (walnut != nil){ count += 1 }
		if (willow != nil){ count += 1 }
		return count
	}
	func report() -> [(String, Int, Int)]{
		var report:[(String, Int, Int)] = []
		if (ash != nil){ report.append( ("ash", ash!, 1200) ) }
		if (birch != nil){ report.append( ("birch", birch!, 1200) ) }
		if (cedar != nil){ report.append( ("cedar", cedar!, 1200) ) }
		if (cottonWood != nil){ report.append( ("cotton wood", cottonWood!, 1200) ) }
		if (elm != nil){ report.append( ("elm", elm!, 1200) ) }
		if (grass != nil){ report.append( ("grass", grass!, 1200) ) }
		if (hackberry != nil){ report.append( ("hackberry", hackberry!, 1200) ) }
		if (molds != nil){ report.append( ("molds", molds!, 1200) ) }
		if (mullberry != nil){ report.append( ("mullberry", mullberry!, 1200) ) }
		if (oak != nil){ report.append( ("oak", oak!, 1200) ) }
		if (poplar != nil){ report.append( ("poplar", poplar!, 1200) ) }
		if (privet != nil){ report.append( ("privet", privet!, 1200) ) }
		if (sycamore != nil){ report.append( ("sycamore", sycamore!, 1200) ) }
		if (walnut != nil){ report.append( ("walnut", walnut!, 1200) ) }
		if (willow != nil){ report.append( ("willow", willow!, 1200) ) }
		return report
	}
	
	func log(){
		if(date != nil) { print(date!) }
		if(ash != nil) { print(ash!) }
		if(birch != nil) { print(birch!) }
		if(cedar != nil) { print(cedar!) }
		if(cottonWood != nil) { print(cottonWood!) }
		if(elm != nil) { print(elm!) }
		if(grass != nil) { print(grass!) }
		if(hackberry != nil) { print(hackberry!) }
		if(molds != nil) { print(molds!) }
		if(mullberry != nil) { print(mullberry!) }
		if(oak != nil) { print(oak!) }
		if(poplar != nil) { print(poplar!) }
		if(privet != nil) { print(privet!) }
		if(sycamore != nil) { print(sycamore!) }
		if(walnut != nil) { print(walnut!) }
		if(willow != nil) { print(willow!) }
	}

	
}
