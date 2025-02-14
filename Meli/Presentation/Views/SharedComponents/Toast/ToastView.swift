//
//  ToastView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//

import SwiftUI

struct ToastView: View {
    @EnvironmentObject var toastManager: ToastManager
    private let toastAnimationDuration: Double = 0.3

    var body: some View {
        VStack {
            Spacer()
            if toastManager.isVisible {
                VStack {
                    HStack {
                        Text(toastManager.message)
                            .font(.system(size: MeliConstants.Values.value14,
                                          weight: .regular))
                        Spacer()
                        if let onTryAgainAction = toastManager.onTryAgainAction {
                            Button {
                                onTryAgainAction()
                            } label: {
                                Text(MeliConstants.Strings.tryAgain)
                                    .font(.system(size: MeliConstants.Values.value14,
                                                  weight: .medium))
                            }
                        }
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(MeliConstants.Dimens.spacing8)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: toastAnimationDuration), value: toastManager.isVisible)
                    .padding(.bottom, MeliConstants.Dimens.spacing40)
                    .edgesIgnoringSafeArea(.bottom)
                }
                .padding()
            }
        }
    }
}
