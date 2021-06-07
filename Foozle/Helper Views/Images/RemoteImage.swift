//
//  RemoteImage.swift
//  Foozle
//
//  Created by Mike Conner on 5/26/21.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    @Published var isLoading: Bool = true
    
    func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromUrlString: urlString) { uiImage in
            guard let uiImage = uiImage else {return}
            DispatchQueue.main.async { [self] in
                self.image = Image(uiImage: uiImage).resizable()
                isLoading = false
            }
        }
    }
    
} // End of class

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("noImage").resizable()
    }
    
} // End of struct

struct GameRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    
    let urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image?.resizable())
            .onAppear { imageLoader.load(fromURLString: urlString) }
            .blur(radius: !imageLoader.isLoading ? 0 : urlString.contains("noImage") ? 0 : 20)
    }
    
} // End of struct
