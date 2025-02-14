//
//  ShareButton.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct ShareButton: View {
    
    var onButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: MeliConstants.Dimens.spacing10) {
            Image(systemName: MeliConstants.Icons.share)
                .foregroundColor(Color.black)
        }
        .padding(MeliConstants.Dimens.spacing10)
        .onTapGesture {
            onButtonPressed?()
        }
        .background(Color.gray.opacity(0.2))
        .containerShape(.circle)
    }
}

#Preview {
    ShareButton()
}
