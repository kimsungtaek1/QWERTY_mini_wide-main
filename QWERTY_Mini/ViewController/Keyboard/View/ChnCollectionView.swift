//
//  ChnTableView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/10/25.
//

import Foundation
import UIKit
import SnapKit

class ChnCollectionView:UICollectionViewCell{
    
    var hanjaEntry:HanjaEntry?
    var chn_btn_width:Constraint?
    let chn_Btn:UIButton = {
        let view = UIButton()
        view.setTitleColor(UIColor.black, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        view.backgroundColor = .clear
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
        [chn_Btn].forEach{
            self.contentView.addSubview($0)
        }
        
        chn_Btn.snp.makeConstraints{
            $0.top.equalTo(self.contentView.snp.top)
            $0.leading.equalTo(self.contentView.snp.leading)
            $0.trailing.equalTo(self.contentView.snp.trailing)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            chn_btn_width = $0.width.equalTo(100).constraint
        }
    }
    
    func setData(_ hanjaEntry:HanjaEntry){
        chn_Btn.setTitle("\(hanjaEntry.def) \(hanjaEntry.hanja)", for: .normal)
        self.hanjaEntry = hanjaEntry
        let textSize = chn_Btn.titleLabel?.text?.size(withAttributes: [.font:  UIFont.systemFont(ofSize: 16,weight: .medium)])

        chn_btn_width?.update(offset: (textSize?.width ?? 0) + 20)
        self.contentView.layoutIfNeeded()
        chn_Btn.sizeToFit()
    }
}
