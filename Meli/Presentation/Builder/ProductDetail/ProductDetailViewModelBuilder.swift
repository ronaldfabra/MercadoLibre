//
//  ProductDetailViewModelBuilder.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//


struct ProductDetailViewModelBuilder {
    static func make(product: ProductDomainModel) -> ProductDetailViewModel {
        let questionRepository = QuestionRepository(network: Network.shared)
        let productRepository = ProductRepository(network: Network.shared)
        let getProductQuestionsUseCase = GetProductQuestionsUseCase(repository: questionRepository)
        let getProductDetailUseCase = GetProductDetailUseCase(repository: productRepository)
        let getProductDescriptionUseCase = GetProductDescriptionUseCase(repository: productRepository)
        let viewModel = ProductDetailViewModel(
            getProductQuestionsUseCase: getProductQuestionsUseCase,
            getProductDetailUseCase: getProductDetailUseCase,
            getProductDescriptionUseCase: getProductDescriptionUseCase,
            product: product
        )
        return viewModel
    }
}
