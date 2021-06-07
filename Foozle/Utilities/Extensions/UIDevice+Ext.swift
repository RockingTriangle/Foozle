//
//  UIDevice+Ext.swift
//  Foozle
//
//  Created by Mike Conner on 6/6/21.
//

import SwiftUI

extension UIDevice {
    static var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first(where: \.isKeyWindow)?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
