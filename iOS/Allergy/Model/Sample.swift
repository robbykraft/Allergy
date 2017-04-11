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
						v = -1
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
	
	func log(){
		if(date != nil) { print(date!) }
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
