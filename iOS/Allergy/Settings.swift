//
//  Settings.swift
//  Allergy
//
//  Created by Robby on 4/6/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class Settings: UITableViewController{
	var data:[String]?{
		didSet{
			self.tableView.reloadData()
		}
	}
	override func viewDidLoad() {
		Fire.shared.getData("types") { (data) in
			if let types = data as? [String:Any]{
				var nameArray:[String] = [];
				let keys = Array(types.keys)
				for key in keys{
					if let thisType = types[key] as? [String:Any]{
						if let thisName = thisType["name"] as? String{
							nameArray.append(thisName)
						}
					}
				}
				self.data = nameArray
			}
		}
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let d = data { return d.count }
		
		return 0
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		if let d = self.data{
			if d.count > indexPath.row{
				cell.textLabel?.text = d[indexPath.row]
			}
		}
		return cell
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}
