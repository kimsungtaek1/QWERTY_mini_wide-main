//
//  KeyboardView.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import Foundation
import UIKit
import SnapKit
import QWERTY_Keyboard
import RxSwift
import RxCocoa

class KeyboardView:UIView{
    // MARK: - UI Elements

    var currentLanguage:CurrentLanguage = .eng
    var currentState:KeyType = .letter
    let disposeBag = DisposeBag()
    var proxy:UITextDocumentProxy?
     var composingLength = 0
    
    var viewModel:KetboardViewModel?
    
    
    
    /// Shift 더블클릭 잠금용: 마지막 Shift 키 탭 시각
        var lastShiftTapTimestamp: TimeInterval = 0
        /// 더블탭으로 인식할 최대 간격 (초)
        let shiftLockInterval: TimeInterval = 0.5
    
    
    
    let keyboardContainer = UIView()
    
    var keyviews:[KeyView] = []

    private var deleteLongPressTimer: Timer?

    //let suggestionBarView = SuggestionBarView()
    
    
    lazy var letterStackView:UIStackView = {
        var tag_num = 0
        let rows = KeyLetter.shared.getEngLetter().map { keyModels -> UIStackView in
            let row = UIStackView()
            row.axis = .horizontal
            row.distribution = .fillEqually
            row.alignment = .fill
            row.spacing = 3
            row.translatesAutoresizingMaskIntoConstraints = false

            for model in keyModels {
                let keyView = KeyView()
                keyView.setData(model)
                keyView.tag = tag_num
                if model.keyType == .delete{
                    let lp = UILongPressGestureRecognizer(target: self, action: #selector(handleDeleteLongPress(_:)))
                                    lp.minimumPressDuration = 0.4  // 길게 누름 인식 시간
                                    keyView.addGestureRecognizer(lp)
                }
                
                
                
                keyView.addTarget(self,action: #selector(keyTapped(_:)),for: .touchUpInside)
                
                row.addArrangedSubview(keyView)
            }
            return row
        }
        
        let view = UIStackView(arrangedSubviews: rows)
        view.axis = .vertical
        view.distribution = .fillEqually  // ensures all rows equal height
        view.alignment = .fill
        view.spacing = 13
        return view
    }()
    
    
    lazy var functionStackView:UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        view.translatesAutoresizingMaskIntoConstraints = false

        for model in KeyLetter.shared.getEngFunction() {
            let keyView = KeyView()
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1){
                keyView.setData(model,self.proxy?.returnKeyType)
            }
            
            keyView.addTarget(self,action: #selector(keyTapped(_:)),for: .touchUpInside)
            view.addArrangedSubview(keyView)
        }
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
    private func layout() {
        [keyboardContainer].forEach{
            self.addSubview($0)
        }
        
        [letterStackView,functionStackView].forEach{
            keyboardContainer.addSubview($0)
        }
        

        keyboardContainer.snp.makeConstraints{
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
           // $0.height.equalTo(300)
        }
        

        letterStackView.snp.makeConstraints{
            $0.top.equalTo(keyboardContainer.snp.top).offset(13)
            $0.leading.equalTo(keyboardContainer.snp.leading).offset(4)
            $0.trailing.equalTo(keyboardContainer.snp.trailing).inset(4)
        }
        
        functionStackView.snp.makeConstraints{
            $0.top.equalTo(letterStackView.snp.bottom).offset(13)
            $0.leading.equalTo(keyboardContainer.snp.leading).offset(4)
            $0.trailing.equalTo(keyboardContainer.snp.trailing).inset(4)
            $0.bottom.equalTo(keyboardContainer.snp.bottom).inset(4)
        }
        
        
    }
    
    func bind(_ viewModel:KetboardViewModel){
        self.viewModel = viewModel
    }
    
    
    // 롱프레스 상태에 따라 타이머 시작/종료
        @objc private func handleDeleteLongPress(_ gesture: UILongPressGestureRecognizer) {
            switch gesture.state {
            case .began:
                // 0.1초 간격으로 반복 삭제
                deleteLongPressTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                                            target: self,
                                                            selector: #selector(repeatDelete),
                                                            userInfo: nil,
                                                            repeats: true)
            case .ended, .cancelled, .failed:
                deleteLongPressTimer?.invalidate()
                deleteLongPressTimer = nil
            default:
                break
            }
        }
    
    // 실제 반복 삭제 로직 (기존 .delete 케이스 로직 그대로 옮겨오기)
       @objc private func repeatDelete() {
           guard let proxy = proxy else { return }
           if composingLength > 0 {
               // 조합 중이면 조합 해체 후 재삽입
              /* for _ in 0..<composingLength {
                   proxy.deleteBackward()
               }*/
               // Just delete one character for English
               proxy.deleteBackward()
               composingLength = 0
           } else {
               // 일반 백스페이스
               proxy.deleteBackward()
           }
       }

       // 뷰 해제 시 타이머 정리
       deinit {
           deleteLongPressTimer?.invalidate()
       }
    
    func reSizeButtons(){
        for stackView in letterStackView.arrangedSubviews{
            let st = stackView as! UIStackView
            
            for keyView in st.arrangedSubviews{
                let _keyView = keyView as! KeyView
                _keyView.setSize(KeyLetter.shared.key_width, KeyLetter.shared.key_height)
            }
        }
        
       
        for keyView in functionStackView.arrangedSubviews{
                let _keyView = keyView as! KeyView
            if _keyView.keyModel?.keyType == .space{
                _keyView.setSize(KeyLetter.shared.calculateKeyboardWidth() - KeyLetter.shared.fuctionwidth * 4, KeyLetter.shared.key_height)
            }else{
                _keyView.setSize(KeyLetter.shared.fuctionwidth, KeyLetter.shared.key_height)
            }
                
            }
        
    }
    
    
    
    func attribute(){
       keyboardContainer.backgroundColor = .systemGray4
        isMultipleTouchEnabled = true
        keyboardContainer.backgroundColor = _overrideUserInterfaceStyle == .light ? UIColor(hexString: "#d0d5dc") : UIColor(hexString: "#2c2d2c")
       /* DispatchQueue.main.async {
            self.textField.becomeFirstResponder()
          }*/
    }
    
    /// 2) 단일/연속탭 처리
    @objc private func keyTapped(_ sender: KeyView) {
        Observable.just(sender)
               .bind(to: self.rx.tab_key)
               .disposed(by: disposeBag)
       }
    
        
    // MARK: – Override touchesBegan to detect order
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // 현재 활성화된 모든 터치를 가져옵니다
        let activeTouches = touches.union(event?.allTouches ?? Set<UITouch>())
            .filter { $0.phase == .began || $0.phase == .moved || $0.phase == .stationary }
        
        // 2개 이상의 터치가 있을 때만 동시 입력 처리
        if activeTouches.count >= 2 {
            // 터치 시간순으로 정렬
            let sortedTouches = activeTouches.sorted { $0.timestamp < $1.timestamp }
            
            // 첫 두 터치의 위치에서 KeyView를 찾습니다
            if let keyA = hitTest(sortedTouches[0].location(in: self), with: nil) as? KeyView,
               let keyB = hitTest(sortedTouches[1].location(in: self), with: nil) as? KeyView {
                keyviews = [keyA, keyB]
                performSimultaneousInput()
            }
        } else {
            keyviews.removeAll()
        }
    }
    
    
    
