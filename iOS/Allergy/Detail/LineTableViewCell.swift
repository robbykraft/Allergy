//
//  LineTableViewCell.swift
//  Allergy
//
//  Created by Robby on 4/12/17.
//  Copyright © 2017 Robby Kraft. All rights reserved.
//

import UIKit

class LineTableViewCell: UITableViewCell {

	let barLayer = CALayer()
	let barDescription = UILabel()
	
	var rating:Rating = .none
	
	var data:(Int, Int)?{  // value, maxValue
		didSet{
			self.layoutSubviews()
		}
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initUI()
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		initUI()
    }
	
	func initUI(){
//		self.layer.addSublayer(barLayer)
		self.layer.insertSublayer(barLayer, at: 0)
		redrawLayers()
		barDescription.font = UIFont(name: SYSTEM_FONT_B, size: Style.shared.P18)
		barDescription.textColor = UIColor.white
		self.addSubview(barDescription)
	}
	
	func redrawLayers(){
		barLayer.sublayers = []
		
		if let (value, max) = data{
			let lineFrame:CGFloat = self.frame.size.width * 0.5
			let strokeWeight:CGFloat = 38
			let pad:CGFloat = 10
			
			let thisLineWidth = lineFrame * CGFloat(Float(value) / Float(max))
			
			let shape = CAShapeLayer()
			let bz = UIBezierPath()
			bz.move(to: CGPoint.init(x: strokeWeight*0.5+pad, y: self.frame.size.height*0.5))
			bz.addLine(to: CGPoint.init(x: strokeWeight*0.5+pad + thisLineWidth, y: self.frame.size.height*0.5))
			shape.path = bz.cgPath
			shape.lineWidth = strokeWeight
			shape.lineCap = kCALineCapRound
			switch self.rating {
			case .none:
				shape.strokeColor = Style.shared.blue.cgColor
			case .low:
				shape.strokeColor = Style.shared.blue.cgColor
			case .medium:
				shape.strokeColor = Style.shared.green.cgColor
			case .heavy:
				shape.strokeColor = Style.shared.orange.cgColor
			case .veryHeavy:
				shape.strokeColor = Style.shared.red.cgColor
			}
			
			barLayer.addSublayer(shape)
		}
	}
	
	override func layoutSubviews() {
		let pad:CGFloat = 10
		let strokeWeight:CGFloat = 38
		
		super.layoutSubviews()
		redrawLayers()
		
		if let (value, max) = data{
			let thisLineWidth = strokeWeight*0.5+pad + CGFloat(self.frame.size.width * 0.5) * CGFloat(Float(value) / Float(max))

			barDescription.isHidden = false
			barDescription.text = String(describing: value)
			barDescription.sizeToFit()
			barDescription.center = CGPoint(x: thisLineWidth - barDescription.frame.size.width*0.5+pad, y: self.frame.size.height*0.5)
		} else{
//			barDescription.isHidden = true
		}
		self.textLabel?.font = UIFont(name: SYSTEM_FONT, size: Style.shared.P18)
		self.textLabel?.sizeToFit()
		self.textLabel?.center = CGPoint(x: self.frame.size.width - (self.textLabel?.frame.size.width)!*0.5-pad, y: self.frame.size.height*0.5)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
