//
//  Settings.swift
//  Allergy
//
//  Created by Robby on 4/6/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class MyAllergies: UITableViewController{
	var data:[(String, String, Bool)]?{  // key, displayname, value
		didSet{
			self.tableView.reloadData()
		}
	}
	override func viewDidLoad() {
		self.title = "MY ALLERGIES"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

		let myAllergies = Pollen.shared.myAllergies
		let keys = Array(myAllergies.keys)
		var dataArray:[(String,String,Bool)] = []
		for key in keys{
			var name:String = ""
			if let t = Pollen.shared.types[key] as? [String:Any]{
				if let tname = t["name"] as? String{
					name = tname
				}
			}
			let value = myAllergies[key]!
			dataArray.append((key, name, value))
		}
		self.data = dataArray
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let d = data { return d.count }
		
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
			if d.count > indexPath.row{
				let (_, name, value) =  d[indexPath.row]
				cell.textLabel?.text = name
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
		return cell
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if var d = self.data{
			var (key, name, value) = d[indexPath.row]
			value = !value
			Pollen.shared.myAllergies[key] = value
			self.data![indexPath.row] = (key, name, value)
//			self.tableView.reloadData()
			self.tableView.reloadRows(at: [indexPath], with: .none)
			self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
			self.tableView.deselectRow(at: indexPath, animated: true)
		}
	}
}
