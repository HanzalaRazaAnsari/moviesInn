//
//  Theme.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation
import UIKit


public class ThemeManager{
    public var theme: Theme = Theme1()
    
    public static var shared: ThemeManager = {
        let themeManager = ThemeManager()
        return themeManager
    }()
    
    public func setTheme(theme: Theme){
        self.theme = theme
    }
}



public protocol Theme {
    
    var primaryColour : UIColor { get }
//    var buttonColorSecondary : UIColor { get }
//    var buttonTitleColor : UIColor {get}
//    var buttonFont: UIFont.Weight {get}
//    var viewBackgroundColor: UIColor {get}
}


public struct Theme1: Theme {
    
    public init() { }
    
    public var primaryColour: UIColor = Colors.purple
//    public var buttonColorSecondary: UIColor = Colors.AppThemeGreen
//    public var buttonTitleColor: UIColor = UIColor.white
//    public var buttonFont = UIFont.Weight.bold
//    public var viewBackgroundColor: UIColor = Colors.viewBackgroundColor
//    public var yellowColor: UIColor = Colors.yellowColor
//    public var babyPink: UIColor = Colors.babyPink
//    public var lightGreen: UIColor = Colors.lightGreen
//    public var pakGreen: UIColor = Colors.lightGreen
}
