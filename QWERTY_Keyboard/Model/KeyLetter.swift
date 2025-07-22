//
//  KeyLetter.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/7/25.
//

import Foundation
import UIKit

class KeyLetter{
    static let shared:KeyLetter = KeyLetter()
    
    var fuctionwidth: Float {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let isPortrait = screenWidth < screenHeight
        
        if isPortrait {
            return Float(51.58 * calculateKeyboardWidth() / 393)
        } else {
            return Float(95.5 * calculateKeyboardWidth() / 697)
        }
    }
    
    var key_width: Float {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let isPortrait = screenWidth < screenHeight
        
        if isPortrait {
            return Float((isProMaxOrLarger() ? 44 : 42) * calculateKeyboardWidth() / 393)
        } else {
            return Float((isProMaxOrLarger() ? 63 : 67) * calculateKeyboardWidth() / 703)
        }
    }
    
    var key_height: Int {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        return screenWidth < screenHeight ? 60 : 46
    }
    
    var subletter_Color = _overrideUserInterfaceStyle == .light ? UIColor(hexString: "#808080") :.white //
    var backgroundColor:UIColor = _overrideUserInterfaceStyle == .light ? .white : UIColor(hexString: "6c6c6d")
    var function_bg:UIColor = _overrideUserInterfaceStyle == .light ? UIColor(hexString: "#a1aabc") : UIColor(hexString: "#464747")
    var textColor:UIColor = _overrideUserInterfaceStyle == .light ? .black : .white
    
    let korsubTextSize:Float = 15.0
    
    let engSmallTextSize:Float = 25.0
    let engLargeTextSize:Float = 19.0
    let engTextSize:Float = 18
    let spaceTextSize:Float = 15
    let return123TextSize:Float = 15
    let specialFontSize:Float = 21
    
    let numerSize:Float = 24
    
    // iPhone Pro Max 이상 기종 판단 함수
    func isProMaxOrLarger() -> Bool {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let isPortrait = screenWidth < screenHeight
        
        // iPhone Pro Max 기준 화면 크기
        let proMaxWidth: CGFloat = 430.0
        
        if isPortrait {
            // 세로 모드일 때는 너비로 판단
            return screenWidth >= proMaxWidth
        } else {
            // 가로 모드일 때는 높이로 판단 (화면이 90도 회전되므로)
            return screenHeight >= proMaxWidth
        }
    }
    
    // 키보드 width 계산 함수
    func calculateKeyboardWidth() -> Float {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let isPortrait = screenWidth < screenHeight
        
        // iPhone Pro Max 기준 화면 크기
        let proMaxWidth: CGFloat = 430.0
        
        if isPortrait {
            // 세로 모드일 때
            if isProMaxOrLarger() {
                // Pro Max 이상의 큰 화면
                return Float(screenWidth * 0.92)
            } else {
                // 일반 기기
                return Float(screenWidth * 0.95)
            }
        } else {
            // 가로 모드일 때
            // 양쪽 여백 공간 (언어변경 + 마이크) 각각 40pt씩
            let sideMargin: CGFloat = 40.0
            let totalMargin = sideMargin * 2
            
            if isProMaxOrLarger() {
                // Pro Max 이상의 큰 화면
                return Float((screenWidth - totalMargin) * 0.98)
            } else {
                // 일반 기기
                return Float(screenWidth - totalMargin)
            }
        }
    }
    
