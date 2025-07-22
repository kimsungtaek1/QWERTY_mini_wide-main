//
//  SettingView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import Foundation
import UIKit
import SnapKit
class SettingView:UIView{
    
    let logo_img:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "QWERTY_Logo")
        return view
    }()
    
    let howUseKeyboard_Btn:UIButton = {
        let view = UIButton()
        view.setTitle("키보드 사용 방법", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        view.backgroundColor = UIColor(hexString: "#3478F5")
        view.layer.cornerRadius = 10
        return view
        
    }()
    
    let previewKeyboard_Btn:UIButton = {
        let view = UIButton()
        view.setTitle("키보드 미리보기", for: .normal)
        view.setTitleColor(UIColor(hexString: "#3478F5"), for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#3478F5").cgColor
        view.layer.cornerRadius = 10
        return view
        
    }()
    
    let agree_SettingItemView:SettingBottomItemView = {
        let view = SettingBottomItemView()
        view.icon_Img.image = UIImage(named: "ic_lock")
        view._titleLabel.text = "이용약관 및 개인정보 보호"
        return view
    }()
    
    let share_SettingItemView:SettingBottomItemView = {
        let view = SettingBottomItemView()
        view.icon_Img.image = UIImage(named: "ic_share")
        view._titleLabel.text = "앱 공유하기"
        return view
    }()
    
    let systemSetting_SettingItemView:SettingBottomItemView = {
        let view = SettingBottomItemView()
        view.icon_Img.image = UIImage(named: "ic_small_setting")
        view._titleLabel.text = "시스템 설정 열기"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        [logo_img,howUseKeyboard_Btn,previewKeyboard_Btn,agree_SettingItemView,share_SettingItemView,systemSetting_SettingItemView].forEach{
            self.addSubview($0)
        }
        
        logo_img.snp.makeConstraints{
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY).offset(-100)
        }
        
        howUseKeyboard_Btn.snp.makeConstraints{
            $0.bottom.equalTo(previewKeyboard_Btn.snp.top).offset(-10)
            $0.leading.equalTo(self.snp.leading).offset(20)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
            $0.height.equalTo(56)
        }
        
        previewKeyboard_Btn.snp.makeConstraints{
            $0.bottom.equalTo(agree_SettingItemView.snp.top).offset(-30)
            $0.leading.equalTo(self.snp.leading).offset(20)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
            $0.height.equalTo(56)
        }
        
        agree_SettingItemView.snp.makeConstraints{
            $0.bottom.equalTo(share_SettingItemView.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(56)
        }
        
        share_SettingItemView.snp.makeConstraints{
            $0.bottom.equalTo(systemSetting_SettingItemView.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(56)
        }
        
        systemSetting_SettingItemView.snp.makeConstraints{
            $0.bottom.equalTo(self.snp.bottom).inset(20)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(56)
        }
    }
}
