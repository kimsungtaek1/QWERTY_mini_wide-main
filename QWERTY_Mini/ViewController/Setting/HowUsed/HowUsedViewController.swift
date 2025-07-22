//
//  HowUsedViewController.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/11/25.
//

import Foundation
import UIKit
class HowUsedViewController:BaseViewController{
    
    let howusedView = HowUsedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func layout(){
        [howusedView].forEach{
            self.view.addSubview($0)
        }
        
        howusedView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    func attribute(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "키보드 사용방법"
    }
}
