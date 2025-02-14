//
//  ProductDetailViewModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductDomainModel
    @Published var questionPaging: PagingDomainModel?
    @Published var isLoading: Bool = false
    @Published var error: NetworkErrorType = .none
    private let questionLimit: Int = 10
    
    private let getProductQuestionsUseCase: GetProductQuestionsUseCaseProtocol
    private let getProductDetailUseCase: GetProductDetailUseCaseProtocol
    private let getProductDescriptionUseCase: GetProductDescriptionUseCaseProtocol

    init(getProductQuestionsUseCase: GetProductQuestionsUseCaseProtocol,
         getProductDetailUseCase: GetProductDetailUseCaseProtocol,
         getProductDescriptionUseCase: GetProductDescriptionUseCaseProtocol,
         product: ProductDomainModel) {
        self.product = product
        self.getProductQuestionsUseCase = getProductQuestionsUseCase
        self.getProductDetailUseCase = getProductDetailUseCase
        self.getProductDescriptionUseCase = getProductDescriptionUseCase
        self.getProductData()
    }
    
    private func getProductData() {
        Task {
            do {
                await showLoading(true)
                async let detailResponse = try await getProductDetailUseCase.execute(productId: product.id)
                async let descriptionResponse = try await getProductDescriptionUseCase.execute(productId: product.id)
                async let questionResponse = try await getProductQuestionsUseCase.execute(
                    itemId: product.id,
                    limit: questionLimit,
                    offset: getNextOffsetForQuestions(limit: questionLimit)
                )
                try await self.processDetailResponse(detailResponse)
                try await self.processDescriptionResponse(descriptionResponse)
                try await self.processQuestionsResponse(questionResponse)
            } catch {
                await self.processError(error)
            }
        }
    }

    @MainActor
    private func resetData() {
        self.error = .none
        self.questionPaging = nil
    }
    
    @MainActor
    private func showLoading(_ show: Bool) {
        self.isLoading = show
    }
    
    @MainActor
    private func processDetailResponse(_ response: ProductDetailDomainModel) {
        self.product.pictures = (response.pictures ?? []).isEmpty ? self.product.pictures : response.pictures
        self.product.attributes = response.attributes.isEmpty ? self.product.attributes : response.attributes
        self.isLoading = false
    }
    
    @MainActor
    private func processDescriptionResponse(_ response: ProductDescriptionDomainModel) {
        self.product.productDescription = response.plainText
        self.isLoading = false
    }
    
    @MainActor
    private func processQuestionsResponse(_ response: ProductQuestionListDomainModel) {
        self.questionPaging = response.paging
        if response.paging.offset == .zero {
            self.product.questions = response.questions
        } else {
            self.product.questions?.append(contentsOf: response.questions)
        }
        self.isLoading = false
    }
    
    @MainActor
    private func processError(_ error: Error) {
        if let error = error as? NetworkErrorType {
            self.error = error
        } else {
            self.error = .unkown(error)
        }
        self.isLoading = false
    }
    
    private func getNextOffsetForQuestions(limit: Int) -> Int {
        if questionPaging?.offset ?? .zero + limit >= questionPaging?.total ?? .zero {
            return (questionPaging?.offset ?? .zero)
        } else {
            return (questionPaging?.offset ?? .zero) + limit
        }
    }
}

extension ProductDetailViewModel {
    func tryAgain() {
        Task {
            await resetData()
            getProductData()
        }
    }
}
