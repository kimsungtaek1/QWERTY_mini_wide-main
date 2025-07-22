//
//  InputManager.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/8/25.
//

// ───────────────────────────────────────────────────────────────
// InputManager.swift
// ───────────────────────────────────────────────────────────────
import Foundation
import UIKit

/// KeyModel 에는 `primaryChar` / `secondaryChar` 속성이 있다고 가정합니다.
class InputManager {
    static let shared = InputManager()
    
    // 연속탭 상태
    private var lastKeyView: KeyView?
    var tapCount = 0
    private var lastTapTime: Date?
    private let multiTapInterval: TimeInterval = 0.3
    
    // 동시탭 상태
   // private let simFirstKeys: Set<KeyType> = [.wq, .oKey]  // W-Q 키, O 키
    //private let simSecondKeys: Set<KeyType> = [.aKey, .lKey] // A 키, L 키
    
    private init() {}
    
    /// 단일 또는 연속탭 처리: 누른 키와 시간 기준으로 tapCount 증가 → 적절한 문자 반환
    func handleTap(on keyView: KeyView, _ currentState:KeyType, _ proxy:UITextDocumentProxy? ) -> String {
        let now = Date()
        // 이전과 동일 키, 시간 간격 이내면 tapCount 증가
        if let last = lastKeyView,
           last.keyModel?.tag == keyView.keyModel?.tag,
           let lastTime = lastTapTime,
           now.timeIntervalSince(lastTime) < multiTapInterval {
            
            
            if keyView.isDoubleLetter(){
                tapCount += 1
            }else{
                tapCount = 1
            }
            
           
        } else {
            // 새로운 키 or 시간 초과 → 카운트 초기화
            lastKeyView = keyView
            tapCount = 1
        }
        lastTapTime = now
        
        // 1회 탭: primaryChar
        // 2회 탭: secondaryChar
        // 3회 탭 (경음용 확장) → 예외 처리 로직 추가 가능
        
        
        
        
        if currentState == .kor{
            
            if getThiredTapKey(keyView) != nil{
                switch tapCount % 3{
                case 1 :
                    if currentState == .kor{
                        return keyView.keyModel?.main_txt ?? ""
                    }else{
                        return ""
                    }
                    
                case 2:
                    if currentState == .kor{
                        return keyView.keyModel?.lt_txt == "" ? (keyView.keyModel?.main_txt ?? "") == "ㅅ" ? "ㅆ" : keyView.keyModel?.main_txt ?? "" :  keyView.keyModel?.lt_txt ?? ""
                    }else{
                        return ""
                    }
                case 0:
                    if currentState == .kor{
                        return getThiredTapKey(keyView) ?? ""
                    }else{
                        return ""
                    }
                default:
                    // 3회 이상은 필요에 따라 확장: 예) tertiaryChar
                    return ""
                }
            }else{
                switch tapCount % 2{
                case 1 :
        
                    if currentState == .kor{
                        return keyView.keyModel?.main_txt ?? ""
                    }else{
                        return ""
                    }
                    
                case 0:
                    if currentState == .kor{
                        return keyView.keyModel?.lt_txt == "" ? (keyView.keyModel?.main_txt ?? "") == "ㅅ" ? "ㅆ" : keyView.keyModel?.main_txt ?? "" :  keyView.keyModel?.lt_txt ?? ""
                    }else{
                        return ""
                    }
                default:
                    // 3회 이상은 필요에 따라 확장: 예) tertiaryChar
                    return ""
                }
            }
            
            
            switch tapCount % 3{
            case 1 :
                if currentState == .kor{
                    return keyView.keyModel?.main_txt ?? ""
                }else{
                    return ""
                }
                
            case 2:
                if currentState == .kor{
                    return keyView.keyModel?.lt_txt == "" ? (keyView.keyModel?.main_txt ?? "") == "ㅅ" ? "ㅆ" : keyView.keyModel?.main_txt ?? "" :  keyView.keyModel?.lt_txt ?? ""
                }else{
                    return ""
                }
            case 0:
                if currentState == .kor{
                    return keyView.keyModel?.lt_txt == "" ? (keyView.keyModel?.main_txt ?? "") == "ㅅ" ? "ㅆ" : keyView.keyModel?.main_txt ?? "" :  keyView.keyModel?.lt_txt ?? ""
                }else{
                    return ""
                }
            default:
                // 3회 이상은 필요에 따라 확장: 예) tertiaryChar
                return ""
            }
        }else{
            switch tapCount % 2 {
            case 1 :
                if currentState == .eng{
                    return keyView.keyModel?.lt_txt ?? ""
                }else if currentState == .number{
                    return keyView.keyModel?.main_txt == "" ? keyView.keyModel?.lt_txt ?? "" : keyView.keyModel?.main_txt ?? ""
                }else if currentState == .spetial{
                    return keyView.keyModel?.lt_txt ?? ""
                }else{
                    return ""
                }
                
            case 0:
                if currentState == .eng{
                    return keyView.keyModel?.rb_txt ?? ""
                }else if currentState == .number{
                    return keyView.keyModel?.rb_txt == "" ? keyView.keyModel?.main_txt ?? "" : keyView.keyModel?.rb_txt ?? ""
                }else if currentState == .spetial{
                    return keyView.keyModel?.rb_txt == "" ? keyView.keyModel?.lt_txt ?? "" : keyView.keyModel?.rb_txt ?? ""
                }else{
                    return ""
                }
            default:
                // 3회 이상은 필요에 따라 확장: 예) tertiaryChar
                return ""
            }
        }
        
        
    }
    
