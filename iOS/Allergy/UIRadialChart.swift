//
//  UIRadialChart.swift
//  Allergy
//
//  Created by Robby on 4/11/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class UIRadialChart: UIView {
	
	var data:Sample?{
		didSet{
			self.refreshViewData()
//			if data != nil{
//				circleLayer.isHidden = false
//			}
		}
	}
	
	// private
	let label = UILabel()
	let arcLayer = CALayer()
	let circleLayer = CALayer()
	
	var radialLabels:[UILabel] = []
	
	let dayLabel = UILabel()
	
	
	func refreshViewData() {
		if let d = data{
			let summary = d.generateSummary()
			switch summary {
			case .veryHeavy: label.text = "very heavy"
			case .heavy: label.text = "heavy"
			case .medium: label.text = "medium"
			case .low: label.text = "light"
			case .none: label.text = "no pollen"
			}
			if let date = d.date{
				dayLabel.text = Style.shared.dayStringForDate(date)
			}
		}
		for label in self.radialLabels{
			label.removeFromSuperview()
		}
		self.radialLabels = []
		self.layoutSubviews()
		redrawGraph()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initUI()
	}
	convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
	
	func initUI() {
		self.layer.addSublayer(arcLayer)
		self.layer.addSublayer(circleLayer)
		
		let radius:CGFloat = self.frame.width*0.33

		let layer = CAShapeLayer()
		let circle = UIBezierPath.init(arcCenter: CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
		layer.path = circle.cgPath
		layer.fillColor = Style.shared.whiteSmoke.cgColor
//		circleLayer.isHidden = true
		circleLayer.addSublayer(layer)
		
		label.font = UIFont.init(name: SYSTEM_FONT_B, size: Style.shared.P48)
		label.textColor = UIColor.black
		self.addSubview(label)
		
		dayLabel.font = UIFont.init(name: SYSTEM_FONT, size:Style.shared.P15)
		dayLabel.textColor = UIColor.gray
		self.addSubview(dayLabel)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		label.sizeToFit()
		label.center = CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
		
		dayLabel.sizeToFit()
		dayLabel.center = CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5 - self.frame.width*0.33 + 50)
	}
	
	func redrawGraph(){
		let radius:CGFloat = self.frame.width*0.33
		let center:CGPoint = CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
		arcLayer.sublayers = []
		var barHeight:CGFloat = 50.0
		if(IS_IPAD){
			barHeight = 150.0;
		}
		if let sample = data{
//			let count = sample.count()
//			for i in 0..<count{
			var report = sample.report().sorted(by: { (a1, a2) -> Bool in
				return ( Float(a1.1)/Float(a1.2) ) < ( Float(a2.1)/Float(a2.2) )
			})
			
			var i = 0
			while i < report.count {
				let removed = report.remove(at: i)
				report.insert(removed, at: 0)
				i += 2
			}
			
			let count = report.count
			for i in 0..<report.count {
				let (name, value, max, rating) = report[i]
				let thisRadius:CGFloat = CGFloat(value) / CGFloat(max) * barHeight
				let layer = CAShapeLayer()
				let angle = CGFloat(Double.pi * 2 / Double(count))
				let circle = UIBezierPath.init(arcCenter: center, radius: (radius+(barHeight*0.4))+thisRadius, startAngle: angle*CGFloat(i)-CGFloat(Double.pi*0.5), endAngle: angle*CGFloat(i+1)-CGFloat(Double.pi*0.5), clockwise: true)
				circle.addLine(to: center)
				layer.path = circle.cgPath
				
				switch rating {
				case .none:
					layer.fillColor = Style.shared.softBlue.cgColor
				case .low:
					layer.fillColor = Style.shared.green.cgColor
				case .medium:
					layer.fillColor = Style.shared.orange.cgColor
				case .heavy:
					layer.fillColor = Style.shared.red.cgColor
				case .veryHeavy:
					layer.fillColor = Style.shared.purple.cgColor
				}

				arcLayer.addSublayer(layer)
				
				let radialLabel = UILabel()
				radialLabel.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
				radialLabel.text = name
				radialLabel.font = UIFont(name: SYSTEM_FONT_B, size: Style.shared.P12)
				radialLabel.textColor = UIColor.white
				radialLabel.sizeToFit()
				radialLabel.center = center
				var transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi*0.5) + angle*CGFloat(Float(i)+0.5)-CGFloat(Double.pi*0.5))
				transform = transform.translatedBy(x: 0, y: -((radius+(barHeight*0.4))+thisRadius-(barHeight*0.25)))
				radialLabel.transform = transform
				self.radialLabels.append(radialLabel)
				self.addSubview(radialLabel)
			}
		}
		self.bringSubview(toFront: label)
		self.bringSubview(toFront: dayLabel)
		circleLayer.removeFromSuperlayer()
		self.layer.insertSublayer(circleLayer, below: label.layer)
	}
	
}
