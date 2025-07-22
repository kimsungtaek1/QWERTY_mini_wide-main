//
//  KeyModel.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/7/25.
//

import Foundation
import UIKit

enum CurrentLanguage{
    case kor
    case eng
}

enum KeyType{
    case none
    case letter
    case space
    case delete
    case kor
    case eng
    case chn
    case number
    case spetial
    case shift
    case onshift
    case returen
    case lockshift
}

class KeyModel{
    var keyType:KeyType = .none
    
    var main_txt:String = ""
    var lt_txt:String = ""
    var rt_txt:String = ""
    var rb_txt:String = ""
    
    
    var main_color:UIColor = .black
    var lt_color:UIColor = .black
    var rt_color:UIColor = .black
    var rb_color:UIColor = .black
    
    var main_textsize:Float = 0
    var lt_textsize:Float = 0
    var rt_textsize:Float = 0
    var rb_textsize:Float = 0
    
    
    var image:String = ""
    var selectImage:String = ""
    
    var backgroundColor:UIColor = .white
    var selectBackgroundColor:UIColor = .white
    
    
    var width:Float = 0
    var height:Int = 0
    var tag = 0
    init(keyType: KeyType,
         main_txt: String = "",
         lt_txt: String = "",
         rt_txt: String = "",
         rb_txt: String = "",
         main_color: UIColor = .black,
         main_textsize:Float = 22,
         lt_color: UIColor = .black,
         lt_textsize:Float = 16,
         rt_color: UIColor = .black,
         rt_textsize:Float = 24,
         rb_color: UIColor = .black,
         rb_textsize:Float = 25,
         image: String = "",
         selectImage: String = "",
         backgroundColor: UIColor = .white,
         selectBackgroundColor: UIColor = .white,
         height:Int = 0,
         width:Float = 0,
         tag:Int = 0
        ) {
        self.keyType = keyType
        self.main_txt = main_txt
        self.lt_txt = lt_txt
        self.rt_txt = rt_txt
        self.rb_txt = rb_txt
        self.main_color = main_color
        self.lt_color = lt_color
        self.rt_color = rt_color
        self.rb_color = rb_color
        self.image = image
        self.selectImage = selectImage
        self.backgroundColor = backgroundColor
        self.selectBackgroundColor = selectBackgroundColor
        self.height = height
        self.width = width
        self.main_textsize = main_textsize
        self.lt_textsize = lt_textsize
        self.rt_textsize = rt_textsize
        self.rb_textsize = rb_textsize
        self.tag = tag
        
    }
    
}
