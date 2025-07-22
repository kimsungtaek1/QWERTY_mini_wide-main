//
//  DictionaryAPI.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/9/25.
//
import Foundation
import UIKit
import SwiftSoup
import Alamofire

/// 한글(key)에 매핑되는 한자+뜻 한 쌍
struct HanjaEntry: Codable {
    let hanja: String
    let def: String
}

class HanjaManager{
    
    

    /// 전체 사전은 [kor: [HanjaEntry]]
    typealias HanjaDictionary = [String: [HanjaEntry]]
    
    //"仮":[{"kor":"가","def":"거짓"}
    static let shared:HanjaManager = HanjaManager()

    private(set) var dictionary: HanjaDictionary = [:]
        
        private init() {
            loadDictionary()
        }
        
        private func loadDictionary() {
            // 1) 번들에서 hanja.json URL 가져오기
            guard let url = Bundle.main.url(forResource: "hanja", withExtension: "js") else {
                assertionFailure("hanja.json not found in bundle")
                return
            }
            
            // 2) Data 로드 & 디코딩
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                dictionary = try decoder.decode(HanjaDictionary.self, from: data)
            } catch {
                print("❌ HanjaDictionary 로드 실패:", error)
            }
        }
        
        /// 주어진 kor(예: "가")에 대응하는 모든 한자 항목 반환
        func entries(for kor: String) -> [HanjaEntry]? {
            return dictionary[kor]
        }

 

}
