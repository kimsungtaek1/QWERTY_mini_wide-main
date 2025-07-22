//
//  SettingVIewController.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
class SettingViewController:BaseViewController{
    let disposeBag = DisposeBag()
    let settingView = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
        bind()
    }
    
    func layout(){
        [settingView].forEach{
            self.view.addSubview($0)
        }
        
        settingView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func bind(){
        settingView.howUseKeyboard_Btn.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_howUseKeyboard_Btn)
            .disposed(by: disposeBag)
        
        settingView.previewKeyboard_Btn.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_previewKeyboard_Btn)
            .disposed(by: disposeBag)
        
        settingView.agree_SettingItemView.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_agree_SettingItemView)
            .disposed(by: disposeBag)
        
        settingView.share_SettingItemView.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_share_SettingItemView)
            .disposed(by: disposeBag)
        
        settingView.systemSetting_SettingItemView.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_systemSetting_SettingItemView)
            .disposed(by: disposeBag)
    }
    
    func attribute(){
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        
    }
}

extension Reactive where Base:SettingViewController{
    var tap_howUseKeyboard_Btn:Binder<Void>{
        return Binder(base){base, _ in
            base.navigationController?.pushViewController(HowUsedViewController(), animated: true)
           
        }
    }
    
    var tap_previewKeyboard_Btn:Binder<Void>{
        return Binder(base){base, _ in
            base.navigationController?.pushViewController(KeyboardViewController(), animated: true)
           
        }
    }
    
    var tap_agree_SettingItemView:Binder<Void>{
        return Binder(base){base, _ in
            base.navigationController?.pushViewController(UseAgreeViewController(), animated: true)
           
        }
    }
    
    var tap_share_SettingItemView:Binder<Void>{
        return Binder(base){base, _ in
            let text  = "이 앱 정말 좋아요! 한 번 사용해보세요👇"
                    let url   = URL(string: "https://apps.apple.com/kr/app/앱스토어-앱ID")!
                    
                    // 2) 액티비티 아이템 배열에 넣기
                    let items: [Any] = [text, url]
                    
                    // 3) UIActivityViewController 생성
                    let activityVC = UIActivityViewController(activityItems: items,
                                                              applicationActivities: nil)
                    // 4) 제외할 액티비티(선택) — 원치 않는 공유 옵션을 빼고 싶을 때
                    activityVC.excludedActivityTypes = [
                        .addToReadingList,
                        .assignToContact,
                        .saveToCameraRoll
                    ]
                    
                    /*// 5) iPad용 = popover 출처 지정
                    if let pop = activityVC.popoverPresentationController {
                        pop.sourceView = sender
                        pop.sourceRect = sender.bounds
                    }*/
                    
                    // 6) 공유 시트 표시
            base.present(activityVC, animated: true)
           
        }
    }
    
    var tap_systemSetting_SettingItemView:Binder<Void>{
        return Binder(base){base, _ in
            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
           
        }
    }
    
    
    
   
    
}
