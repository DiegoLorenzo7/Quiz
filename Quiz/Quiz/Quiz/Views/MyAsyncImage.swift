//
//  MyAsyncImage.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
import SwiftUI
struct MyAsyncImage: View {
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            if url == nil {
                Color.white
            }else if let image = phase.image {
                image.resizable()
            } else if phase.error != nil {
                Color.black
            } else {
                ProgressView()
            }
        }
    }
}

struct MyAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        MyAsyncImage()
    }
}
