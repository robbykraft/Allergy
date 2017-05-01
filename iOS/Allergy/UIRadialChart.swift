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
		}
	}
	
	var pressed:Bool = false{
		didSet{
			if self.pressed{
				if let subs = self.circleLayer.sublayers{
					let circle = subs[0] as? CAShapeLayer
					circle?.fillColor = Style.shared.whiteSmoke.cgColor
					self.label.textColor = Style.shared.blue
					self.dayLabel.textColor = Style.shared.blue
				}
			} else{
//				self.circleLayer.opacity = 1.0
				if let subs = self.circleLayer.sublayers{
					let circle = subs[0] as? CAShapeLayer
					circle?.fillColor = UIColor.white.cgColor
					self.label.textColor = UIColor.black
					self.dayLabel.textColor = UIColor.gray

				}
			}
			self.layoutSubviews()
		}
	}
	
	// private
	let label = UILabel()
	let arcLayer = CALayer()
	let circleLayer = CALayer()
	
//	var radialLabels:[UILabel] = []
	
	let radialLabelImageView:UIImageView = UIImageView()
	
	let dayLabel = UILabel()
	
	func refreshViewData() {
		if let d = data{
			let summary = d.generateSummary()
			label.text = Pollen.shared.stringForRating(summary)
			// text size
			switch summary {
			case .veryHeavy: label.font = UIFont.init(name: SYSTEM_FONT_B, size: Style.shared.P40)
			case .none: label.font = UIFont.init(name: SYSTEM_FONT_B, size: Style.shared.P40)
			default: label.font = UIFont.init(name: SYSTEM_FONT_B, size: Style.shared.P48)
			}
			if let date = d.date{
				dayLabel.text = Style.shared.dayStringForDate(date)
			}
		}
//		for label in self.radialLabels{
//			label.removeFromSuperview()
//		}
//		self.radialLabels = []
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
		layer.fillColor = UIColor.white.cgColor
//		circleLayer.isHidden = true
		circleLayer.addSublayer(layer)
		
		label.font = UIFont.init(name: SYSTEM_FONT_B, size: Style.shared.P48)
		label.textColor = UIColor.black
		self.addSubview(label)
		
		dayLabel.font = UIFont.init(name: SYSTEM_FONT, size:Style.shared.P15)
		dayLabel.textColor = UIColor.gray
		self.addSubview(dayLabel)
		
		self.addSubview(radialLabelImageView)
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

		var barHeight:CGFloat = 40.0 + (self.frame.size.width - 320.0) * 0.18
		if(IS_IPAD){
			barHeight = 110.0;
		}
		if let sample = data{
//			let count = sample.count()
//			for i in 0..<count{
			var report = sample.report().sorted(by: { (a1, a2) -> Bool in
				return ( Float(a1.2) ) < ( Float(a2.2) )
			})
			
			var i = 0
			while i < report.count {
				let removed = report.remove(at: i)
				report.insert(removed, at: 0)
				i += 2
			}
			
			let count = report.count
			for i in 0..<report.count {
				let (_, _, logValue, rating) = report[i]
				var valuePCT:CGFloat = CGFloat(logValue)
				if(valuePCT > 0.75){ valuePCT = 0.75 }
				let thisRadius:CGFloat = valuePCT * barHeight
				let layer = CAShapeLayer()
				let angle = CGFloat(Double.pi * 2 / Double(count))
				let circle = UIBezierPath.init(arcCenter: center, radius: (radius+(barHeight*0.4))+thisRadius, startAngle: angle*CGFloat(i)-CGFloat(Double.pi*0.5), endAngle: angle*CGFloat(i+1)-CGFloat(Double.pi*0.5), clockwise: true)
				circle.addLine(to: center)
				layer.path = circle.cgPath
				
				switch rating {
				case .none:      layer.fillColor = Style.shared.colorNoPollen.cgColor
				case .low:       layer.fillColor = Style.shared.colorLow.cgColor
				case .medium:    layer.fillColor = Style.shared.colorMedium.cgColor
				case .heavy:     layer.fillColor = Style.shared.colorHeavy.cgColor
				case .veryHeavy: layer.fillColor = Style.shared.colorVeryHeavy.cgColor
				}

				arcLayer.addSublayer(layer)
				
			}
			
			
			let size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
			
			UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
			//		UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
			let context = UIGraphicsGetCurrentContext()!
			// *******************************************************************
			// Scale & translate the context to have 0,0
			// at the centre of the screen maths convention
			// Obviously change your origin to suit...
			// *******************************************************************
			context.translateBy (x: size.width / 2, y: size.height / 2)
			context.scaleBy (x: 1, y: -1)

			for i in 0..<report.count {
				let (name, _, logValue, _) = report[i]
				var valuePCT = CGFloat(logValue)
				if(valuePCT > 0.75){ valuePCT = 0.75 }
				let thisRadius:CGFloat = valuePCT * barHeight
				let angle = CGFloat(Double.pi * 2 / Double(count))
				let textAngle = angle*CGFloat(Float(i)+0.5) - CGFloat(Double.pi*0.5)
				let textRadius = (radius+(barHeight*0.4))+thisRadius-(barHeight*0.22)
				centreArcPerpendicular(text: name, context: context, radius: textRadius, angle: -textAngle, colour: UIColor.white, font: UIFont(name: SYSTEM_FONT_B, size: Style.shared.P12)!, clockwise: true)
			}
			let image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			self.radialLabelImageView.image = image
			self.radialLabelImageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		}
		self.bringSubview(toFront: label)
		self.bringSubview(toFront: dayLabel)
		circleLayer.removeFromSuperlayer()
		self.layer.insertSublayer(circleLayer, below: label.layer)
		self.bringSubview(toFront: radialLabelImageView)
		self.radialLabelImageView.center = CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.height*0.5)
	}

	
	/////////////////////////////////////////////////////////////////////////
	
	func centreArcPerpendicular(text str: String, context: CGContext, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, clockwise: Bool){
		// *******************************************************
		// This draws the String str around an arc of radius r,
		// with the text centred at polar angle theta
		// *******************************************************
		
		let l = str.characters.count
		let attributes = [NSFontAttributeName: font]
		
		let characters: [String] = str.characters.map { String($0) } // An array of single character strings, each character in str
		var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
		var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
		
		// Calculate the arc subtended by each letter and their total
		for i in 0 ..< l {
			arcs += [chordToArc(characters[i].size(attributes: attributes).width, radius: r)]
			totalArc += arcs[i]
		}
		
		// Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
		// or anti-clockwise (right way up at 6 o'clock)?
		let direction: CGFloat = clockwise ? -1 : 1
		let slantCorrection = clockwise ? -CGFloat(Double.pi/2) : CGFloat(Double.pi/2)
		
		// The centre of the first character will then be at
		// thetaI = theta - totalArc / 2 + arcs[0] / 2
		// But we add the last term inside the loop
		var thetaI = theta - direction * totalArc / 2
		
		for i in 0 ..< l {
			thetaI += direction * arcs[i] / 2
			// Call centerText with each character in turn.
			// Remember to add +/-90º to the slantAngle otherwise
			// the characters will "stack" round the arc rather than "text flow"
			centre(text: characters[i], context: context, radius: r, angle: thetaI, colour: c, font: font, slantAngle: thetaI + slantCorrection)
			// The centre of the next character will then be at
			// thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
			// but again we leave the last term to the start of the next loop...
			thetaI += direction * arcs[i] / 2
		}
	}
	
	func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
		// *******************************************************
		// Simple geometry
		// *******************************************************
		return 2 * asin(chord / (2 * radius))
	}
	
	func centre(text str: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, slantAngle: CGFloat) {
		// *******************************************************
		// This draws the String str centred at the position
		// specified by the polar coordinates (r, theta)
		// i.e. the x= r * cos(theta) y= r * sin(theta)
		// and rotated by the angle slantAngle
		// *******************************************************
		
		// Set the text attributes
		let attributes = [NSForegroundColorAttributeName: c,
		                  NSFontAttributeName: font]
		// Save the context
		context.saveGState()
		// Undo the inversion of the Y-axis (or the text goes backwards!)
		context.scaleBy(x: 1, y: -1)
		// Move the origin to the centre of the text (negating the y-axis manually)
		context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
		// Rotate the coordinate system
		context.rotate(by: -slantAngle)
		// Calculate the width of the text
		let offset = str.size(attributes: attributes)
		// Move the origin by half the size of the text
		context.translateBy (x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
		// Draw the text
		str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
		// Restore the context
		context.restoreGState()
	}
	
}
