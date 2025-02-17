//
//  RemoteImageView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct RemoteImageView: View {
    var url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .failure:
                EmptyView()
            case .success(let image):
                image
                    .resizable()
            default:
                ProgressView()
            }
        }
    }
}
