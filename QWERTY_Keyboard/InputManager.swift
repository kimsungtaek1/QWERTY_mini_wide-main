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
    var lastKeyView: KeyView?
    var tapCount = 0
    var lastTapTime: Date?
    private let multiTapInterval: TimeInterval = 0.3
    
    // 동시탭 상태
   // private let simFirstKeys: Set<KeyType> = [.wq, .oKey]  // W-Q 키, O 키
    //private let simSecondKeys: Set<KeyType> = [.aKey, .lKey] // A 키, L 키
    
    private init() {}
    
    /// 단일 또는 연속탭 처리: 누른 키와 시간 기준으로 tapCount 증가 → 적절한 문자 반환
    func handleTap(on keyView: KeyView, _ currentState:KeyType, _ proxy:UITextDocumentProxy?, _ isShiftOn: Bool = false) -> String {
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
        
        
        
        
        switch tapCount % 2 {
        case 1 :
            if currentState == .letter{
                let char = keyView.keyModel?.lt_txt ?? ""
                // If shift is on and it's an alphabetic character, convert to uppercase
                if isShiftOn && char.count == 1 {
                    let scalar = char.unicodeScalars.first!
                    if CharacterSet.lowercaseLetters.contains(scalar) {
                        return char.uppercased()
                    }
                }
                return char
            }else if currentState == .number{
                return keyView.keyModel?.main_txt == "" ? keyView.keyModel?.lt_txt ?? "" : keyView.keyModel?.main_txt ?? ""
            }else if currentState == .spetial{
                return keyView.keyModel?.lt_txt ?? ""
            }else{
                return ""
            }
            
        case 0:
            if currentState == .letter{
                let char = keyView.keyModel?.rb_txt ?? ""
                // If shift is on and it's an alphabetic character, convert to uppercase
                if isShiftOn && char.count == 1 {
                    let scalar = char.unicodeScalars.first!
                    if CharacterSet.lowercaseLetters.contains(scalar) {
                        return char.uppercased()
                    }
                }
                return char
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
    
    /// 동시탭 처리: 두 개의 KeyModel 중 Sim 키가 어떤 역할인지 보고 primary/secondary 결정
    func handleSimultaneous(_ keyViews: [KeyView],_ currLanguage:CurrentLanguage) -> String? {
        guard keyViews.count == 2 else { return nil }
        
        return getSimultaneousKey(keyViews, currLanguage)
    }
    
    
    /// 특수 기능 키(지우기, 한영, 엔터, 특수문자, 스페이스, 시프트 등)인지 판별하는 함수
    private func isSpecialFunctionKey(_ keyView: KeyView?) -> Bool {
        guard let type = keyView?.keyModel?.keyType else { return false }
        // 필요에 따라 여기에 특수키를 추가하세요
        switch type {
        case .delete, .onshift, .lockshift, .space, .returen, .number, .spetial, .abc:
            return true
        default:
            return false
        }
    }
    
    func getSimultaneousKey(_ keyViews: [KeyView],_ currLanguage:CurrentLanguage) -> String? {
        // 동시탭된 두 키 중 하나라도 특수 기능 키라면, 문자 입력이 아닌 동작이므로 아무 문자도 반환하지 않음
        // (예: 지우기, 한영, 엔터, 특수문자, 스페이스, 시프트 등)
        if isSpecialFunctionKey(keyViews[0]) || isSpecialFunctionKey(keyViews[1]) {
            // 주니어 개발자 참고: 특수 기능 키는 동시탭 시 문자 입력이 되면 안 되므로 nil 반환
            return nil
        }
        
        print("first : \(keyViews[0].keyModel?.main_txt)" )
        print("second : \(keyViews[1].keyModel?.main_txt)" )
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
        
        
        return nil
    }
    
    func isEnglishOnly(_ text: String) -> Bool {
        let pattern = "^[A-Za-z]+$"
        return text.range(of: pattern, options: .regularExpression) != nil
    }
    
    
    func isEngKeyView(_ keyViews:[KeyView],_ value:String) -> Bool{
        
        return keyViews[0].keyModel?.lt_txt == value
    }
}

