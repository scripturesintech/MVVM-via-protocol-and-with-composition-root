//
//  kanyeTests.swift
//  kanyeTests
//
//  Created by ScripturesInTech on 19/01/23.
//

import XCTest

@testable import kanye

class kanyeTests: XCTestCase {

    private var sut: ViewModel!
    private var networkManager: MockWebService!
    private var out: MockQuoteOutput!


    override func setUpWithError() throws {
        networkManager = MockWebService()
        out = MockQuoteOutput()
        sut = ViewModel(networkProtocol: networkManager)
        sut.output = out
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        networkManager = nil
        try super.tearDownWithError()
    }

    func test_apiSuccessResult() {

        //Given [Arrange]
        let quote = Quote(quote: "Good Morning Folks!")
        networkManager.fetchQuoteResult = .success(quote)

        //When [Act]
        sut.fetchQuote()

        //Then [Assert]
        XCTAssertEqual(out.outputArray.count, 1)
        XCTAssertEqual(out.outputArray[0], quote.quote)
    }

    func test_apiSuccessResult1() {

            //Given [Arrange]
        let quote = Quote(quote: "Good Morning Folks!")
        networkManager.fetchQuoteResult = .success(quote)

            //When [Act]
        sut.fetchQuote()
        sut.fetchQuote()

            //Then [Assert]
        XCTAssertEqual(out.outputArray.count, 2)
        XCTAssertEqual(out.outputArray[1], quote.quote)
    }

}

class MockWebService: NetworkProtocol {

    var fetchQuoteResult: Result<Quote, Error>?
    func fetchQuote(url: URL, complition: @escaping (Result<Quote, Error>) -> (Void)) {
        if let result = fetchQuoteResult {
            complition(result)
        }
    }
}

class MockQuoteOutput: QuoteViewModelResult {

    var outputArray: [String] = []
    func updateView(model: Quote) {
        outputArray.append(model.quote)
    }
}
