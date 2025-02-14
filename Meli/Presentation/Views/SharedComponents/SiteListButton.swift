//
//  SiteListButton.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct SiteListButton: View {
    var options: [String] = []
    @Binding var selectedOption: String?
    @State private var isDropdownVisible = false

    var body: some View {
        HStack(spacing: MeliConstants.Dimens.spacing10) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(option) {
                        selectedOption = option
                        isDropdownVisible.toggle()
                    }
                }
            } label: {
                HStack {
                    Image(systemName: MeliConstants.Icons.site)
                    if let selectedOption {
                        Text(selectedOption)
                            .font(.system(size: MeliConstants.Values.value10,
                                          weight: .regular))
                    } else {
                        Text(MeliConstants.Strings.location)
                            .font(.system(size: MeliConstants.Values.value10,
                                          weight: .regular))
                    }
                    Image(systemName: MeliConstants.Icons.downArrow)
                }
                .padding(MeliConstants.Dimens.spacing8)
                .background(Capsule().stroke(Color.black, lineWidth: 1))
                .clipShape(Capsule())
                .onTapGesture {
                    isDropdownVisible.toggle()
                }
            }
        }
        .padding(MeliConstants.Dimens.spacing10)
        .foregroundStyle(Color.black)
    }
}

#Preview {
    @Previewable @State var selectedOption: String?
    SiteListButton(options: ["Option 1", "Option 2", "Option 3"],
                   selectedOption: $selectedOption)
}