    // 2) touchesEnded 에서 남은 터치가 한 개일 때, 그 키를 다시 입력으로 처리
       override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesEnded(touches, with: event)
           guard let all = event?.allTouches else { return }
           // ended/cancelled 가 아닌 '현재' 터치만
           let active = all.filter { $0.phase == .began || $0.phase == .moved || $0.phase == .stationary }
           if active.count == 1 {
               // 한 손가락만 남았으니 그 키 하나를 일반 터치처럼 처리
               let touch = active.first
               if let key = hitTest(touch!.location(in: self), with: nil) as? KeyView {
                   performSingleInput(on: key)
               }
           }
       }

       override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
           // touchesEnded 와 동일하게 처리
           touchesEnded(touches, with: event)
       }

       // 3) 두 손가락 입력 로직을 분리
       private func performSimultaneousInput() {
           guard let ch = InputManager.shared.handleSimultaneous(keyviews, currentLanguage) else {
               return
            }
           
           let split = ch.split(separator: ",")
           print("splite : \(split)")
           if split.count > 0{
               for i in 0...(split.count - 1){
                   proxy?.insertText(String(split[i]))
               }
           }
       }

       // 4) 한 손가락 입력 로직을 분리
       private func performSingleInput(on keyView: KeyView) {
           let isShiftOn = isShiftActive()
           let ch = InputManager.shared.handleTap(on: keyView, currentState, proxy, isShiftOn)
           // 영문·특수문자 등 단일 입력
           composingLength = 0
           proxy?.unmarkText()
           proxy?.insertText(ch)
       }
    
    
    
    
    
    func commitText(){
        
        composingLength = 0
        proxy?.unmarkText()
        
    }
    
    
    func changeLetter(_ letters:[[KeyModel]]){
        for i in 0..<letterStackView.arrangedSubviews.count{
            let stackView = letterStackView.arrangedSubviews[i] as! UIStackView
            for j in 0..<stackView.arrangedSubviews.count{
                let keyView = stackView.arrangedSubviews[j] as! KeyView
                keyView.setData(letters[i][j])
            }
        }
    }
    
    func changeFunction(_ letters:[KeyModel]){
        for i in 0..<functionStackView.arrangedSubviews.count{
            let keyView = functionStackView.arrangedSubviews[i] as! KeyView
            keyView.isHidden = false
            if letters.count - 1 < i{
                keyView.isHidden = true
            }else{
                keyView.setData(letters[i],proxy?.returnKeyType)
            }
            
            
        }
    }
    
    func isShiftActive() -> Bool {
        for i in 0..<functionStackView.arrangedSubviews.count{
            let keyView = functionStackView.arrangedSubviews[i] as! KeyView
            if keyView.keyModel?.keyType == .onshift || keyView.keyModel?.keyType == .lockshift {
                return true
            }
        }
        return false
    }
    
}

