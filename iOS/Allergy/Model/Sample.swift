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
		if let unixTime = data["date"] as? Double{
			self.date = Date.init(timeIntervalSince1970: unixTime)
		}
	}
	
	func generateSummary() -> Rating{
		var ratings:[Rating] = []
		if (ash != nil && Pollen.shared.myAllergies["ash"] == true){ ratings.append(Pollen.shared.ratingFor(key:"ash", value: ash! )) }
		if (birch != nil && Pollen.shared.myAllergies["bir"] == true){ ratings.append(Pollen.shared.ratingFor(key:"bir", value: birch! )) }
		if (cedar != nil && Pollen.shared.myAllergies["cdr"] == true){ ratings.append(Pollen.shared.ratingFor(key:"cdr", value: cedar! )) }
		if (cottonWood != nil && Pollen.shared.myAllergies["cot"] == true){ ratings.append(Pollen.shared.ratingFor(key:"cot", value: cottonWood! )) }
		if (elm != nil && Pollen.shared.myAllergies["elm"] == true){ ratings.append(Pollen.shared.ratingFor(key:"elm", value: elm! )) }
		if (grass != nil && Pollen.shared.myAllergies["grs"] == true){ ratings.append(Pollen.shared.ratingFor(key:"grs", value: grass! )) }
		if (hackberry != nil && Pollen.shared.myAllergies["hck"] == true){ ratings.append(Pollen.shared.ratingFor(key:"hck", value: hackberry! )) }
		if (molds != nil && Pollen.shared.myAllergies["mld"] == true){ ratings.append(Pollen.shared.ratingFor(key:"mld", value: molds! )) }
		if (mullberry != nil && Pollen.shared.myAllergies["mul"] == true){ ratings.append(Pollen.shared.ratingFor(key:"mul", value: mullberry! )) }
		if (oak != nil && Pollen.shared.myAllergies["oak"] == true){ ratings.append(Pollen.shared.ratingFor(key:"oak", value: oak! )) }
		if (poplar != nil && Pollen.shared.myAllergies["pop"] == true){ ratings.append(Pollen.shared.ratingFor(key:"pop", value: poplar! )) }
		if (privet != nil && Pollen.shared.myAllergies["prv"] == true){ ratings.append(Pollen.shared.ratingFor(key:"prv", value: privet! )) }
		if (sycamore != nil && Pollen.shared.myAllergies["syc"] == true){ ratings.append(Pollen.shared.ratingFor(key:"syc", value: sycamore! )) }
		if (walnut != nil && Pollen.shared.myAllergies["wal"] == true){ ratings.append(Pollen.shared.ratingFor(key:"wal", value: walnut! )) }
		if (willow != nil && Pollen.shared.myAllergies["wil"] == true){ ratings.append(Pollen.shared.ratingFor(key:"wil", value: willow! )) }
		
		if(ratings.contains(.veryHeavy)){ return .veryHeavy }
		if(ratings.contains(.heavy)){ return .heavy }
		if(ratings.contains(.medium)){ return .medium }
		if(ratings.contains(.low)){ return .low }
		return .none
	}
	
	func count() -> Int{
		var count = 0
		if (ash != nil && Pollen.shared.myAllergies["ash"] == true){ count += 1 }
		if (birch != nil && Pollen.shared.myAllergies["bir"] == true){ count += 1 }
		if (cedar != nil && Pollen.shared.myAllergies["cdr"] == true){ count += 1 }
		if (cottonWood != nil && Pollen.shared.myAllergies["cot"] == true){ count += 1 }
		if (elm != nil && Pollen.shared.myAllergies["elm"] == true){ count += 1 }
		if (grass != nil && Pollen.shared.myAllergies["grs"] == true){ count += 1 }
		if (hackberry != nil && Pollen.shared.myAllergies["hck"] == true){ count += 1 }
		if (molds != nil && Pollen.shared.myAllergies["mld"] == true){ count += 1 }
		if (mullberry != nil && Pollen.shared.myAllergies["mul"] == true){ count += 1 }
		if (oak != nil && Pollen.shared.myAllergies["oak"] == true){ count += 1 }
		if (poplar != nil && Pollen.shared.myAllergies["pop"] == true){ count += 1 }
		if (privet != nil && Pollen.shared.myAllergies["prv"] == true){ count += 1 }
		if (sycamore != nil && Pollen.shared.myAllergies["syc"] == true){ count += 1 }
		if (walnut != nil && Pollen.shared.myAllergies["wal"] == true){ count += 1 }
		if (willow != nil && Pollen.shared.myAllergies["wil"] == true){ count += 1 }
		return count
	}
	
	// my report gives back the sample, filtered through your curated list of allergy types
	//
	func report() -> [(String, Int, Int, Rating)]{
		var report:[(String, Int, Int, Rating)] = []
		if (ash != nil && Pollen.shared.myAllergies["ash"] == true){ report.append( ("ash", ash!, Pollen.shared.veryHeavyFor(key: "ash"), Pollen.shared.ratingFor(key: "ash", value: ash! ) ) ) }
		if (birch != nil && Pollen.shared.myAllergies["bir"] == true){ report.append( ("birch", birch!, Pollen.shared.veryHeavyFor(key: "bir"), Pollen.shared.ratingFor(key: "bir", value: birch! ) ) ) }
		if (cedar != nil && Pollen.shared.myAllergies["cdr"] == true){ report.append( ("cedar", cedar!, Pollen.shared.veryHeavyFor(key: "cdr"), Pollen.shared.ratingFor(key: "cdr", value: cedar! ) ) ) }
		if (cottonWood != nil && Pollen.shared.myAllergies["cot"] == true){ report.append( ("cotton wood", cottonWood!, Pollen.shared.veryHeavyFor(key: "cot"), Pollen.shared.ratingFor(key: "cot", value: cottonWood! ) ) ) }
		if (elm != nil && Pollen.shared.myAllergies["elm"] == true){ report.append( ("elm", elm!, Pollen.shared.veryHeavyFor(key: "elm"), Pollen.shared.ratingFor(key: "elm", value: elm! ) ) ) }
		if (grass != nil && Pollen.shared.myAllergies["grs"] == true){ report.append( ("grass", grass!, Pollen.shared.veryHeavyFor(key: "grs"), Pollen.shared.ratingFor(key: "grs", value: grass! ) ) ) }
		if (hackberry != nil && Pollen.shared.myAllergies["hck"] == true){ report.append( ("hackberry", hackberry!, Pollen.shared.veryHeavyFor(key: "hck"), Pollen.shared.ratingFor(key: "hck", value: hackberry! ) ) ) }
		if (molds != nil && Pollen.shared.myAllergies["mld"] == true){ report.append( ("molds", molds!, Pollen.shared.veryHeavyFor(key: "mld"), Pollen.shared.ratingFor(key: "mld", value: molds! ) ) ) }
		if (mullberry != nil && Pollen.shared.myAllergies["mul"] == true){ report.append( ("mullberry", mullberry!, Pollen.shared.veryHeavyFor(key: "mul"), Pollen.shared.ratingFor(key: "mul", value: mullberry! ) ) ) }
		if (oak != nil && Pollen.shared.myAllergies["oak"] == true){ report.append( ("oak", oak!, Pollen.shared.veryHeavyFor(key: "oak"), Pollen.shared.ratingFor(key: "oak", value: oak! ) ) ) }
		if (poplar != nil && Pollen.shared.myAllergies["pop"] == true){ report.append( ("poplar", poplar!, Pollen.shared.veryHeavyFor(key: "pop"), Pollen.shared.ratingFor(key: "pop", value: poplar! ) ) ) }
		if (privet != nil && Pollen.shared.myAllergies["prv"] == true){ report.append( ("privet", privet!, Pollen.shared.veryHeavyFor(key: "prv"), Pollen.shared.ratingFor(key: "prv", value: privet! ) ) ) }
		if (sycamore != nil && Pollen.shared.myAllergies["syc"] == true){ report.append( ("sycamore", sycamore!, Pollen.shared.veryHeavyFor(key: "syc"), Pollen.shared.ratingFor(key: "syc", value: sycamore! ) ) ) }
		if (walnut != nil && Pollen.shared.myAllergies["wal"] == true){ report.append( ("walnut", walnut!, Pollen.shared.veryHeavyFor(key: "wal"), Pollen.shared.ratingFor(key: "wal", value: walnut! ) ) ) }
		if (willow != nil && Pollen.shared.myAllergies["wil"] == true){ report.append( ("willow", willow!, Pollen.shared.veryHeavyFor(key: "wil"), Pollen.shared.ratingFor(key: "wil", value: willow! ) ) ) }
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
