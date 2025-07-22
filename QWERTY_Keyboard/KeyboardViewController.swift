import UIKit
import RxSwift
import RxCocoa
//var userInterFaceStyle:UIUserInterfaceStyle?

var _overrideUserInterfaceStyle: UIUserInterfaceStyle = .light

class KeyboardViewController: UIInputViewController {

    lazy var proxy = textDocumentProxy
    let keyboardView = KeyboardView()
    let viewModel = KetboardViewModel()
    lazy var lastWidth = Float(view.bounds.width / 9) - 6
    let disposeBag = DisposeBag()
    private var registrationToken: Any?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheme()
        attribute()
        layout()
        bind(viewModel)
    }
    
    /// 입력창 진입/포커스 변경 시 키보드 상태를 초기화하는 함수
    func resetKeyboardState() {
        keyboardView.currentLanguage = .eng
        keyboardView.currentState = .letter
        keyboardView.composingLength = 0
        keyboardView.proxy?.unmarkText()
        InputManager.shared.tapCount = 0
        InputManager.shared.lastKeyView = nil
        InputManager.shared.lastTapTime = nil
        keyboardView.changeLetter(KeyLetter.shared.getEngLetter())
        keyboardView.changeFunction(KeyLetter.shared.getEngFunction())
        keyboardView.keyviews.removeAll()
    }
    
    func updateTheme() {
        _overrideUserInterfaceStyle = traitCollection.userInterfaceStyle
        KeyLetter.shared.setColor()
        // 뷰를 새로고침하여 테마 변경을 즉시 반영합니다.
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: 0)
    }
    


    // MARK: - Layout

    func layout(){
        [keyboardView].forEach{
            self.view.addSubview($0)
        }
        
        keyboardView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func attribute(){
        keyboardView.proxy = proxy
        //userInterFaceStyle = self.overrideUserInterfaceStyle
    }
    
    func bind(_ viewModel:KetboardViewModel){
        keyboardView.bind(viewModel)
        
        /*keyboardView.suggestionBarView.done.rx.tap
            .asObservable()
            .bind{ _ in
                self.view.endEditing(true)
            }.disposed(by: disposeBag)*/
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면이 나타날 때마다 키보드 크기 업데이트
        DispatchQueue.main.async { [weak self] in
            self?.sizeChange()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 화면이 완전히 나타난 후 한 번 더 크기 업데이트
        DispatchQueue.main.async { [weak self] in
            self?.sizeChange()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }
            self.sizeChange()
        }) { [weak self] _ in
            guard let self = self else { return }
            // 회전 완료 후 한 번 더 크기 조정
            DispatchQueue.main.async {
                self.sizeChange()
            }
        }
    }
    
    func sizeChange() {
        // 키보드 뷰 업데이트
        self.keyboardView.reSizeButtons()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    
    override func textWillChange(_ textInput: UITextInput?) {
        super.textWillChange(textInput)
        // 새로운 입력 세션이 시작될 때마다 내부 조합 버퍼를 초기화
        print("textWillChange")
        resetKeyboardState() // ← 상태 초기화
    }

    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)

        // 전송 버튼 누른 뒤 카톡이 입력 필드를 비워버리면
        // documentContextBeforeInput 이 빈 문자열이 됩니다.
        if let before = proxy.documentContextBeforeInput,
           before.isEmpty {
            // ⇒ 전송 이벤트로 간주하고 버퍼 초기화
            print("시바")
            keyboardView.commitText()
          //  keyboardView.composingLength = 0
        }else{
            keyboardView.commitText()
        }
    }
    
    override func selectionDidChange(_ textInput: (any UITextInput)?) {
        super.selectionDidChange(textInput)
        print("selectionDidChange")
    }
    
    override func selectionWillChange(_ textInput: (any UITextInput)?) {
        super.selectionWillChange(textInput)
        print("selectionWillChange")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateTheme()
            keyboardView.setNeedsLayout()
            keyboardView.layoutIfNeeded()
        }
    }


    // MARK: - Height

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
}