extension Reactive where Base:KeyboardView{
    
    
    
    var tab_key:Binder<KeyView>{
        return Binder(base){base, view in
            
            switch view.keyModel?.keyType {
            case .none:
                break
            case .lockshift:
                
                if base.keyviews.count > 1{
                    return
                }
                view.keyModel?.keyType = .shift
                view.setBackgroundColor(false)
                changeLetter(KeyLetter.shared.getEngLetter())
                break
            case .letter:
                if base.keyviews.count < 2{
                    tap_Letter(view)
                }
                
                // Don't reset shift - keep it active
                // Only reset shift if it's not in lock mode
                // if !isShiftLocked() {
                //     resetShift()
                // }
                break
            case .space:
                commitText()
                    base.proxy?.insertText(" ") // 공백 삽입
               
                break
            case .delete:
                // Simple delete for English keyboard
                base.proxy?.deleteBackward()
                base.composingLength = 0
                break
            case .number:
                commitText()
                base.currentState = .number
                changeLetter(KeyLetter.shared.getNumberLetter(.eng))
                changeFunction(KeyLetter.shared.getNumberFuntion(.eng))
                break
            case .abc:
                commitText()
                base.currentState = .letter
                changeLetter(KeyLetter.shared.getEngLetter())
                changeFunction(KeyLetter.shared.getEngFunction())
                break
            case .spetial:
                base.currentState = .spetial
                changeLetter(KeyLetter.shared.getSpecialLetter(.eng))
                changeFunction(KeyLetter.shared.getSpectialFuntion(.eng))
                break
            case .shift:
                
                
                // 첫 탭: Shift 활성화 (한 글자만 대문자/겹자음)
                  guard base.keyviews.count < 2 else { return }
                  view.keyModel?.keyType = .onshift
                view.setBackgroundColor(true)
                  // Shift 글자셋으로 변경
                  changeLetter(KeyLetter.shared.getEngShiftLetter())
                  // 더블클릭 잠금 판정용 타임스탬프 저장
                  base.lastShiftTapTimestamp = Date().timeIntervalSince1970
                  break
                
                
            case .onshift:
               
                
                // 두 번째 탭: 순간 간격이 짧으면 Lock 모드로, 아니면 해제 모드로
               guard base.keyviews.count < 2 else { return }
               let now = Date().timeIntervalSince1970
               if now - base.lastShiftTapTimestamp < base.shiftLockInterval {
                   // ▶ 더블클릭: Shift 고정 (Lock)
                   view.keyModel?.keyType = .lockshift
                   view.setBackgroundColor(true)
               } else {
                   // ▶ 일반 탭: Shift 해제
                   view.keyModel?.keyType = .shift
                   view.setBackgroundColor(false)
                   changeLetter(KeyLetter.shared.getEngLetter())
               }
               // 다음 탭 판단을 위해 타임스탬프 갱신
               base.lastShiftTapTimestamp = now
                
                break
            case .returen:
                commitText()
              //  base.composer.reset()
                base.proxy?.insertText("\n")
                
                break
            case .some(.none):
                break
            }
                
            
        }
    }
    
