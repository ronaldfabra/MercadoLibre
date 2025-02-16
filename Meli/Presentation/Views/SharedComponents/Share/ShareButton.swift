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
        Button(action: {
            onButtonPressed?()
        }, label: {
            Image(systemName: MeliConstants.Icons.share)
                .padding(MeliConstants.Dimens.spacing10)
        })
        .foregroundColor(Color.black)
        .background(Color.gray.opacity(0.2))
        .containerShape(.circle)
    }
}

#Preview {
    ShareButton()
}
