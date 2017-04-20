//
//  DailyTableViewController.swift
//  Allergy
//
//  Created by Robby on 4/12/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
	
	var data:Sample?{
		didSet{
			self.tableView.reloadData()
			if let d = data{
				self.report = d.report()
			}
		}
	}
	
	var report:[(String, Int, Int, Rating)]? // name, value, maxValue
	
	let gridLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "TODAY"
		let newBackButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
		self.navigationItem.rightBarButtonItem = newBackButton
		self.tableView.separatorStyle = .none

		
		self.view.layer.insertSublayer(gridLayer, at: 0)
		let lineFrame:CGFloat = self.view.frame.size.width * 0.5
		let strokeWeight:CGFloat = 38
		let pad:CGFloat = 10
		gridLayer.sublayers = []
		for i in 0..<3{
			let shape = CAShapeLayer()
			let bz = UIBezierPath()
			bz.move(to: CGPoint.init(x: 1+strokeWeight+pad + lineFrame/4.0*CGFloat(i), y: 0.0))
			bz.addLine(to: CGPoint.init(x: 1+strokeWeight+pad + lineFrame/4.0*CGFloat(i), y: self.view.frame.size.height))
			shape.lineWidth = 4
			let lineDashPatterns: [NSNumber]  = [0, 8]
			shape.lineDashPattern = lineDashPatterns
			shape.lineCap = kCALineCapRound
			shape.strokeColor = Style.shared.whiteSmoke.cgColor
			shape.path = bz.cgPath
			gridLayer.addSublayer(shape)
		}
		
		// Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	
	func doneButtonPressed(){
		self.dismiss(animated: true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if(IS_IPAD){
			return 68
		}
		return 44
	}

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
		if self.report != nil{
			return 1
		}
		return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		if let r = self.report{
			return r.count
		}
		return 0
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		let cell = LineTableViewCell.init(style: .default, reuseIdentifier: "BarTableViewCell")
		cell.selectionStyle = .none
		if let r = report{
			if r.count > indexPath.row{
				let (name, value, max, rating) = r[indexPath.row]
				cell.textLabel?.text = name
				cell.data = (value, max)
				cell.rating = rating
			}
		}
		
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
