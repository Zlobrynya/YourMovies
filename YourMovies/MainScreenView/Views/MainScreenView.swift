//
//  MainScreenView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import SwiftUI

struct MainScreenView: View {
    
    let data: [String] = ["testImage2", "testImage3", "testImage4",
                          "testImage2", "testImage3", "testImage4",
                          "testImage2", "testImage3", "testImage4"]

    // MARK: - Body

    var body: some View {
        VStack {
            Spacer()
            CarouselView(array: data) { item in
                Image(item, bundle: .main)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
        }
    }

    // MARK: - Views

   
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
