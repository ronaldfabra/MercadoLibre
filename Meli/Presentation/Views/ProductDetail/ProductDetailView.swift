//
//  ProductDetailView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    @EnvironmentObject var favoritesProductsViewModel: FavoritesProductsViewModel
    @EnvironmentObject var toastManager: ToastManager
    @State private var showShareSheet = false

    init(product: ProductDomainModel, dependencyContainer: DIContainerProtocol) {
        self._viewModel = StateObject(
            wrappedValue: dependencyContainer.getProductDetailViewModel(product: product)
        )
    }

    var body: some View {
        bodyView
            .navigationTitle(MeliConstants.Strings.productDetail)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(items: [viewModel.product.permalink])
            }
            .onChange(of: viewModel.error) { _, error in
                if error != .none {
                    toastManager.showToast(message: error.errorDescription,
                                           fixed: true) {
                        viewModel.tryAgain()
                    }
                } else {
                    toastManager.hideToast()
                }
            }
            .onDisappear {
                toastManager.hideToast()
            }
    }
}

// MARK: bodyView
extension ProductDetailView {
    private var bodyView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing16) {
                Text(viewModel.product.condition)
                    .font(.system(size: MeliConstants.Values.value18,
                                  weight: .medium))
                Text(viewModel.product.title)
                    .font(.system(size: MeliConstants.Values.value20,
                                  weight: .bold))
                carouselImages
                priceInformation
                shippingComponent
                buyNowButton
                sellerComponent
                productAttributes
                descriptionComponent
                productQuestions
            }
            .padding()
        }
    }
}

// MARK: carouselImages
extension ProductDetailView {
    var carouselImages: some View {
        ZStack(alignment: .topTrailing) {
            TabView {
                ForEach(viewModel.product.imagesCarousel) { image in
                    if let imageURL = URL(string: image.secureUrl) {
                        RemoteImageView(url: imageURL)
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: MeliConstants.Dimens.carouselHeight)
            VStack {
                FavoriteButton(isFavorite: favoritesProductsViewModel.isFavorite(productId: viewModel.product.id)) {
                    favoritesProductsViewModel.updateFavorite(product: viewModel.product)
                }
                Spacer()
                ShareButton() {
                    showShareSheet.toggle()
                }
            }
            .font(.system(size: MeliConstants.Values.value14))
        }
    }
}

// MARK: priceInformation
extension ProductDetailView {
    var priceInformation: some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing8) {
            if let originalPrice = viewModel.product.originalPrice?.toCurrency {
                Text(originalPrice)
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .light))
                    .foregroundColor(.gray)
                    .strikethrough()
            }
            HStack(spacing: MeliConstants.Dimens.spacing10) {
                Text(viewModel.product.price.toCurrency ?? .empty)
                    .font(.system(size: MeliConstants.Values.value18,
                                  weight: .medium))
                    .foregroundColor(.black)
                if let discountText = viewModel.product.discountText {
                    Text(String(format: MeliConstants.Strings.discountOff, discountText))
                        .font(.system(size: MeliConstants.Values.value10,
                                      weight: .medium))
                        .foregroundColor(.green)
                }
            }
            installmentComponent
        }
    }

    var installmentComponent: some View {
        VStack {
            if let installment = viewModel.product.installments {
                Text(MeliConstants.Strings.in)
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .regular))
                    .foregroundColor(.black)
                +
                Text(String(format: MeliConstants.Strings.installmentText,
                            installment.quantity,
                            installment.amount.toCurrency ?? .empty,
                            installment.rate.toPercentage ?? .empty)
                )
                .font(.system(size: MeliConstants.Values.value12,
                              weight: .regular))
                .foregroundColor(.green)
            }
        }
    }
}

// MARK: shippingComponent
extension ProductDetailView {
    var shippingComponent: some View {
        VStack {
            if viewModel.product.shipping.freeShipping {
                Text(MeliConstants.Strings.freeShipping)
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .medium))
                    .foregroundColor(.green)
            }
        }
    }
}

// MARK: buyNowButton
extension ProductDetailView {
    var buyNowButton: some View {
        Button(action: {}) {
            Text(MeliConstants.Strings.buyNow)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(MeliConstants.Dimens.spacing8)
        }
    }
}

// MARK: sellerComponent
extension ProductDetailView {
    private var sellerComponent: some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
            if let sellerNickName = viewModel.product.seller?.nickname {
                Text(MeliConstants.Strings.sellerBy)
                    .foregroundColor(.black)
                +
                Text(sellerNickName)
                    .foregroundColor(.blue)
                Divider()
            }
        }
        .font(.system(size: MeliConstants.Values.value12,
                      weight: .medium))
    }
}

