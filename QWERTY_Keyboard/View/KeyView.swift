//
//  KeyView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/7/25.
//

import Foundation
import UIKit
import SnapKit

class KeyView: UIButton {
    
    var keyModel: KeyModel?
    var heightConstraint: Constraint?
    var widthConsraint: Constraint?
    
    let keyButton: UIView = {
        let button = UIView()
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .clear
        
        return button
    }()
    
    let blockview:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        view.layer.opacity = 0.3
        view.isHidden = true
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    let _imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    let lt_Label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textColor = .black
        return view
    }()
    
    let rt_Label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textColor = .black
        return view
    }()
    
    let rb_Label: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        view.textColor = UIColor(hexString: "#808080")
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
    
    func layout() {
        [keyButton, lt_Label, rt_Label, rb_Label,_imageView,blockview].forEach {
            self.addSubview($0)
        }
        
        keyButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lt_Label.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(2)
            $0.leading.equalTo(self.snp.leading).offset(4)
        }
        
        rb_Label.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(2)
            $0.trailing.equalTo(self.snp.trailing).inset(4)
        }
        
        rt_Label.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(4)
            $0.trailing.equalTo(self.snp.trailing).inset(4)
            $0.height.equalTo(20)
            $0.width.equalTo(10)
        }
        
        _imageView.snp.makeConstraints{
            $0.centerY.equalTo(self.snp.centerY)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalTo(26)
            $0.height.equalTo(28)
        }
        
        blockview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setSize(_ width: Float, _ height: Int) {
        print("resizeheight: \(height)")
        print("resizewidth: \(width)")
        
        heightConstraint?.deactivate()
        widthConsraint?.deactivate()
        
        self.snp.makeConstraints {
            self.widthConsraint = $0.width.equalTo(width).constraint
            self.heightConstraint = $0.height.equalTo(height).constraint
        }
    }
    
    
    func setData(_ _keyModel: KeyModel, _ returnType: UIReturnKeyType? = .default) {
        isSelected = false
        
        titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(_keyModel.main_textsize), weight: isHangul(_keyModel.main_txt) ? .medium : .light)
        
        lt_Label.text = _keyModel.lt_txt
        lt_Label.textColor = _keyModel.lt_color
        if _keyModel.lt_textsize != 0 {
            lt_Label.font = UIFont.systemFont(ofSize: CGFloat(_keyModel.lt_textsize),weight: isEnglishUppercase(_keyModel.lt_txt) ?  .medium : .regular )
        }
        
        rt_Label.text = _keyModel.rt_txt
        rt_Label.textColor = _keyModel.rt_color
        if _keyModel.rt_textsize != 0 {
            rt_Label.font = UIFont.systemFont(ofSize: CGFloat(_keyModel.rt_textsize))
        }
        
        rb_Label.text = _keyModel.rb_txt
        rb_Label.textColor = _keyModel.rb_color
        if _keyModel.rb_textsize != 0 {
            rb_Label.font = UIFont.systemFont(ofSize: CGFloat(_keyModel.rb_textsize),weight: isEnglishUppercase(_keyModel.lt_txt) ?  .medium : .regular)
        }
        
        if returnType == .search && (_keyModel.main_txt == "return" || _keyModel.main_txt == "↵") {
            if _keyModel.main_txt == "return" {
                setTitle("go", for: .normal)
            } else {
                setTitle("이동", for: .normal)
            }
            setBackgroundImage(UIImage(color: UIColor(hexString: "#007AFF")), for: .normal)
            setTitleColor(.white, for: .normal)
        } else {
            setTitle(_keyModel.main_txt, for: .normal)
            setTitleColor(_keyModel.main_color, for: .normal)
            keyButton.backgroundColor = _keyModel.backgroundColor
          //  keyButton.setBackgroundImage(UIImage(color: _keyModel.backgroundColor), for: .normal)
        }
       // keyButton.backgroundColor = _keyModel.backgroundColor
        //keyButton.setBackgroundImage(UIImage(color: _keyModel.selectBackgroundColor), for: .selected)
        
        if _keyModel.image != "" {
            let image = UIImage(named: _keyModel.image)?.withRenderingMode(.alwaysTemplate)
            let tintImg = image?.withTintColor(_overrideUserInterfaceStyle == .light ? .black : .white, renderingMode: .alwaysOriginal)
            _imageView.image = tintImg
           // setImage(tintImg, for: .normal)
        } else {
            _imageView.image = nil
           // setImage(nil, for: .normal)
        }
        
        if _keyModel.selectImage != "" {
            let image = UIImage(named: _keyModel.selectImage)?.withRenderingMode(.alwaysTemplate)
            let tintImage = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
            setImage(tintImage, for: .selected)
        } else {
            _imageView.image = nil
           // setImage(nil, for: .selected)
        }
        
        keyModel = _keyModel
        widthConsraint?.deactivate()
        heightConstraint?.deactivate()
        print("width : \(_keyModel.width)")
        
        self.snp.makeConstraints {
            if _keyModel.width != 0 {
                widthConsraint = $0.width.equalTo(_keyModel.width).constraint
            }
            
            if _keyModel.height != 0 {
                heightConstraint = $0.height.equalTo(_keyModel.height).constraint
            }
        }
        
        self.layoutIfNeeded()
        
        if _keyModel.keyType == .space {
            self.setContentHuggingPriority(.defaultLow, for: .horizontal)
            self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        } else if _keyModel.main_txt == "Chn" {
            self.setContentHuggingPriority(.sceneSizeStayPut, for: .horizontal)
            self.setContentCompressionResistancePriority(.sceneSizeStayPut, for: .horizontal)
        } else {
            self.setContentHuggingPriority(.required, for: .horizontal)
            self.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }
    
    func attribute() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        
        // shadowPath는 layoutSubviews에서 설정
      //  keyButton.addTarget(self, action: #selector(buttonTouchBegan), for: .touchDown)
       // keyButton.addTarget(self, action: #selector(buttonTouchEnded), for: .touchUpInside)
        //keyButton.addTarget(self, action: #selector(buttonTouchCancelled), for: .touchCancel)
    }
    
    @objc private func buttonTouchBegan() {
        // 버튼이 터치되면 KeyView의 touchesBegan을 직접 호출
        let touch = UITouch()
        let touches = Set<UITouch>([touch])
        self.touchesBegan(touches, with: nil)
    }
    
    @objc private func buttonTouchEnded() {
        // 버튼 터치가 끝나면 KeyView의 touchesEnded를 직접 호출
        let touch = UITouch()
        let touches = Set<UITouch>([touch])
        self.touchesEnded(touches, with: nil)
    }
    
    @objc private func buttonTouchCancelled() {
        // 버튼 터치가 취소되면 KeyView의 touchesCancelled를 직접 호출
        let touch = UITouch()
        let touches = Set<UITouch>([touch])
        self.touchesCancelled(touches, with: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowRect = CGRect(x: 2, y: self.bounds.height - 3, width: self.bounds.width - 4, height: 2)
        self.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 5).cgPath
    }
    
    func isDoubleLetter() -> Bool {
        var textCount = 0
        
        if keyModel?.main_txt == "ㅅ" {
            textCount += 1
        }
        
        if keyModel?.main_txt != "" {
            textCount += 1
        }
        
        if keyModel?.lt_txt != "" {
            textCount += 1
        }
        
        if keyModel?.rb_txt != "" && keyModel?.rb_txt != "." {
            textCount += 1
        }
        
        return textCount > 1
    }
    
    /// 문자열이 한글인지 판별하는 함수
    /// - Parameter str: 판별할 문자열
    /// - Returns: 한글이면 true, 아니면 false
    func isHangul(_ str: String) -> Bool {
        // 한글 유니코드 범위: AC00-D7A3 (완성형 한글), 1100-11FF (자모)
        let pattern = "^[가-힣ㄱ-ㅎㅏ-ㅣ]*$"
        return str.range(of: pattern, options: .regularExpression) != nil
    }
    
    /// 문자열이 영어 대문자인지 판별하는 함수
    /// - Parameter str: 판별할 문자열
    /// - Returns: 영어 대문자면 true, 아니면 false
    func isEnglishUppercase(_ str: String) -> Bool {
        // 영어 대문자 유니코드 범위: 41-5A (A-Z)
        let pattern = "^[A-Z]*$"
        return str.range(of: pattern, options: .regularExpression) != nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        blockview.isHidden = false
        super.touchesBegan(touches, with: event)
        self.next?.touchesBegan(touches, with: event)
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        
        
        blockview.isHidden = true
    }
    
    func setBackgroundColor(_ isSelect:Bool){
        keyButton.backgroundColor = isSelect ? keyModel?.selectBackgroundColor : keyModel?.backgroundColor
        
        if isSelect{
            let image = UIImage(named: keyModel!.selectImage)?.withRenderingMode(.alwaysTemplate)
            let tintImage = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
            
            _imageView.image = tintImage
            
        }else{
            let image = UIImage(named: keyModel!.image)?.withRenderingMode(.alwaysTemplate)
            let tintImg = image?.withTintColor(_overrideUserInterfaceStyle == .light ? .black : .white, renderingMode: .alwaysOriginal)
            
            _imageView.image = tintImg
        }
        
        
        
        
    }
}
