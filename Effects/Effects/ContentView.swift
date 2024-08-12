//
//  ContentView.swift
//  Effects
//
//  Created by Anton Gorlov on 05.08.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    @Bindable var store: StoreOf<ProcessingReducer>
    
    var body: some View {
        
        VStack {
            
            if store.results.isEmpty {
                
                if store.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                else {
                    
                     Button(action: {
                         store.send(.publisherLoadData)
                     }, label: {
                         Text("Fetch data")
                     })
                }
            } else {
                
                personCell
            }
        }
        
    }
    
    private var personCell: some View {
            
        List {
            
            ForEach(store.results, id: \.id) { item in
                
                VStack(alignment: .leading) {
                    
                    Text(item.name)
                        .foregroundStyle(.brown.gradient)
                        .fontWeight(.medium)
                    
                    Text("Status: \(item.status)")
                       
                    Text("Species: \(item.species)")
                    Text("Gender: \(item.gender)")
                    Text("Location: \(item.location.name)")
                }
                .listRowBackground(Color.accentColor.opacity(0.15))
            }
        }
        .padding(.top)
    }
}

#Preview {
    
    let store = Store(initialState: ProcessingReducer.State()) {
        
        ProcessingReducer()
    }
    
    return ContentView(store: store)
}
