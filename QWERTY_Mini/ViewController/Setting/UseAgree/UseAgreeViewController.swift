//
//  UseAgreeViewController.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/11/25.
//

import Foundation
import UIKit

class UseAgreeViewController:BaseViewController{
    
    let useAgreeView = UseAgreeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    func layout(){
        [useAgreeView].forEach{
            self.view.addSubview($0)
        }
        
        useAgreeView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func attribute(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "서비스 이용약관"
    }
}
