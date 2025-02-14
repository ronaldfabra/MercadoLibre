//
//  ToastManager.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//

import SwiftUI

class ToastManager: ObservableObject {
    @Published var message: String = .empty
    @Published var isVisible: Bool = false
    @Published var onTryAgainAction: (() -> Void)? = nil

    func showToast(message: String, fixed: Bool = false, onTryAgainAction: (() -> Void)? = nil) {
        self.message = message
        self.isVisible = true
        self.onTryAgainAction = onTryAgainAction

        if !fixed {
            hideToast(duration: 3)
        }
    }

    func hideToast(duration: CGFloat = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                self.isVisible = false
            }
            self.onTryAgainAction = nil
        }
    }
}
