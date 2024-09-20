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
    @State var aspectRatio: ContentMode = .fit
    var body: some View {
        ZStack {
            //BackgroundColourView()
            VStack {
                PhotosPicker(selection: $viewModel.imageSelection, matching: .any(of: [.images, .videos, .slomoVideos, .cinematicVideos, .depthEffectPhotos, .panoramas, .timelapseVideos]),label: {
                    
                    if let image = viewModel.selecetedImage {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .aspectRatio(contentMode: aspectRatio)
                            //.frame(width: 80, height: 100)
                            
                        }
                        .overlay(alignment: .bottomLeading, content: {
                            Button(action: {
                                aspectRatio = .fill
                            }){
                                Image(systemName: "crop")
                                    .imageScale(.large)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .background(Circle()
                                        .opacity(0.5))
                                
                            }
                            .padding()
                        })
                        
                    }
                    else {
                        ZStack {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .overlay(alignment: .bottomTrailing, content: {
                                    Image(systemName: "plus")
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.white)
                                        .background(.gray)
                                        .clipShape(Circle())
                                })
                            
                        }
                        
                    }
                })
                
            }
            .padding([.horizontal, .top], 10)
        }
        
    }
}

#Preview {
    PostView()
}