    /// 동시탭 처리: 두 개의 KeyModel 중 Sim 키가 어떤 역할인지 보고 primary/secondary 결정
    func handleSimultaneous(_ keyViews: [KeyView],_ currLanguage:CurrentLanguage) -> String? {
        guard keyViews.count == 2 else { return nil }
        
        return getSimultaneousKey(keyViews, currLanguage)
    }
    
    func getThiredTapKey(_ keyView:KeyView) -> String?{
        
            if keyView.keyModel?.main_txt == "ㅂ"{
                return "ㅃ"
            }
            
            if keyView.keyModel?.main_txt == "ㅈ"{
                return "ㅉ"
            }
            
            if keyView.keyModel?.main_txt == "ㄷ"{
                return "ㄸ"
            }
            
            if keyView.keyModel?.main_txt == "ㄱ"{
                return "ㄲ"
            }
            
           /* if keyView.keyModel?.main_txt == "ㅗ"{
                return "ㅙ"
            }
            
            if keyView.keyModel?.main_txt == "ㅏ"{
                return "ㅒ"
            }
            
            if keyView.keyModel?.main_txt == "ㅜ"{
                return "ㅞ"
            }
            
            if keyView.keyModel?.main_txt == "ㅓ"{
                return "ㅖ"
            }*/
            
            
        
        return nil
    }
    
