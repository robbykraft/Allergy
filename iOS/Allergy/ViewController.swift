//
//  ViewController.swift
//  Allergy
//
//  Created by Robby on 4/3/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate {
	
	var data:[Int] = []{
		didSet{
			self.graph.reloadGraph()
		}
	}
	var samples:[Sample] = []{
		didSet{
			for s in samples {
				s.log()
			}
		}
	}

	func numberOfPoints(inLineGraph graph: BEMSimpleLineGraphView) -> Int {
		return data.count
	}
	
	func lineGraph(_ graph: BEMSimpleLineGraphView, valueForPointAt index: Int) -> CGFloat {
		if(data.count > index) {
			return CGFloat(data[index])
		}
		return CGFloat(index)
	}
	
	
	let bigLabel = UILabel()
	let graph = BEMSimpleLineGraphView()

	override func viewDidLoad() {
		super.viewDidLoad()
//		self.view.backgroundColor = UIColor.init(white: 1.0, alpha: 1.0)
		self.view.backgroundColor = UIColor.appleBlue()
		bigLabel.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width*0.33)
		bigLabel.font = UIFont.systemFont(ofSize: 40)
		bigLabel.textColor = UIColor.black
		bigLabel.textAlignment = .center
		self.view.addSubview(bigLabel)
		
		graph.dataSource = self;
		graph.delegate = self;
		graph.enableBezierCurve = true
		graph.frame = CGRect.init(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.height - 400)
		self.view.addSubview(graph)
		
//		Allergy.shared.loadRecentData(numberOfDays: 5) { (sample) in
//			self.samples.append(sample)
//		}
		
		let chart = UIChartView.init(frame: CGRect.init(x: 0, y: self.view.frame.size.height - 200, width: self.view.frame.size.width, height: 200))
		self.view.addSubview(chart)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

