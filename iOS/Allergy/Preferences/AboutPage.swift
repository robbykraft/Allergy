//
//  Settings.swift
//  Allergy
//
//  Created by Robby on 4/6/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class AboutPage: UITableViewController{
	
	let PHONE_NUMBER:String = "512.349.0777"
	let PHONE_NUMBER_CODE:String = "5123490777"
	
	let WEBSITE:String = "allergyfreeaustin.com"
	
	override func viewDidLoad() {
		self.title = "ABOUT"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if(indexPath.section == 0){
			if(IS_IPAD){
				return 460
			}
			// screen resolutions
			// 5:  320.0
			// 6+: 414.0
			return 340 - (self.view.frame.size.width - 320)*0.7
		}
		if(IS_IPAD){
			return 60
		}
		return 44
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Allergy and Asthma Associates P.L.L.C."
		case 1:
			return "Contact Us"
		case 2:
			return "Visit Us"
		default:
		return nil
		}
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section{
		case 0: return 1
		case 1: return 2
		case 2: return 2
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
			cell.textLabel?.text = "Dr. Douglas Barstow, Jr. and Dr. Thomas Leath have the specialized training to treat children and adults for allergy and asthma problems. Our Austin allergists are board-certified by the American Board of Allergy and Immunology, and they are members of the American College of Allergy, Asthma and Immunology, as well as the American Academy of Allergy, Asthma and Immunology."
			cell.textLabel?.numberOfLines = 0
		case 1:
			switch indexPath.row {
			case 0:
				cell.textLabel?.text = "Phone"
				cell.detailTextLabel?.textColor = UIColor.black
				cell.detailTextLabel?.text = PHONE_NUMBER
			case 1:
				cell.textLabel?.text = WEBSITE
			default:
				cell.textLabel?.text = ""
			}
		case 2:
			switch indexPath.row {
			case 0:
				cell.textLabel?.text = "3410 Far West Boulevard, Austin TX"
			case 1:
				cell.textLabel?.text = "Drop In"
				cell.detailTextLabel?.textColor = UIColor.black
				cell.detailTextLabel?.text = "Saturdays 9-11:30 AM"
			default:
				cell.textLabel?.text = ""
			}
			
		default:
			cell.detailTextLabel?.textColor = UIColor.black
		}

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0{
			
		} else if indexPath.section == 1{
			if(indexPath.row == 0){
				UIApplication.shared.openURL(URL(string: "tel://" + PHONE_NUMBER_CODE)!)
			} else if indexPath.row == 1{
				UIApplication.shared.openURL(URL(string: "http://" + WEBSITE)!)
			}
		} else{
			
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
