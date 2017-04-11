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
			if let d = data{
				if let s = d.summary{
					label.text = s
				}
			}
			self.layoutSubviews()
			redrawLayers()
		}
	}
	
	// private
	let label = UILabel()
	let arcLayer = CALayer()
	let circleLayer = CALayer()
	
	let todaysAllergyLabel = UILabel()
	
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
		circleLayer.addSublayer(layer)
		
		label.font = UIFont.init(name: SYSTEM_FONT_B, size: Style.shared.P64)
		label.textColor = UIColor.black
		self.addSubview(label)
		
		todaysAllergyLabel.font = UIFont.init(name: SYSTEM_FONT, size:Style.shared.P15)
		todaysAllergyLabel.textColor = UIColor.gray
		todaysAllergyLabel.text = "today"
		self.addSubview(todaysAllergyLabel)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		label.sizeToFit()
		label.center = CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
		
		todaysAllergyLabel.sizeToFit()
		todaysAllergyLabel.center = CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5 - self.frame.width*0.33 + 50)

	}
	
	func redrawLayers(){
		let radius:CGFloat = self.frame.width*0.33
		let center:CGPoint = CGPoint.init(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
		arcLayer.sublayers = []
		if let sample = data{
			let count = sample.count()
			for i in 0..<count{
				let thisRadius:CGFloat = CGFloat(arc4random()%35)
				let layer = CAShapeLayer()
				let angle = CGFloat(Double.pi * 2 / Double(count))
				let circle = UIBezierPath.init(arcCenter: center, radius: radius+thisRadius, startAngle: angle*CGFloat(i), endAngle: angle*CGFloat(i+1), clockwise: true)
				circle.addLine(to: center)
				layer.path = circle.cgPath
				layer.fillColor = UIColor.init(white: 0.6 + CGFloat(Double(arc4random()%100)/100.0*0.3), alpha: 1.0).cgColor
				arcLayer.addSublayer(layer)
			}
		}
	}
	

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
