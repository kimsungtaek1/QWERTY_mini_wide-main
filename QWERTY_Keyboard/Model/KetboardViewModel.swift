//
//  KetboardModel.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/10/25.
//

import Foundation
import RxSwift
import RxCocoa
class KetboardViewModel{
    let hanjaEntryData:Signal<[HanjaEntry]>
    let getHanjaEntrygData = BehaviorRelay<[HanjaEntry]>(value:  [])
   
    init(){
        
        hanjaEntryData = getHanjaEntrygData
            .asSignal(onErrorJustReturn: [])
        
    }
    
    
}
