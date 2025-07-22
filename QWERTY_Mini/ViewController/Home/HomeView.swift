//
//  HomeView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import Foundation
import UIKit
import SnapKit
class HomeView:UIView{
    
    let container_view:UIView = UIView()
    
    let logo_img:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "QWERTY_Logo")
        return view
    }()
    
    let setting_Label:UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        view.textColor = UIColor.black
        view.text = "키보드를 설정해주세요."
        return view
    }()
    
    let goToSetting_Btn:UIButton = {
        let view = UIButton()
        view.setTitle("키보드 설정으로 바로가기", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        view.backgroundColor = UIColor(hexString: "#3478F5")
        view.layer.cornerRadius = 10
        return view
        
    }()
    
    let setting_Btn:UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "ic_setting"), for: .normal)
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
        [container_view,setting_Btn].forEach{
            self.addSubview($0)
        }
        
        [logo_img,setting_Label,goToSetting_Btn].forEach{
            container_view.addSubview($0)
        }
        
        setting_Btn.snp.makeConstraints{
            $0.top.equalTo(self.snp.top).offset(10)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        container_view.snp.makeConstraints{
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
        }
        
        logo_img.snp.makeConstraints{
            $0.top.equalTo(container_view.snp.top)
            $0.centerX.equalTo(container_view.snp.centerX)
        }
        
        setting_Label.snp.makeConstraints{
            $0.top.equalTo(logo_img.snp.bottom).offset(120)
            $0.centerX.equalTo(container_view.snp.centerX)
        }
        
        goToSetting_Btn.snp.makeConstraints{
            $0.top.equalTo(setting_Label.snp.bottom).offset(30)
            $0.leading.equalTo(container_view.snp.leading).offset(20)
            $0.trailing.equalTo(container_view.snp.trailing).inset(20)
            $0.height.equalTo(56)
            $0.bottom.equalTo(container_view.snp.bottom)
        }
    }
}
