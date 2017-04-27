//
//  Settings.swift
//  Allergy
//
//  Created by Robby on 4/6/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class AboutPage: UITableViewController{
	
	override func viewDidLoad() {
		self.title = "ABOUT"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if(indexPath.section == 0){
			if(IS_IPAD){
				return 300
			}
			return 200
		}
		if(IS_IPAD){
			return 60
		}
		return 44
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Allergy and Asthma Associates"
		case 1:
			return nil
		default:
		return nil
		}
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section{
		case 0: return 1
		case 1: return 1
		default: return 0
		}
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "AboutCell")
		cell.textLabel?.font = UIFont(name: SYSTEM_FONT, size: Style.shared.P18)
		cell.detailTextLabel?.font = UIFont(name: SYSTEM_FONT_B, size: Style.shared.P18)

		let selectionView = UIView()
		selectionView.backgroundColor = Style.shared.athensGray
		cell.selectedBackgroundView = selectionView

		switch indexPath.section{
		case 0:
			cell.selectionStyle = .none
			cell.textLabel?.text = "We are friendly group of people text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text"
			cell.textLabel?.numberOfLines = 0
		case 1:
			cell.textLabel?.text = "Contact us"
			cell.detailTextLabel?.textColor = UIColor.black
			cell.detailTextLabel?.text = "555.235.1232"
			
		default:
			cell.detailTextLabel?.textColor = UIColor.black
		}

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0{
			
		} else if indexPath.section == 1{
			// cal phone
		} else{
			
		}
	}
}
