//
//  Colors.swift
//  NON
//
//  Created by Evghenia Nedbailova on 22/11/2023.
//

import UIKit
import SwiftUI

enum Colors {
    enum UIColorType {
        case mainColorPink
        case subtitleColorPink
        case darkGray
        case almostBlack
        case lightCyan
        case darkCyan

        var value: UIColor {
            switch self {
            case .mainColorPink:
                return UIColor(cgColor: Colors.CGColorType.mainColorPink.value)
            case .subtitleColorPink:
                return UIColor(cgColor: Colors.CGColorType.subtitleColorPink.value)
            case .darkGray:
                return UIColor(cgColor: Colors.CGColorType.darkGray.value)
            case .almostBlack:
                return UIColor(cgColor: Colors.CGColorType.almostBlack.value)
            case .lightCyan:
                return UIColor(cgColor: Colors.CGColorType.lightCyan.value)
            case .darkCyan:
                return UIColor(cgColor: Colors.CGColorType.darkCyan.value)
            }
        }
    }

    enum CGColorType {
        case mainColorPink
        case subtitleColorPink
        case darkGray
        case almostBlack
        case lightCyan
        case darkCyan

        var value: CGColor {
            switch self {
            case .mainColorPink:
                return #colorLiteral(red: 0.831372549, green: 0.09411764706, blue: 0.462745098, alpha: 1)
            case .subtitleColorPink:
                return #colorLiteral(red: 1, green: 0.768627451, blue: 0.937254902, alpha: 0.85)
            case .darkGray:
                return #colorLiteral(red: 0.368627451, green: 0.368627451, blue: 0.368627451, alpha: 1)
            case .almostBlack:
                return #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
            case .lightCyan:
                return #colorLiteral(red: 0, green: 0.8428697586, blue: 0.9040647745, alpha: 1)
            case .darkCyan:
                return #colorLiteral(red: 0, green: 0.4712916017, blue: 0.5072036386, alpha: 1)
            }
        }
    }

    enum SwiftUIColorType {
        case mainColorPink
        case subtitleColorPink
        case darkGray
        case almostBlack
        case lightCyan
        case darkCyan

        var value: Color {
            switch self {
            case .mainColorPink:
                return Color(Colors.UIColorType.mainColorPink.value)
            case .subtitleColorPink:
                return Color(Colors.UIColorType.subtitleColorPink.value)
            case .darkGray:
                return Color(Colors.UIColorType.darkGray.value)
            case .almostBlack:
                return Color(Colors.UIColorType.almostBlack.value)
            case .lightCyan:
                return Color(Colors.UIColorType.lightCyan.value) 
            case .darkCyan:
                return Color(Colors.UIColorType.darkCyan.value)
            }
        }
    }
}