    func getSimultaneousKey(_ keyViews: [KeyView],_ currLanguage:CurrentLanguage) -> String? {
        
        print("first : \(keyViews[0].keyModel?.main_txt)" )
        print("second : \(keyViews[1].keyModel?.main_txt)" )
        
        if currLanguage == .kor{
            if isKorKeyView(keyViews, "ㅡ"){
                if isSecondKorKeyView(keyViews, "ㅂ"){
                    return "ㅃ"
                }
                if isSecondKorKeyView(keyViews, "ㅈ"){
                    return "ㅉ"
                }
                if isSecondKorKeyView(keyViews, "ㄷ"){
                    return "ㄸ"
                }
                if isSecondKorKeyView(keyViews, "ㄱ"){
                    return "ㄲ"
                }
                if isSecondKorKeyView(keyViews, "ㅅ"){
                    return "ㅆ"
                }
                
            }
            
            if isKorKeyView(keyViews, "ㅣ"){
                if isSecondKorKeyView(keyViews, "ㅂ"){
                    return "ㅂ"
                }
                if isSecondKorKeyView(keyViews, "ㅈ"){
                    return "ㅈ"
                }
                if isSecondKorKeyView(keyViews, "ㄷ"){
                    return "ㄷ"
                }
                if isSecondKorKeyView(keyViews, "ㄱ"){
                    return "ㄱ"
                }
                if isSecondKorKeyView(keyViews, "ㅅ"){
                    return "ㅅ"
                }
                
                
            }
            
            if isKorKeyView(keyViews, "ㅎ"){
                if isSecondKorKeyView(keyViews, "ㅂ"){
                    return "ㅍ"
                }
                if isSecondKorKeyView(keyViews, "ㅈ"){
                    return "ㅊ"
                }
                if isSecondKorKeyView(keyViews, "ㄷ"){
                    return "ㅌ"
                }
                if isSecondKorKeyView(keyViews, "ㄱ"){
                    return "ㅋ"
                }
                
                
            }
            
            if isKorKeyView(keyViews, "ㅁ"){
                if isSecondKorKeyView(keyViews, "ㅗ"){
                    return "ㅛ"
                }
                if isSecondKorKeyView(keyViews, "ㅏ"){
                    return "ㅑ"
                }
                if isSecondKorKeyView(keyViews, "ㅜ"){
                    return "ㅠ"
                }
                if isSecondKorKeyView(keyViews, "ㅓ"){
                    return "ㅕ"
                }
               
                
            }
            
            if isKorShiftView(keyViews,.shift){
                if isSecondKorKeyView(keyViews, "ㅗ"){
                    return "ㅙ"
                }
                if isSecondKorKeyView(keyViews, "ㅏ"){
                    return "ㅒ"
                }
                if isSecondKorKeyView(keyViews, "ㅜ"){
                    return "ㅞ"
                }
                if isSecondKorKeyView(keyViews, "ㅓ"){
                    return "ㅖ"
                }
            }
            if (keyViews[0].keyModel?.main_txt ?? "") == "" && (keyViews[1].keyModel?.main_txt ?? "") == ""{
                return "\(keyViews[0].keyModel?.lt_txt ?? ""),\(keyViews[1].keyModel?.lt_txt ?? "")"
            }else{
                return "\(keyViews[0].keyModel?.main_txt ?? ""),\(keyViews[1].keyModel?.main_txt ?? "")"
            }
            
        }
        
        if currLanguage == .eng{
            if isEngKeyView(keyViews,"W") || isEngKeyView(keyViews, "O") || isEngKeyView(keyViews, "w") || isEngKeyView(keyViews, "o"){
                
                return keyViews[1].keyModel?.lt_txt
            }
            
            if isEngKeyView(keyViews,"A") || isEngKeyView(keyViews, "a") || isEngKeyView(keyViews, "L") || isEngKeyView(keyViews, "l"){
                
                if keyViews[1].keyModel?.rb_txt == "." || keyViews[1].keyModel?.rb_txt == ""{
                    return nil
                }else{
                    return keyViews[1].keyModel?.rb_txt
                }
            }
            
            if isEnglishOnly(keyViews[1].keyModel?.lt_txt ?? "") && isEnglishOnly(keyViews[0].keyModel?.lt_txt ?? ""){
                return keyViews[1].keyModel?.lt_txt
            }else{
                return "\(keyViews[0].keyModel?.lt_txt ?? ""),\(keyViews[1].keyModel?.lt_txt ?? "")"
            }
            
            
            
        }
        
        
        return nil
    }
    
    func isEnglishOnly(_ text: String) -> Bool {
        let pattern = "^[A-Za-z]+$"
        return text.range(of: pattern, options: .regularExpression) != nil
    }
    
    func isSecondKorKeyView(_ keyViews:[KeyView],_ value:String) -> Bool{
        if (keyViews[1].keyModel?.main_txt ?? "") == value{
            return true
        }
        
        return false
    }
    
    func isKorKeyView(_ keyViews:[KeyView],_ value:String) -> Bool{
        if (keyViews[0].keyModel?.main_txt ?? "") == value{
            return true
        }
        
        return false
    }
    
    func isKorShiftView(_ keyViews:[KeyView],_ keyType:KeyType) -> Bool{
        if keyViews[0].keyModel?.keyType == keyType{
            return true
        }
        
        return false
    }
    
    func isEngKeyView(_ keyViews:[KeyView],_ value:String) -> Bool{
        
        return keyViews[0].keyModel?.lt_txt == value
    }
}

