//
//  RemoteImageView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct RemoteImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    var url: URL
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.load(from: url)
        }
    }
}
