//
//  SkeletonView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct SkeletonView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .cornerRadius(MeliConstants.Dimens.spacing8)
            .shimmering()
    }
}

#Preview {
    SkeletonView()
        .frame(height: 40)
        .padding()
}
