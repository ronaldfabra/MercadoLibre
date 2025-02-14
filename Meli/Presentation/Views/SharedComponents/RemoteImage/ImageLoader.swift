//
//  ImageLoader.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil

    private var cancellable: AnyCancellable?

    func load(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
