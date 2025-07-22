//
//  BaseViewController.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import Foundation
import UIKit
class BaseViewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1) 사용할 이미지를 준비 (Asset Catalog에 추가)
            let image = UIImage(named: "ic_leftArrow")?
                .withRenderingMode(.alwaysOriginal) //.tintColor 무시하고 원본 색상 유지

            // 2) UIBarButtonItem 생성
            let backButton = UIBarButtonItem(image: image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapBack))

            // 3) 왼쪽 버튼으로 설정
            navigationItem.leftBarButtonItem = backButton
        
        
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
