//
//  ProcessingReducer.swift
//  Effects
//
//  Created by Anton Gorlov on 05.08.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ProcessingReducer {
    
    private let url = URL(string: "https://rickandmortyapi.com/api/character")!
    
    @ObservableState
    struct State {
        var isLoading = false
        var results: [PersonResponseData] = []
    }
    
    enum Action {
        case loadData
        case publisherLoadData
        case failed(Error)
        case success([PersonResponseData])
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadData:
            state.isLoading = true
            return .run { send in // an async task
                do {
                    let response = try await ExampleAPI().getAsync(url)
                    await send(.success(response))
                } catch {
                    await send(.failed(error))
                }
            }
        case .publisherLoadData:
            state.isLoading = true
            return .publisher {
                ExampleAPI().getCharacters(url)
                    .receive(on: DispatchQueue.main)
                    .replaceError(with: [])
                    .map { response in
                        response.isEmpty ? .failed(NetworkError.emptyResponse) : .success(response)
                    }
            }
        case .failed(let error):
            print(error)
            state.isLoading = false
            return .none
        case .success(let result):
            state.results = result
            state.isLoading = false
            print(result)
            return .none
        }
    }
}

// Effects - this entity allows you to add additional actions (they are called Side-Effect)

// Operation
// 1) .none - It's an empty effect
// 2) .run - It's an asynchronous operation that will be performed. If after changing the state you need to launch some additional action (loading, processing, waiting) and you can send Actions from this action
// 3) .publisher - This is the effect inside which the publisher publishes (triggers) when some event occurs (Output = Action)

// Each effect has its own task
// Effects do not block each other from execution, but the final task waits for all effects created in the current scope to be executed
