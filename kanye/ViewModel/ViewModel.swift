//
//  ViewModel.swift
//  kanye
//
//  Created by ScripturesInTech on 19/01/23.
//

import Foundation


protocol QuoteViewModelResult: AnyObject {
    func updateView(model: Quote)
}

class ViewModel {

    private var networkProtocol: NetworkProtocol
    weak var output: QuoteViewModelResult?

    init(networkProtocol: NetworkProtocol) {
        self.networkProtocol = networkProtocol
    }
    
    /// loopingIn function
    func loopingIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.fetchQuote()
            self.loopingIn()
        }
    }

    func fetchQuote() {
        let url = URL(string: "https://api.kanye.rest/")!
        networkProtocol.fetchQuote(url: url) {[weak self] result in
            switch result {
                case .success(let quote):
                    debugPrint("Quotes: \(quote)")
                    self?.output?.updateView(model: quote)

                case .failure(let error):
                    debugPrint(error.localizedDescription)
            }
        }
    }
}
