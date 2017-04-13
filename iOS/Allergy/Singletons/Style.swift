//
//  Style.swift
//  Character
//
//  Created by Robby on 8/23/16.
//  Copyright © 2016 Robby. All rights reserved.
//

extension UIColor {
	static func appleBlue() -> UIColor {
		return UIColor.init(colorLiteralRed: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)
	}
}

import UIKit

//let SYSTEM_FONT:String = "ArialRoundedMTBold"
let SYSTEM_FONT:String = "BanglaSangamMN"
let SYSTEM_FONT_B:String = "BanglaSangamMN-Bold"

//let SYSTEM_FONT:String = "Optima-Regular"
//let SYSTEM_FONT_B:String = "Optima-ExtraBlack"


let IS_IPAD:Bool = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
let IS_IPHONE:Bool = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone


class Style {
	
	let gray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
	let darkGray = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.00)
	let whiteSmoke = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
	let athensGray = UIColor(red:0.94, green:0.94, blue:0.96, alpha:1.00)
	let red = UIColor(red: 255/255.0, green: 59/255.0, blue: 48/255.0, alpha: 1.0)
	let orange = UIColor(red: 255/255.0, green: 149/255.0, blue: 0, alpha: 1.0)
	let blue = UIColor(red: 0, green: 122/255.0, blue: 1.0, alpha: 1.0)
	let green = UIColor(red: 76/255.0, green: 217/255.0, blue: 100/255.0, alpha: 1.0)
	let softBlue = UIColor(red:0.20, green:0.67, blue:0.86, alpha:1.00)
	let alienGreen = UIColor(red:0.30, green:0.85, blue:0.39, alpha:1.00)
	
	var P64:CGFloat = 64
	var P40:CGFloat = 40
	var P30:CGFloat = 30
	var P24:CGFloat = 24
	var P18:CGFloat = 18
	var P15:CGFloat = 15
	var P12:CGFloat = 12
	
	static let shared = Style()
	
	fileprivate init() {
		if(IS_IPAD){
			P64 = 92
			P40 = 60
			P30 = 50
			P24 = 42
			P18 = 32
			P15 = 26
			P12 = 24
		}
		
		styleUIAppearance()
	}
	
	func heading1Attributes() -> [String:NSObject] {
		var fontSize:CGFloat = 22
		if(IS_IPAD){
			fontSize = 36
		}
		let titleParagraphStyle = NSMutableParagraphStyle()
		titleParagraphStyle.alignment = .center
		return [NSFontAttributeName : UIFont(name: SYSTEM_FONT, size: fontSize)!,
		        NSKernAttributeName : CGFloat(2.4) as NSObject,
		        NSParagraphStyleAttributeName: titleParagraphStyle,
		        NSForegroundColorAttributeName : Style.shared.darkGray];
	}
	
	func styleUIAppearance(){
		let navigationBarAppearace = UINavigationBar.appearance()
//		navigationBarAppearace.tintColor = UIColor.white
//		navigationBarAppearace.setBackgroundImage(UIImage.init(named: "darkGray"), for: .default)
//		navigationBarAppearace.barStyle = UIBarStyle.blackTranslucent
		navigationBarAppearace.titleTextAttributes = [NSFontAttributeName : UIFont(name: SYSTEM_FONT_B, size: self.P24)!,
		                                              NSForegroundColorAttributeName : UIColor.black]
		//	                                              NSKernAttributeName : CGFloat(-4.0)]
		
	}
}

func statusBarHeight() -> CGFloat {
	let statusBarSize = UIApplication.shared.statusBarFrame.size
	return Swift.min(statusBarSize.width, statusBarSize.height)
}

