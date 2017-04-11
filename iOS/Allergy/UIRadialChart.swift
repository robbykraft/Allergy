//
//  UIRadialChart.swift
//  Allergy
//
//  Created by Robby on 4/11/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class UIRadialChart: UIView {
	
	var summary:String?
	
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
		refresh()
	}
	
	func refresh(){
		
		self.layer.sublayers = []
		
		let count:CGFloat = 15
		let lineWidth:CGFloat = 15
		let spacer:CGFloat = 2
		
		let padW:CGFloat = 0.5 * (self.frame.size.width - CGFloat((count-1) * (lineWidth+spacer)))
		let padH:CGFloat = 20 + lineWidth
		
		for i in 0..<Int(count){
			let layer = CAShapeLayer()
			let bz = UIBezierPath()
			let start = CGPoint.init(x: padW + CGFloat(i)*(lineWidth+spacer), y: self.frame.size.height-padH)
			bz.move(to: start)
			print(String(describing: start.x) + " " + String(describing: start.y))
			bz.addLine(to: CGPoint.init(x: start.x, y: padH))
			layer.path = bz.cgPath
			layer.strokeColor = Style.shared.whiteSmoke.cgColor
			layer.lineWidth = lineWidth
			layer.lineCap = kCALineCapRound
			self.layer.addSublayer(layer)
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
