//
//  ViewController.swift
//  QWERTY_Mini
//
//  Created by 서명주 on 5/4/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
class HomeController: BaseViewController {

    let disposeBag = DisposeBag()
    let homeView = HomeView()
    let sharedDefaults = UserDefaults(suiteName: "group.com.example.QWERTYmini")
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
        bind()
        
    }
    
    func layout(){
        [homeView].forEach{
            self.view.addSubview($0)
        }
        
        homeView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func attribute(){
        
    }
    
    func bind(){
        homeView.setting_Btn.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_setting_Btn)
            .disposed(by: disposeBag)
        
        homeView.goToSetting_Btn.rx.tap
            .asObservable()
            .bind(to: self.rx.tap_gotoSetting)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

}

extension Reactive where Base:HomeController{
    var tap_setting_Btn:Binder<Void>{
        return Binder(base){base, _ in
            base.navigationController?.pushViewController(SettingViewController(), animated: true)
           
        }
    }
    
    var tap_gotoSetting:Binder<Void>{
        return Binder(base){base, _ in
            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
           
        }
    }
    
   
    
}