    var logTab_Key:Binder<KeyType>{
        return Binder(base){base, keyType in
            
            switch keyType{
            
            case .none:
                break
            case .letter:
                break
            case .space:
                break
            case .delete:
                break
            case .number:
                break
            case .abc:
                break
            case .spetial:
                break
            case .shift:
                break
            case .onshift:
                break
            case .returen:
                break
            case .lockshift:
                break
            }
                
            
        }
    }
    
    
    
    func commitText(){
            base.composingLength = 0
            base.proxy?.unmarkText()
    }
    
    
    
    func changeLetter(_ letters:[[KeyModel]]){
        for i in 0..<base.letterStackView.arrangedSubviews.count{
            let stackView = base.letterStackView.arrangedSubviews[i] as! UIStackView
            for j in 0..<stackView.arrangedSubviews.count{
                let keyView = stackView.arrangedSubviews[j] as! KeyView
                keyView.setData(letters[i][j])
            }
        }
    }
    
    func changeFunction(_ letters:[KeyModel]){
        for i in 0..<base.functionStackView.arrangedSubviews.count{
            let keyView = base.functionStackView.arrangedSubviews[i] as! KeyView
            keyView.isHidden = false
            if letters.count - 1 < i{
                keyView.isHidden = true
            }else{
                keyView.setData(letters[i],base.proxy?.returnKeyType)
            }
            
            
        }
    }
    
    func isShiftLocked() -> Bool {
        for i in 0..<base.functionStackView.arrangedSubviews.count{
            let keyView = base.functionStackView.arrangedSubviews[i] as! KeyView
            if keyView.keyModel?.keyType == .lockshift {
                return true
            }
        }
        return false
    }
    
    func resetShift(){
        for i in 0..<base.functionStackView.arrangedSubviews.count{
            let keyView = base.functionStackView.arrangedSubviews[i] as! KeyView
            if keyView.keyModel?.keyType == .onshift{
                keyView.keyModel?.keyType = .shift
                keyView.setBackgroundColor(false)
                changeLetter(KeyLetter.shared.getEngLetter())
            }
            
            
        }
    }
    
    func tap_Letter(_ keyView:KeyView){
       // print(base.currentState)
        let isShiftOn = base.isShiftActive()
        let ch = InputManager.shared.handleTap(on: keyView,base.currentState,base.proxy, isShiftOn)
        
        // 연속 탭인 경우 이전 문자를 지우고 새 문자로 교체
        if InputManager.shared.tapCount > 1 {
            base.proxy?.deleteBackward()
        }
        
        base.composingLength = 0
        // 1) 조합 중인 marked text를 커밋(확정)시키고 해제
        base.proxy?.unmarkText()
        
        base.proxy?.insertText(ch)
        
               // delegate?.insert(text: ch)
    }
    
    
    
    
    
}