    func setColor(){
        if _overrideUserInterfaceStyle == .light {
            backgroundColor = .white
            function_bg = UIColor(hexString: "#a1aabc")
            textColor = .black
            subletter_Color = UIColor(hexString: "#808080")
        } else { // .dark or default
            backgroundColor = UIColor(red: 83/255, green: 83/255, blue: 83/255, alpha: 1.0)
            function_bg = UIColor(hexString: "#464747")
            textColor = .white
            subletter_Color = .white
        }
    }
    
    
    
    
    func getKorLetters() -> [[KeyModel]] {
        
        return [
            [KeyModel(keyType: .letter,main_txt: "ㅂ",lt_txt: "ㅍ", main_color: textColor, lt_color: subletter_Color,lt_textsize: korsubTextSize, backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 0),
             KeyModel(keyType: .letter,main_txt: "ㅈ",lt_txt: "ㅊ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 1),
             KeyModel(keyType: .letter,main_txt: "ㄷ",lt_txt: "ㅌ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 2),
             KeyModel(keyType: .letter,main_txt: "ㄱ",lt_txt: "ㅋ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 3),
             KeyModel(keyType: .letter,main_txt: "ㅅ", main_color: textColor,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 4),
             KeyModel(keyType: .letter,main_txt: "ㅗ",lt_txt: "ㅛ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 5),
             KeyModel(keyType: .letter,main_txt: "ㅏ",lt_txt: "ㅑ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 6),
             KeyModel(keyType: .letter,main_txt: "ㅣ",main_color: textColor, rt_color: subletter_Color,rt_textsize: 10, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 7),
             KeyModel(keyType: .delete,main_txt: "⌫", main_color: textColor,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width)],
            [KeyModel(keyType: .letter,main_txt: "ㅁ", main_color: textColor,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 9),
             KeyModel(keyType: .letter,main_txt: "ㄴ", main_color: textColor,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 10),
             KeyModel(keyType: .letter,main_txt: "ㅇ", main_color: textColor,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 11),
             KeyModel(keyType: .letter,main_txt: "ㄹ", main_color: textColor,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 12),
             KeyModel(keyType: .letter,main_txt: "ㅎ", main_color: textColor,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 13),
             KeyModel(keyType: .letter,main_txt: "ㅜ",lt_txt: "ㅠ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 14),
             KeyModel(keyType: .letter,main_txt: "ㅓ",lt_txt: "ㅕ", main_color: textColor,lt_color: subletter_Color,lt_textsize: korsubTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 15),
             KeyModel(keyType: .letter,main_txt: "ㅡ", rt_txt: "⠈", main_color: textColor, rt_color: subletter_Color, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 16),
             KeyModel(keyType: .eng ,main_txt: "Eng", main_color: textColor,main_textsize: engTextSize, backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width)]
        ]
    }

    func getKorFunction() -> [KeyModel]{
        return [
            KeyModel(keyType: .shift,image: "ic_shift.png",selectImage: "ic_shift_on.png",backgroundColor: function_bg,selectBackgroundColor: .white,height: key_height, width: fuctionwidth),
            KeyModel(keyType: .number,main_txt: "123",main_color: textColor, main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth),
            KeyModel(keyType: .space ,main_txt: "스페이스",main_color: textColor,main_textsize: spaceTextSize, backgroundColor: backgroundColor)
            ,KeyModel(keyType: .returen,main_txt: "↵",main_color: textColor,main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth + key_width + 6)
        ]
    }

    func getEngFunction() -> [KeyModel]{
        return [
            KeyModel(keyType: .shift,image: "ic_shift.png",selectImage: "ic_shift_on.png",backgroundColor: function_bg,selectBackgroundColor: .white,height: key_height, width: fuctionwidth),
            KeyModel(keyType: .number,main_txt: "123",main_color: textColor,main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth),
            KeyModel(keyType: .space ,main_txt: "Space",main_color: textColor,main_textsize: spaceTextSize, backgroundColor: backgroundColor)
            ,KeyModel(keyType: .returen,main_txt: "return",main_color: textColor,main_textsize: return123TextSize, backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth + key_width + 6)
        ]
    }

    func getShiftLetter() -> [[KeyModel]]{
        return [
            [KeyModel(keyType: .letter,main_txt: "ㅃ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㅉ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㄸ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㄲ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㅆ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㅙ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㅒ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,main_txt: "ㅣ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .delete,main_txt: "⌫" , main_color: textColor,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width),
             ],
            [
                KeyModel(keyType: .letter,main_txt: "ㅁ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㄴ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㅇ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㄹ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㅎ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㅞ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㅖ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                 KeyModel(keyType: .letter,main_txt: "ㅡ", main_color: textColor, backgroundColor: backgroundColor, height:key_height, width: key_width),
                KeyModel(keyType: .eng,main_txt: "Eng", main_color: textColor,main_textsize: engTextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg, height:key_height, width: key_width),
            ]
        ]
    }

    func getEngLetter() -> [[KeyModel]]{
        return [
            [KeyModel(keyType: .letter,lt_txt: "w",rt_txt: "⠈",rb_txt: "q", lt_color: textColor, lt_textsize: engSmallTextSize, rt_color: textColor,rb_color:subletter_Color,rb_textsize: engSmallTextSize, lt_textMarginRight: 10, lt_textMarginBottom: 15, rb_textMarginLeft: 25, rb_textMarginTop: 15, lt_textGravity: 3, rb_textGravity: 85, backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 0),
             KeyModel(keyType: .letter,lt_txt: "e", lt_color: textColor, lt_textsize: engSmallTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 1),
             KeyModel(keyType: .letter,lt_txt: "r",rb_txt: "f", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 2),
             KeyModel(keyType: .letter,lt_txt: "t",rb_txt: "g", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 3),
             KeyModel(keyType: .letter,lt_txt: "y", rb_txt: "p", lt_color: textColor,lt_textsize: engSmallTextSize, rb_color: subletter_Color, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 4),
             KeyModel(keyType: .letter,lt_txt: "u", lt_color: textColor, lt_textsize: engSmallTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 5),
             KeyModel(keyType: .letter,lt_txt: "i", lt_color: textColor, lt_textsize: engSmallTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 6),
             KeyModel(keyType: .letter,lt_txt: "o",rt_txt: "⠈", lt_color: textColor,lt_textsize: engSmallTextSize, rt_color: textColor, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 7),
             KeyModel(keyType: .delete,main_txt: "⌫", main_color: textColor ,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width,tag: 8)],
            [KeyModel(keyType: .letter,lt_txt: "a",rt_txt: "⠈", lt_color: textColor,lt_textsize: engSmallTextSize, rt_color: subletter_Color, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "s",rb_txt: "z", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 10),
             KeyModel(keyType: .letter,lt_txt: "d",rb_txt: "x", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 11),
             KeyModel(keyType: .letter,lt_txt: "c",rb_txt: "v", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 12),
             KeyModel(keyType: .letter,lt_txt: "h",rb_txt: "b", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 13),
             KeyModel(keyType: .letter,lt_txt: "n",rb_txt: "j", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 14),
             KeyModel(keyType: .letter,lt_txt: "m",rb_txt: "k", lt_color: textColor, lt_textsize: engSmallTextSize,rb_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 15),
             KeyModel(keyType: .letter,lt_txt: "l",rt_txt: "⠈", lt_color: textColor, lt_textsize: engSmallTextSize,rt_color: subletter_Color ,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 16),
             KeyModel(keyType: .kor ,main_txt: "Kor",main_color: textColor ,main_textsize: engTextSize, backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width)]
        ]
    }

    func getEngShiftLetter() -> [[KeyModel]]{
        return   [
            [KeyModel(keyType: .letter,lt_txt: "W",rt_txt: "⠈",rb_txt: "Q", lt_color: textColor, lt_textsize: engLargeTextSize,rt_color: textColor, rb_color:subletter_Color,rb_textsize: engLargeTextSize, lt_textMarginRight: 10, lt_textMarginBottom: 15, rb_textMarginLeft: 25, rb_textMarginTop: 15, lt_textGravity: 3, rb_textGravity: 85, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 16),
             KeyModel(keyType: .letter,lt_txt: "E", lt_color: textColor, lt_textsize: engLargeTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 0),
             KeyModel(keyType: .letter,lt_txt: "R",rb_txt: "F", lt_color: textColor, lt_textsize: engLargeTextSize,rb_color: subletter_Color,rb_textsize: engLargeTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 1),
             KeyModel(keyType: .letter,lt_txt: "T",rb_txt: "G", lt_color: textColor, lt_textsize: engLargeTextSize,rb_color: subletter_Color,rb_textsize: engLargeTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 2),
             KeyModel(keyType: .letter,lt_txt: "Y", rb_txt: "P", lt_color: textColor, lt_textsize: engLargeTextSize, rb_color: subletter_Color,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 3),
             KeyModel(keyType: .letter,lt_txt: "U", lt_color: textColor, lt_textsize: engLargeTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 4),
             KeyModel(keyType: .letter,lt_txt: "I", lt_color: textColor, lt_textsize: engLargeTextSize, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 5),
             KeyModel(keyType: .letter,lt_txt: "O",rt_txt: "⠈", lt_color: textColor,lt_textsize: engLargeTextSize, rt_color: textColor, backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 6),
             KeyModel(keyType: .delete,main_txt: "⌫" , main_color: textColor,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width,tag: 7)],
            [KeyModel(keyType: .letter,lt_txt: "A",rt_txt: "⠈", lt_color: textColor,lt_textsize: engLargeTextSize,rt_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 8),
             KeyModel(keyType: .letter,lt_txt: "S",rb_txt: "Z", lt_color: textColor,lt_textsize: engLargeTextSize,rb_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 9),
             KeyModel(keyType: .letter,lt_txt: "D",rb_txt: "X", lt_color: textColor,lt_textsize: engLargeTextSize,rb_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 10),
             KeyModel(keyType: .letter,lt_txt: "C",rb_txt: "V", lt_color: textColor,lt_textsize: engLargeTextSize,rb_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 11),
             KeyModel(keyType: .letter,lt_txt: "H",rb_txt: "B", lt_color: textColor,lt_textsize: engLargeTextSize,rb_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 12),
             KeyModel(keyType: .letter,lt_txt: "N",rb_txt: "J", lt_color: textColor,lt_textsize: engLargeTextSize,rb_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 13),
             KeyModel(keyType: .letter,lt_txt: "M",rb_txt: "K", lt_color: textColor,lt_textsize: engLargeTextSize,rb_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 14),
             KeyModel(keyType: .letter,lt_txt: "L",rt_txt: "⠈", lt_color: textColor,lt_textsize: engLargeTextSize,rt_color: subletter_Color ,rb_textsize: engLargeTextSize,backgroundColor: backgroundColor,height:key_height, width: key_width,tag: 15),
             KeyModel(keyType: .kor ,main_txt: "Kor", main_color: textColor,main_textsize: engTextSize,rb_textsize: engLargeTextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width)]
        ]
    }

    func getNumberLetter(_ currentLanguage:CurrentLanguage) -> [[KeyModel]]{
        return [
            [KeyModel(keyType: .letter,main_txt: "1",main_color: textColor,main_textsize: numerSize, backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 0),
             KeyModel(keyType: .letter,main_txt: "2",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 1),
             KeyModel(keyType: .letter,main_txt: "3",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 2),
             KeyModel(keyType: .letter,main_txt: "4",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 3),
             KeyModel(keyType: .letter,main_txt: "5",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 4),
             KeyModel(keyType: .letter,main_txt: "6",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 5),
             KeyModel(keyType: .letter,main_txt: "7",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 6),
             KeyModel(keyType: .letter,main_txt: "8",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 7),
             KeyModel(keyType: .delete,main_txt: "⌫",main_color: textColor ,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width),
             ],
            [
                KeyModel(keyType: .letter,main_txt: "0",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 8),
                 KeyModel(keyType: .letter,main_txt: ".",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 9),
                 KeyModel(keyType: .letter,main_txt: ",",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 10),
                 KeyModel(keyType: .letter,main_txt: "?",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 11),
                 KeyModel(keyType: .letter,main_txt: "!",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 12),
                KeyModel(keyType: .letter,lt_txt: "'",rb_txt: "\"", lt_color: textColor,lt_textsize: numerSize, rb_color: textColor,rb_textsize: numerSize, backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 13),
                KeyModel(keyType: .letter,lt_txt: "-",rb_txt: "_",lt_color: textColor, lt_textsize: numerSize, rb_color: textColor,rb_textsize: numerSize, backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 14),
                 KeyModel(keyType: .letter,main_txt: "9",main_color: textColor,main_textsize: numerSize,backgroundColor: backgroundColor, height:key_height, width: key_width,tag: 15),
                KeyModel(keyType: currentLanguage == .kor ? .kor : .eng,main_txt: currentLanguage == .kor ? "Kor" : "Eng",main_color: textColor,main_textsize: engTextSize, backgroundColor: function_bg,selectBackgroundColor: function_bg, height:key_height, width: key_width),
            ]
        ]
    }

    func getNumberFuntion(_ currentLanguage:CurrentLanguage) -> [KeyModel]{
        return [
            KeyModel(keyType: .spetial,main_txt: "#+=",main_color: textColor,main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: .white,height: key_height, width: fuctionwidth),
            KeyModel(keyType: currentLanguage == .kor ? .kor : .eng,main_txt: currentLanguage == .kor ? "ㄱㄴㄷ" : "ABC",main_color: textColor,main_textsize: return123TextSize, backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth),
            KeyModel(keyType: .space ,main_txt: currentLanguage == .kor ? "스페이스" : "Space",main_color: textColor,main_textsize: spaceTextSize, backgroundColor: backgroundColor)
            ,KeyModel(keyType: .returen,main_txt: "↵",main_color: textColor,main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth + key_width + 6)
        ]
    }

    func getSpecialLetter(_ currentLanguage:CurrentLanguage) -> [[KeyModel]]{
        return   [
            [KeyModel(keyType: .letter,lt_txt: "@",lt_color: textColor, lt_textsize: specialFontSize,backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "#",lt_color: textColor,backgroundColor: backgroundColor, height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "$",rb_txt: "￦",lt_color: textColor , lt_textsize: specialFontSize,rb_color: textColor,rb_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "%",lt_color: textColor, lt_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "^",lt_color: textColor, lt_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "&",lt_color: textColor,lt_textsize: specialFontSize, rb_color: textColor, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "*",lt_color: textColor, lt_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "+",rb_txt: "=",lt_color: textColor, lt_textsize: specialFontSize,rb_color: textColor,rb_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .delete,main_txt: "⌫",main_color: textColor ,backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width)],
            [KeyModel(keyType: .letter,lt_txt: "~",lt_color: textColor, lt_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "/",lt_color: textColor, lt_textsize: specialFontSize, backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: ":",rb_txt: ";",lt_color: textColor,rb_color: textColor ,rb_textsize: specialFontSize,backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "(",rb_txt: "<",lt_color: textColor,rb_color: textColor ,rb_textsize: specialFontSize,backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: ")",rb_txt: ">",lt_color: textColor,rb_color: textColor ,rb_textsize: specialFontSize,backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "[",rb_txt: "{",lt_color: textColor,rb_color: textColor, rb_textsize: specialFontSize,backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "]",rb_txt: "}",lt_color: textColor,rb_color: textColor ,rb_textsize: specialFontSize,backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: .letter,lt_txt: "|",rb_txt: "\\",lt_color: textColor,rb_color: textColor ,rb_textsize: specialFontSize,backgroundColor: backgroundColor,height:key_height, width: key_width),
             KeyModel(keyType: currentLanguage == .kor ? .kor : .eng ,main_txt: currentLanguage == .kor ? "Kor" : "Eng",main_color: textColor,main_textsize: engTextSize, backgroundColor: function_bg,selectBackgroundColor: function_bg,height:key_height, width: key_width)]
        ]
    }

    func getSpectialFuntion(_ currentLanguage:CurrentLanguage) -> [KeyModel]{
        return [
            KeyModel(keyType: .number,main_txt: "123",main_color: textColor,main_textsize: return123TextSize, backgroundColor: function_bg,selectBackgroundColor: .white,height: key_height, width: fuctionwidth),
            KeyModel(keyType: currentLanguage == .kor ? .kor : .eng,main_txt: currentLanguage == .kor ? "ㄱㄴㄷ" : "ABC",main_color: textColor,main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth),
            KeyModel(keyType: .space ,main_txt: currentLanguage == .kor ? "스페이스" : "Space",main_color: textColor,main_textsize: spaceTextSize,backgroundColor: backgroundColor)
            ,KeyModel(keyType: .returen,main_txt: "↵",main_color: textColor,main_textsize: return123TextSize,backgroundColor: function_bg,selectBackgroundColor: function_bg,height: key_height, width: fuctionwidth + key_width + 6)
        ]
    }
}