// MARK: productAttributes
extension ProductDetailView {
    private var productAttributes: some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
            if !viewModel.product.attributes.isEmpty {
                attributesComponent(limit: 5)
                NavigationLink(destination: attributesView) {
                    Text(MeliConstants.Strings.seeAllAttributes)
                        .font(.system(size: MeliConstants.Values.value12,
                                      weight: .medium))
                        .foregroundColor(.blue)
                }
                Divider()
            }
        }
    }
}

// MARK: attributesComponent
extension ProductDetailView {
    private func attributesComponent(limit: Int? = nil) -> some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
            Text(MeliConstants.Strings.whatYouNeedToKnowAboutThisProduct)
                .font(.system(size: MeliConstants.Values.value18,
                              weight: .regular))
            VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing5) {
                ForEach(
                    viewModel.product.attributes
                        .prefix(limit ?? viewModel.product.attributes.count)
                ) { attribute in
                    if let name = attribute.name,
                       let value = attribute.value {
                        Group {
                            Text("· \(name.capitalized)")
                            +
                            Text(": \(value.capitalized)")
                        }
                        .font(.system(size: MeliConstants.Values.value12,
                                      weight: .regular))
                        .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

// MARK: descriptionComponent
extension ProductDetailView {
    var descriptionComponent: some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
            if let productDescription = viewModel.product.productDescription,
               !productDescription.isEmpty {
                Text(MeliConstants.Strings.description)
                    .font(.system(size: MeliConstants.Values.value18,
                                  weight: .regular))
                Text(productDescription)
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .regular))
                Divider()
            }
        }
    }
}

// MARK: productQuestions
extension ProductDetailView {
    var productQuestions: some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
            if let questions = viewModel.product.questions,
               !questions.isEmpty {
                questionsComponent(questions: questions, limit: 1)
                NavigationLink(destination: questionsView) {
                    Text(MeliConstants.Strings.seeAllQuestions)
                        .font(.system(size: MeliConstants.Values.value12,
                                      weight: .medium))
                        .foregroundColor(.blue)
                }
                Divider()
            }
        }
    }
}

// MARK: questionsComponent
extension ProductDetailView {
    private func questionsComponent(questions: [ProductQuestionDomainModel], limit: Int? = nil) -> some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing20) {
            Text(MeliConstants.Strings.questionsAndAnswers)
                .font(.system(size: MeliConstants.Values.value18,
                              weight: .regular))
            VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
                ForEach(questions.filter { $0.answer != nil }.prefix(limit ?? questions.count)) { question in
                    VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing10) {
                        HStack(alignment: .top) {
                            Image(systemName: MeliConstants.Icons.question)
                            Text(question.text)
                        }
                        .font(.system(size: MeliConstants.Values.value12,
                                      weight: .regular))
                        .foregroundColor(.black)
                        if let answer = question.answer {
                            HStack(alignment: .top) {
                                Image(systemName: MeliConstants.Icons.answer)
                                Text(answer.text)
                                +
                                Text(" \(answer.dateCreated.toOnlyDate ?? .empty)")
                            }
                            .padding([.leading, .trailing])
                            .font(.system(size: MeliConstants.Values.value12,
                                          weight: .regular))
                            .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}

// MARK: attributesView
extension ProductDetailView {
    var attributesView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            attributesComponent()
                .padding(.vertical)
        }
        .navigationTitle(MeliConstants.Strings.attributes)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: questionsView
extension ProductDetailView {
    var questionsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            questionsComponent(questions: viewModel.product.questions ?? [])
                .padding()
        }
        .navigationTitle(MeliConstants.Strings.questions)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView(
        product: .init(
            id: "MCO1520085331",
            title: "Moto G34 5g 256 Gb Negro Meteorito 8 Gb Ram Motorola",
            seller: .init(id: 0, nickname: "MELI"),
            price: 1799900,
            condition: "new",
            permalink: "https://www.mercadolibre.com.ar/p/MLA12866684",
            thumbnail: "http://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg",
            thumbnailId: "619757-MLU75370564956_042024",
            attributes: [.init(id: "BRAND", name: "Marca", value: "Motorola")],
            originalPrice: 2499000,
            installments: .init(quantity: 12, amount: 149992, rate: 0),
            officialStoreName: nil,
            shipping: .init(freeShipping: true),
            order: 0
        ),
        dependencyContainer: DIContainer.shared
    )
    .environmentObject(FavoritesProductsViewModelBuilder.make())
    .environmentObject(ToastManager())
}
