//
//  MeliConstants.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

struct MeliConstants {
    struct MeliURL {
        static let baseURL = "https://api.mercadolibre.com"
        static let imageBaseURL = "https://http2.mlstatic.com/D_"
        static let thumnailImageUrlExtension = "-I.jpg"
        static let originalImageUrlExtension = "-O.jpg"
        static let questionsApiVersion = 4

        struct Params {
            static let queryKey = "q"
            static let limitKey = "limit"
            static let offsetKey = "offset"
            static let itemKey = "item"
            static let apiVersionKey = "api_version"
        }
    }

    struct Strings {
        struct NetworkError {
            static let invalidURL = "The url seems to be incorrect, try again later."
            static let serverError = "Internal server error, try again later."
            static let invalidData = "Error in the data obtained, try again later."
            static let internetConnection = "The internet connection appears to be offline."
            static let general = "System error, try again later."
        }

        static let brandId = "BRAND"
        static let location = "location"
        static let by = "by %@"
        static let layoutType = "layout type"
        static let attributes = "Attributes"
        static let questions = "Questions"
        static let questionsAndAnswers = "Questions and answers"
        static let seeAllQuestions = "See all questions"
        static let description = "Description"
        static let whatYouNeedToKnowAboutThisProduct = "What you need to know about this product"
        static let seeAllAttributes = "See all attributes"
        static let sellerBy = "Seller by "
        static let buyNow = "Buy now"
        static let freeShipping = "Free shipping"
        static let `in` = "in "
        static let installmentText = "%d installments of %@ with %@ interest"
        static let discountOff = "%@ OFF"
        static let productDetail = "Product detail"
        static let favorites = "Favorites"
        static let searchProduct = "Search Product"
        static let tryAgain = "Try Again"
        static let colombiaSiteId = "MCO"

        struct EmptyState {
            struct Favorites {
                static let title = "No favorites yet"
                static let message = "Add your favorite products to see their details"
                static let addFavoriteHelper = "Browse our collection of products and click on "
                static let button = " button."
            }

            struct Search {
                static let title = "Search for your favorite product and you will find details about it."
            }
        }
    }

    struct Icons {
        static let favorite = "heart.fill"
        static let notFavorite = "heart"
        static let search = "magnifyingglass"
        static let list = "list.bullet"
        static let grid = "square.grid.2x2"
        static let site = "location"
        static let downArrow = "chevron.down"
        static let question = "questionmark.bubble"
        static let answer = "text.bubble"
        static let share = "paperplane"
    }

    struct Dimens {
        static let carouselHeight = 300.0
        static let productImageRowSize = 130.0
        static let spacing4 = 4.0
        static let spacing5 = 5.0
        static let spacing8 = 8.0
        static let spacing10 = 10.0
        static let spacing16 = 16.0
        static let spacing20 = 20.0
        static let spacing30 = 30.0
        static let spacing40 = 40.0
        static let spacing50 = 50.0
    }

    struct Values {
        static let value9 = 9.0
        static let value10 = 10.0
        static let value12 = 12.0
        static let value14 = 14.0
        static let value18 = 18.0
        static let value20 = 20.0
        static let value30 = 30.0
    }

    struct DateFormat {
        static let dateWithTime = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let onlyDate =  "dd-MM-yyyy"
    }
}
