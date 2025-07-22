//
//  HowUsedView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/11/25.
//

import Foundation
import UIKit
import SnapKit
class HowUsedView:UIView{
    
    let imageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_howuse")
        return view
    }()
    
    let lable:UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        view.textColor = .black
        view.numberOfLines = 2
        view.textAlignment = .center
        
        let text = "버튼을 길게 눌러 QWERTY mini\n키보드를 선택해주세요."
        
        let attributed = NSMutableAttributedString(string: text)
        
        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.black,
            range: (text as NSString).range(of: "버튼을 길게 눌러 ")
        )
        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.systemBlue,
            range: (text as NSString).range(of: "QWERTY mini")
        )
        
        attributed.addAttribute(
            .foregroundColor,
            value: UIColor.black,
            range: (text as NSString).range(of: "키보드를 선택해주세요.")
        )
        view.attributedText = attributed
         
         
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
        [imageView,lable].forEach{
            self.addSubview($0)
        }
        
        imageView.snp.makeConstraints{
            $0.width.equalTo(393)
            $0.height.equalTo(316.32)
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY).offset(-100)
        }
        
        lable.snp.makeConstraints{
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY).offset(150)
        }
        
        
    }
}
