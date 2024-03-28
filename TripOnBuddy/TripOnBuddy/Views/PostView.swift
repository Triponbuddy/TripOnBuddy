//
//  PostView.swift
//  TripOnBuddy
//
//  Created by Sunil Sharma on 18/03/24.
//

import SwiftUI
import PhotosUI

final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selecetedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selecetedImage = uiImage
                    return
                }
            }
        }
    }
}

struct PostView: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.imageSelection, matching: .any(of: [.images, .videos, .slomoVideos, .cinematicVideos, .depthEffectPhotos, .panoramas, .timelapseVideos]),label: {
                
                if let image = viewModel.selecetedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                }
                else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.white)
                        .background(.gray)
                        .clipShape(Circle())
                }
            })
            
        }
    }
}

#Preview {
    PostView()
}
