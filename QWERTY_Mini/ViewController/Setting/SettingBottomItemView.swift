//
//  SettingBottomItem.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import Foundation
import UIKit
import SnapKit
class SettingBottomItemView:UIButton{
    
    var icon:UIImage?
    var title:String = ""
    
    let icon_Img:UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let _titleLabel:UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        view.textColor = UIColor.black
        return view
    }()
    
    let rightArrow_Img:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rightArrow")
        return view
    }()
    
    let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#E7E7E7")
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        [icon_Img,_titleLabel,rightArrow_Img,lineView].forEach{
            self.addSubview($0)
        }
        
        icon_Img.snp.makeConstraints{
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.equalTo(self.snp.leading).offset(20)
        }
        
        _titleLabel.snp.makeConstraints{
            $0.leading.equalTo(icon_Img.snp.trailing).offset(20)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        rightArrow_Img.snp.makeConstraints{
            $0.trailing.equalTo(self.snp.trailing).inset(20)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        lineView.snp.makeConstraints{
            $0.bottom.equalTo(self.snp.bottom)
            $0.height.equalTo(1)
            $0.leading.equalTo(self.snp.leading).offset(20)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
        }
    }
    
    func attribute(){
        icon_Img.image = icon
        _titleLabel.text = title
    }
}
