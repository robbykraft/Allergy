//
//  ViewController.swift
//  Allergy
//
//  Created by Robby on 4/3/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
	
	let weekdayStrings = ["S", "M", "T", "W", "T", "F", "S"]
	
	var radialChart = UIRadialChart()
	var barChart = UIBarChartView()
	
	let preferencesButton = UIButton()
	
	var data:[Int] = []{
		didSet{
//			self.graph.reloadGraph()
		}
	}
	var samples:[Sample] = []{
		didSet{
			for s in samples {
				s.log()
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.statusBarStyle = .lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = Style.shared.whiteSmoke
		
		let barChartTop:CGFloat = self.view.frame.size.height - 200
		let radius:CGFloat = self.view.frame.size.height * 1.25
		
		let layer = CAShapeLayer()
		let circle = UIBezierPath.init(arcCenter: CGPoint.init(x: self.view.center.x, y: barChartTop - radius), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
		layer.path = circle.cgPath
		layer.fillColor = Style.shared.blue.cgColor
		self.view.layer.addSublayer(layer)
		
		radialChart = UIRadialChart.init(frame: CGRect.init(x: 0, y: 10, width: self.view.frame.size.width, height: self.view.frame.size.width))
		self.view.addSubview(radialChart)
		
		barChart = UIBarChartView.init(frame: CGRect.init(x: 0, y: barChartTop, width: self.view.frame.size.width, height: 200))
		self.view.addSubview(barChart)
		
		preferencesButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
		preferencesButton.setImage(UIImage.init(named: "cogs")?.imageWithTint(UIColor.white), for: .normal)
		preferencesButton.center = CGPoint.init(x: self.view.frame.size.width - 22-5, y: 22+22+5)
		preferencesButton.addTarget(self, action: #selector(preferencesButtonPressed), for: .touchUpInside)
		self.view.addSubview(preferencesButton)
		
		Allergy.shared.loadRecentData(numberOfDays: 1) { (sample) in
			self.radialChart.data = sample
		}
		
		Allergy.shared.loadRecentData(numberOfDays: 5) { (sample) in
			self.samples.append(sample)
			// build bar chart again
			var barValues:[Float] = []
			for sample in self.samples{
				if let mold = sample.molds{
					barValues.append( Float(mold) / 3000.0 )
				}
			}
			self.barChart.values = barValues
			// set bar labels
			var dateStrings:[String] = []
			for sample in self.samples{
				if let date = sample.date{
					let weekday = NSCalendar.current.component(.weekday, from: date)
					dateStrings.append(self.weekdayStrings[weekday])
				}
			}
			self.barChart.labels = dateStrings
		}
		
	}
	
	func preferencesButtonPressed(){
		let nav = UINavigationController()
		nav.viewControllers = [Preferences.init(style: .grouped)]
		self.present(nav, animated: true, completion: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

