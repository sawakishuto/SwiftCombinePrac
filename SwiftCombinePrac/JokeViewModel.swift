//
//  JokeViewModel.swift
//  SwiftCombinePrac
//
//  Created by 澤木柊斗 on 2023/10/11.
//

import Foundation
import Combine

final class WebAPIViewModel: ObservableObject {
    @Published var joke: String = ""

    private var cancellables: [AnyCancellable] = []

    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    func fetchJoke() {
        guard let url = URL(string: "https://icanhazdadjoke.com/") else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, _: URLResponse) in return data }
            .decode(type: JokeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    print("終了")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue:{ [weak self] response in
                self?.joke = response.joke
            })
    }
}
