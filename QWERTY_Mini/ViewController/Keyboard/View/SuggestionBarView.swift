//
//  SuggestionBarView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/7/25.
//

import Foundation
import UIKit
import SnapKit
class SuggestionBarView:UIView{
    
    
    
    let downArrow = makeBarButton(systemName: "chevron.down")
    let upArrow = makeBarButton(systemName: "chevron.up")
    let done = makeTextBarButton("완료")
    
    private lazy var suggestionBar: UIStackView = {
        
        let spacer = UIView()
        
        let stack = UIStackView(arrangedSubviews: [downArrow, upArrow, spacer, done])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = UIColor(hexString: "#F3F3F8")
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        [suggestionBar].forEach{
            self.addSubview($0)
        }
        
        suggestionBar.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
            
        }
    }
    
    private static func makeBarButton(systemName: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: systemName), for: .normal)
        btn.tintColor = .label
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 24).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return btn
    }
    
    private static func makeTextBarButton(_ text: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    
    
    
}
