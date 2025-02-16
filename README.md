# MercadoLibre

[![Build](https://github.com/ronaldfabra/MercadoLibre/actions/workflows/build.yml/badge.svg)](https://github.com/ronaldfabra/MercadoLibre/actions/workflows/build.yml)

[![codecov](https://codecov.io/gh/ronaldfabra/MercadoLibre/branch/master/graph/badge.svg?token=3G8XLZ41UJ)](https://codecov.io/gh/ronaldfabra/MercadoLibre)

Meli is an application for Mercado Libre to list products and can see the product details.

## Prerequisites

Before running the project, make sure to set up the project correctly.

1. Clone the repository.
2. After cloning the repository, open **Meli.xcodeproj** file at the root of the project.
3. After open **Meli.xcodeproj** file you are ready to build and run the project.

   
## Architecture

The project follows the Clean Architecture approach, using also the DI pattern ensuring high cohesion and low coupling through layer separation:

- Data Layer: Groups components associated with different data sources to get the data like network and local database using Swift Data, such as mappers, response models (Dto), endpoints and repositories.
- DIContainer: Contains a class to get the app viewmodels and handle the dependency injection.
- Domain Layer: Contains business specifications with different use cases, and domain models.
- Extensions: Contains some class extensions to handle the data.
- Presentation Layer: Contains the desing patterns, functionality modules and shared components used in all the application.
- Utils: Contain some util funcitonalities to process and handle the data.

## Design Pattern

The project follows the MVVM, Adapter, Builder and Strategy ensuring separation of responsibilities, better maintenance and testing of business logic:

- Adapters Layer: Contains the logic that allows a class or interface that is not compatible with another to be adapted so that they can work together..
- Builder Layer: Contains the logic that allows to create complex objects step by step, which is useful when you need to instantiate objects that have many properties as ViewModels.
- Strategy Layer: Contains the logic that allows changing the behavioral logic of an algorithm at runtime, which is ideal for situations where different behaviors or strategies must be interchangeable in this case to display the product as row list or grid list.

## Dependency Injection

The project uses Dependency Injection (DI) to facilitate layer separation, following the principle of dependency inversion. This prevents the domain layer from having direct references to the data layer, making the code easier to test and maintain. The DI is handle using the Builder desing pattern, which is to efficiently to handle the memory leak when have too many class instances.

## Unit test
Unit tests have been implemented for viewModels, use cases, repositories, database container, and utils as these components contain most of the project's logic.

## UI test
UI tests have been implemented for the views to ensure to have the expected components.

## API
- **URL base**: `https://api.mercadolibre.com`
- **Api version for questions service **: `4`
- **Available Services**:
    - Sites: `GET /sites`
    - Search Products: `GET /sites/{siteId}/search?q={query}&limit={limit}&offset={offset}`
    - Product Detail: `GET /items/{itemId}`
    - Product Description: `GET /items/{itemId}/description`
    - Product Questions: `GET /questions/search?item={itemId}&limit={limit}&offset={offset}&api_version={questionApiVersion}`
 
## Continuous Integration (CI) with GitHub Actions
A CI pipeline has been integrated using GitHub Actions to automatically validate the project. This pipeline performs the following tasks:

- **Runs Unit Tests**: Verifies that all tests pass correctly.
- **Checks Code Coverage with Codecov**: Generates a test coverage report and ensures that defined thresholds are met. this coverage can be find in `https://app.codecov.io/gh/ronaldfabra/MercadoLibre`

## Pipeline local with pipeline.sh

In addition to the GitHub Actions pipeline, you can run the same CI process locally using a **run_tests.sh** script. This script will perform all the necessary validations to ensure code quality before pushing changes to the repository. 

## Instructions to Run the Local Pipeline:

1. Make sure you have the `run_tests.sh` file in the root of the project.
2. Open a terminal in the project directory and run the following command:

   ```properties 
    ./run_tests.sh

## Other Information
- this app was developed in SwiftUI with Swift languages.
- the requests was developed using async and await that are the new structured concurrency changes that arrived in Swift 5.5 during WWDC 2021.
- the app support portrait and landscape orientation.
- the app use a local database to handle the favorites locations this with Swift Data.
- the app has unit tests and ui tests to ensure the correct behavior this with Swift Tests and XCTests.
- the app support the errors handler.
- there is no any third library, all the application was made with own code.
