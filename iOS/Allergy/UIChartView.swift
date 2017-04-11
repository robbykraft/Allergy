//
//  UIChartView.swift
//  Allergy
//
//  Created by Robby on 4/10/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class UIChartView: UIView {
	
	var values:[Float] = []
	
	var uiLabels:[UILabel] = []
	
	let count:CGFloat = 15
	
	let barLayer:CALayer = CALayer()
	let watermarkLayer:CALayer = CALayer()

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
		
		// UILabels
		for i in 0..<Int(count){
			let label = UILabel()
			label.font = UIFont.init(name: SYSTEM_FONT, size: Style.shared.P12)
			label.textColor = UIColor.black
			self.addSubview(label)
			uiLabels.append(label)
		}
		
		self.layer.addSublayer(watermarkLayer)
		self.layer.addSublayer(barLayer)

//		self.backgroundColor = UIColor.lightGray
		redraw()
	}
	
	func redraw(){

		barLayer.sublayers = []
		watermarkLayer.sublayers = []
		
		let lineWidth:CGFloat = 15
		let spacer:CGFloat = 2

		let padW:CGFloat = 0.5 * (self.frame.size.width - CGFloat((count-1) * (lineWidth+spacer)))
		let padH:CGFloat = 20 + lineWidth
		let padLabel:CGFloat = 40
		
		// uilabels
		for i in 0..<Int(count){
			if(uiLabels.count > i){
				let xPos:CGFloat = padW + CGFloat(i)*(lineWidth+spacer)
				uiLabels[i].sizeToFit()
				uiLabels[i].center = CGPoint.init(x: xPos, y: self.frame.size.height-padH)
				self.bringSubview(toFront: uiLabels[i])
			}
		}
		
		// watermarks
		for i in 0..<Int(count){
			let layer = CAShapeLayer()
			let bz = UIBezierPath()
			let xPos:CGFloat = padW + CGFloat(i)*(lineWidth+spacer)
			bz.move(to: CGPoint.init(x: xPos, y: self.frame.size.height-padH - padLabel))
			bz.addLine(to: CGPoint.init(x: xPos, y: padH))
			layer.path = bz.cgPath
			layer.strokeColor = Style.shared.whiteSmoke.cgColor
			layer.lineWidth = lineWidth
			layer.lineCap = kCALineCapRound
			watermarkLayer.addSublayer(layer)
		}

		// data layer
		for i in 0..<values.count{
			let layer = CAShapeLayer()
			let bz = UIBezierPath()
			let xPos:CGFloat = padW + CGFloat(i)*(lineWidth+spacer)
			bz.move(to: CGPoint.init(x: xPos, y: self.frame.size.height-padH - padLabel))
			bz.addLine(to: CGPoint.init(x: xPos, y: padH))
			layer.path = bz.cgPath
			layer.strokeColor = UIColor.appleBlue().cgColor
			layer.lineWidth = lineWidth
			layer.lineCap = kCALineCapRound
			barLayer.addSublayer(layer)
		}
		

	}
	
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }

}
