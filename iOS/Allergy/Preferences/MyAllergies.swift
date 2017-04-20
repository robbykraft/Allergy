//
//  Settings.swift
//  Allergy
//
//  Created by Robby on 4/6/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class MyAllergies: UITableViewController{
	
	var sections:[[String]] = []  // array of arrays. 1:number of sections, 2:array of keys in each section
	
//	var data:[(String, String, Bool)]?{  // key, displayname, value
//		didSet{
//			self.tableView.reloadData()
//		}
//	}
	var data:[String:Bool]?{
		didSet{
			self.tableView.reloadData()
		}
	}// key, displayname, value

	override func viewDidLoad() {
		self.title = "MY ALLERGIES"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

		// by seasons
		self.sections = [ [], [], [], [] ]
		
		let myAllergies = Pollen.shared.myAllergies
		let keys = Array(myAllergies.keys)
//		var dataArray:[(String,String,Bool)] = []
		var dataKeys:[String:Bool] = [:]
		for key in keys{
			var name:String = ""
			var season:Int = 0
			if let t = Pollen.shared.types[key] as? [String:Any]{
				if let tname = t["name"] as? String{
					name = tname
				}
				if let tSeason = t["season"] as? Int{
					season = tSeason
				}
			}
			let value = myAllergies[key]!
//			dataArray.append((key, name, value))
			dataKeys[key] = value
			self.sections[season].append(key)
		}
//		self.data = dataArray
		self.data = dataKeys
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if(IS_IPAD){
			return 60
		}
		return 44
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section{
		case 0: return "Spring"
		case 1: return "Summer"
		case 2: return "Autumn"
		case 3: return "Winter"
		default: return ""
		}
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		if let d = data { return d.count }
		if sections.count > section {
			return sections[section].count
		}
		
		return 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "MyAllergiesCell")
		cell.textLabel?.font = UIFont(name: SYSTEM_FONT, size: Style.shared.P18)
		cell.detailTextLabel?.font = UIFont(name: SYSTEM_FONT_B, size: Style.shared.P18)

		let selectionView = UIView()
		selectionView.backgroundColor = Style.shared.athensGray
		cell.selectedBackgroundView = selectionView

		
		if let d = self.data{
			if self.sections.count > indexPath.section{
				if self.sections[indexPath.section].count > indexPath.row{
					let key = self.sections[indexPath.section][indexPath.row]
					let value = d[key]
					cell.textLabel?.text = Pollen.shared.nameFor(key: key)
					if(value == true){
						cell.textLabel?.textColor = UIColor.black
						cell.detailTextLabel?.text = "Include"
						cell.detailTextLabel?.textColor = Style.shared.blue
					}else{
						cell.textLabel?.textColor = UIColor.gray
						cell.detailTextLabel?.text = "Ignore"
						cell.detailTextLabel?.textColor = UIColor.lightGray
					}
					
				}
			}
		}

//		if let d = self.data{
//			if d.count > indexPath.row{
//				let (_, name, value) =  d[indexPath.row]
//				cell.textLabel?.text = name
//				if(value == true){
//					cell.textLabel?.textColor = UIColor.black
//					cell.detailTextLabel?.text = "Include"
//					cell.detailTextLabel?.textColor = Style.shared.blue
//				}else{
//					cell.textLabel?.textColor = UIColor.gray
//					cell.detailTextLabel?.text = "Ignore"
//					cell.detailTextLabel?.textColor = UIColor.lightGray
//				}
//			}
//		}
		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if var d = self.data{
			if self.sections.count > indexPath.section{
				if self.sections[indexPath.section].count > indexPath.row{
					let key = self.sections[indexPath.section][indexPath.row]
					var value = d[key]!
					value = !value
					Pollen.shared.myAllergies[key] = value
					self.data![key] = value
//					self.tableView.reloadData()
					self.tableView.reloadRows(at: [indexPath], with: .none)
					self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
					self.tableView.deselectRow(at: indexPath, animated: true)
				}
			}
		}
	}
}
