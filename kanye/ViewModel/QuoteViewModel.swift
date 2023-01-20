//
//  QuoteViewModel.swift
//  kanye
//
//  Created by roopesh.s.tripathi on 24/02/22.
//

import Foundation
import Combine

class QuoteViewModel: ObservableObject {

    private var cancellables = Set<AnyCancellable>()
    @Published var quote = QuoteModel()

    func getQuote() {
        NetworkService.shared.fetchData(endPoint: .flights, type: QuoteModel.self)
            .sink { completion in
                switch completion {
                    case .failure(let err):
                        print("Error is \(err.localizedDescription)")
                    case .finished:
                        print("Finished")
                }
            }
        receiveValue: { [weak self] quoteData in
            self?.quote = quoteData
        }
        .store(in: &cancellables)
        }
    }
