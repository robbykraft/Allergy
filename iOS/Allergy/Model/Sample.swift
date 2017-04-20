//
//  Sample.swift
//  Allergy
//
//  Created by Robby on 4/10/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class Sample: NSObject {
	
	var date:Date?
	
	var values:[String:Int] = [:]
	
//	var ash:Int?
//	var birch:Int?
//	var cedar:Int?
//	var cottonWood:Int?
//	var elm:Int?
//	var grass:Int?
//	var hackberry:Int?
//	var molds:Int?
//	var mullberry:Int?
//	var oak:Int?
//	var poplar:Int?
//	var privet:Int?
//	var sycamore:Int?
//	var walnut:Int?
//	var willow:Int?
	
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
						self.values[item] = value
//						switch item {
//						case "ash" : self.ash = value
//						case "bir" : self.birch = value
//						case "cdr" : self.cedar = value
//						case "cot" : self.cottonWood = value
//						case "elm" : self.elm = value
//						case "grs" : self.grass = value
//						case "hck" : self.hackberry = value
//						case "md0" : self.molds = value
//						case "mul" : self.mullberry = value
//						case "oak" : self.oak = value
//						case "pop" : self.poplar = value
//						case "prv" : self.privet = value
//						case "syc" : self.sycamore = value
//						case "wal" : self.walnut = value
//						case "wil" : self.willow = value
//						default: print("DATABASE PROBLEM: no entry for: " + item)
//						}
					}
				}
			}
		}
		if let unixTime = data["date"] as? Double{
			self.date = Date.init(timeIntervalSince1970: unixTime)
		}
	}
	
	func generateSummary() -> Rating{
		var ratings:[Rating] = []
		for key in Array(self.values.keys) {
			if Pollen.shared.myAllergies[key]!{
				ratings.append(Pollen.shared.ratingFor(key: key, value: self.values[key]!))
			}
		}
		if(ratings.contains(.veryHeavy)){ return .veryHeavy }
		if(ratings.contains(.heavy)){ return .heavy }
		if(ratings.contains(.medium)){ return .medium }
		if(ratings.contains(.low)){ return .low }
		return .none
	}
	
//	func count() -> Int{
//		var count = 0
//		if (ash != nil && Pollen.shared.myAllergies["ash"] == true){ count += 1 }
//		if (birch != nil && Pollen.shared.myAllergies["bir"] == true){ count += 1 }
//		if (cedar != nil && Pollen.shared.myAllergies["cdr"] == true){ count += 1 }
//		if (cottonWood != nil && Pollen.shared.myAllergies["cot"] == true){ count += 1 }
//		if (elm != nil && Pollen.shared.myAllergies["elm"] == true){ count += 1 }
//		if (grass != nil && Pollen.shared.myAllergies["grs"] == true){ count += 1 }
//		if (hackberry != nil && Pollen.shared.myAllergies["hck"] == true){ count += 1 }
//		if (molds != nil && Pollen.shared.myAllergies["mld"] == true){ count += 1 }
//		if (mullberry != nil && Pollen.shared.myAllergies["mul"] == true){ count += 1 }
//		if (oak != nil && Pollen.shared.myAllergies["oak"] == true){ count += 1 }
//		if (poplar != nil && Pollen.shared.myAllergies["pop"] == true){ count += 1 }
//		if (privet != nil && Pollen.shared.myAllergies["prv"] == true){ count += 1 }
//		if (sycamore != nil && Pollen.shared.myAllergies["syc"] == true){ count += 1 }
//		if (walnut != nil && Pollen.shared.myAllergies["wal"] == true){ count += 1 }
//		if (willow != nil && Pollen.shared.myAllergies["wil"] == true){ count += 1 }
//		return count
//	}
	
	// my report gives back the sample, filtered through your curated list of allergy types
	//
	func report() -> [(String, Int, Int, Rating)]{
		var report:[(String, Int, Int, Rating)] = []
		for key in Array(self.values.keys) {
			if Pollen.shared.myAllergies[key]!{
				report.append( (Pollen.shared.nameFor(key: key), self.values[key]!, Pollen.shared.veryHeavyFor(key: key), Pollen.shared.ratingFor(key: key, value: self.values[key]! ) ) )
			}
		}
		return report
	}
	
	func log(){
		print(self.values)
//		if(date != nil) { print(date!) }
//		if(ash != nil) { print(ash!) }
//		if(birch != nil) { print(birch!) }
//		if(cedar != nil) { print(cedar!) }
//		if(cottonWood != nil) { print(cottonWood!) }
//		if(elm != nil) { print(elm!) }
//		if(grass != nil) { print(grass!) }
//		if(hackberry != nil) { print(hackberry!) }
//		if(molds != nil) { print(molds!) }
//		if(mullberry != nil) { print(mullberry!) }
//		if(oak != nil) { print(oak!) }
//		if(poplar != nil) { print(poplar!) }
//		if(privet != nil) { print(privet!) }
//		if(sycamore != nil) { print(sycamore!) }
//		if(walnut != nil) { print(walnut!) }
//		if(willow != nil) { print(willow!) }
	}

	
}
