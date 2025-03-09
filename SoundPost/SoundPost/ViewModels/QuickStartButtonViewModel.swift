import SwiftUI
import PhotosUI

class QuickStartButtonViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published private var audio: Data = Data()
    @Published var imageSelection: PhotosPickerItem? = nil
    //유저 정보를 받아와야함
    var uploader: User = User(email: " ", nickname: " ", password: " ", isAlarmOn: false, signupDate: Date.now)
    
    final func NewPostUpload() {
        //        let newPost: Post = Post(id: Date.now.formatted() , uploadDate: Date.now, audio: audio, image: image, uploader: uploader)
//        if let image = selectedImage {
//            return image.pngData()
//        }
        //        uploader.posts.append(newPost)
    }
    
    final func setImage (from selection: PhotosPickerItem?) {
        guard let selection else { return }
        selection.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data) :
                if let data = data, let newImage = UIImage(data: data) {
                    if self.selectedImage?.pngData() != newImage.pngData() {
                        DispatchQueue.main.async {
                            self.selectedImage = newImage
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
