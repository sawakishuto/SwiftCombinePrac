//
//  ContentView.swift
//  SwiftCombinePrac
//
//  Created by 澤木柊斗 on 2023/10/11.
//

import SwiftUI

struct WebJokeVeiw: View {
    @StateObject private var viewModel = WebAPIViewModel()
    var body: some View {
        VStack {
            Text("ジョーク")
            Text(viewModel.joke)
            Button { viewModel.fetchJoke()} label: {
                Text("ジョーク表示")
            }
        }
    }
    
}

#Preview {
    WebJokeVeiw()
}
