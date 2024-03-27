//
//  ContentView.swift
//  Testy
//
//  Created by Davide Galdiero on 26/03/24.
//

import SwiftUI

struct ContentView: View {
    
    let url = URL(string: "https://api.chucknorris.io/jokes/random")!
    let imageName = "cowboy_6342596"
    @AppStorage("joke") private var joke = "Press the button"
    var body: some View {
        NavigationStack {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding()
                Text(joke)
                    .foregroundStyle(.foreground)
                    .padding()
                Button("Fetch joke") {
                    Task{
                        do{
                            let (data, _) = try await URLSession.shared.data(from: url)
                            let decodeResponse = try JSONDecoder().decode(Joke.self, from: data)
                            
                            joke = decodeResponse.value
                        }
                        catch{
                            print("failed to fetch: \(error)")
                        }
                    }
                }
                .padding()
                .navigationTitle("Spam Norris")
                
            }
            .preferredColorScheme(.dark)
        }
    }
    
    
}

#Preview {
    ContentView()
}
