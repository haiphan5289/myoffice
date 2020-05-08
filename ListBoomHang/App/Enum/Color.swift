//
//  Color.swift
//  AppHost
//
//  Created by MacbookPro on 4/5/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

enum  CustomColor {
    case blacktwo
    case whiteten
    case niceblue
    case warmgrey
    case whitetwo
    case c939393
    case whitefive
    case black16two
    case lightmint
    case df483b
    case c484848
    case whiteseven
    case pine
    case a50000
    case c6c6c6
    case c525252
    case whiteseven83
    case greyishbrown
    case waterblue
    case c393939
    case c41e9ff
    case c37b4f5
    case ffb033
    case ff5800
    case c90d0d
    case brownishgrey
    case canaryyellow
    case orangeyred
    case whiteeight
    case dodgerblue
    case c08a7fc
    case c5c5b5b
    case edebeb
    case d92718
    case ffba4d
    case c363434
    case c005bc6
    case blackthree
    case viewLine
    case c38383887
    case peacockblue
    case e8e8e8
    case ebf4f9
    case c0180c7
    case c660099
    case c29ab02
    case c3274fe
    case whitefour
    
    var color: UIColor {
        switch self {
        case .blacktwo:
            return #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        case .whiteten:
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        case .niceblue:
            return #colorLiteral(red: 0.1098039216, green: 0.5333333333, blue: 0.7568627451, alpha: 1)
        case .warmgrey:
            return #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        case .whitetwo:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .c939393:
            return #colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.5764705882, alpha: 1)
        case .whitefive:
            return #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        case .black16two:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16)
        case .lightmint:
            return #colorLiteral(red: 0.7098039216, green: 1, blue: 0.7568627451, alpha: 1)
        case .df483b:
            return #colorLiteral(red: 0.8745098039, green: 0.2823529412, blue: 0.231372549, alpha: 1)
        case .c484848:
            return #colorLiteral(red: 0.2823529412, green: 0.2823529412, blue: 0.2823529412, alpha: 1)
        case .whiteseven:
            return #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        case .pine:
            return #colorLiteral(red: 0.1254901961, green: 0.3607843137, blue: 0.1607843137, alpha: 1)
        case .a50000:
            return #colorLiteral(red: 0.6470588235, green: 0, blue: 0, alpha: 1)
        case .c6c6c6:
            return #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        case .c525252:
            return #colorLiteral(red: 0.3215686275, green: 0.3215686275, blue: 0.3215686275, alpha: 1)
        case .whiteseven83:
            return #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 0.83)
        case .greyishbrown:
            return #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        case .waterblue:
            return #colorLiteral(red: 0.0431372549, green: 0.4588235294, blue: 0.7450980392, alpha: 1)
        case .c393939:
            return #colorLiteral(red: 0.2235294118, green: 0.2235294118, blue: 0.2235294118, alpha: 1)
        case .c41e9ff:
            return #colorLiteral(red: 0.2549019608, green: 0.9137254902, blue: 1, alpha: 1)
        case .c37b4f5:
            return #colorLiteral(red: 0.2156862745, green: 0.7058823529, blue: 0.9607843137, alpha: 1)
        case .ff5800:
            return #colorLiteral(red: 1, green: 0.3450980392, blue: 0, alpha: 1)
        case .ffb033:
            return #colorLiteral(red: 1, green: 0.6901960784, blue: 0.2, alpha: 1)
        case .c90d0d:
            return #colorLiteral(red: 0.7882352941, green: 0.05098039216, blue: 0.05098039216, alpha: 1)
        case .brownishgrey:
            return #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
        case .orangeyred:
            return #colorLiteral(red: 0.9725490196, green: 0.2, blue: 0.168627451, alpha: 1)
        case .canaryyellow:
            return #colorLiteral(red: 1, green: 0.8862745098, blue: 0.2549019608, alpha: 1)
        case .whiteeight:
            return #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        case .dodgerblue:
            return #colorLiteral(red: 0.2, green: 0.7019607843, blue: 0.968627451, alpha: 1)
        case .c08a7fc:
            return #colorLiteral(red: 0.03137254902, green: 0.6549019608, blue: 0.9882352941, alpha: 1)
        case .c5c5b5b:
            return #colorLiteral(red: 0.3607843137, green: 0.3568627451, blue: 0.3568627451, alpha: 1)
        case .edebeb:
            return #colorLiteral(red: 0.9294117647, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        case .ffba4d:
            return #colorLiteral(red: 1, green: 0.7294117647, blue: 0.3019607843, alpha: 1)
        case .d92718:
            return #colorLiteral(red: 0.8509803922, green: 0.1529411765, blue: 0.09411764706, alpha: 1)
        case .c363434:
            return #colorLiteral(red: 0.2117647059, green: 0.2039215686, blue: 0.2039215686, alpha: 0.8)
        case .c005bc6:
            return #colorLiteral(red: 0, green: 0.3568627451, blue: 0.7764705882, alpha: 1)
        case .blackthree:
            return #colorLiteral(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
        case .viewLine:
            return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        case .c38383887:
            return #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 0.87)
        case .peacockblue:
            return #colorLiteral(red: 0, green: 0.3764705882, blue: 0.5764705882, alpha: 1)
        case .e8e8e8:
            return #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        case .ebf4f9:
            return #colorLiteral(red: 0.9215686275, green: 0.9568627451, blue: 0.9764705882, alpha: 1)
        case .c0180c7:
            return #colorLiteral(red: 0.003921568627, green: 0.5019607843, blue: 0.7803921569, alpha: 1)
        case .c660099:
            return #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
        case .c29ab02:
            return #colorLiteral(red: 0.1607843137, green: 0.6705882353, blue: 0.007843137255, alpha: 1)
        case .c3274fe:
            return #colorLiteral(red: 0.1960784314, green: 0.4549019608, blue: 0.9960784314, alpha: 1)
        case .whitefour:
            return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        }
    }
}
