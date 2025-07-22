//
//  UIImage+Extention.swift
//  QWERTY_Keyboard
//
//  Created by 서명주 on 5/5/25.
//

import Foundation
import UIKit
extension UIImage {
    /// 주어진 색상으로 1×1 이미지 생성
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: cgImage)
    }
}
