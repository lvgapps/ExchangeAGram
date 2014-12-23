//
//  Scripts.swift
//  Lemonde Stand
//
//  Created by Wale Anif on 11/10/14.
//  Copyright (c) 2014 Lavvo Group. All rights reserved.
//

import Foundation
import UIKit

struct Scripts {
    /*************************************************************************************
    //MARK: Identify functions and classes for logging
    **************************************************************************************/
    static func identify(obj: String, arg1: String) {
        println("------------------------------------------------------------------------")
        println("\(obj) -> \(arg1)")
        println("------------------------------------------------------------------------")
        println()
        println()
    }
    
    /*************************************************************************************
    //MARK: Randomizer Functions
    **************************************************************************************/
    static func rand(range: Int) -> Int{
        return Int(arc4random_uniform(UInt32(range)) + 1)
    }
    
    static func randZero(range: Int) -> Int{
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    /*************************************************************************************
    //MARK: Colors using HEX input | USAGE > hexColor(0xFFD557)
    **************************************************************************************/
    //
    static func hexColor (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }
    
    /*************************************************************************************
    //MARK: Rounding of UI Views
    **************************************************************************************/
    static func roundView(viewObject: UIView) {
        viewObject.layer.cornerRadius = viewObject.frame.width / 2
        viewObject.clipsToBounds = true
    }
    
    static func roundViewWithBorder(viewObject: UIView, borderWidth: Double, borderColor: UIColor){
        self.createBorder(viewObject, borderWidth: borderWidth, borderColor: borderColor)
        self.roundView(viewObject)
    }
    
    static func roundCorners(viewObject: UIView, radius: Double) {
        viewObject.layer.cornerRadius = CGFloat(radius)
        viewObject.clipsToBounds = true
    }
    
    static func roundCornersWithBorder(viewObject: UIView, radius: Double, borderWidth: Double, borderColor: UIColor){
        self.createBorder(viewObject, borderWidth: borderWidth, borderColor: borderColor)
        self.roundCorners(viewObject, radius: radius)
    }
    
    static func createBorder(viewObject: UIView, borderWidth: Double, borderColor: UIColor) {
        viewObject.layer.borderWidth = CGFloat(borderWidth);
        viewObject.layer.borderColor = borderColor.CGColor;
    }

    
    /*************************************************************************************
    //MARK: Borders
    **************************************************************************************/
    static func borderBottom(viewObject: UIView){
        var lineView: UIView = UIView(frame: CGRect(x: 0, y: viewObject.frame.height - 1, width: viewObject.frame.width, height: 0.5))
        lineView.backgroundColor = hexColor(0x000000, alpha: 1.0)
        lineView.alpha = 0.1
        viewObject.addSubview(lineView)
    }
    
    static func borderTop(viewObject: UIView){
        var lineView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: viewObject.frame.width, height: 0.5))
        lineView.backgroundColor = hexColor(0x000000, alpha: 1.0)
        lineView.alpha = 0.1
        viewObject.addSubview(lineView)
    }
    
    static func borderLeft(viewObject: UIView){
        var lineView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0.5, height: viewObject.frame.height))
        lineView.backgroundColor = hexColor(0x000000, alpha: 1.0)
        lineView.alpha = 0.1
        viewObject.addSubview(lineView)
    }
    
    static func borderRight(viewObject: UIView){
        var lineView: UIView = UIView(frame: CGRect(x: viewObject.frame.width - 1, y: 0, width: 0.5, height: viewObject.frame.height))
        lineView.backgroundColor = hexColor(0x000000, alpha: 1.0)
        lineView.alpha = 0.1
        viewObject.addSubview(lineView)
    }

    
   

    
    /*************************************************************************************
    //MARK: Alerts
    **************************************************************************************/
    
    static func alert(viewController: UIViewController, header: String = "Warning", message: String){
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

}