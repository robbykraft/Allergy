//
//  Preferences.swift
//  Allergy
//
//  Created by Robby on 4/11/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class Preferences: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "Preferences"
		
		let newBackButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(backButtonPressed))
		self.navigationItem.rightBarButtonItem = newBackButton

        // Do any additional setup after loading the view.
    }
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section{
		case 0: return nil
		case 1: return "Push Notifications"
		default: return nil
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 1
		case 1:
			return 2
		default:
			return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .default, reuseIdentifier: "PreferencesCell")
		switch indexPath.section {
		case 0:
			cell.textLabel?.text = "Allergy Types"
		case 1:
			switch indexPath.row {
			case 0:
				cell.textLabel?.text = "Enable Notifications"
			case 1:
				cell.textLabel?.text = "Send push for MEDIUM or above"
			default: break
			}
		default: break
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 0:
			switch indexPath.row {
			case 0:
				self.navigationController?.pushViewController(Settings(), animated: true)
			default:
				break
			}
		case 1:
			switch indexPath.row {
			case 0:
				break
			default:
				break
			}
		default:
			break
		}
	}
	func backButtonPressed(){
		self.dismiss(animated: true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
