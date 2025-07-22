//
//  UseAgreeView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/11/25.
//

import Foundation
import UIKit
import SnapKit
class UseAgreeView:UIView{
    
    let agreementText = """
    제1조(목적)

    이 약관은 ○○학원(이하 ‘학원’이라 합니다)과 학원이 제공하는 교습과정을 수강하는 자(이하 ‘수강자’라 합니다)간의 교습 및 수강에 관한 제반사항을 규정하는 것을 목적으로 합니다.

    제2조(관계법령)

    이 약관에 규정되지 아니한 사항 또는 이 약관의 해석에 관하여 다툼이 있는 사항에 대해서는 학원과 수강자가 합의하여 결정하되, 합의가 이루어지지 아니한 경우에는 학원의설립·운영및과외교습에관한법률, 약관의규제에관한법률, 할부거래에관한법률, 민법, 상법 등 관계법령 및 공정 타당한 일반관례에 따릅니다.

    제3조(게시의무)

    ① 학원은 수강자가 보기 쉬운 곳에 다음 각호의 사항을 게시합니다.

        1. 강사의 인적사항
        2. 교습과정(과목)의 현황과 개요
        3. 교습과정(과목)별 수강료 및 일체의 부대비용(교재대금, 실습재료비 등)
        4. 교습과정(과목)별 강의시간
        5. 이 약관
        6. 기타 수강자에게 필요한 사항

    ② 학원은 제1항 제3호의 규정에 의한 수강료 및 부대비용(이하 ‘수강료등’이라 합니다)을 허위로 게시하거나 이를 초과하여 징수하지 아니합니다.
    """

    let container:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#f7f7f7")
        return view
    }()
    
    lazy var label:UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        view.textColor = .black
        view.text = agreementText
        view.numberOfLines = 0
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
        [container].forEach{
            self.addSubview($0)
        }
        
        [label].forEach{
            container.addSubview($0)
        }
        
        container.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        label.snp.makeConstraints{
            $0.top.equalTo(container.snp.top).offset(20)
            $0.leading.equalTo(container.snp.leading).offset(20)
            $0.trailing.equalTo(container.snp.trailing).inset(20)
           // $0.bottom.equalTo(container.snp.bottom).inset(20)
        }
    }
}
