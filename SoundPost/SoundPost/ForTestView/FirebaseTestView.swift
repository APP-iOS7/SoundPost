import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct FirebaseTestView: View {
    @State private var email: String = "roll0517@naver.com"
    @State private var password: String = "Pl103801"
    @State private var loginStatus: String = ""
    
    @State private var selectedImage: UIImage?
    @State private var imageDownloadURL: String = ""
    
    @State private var selectedAudioURL: URL? = Bundle.main.url(forResource: "testAudio", withExtension: ".mp3")
    @State private var audioDownloadURL: String = ""

    @State private var isImagePickerPresented = false
    @State private var isAudioPickerPresented = false

    var body: some View {
        VStack {
            // ✅ Firebase Authentication 로그인 테스트
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                FirebaseManager.shared.emailSignIn(email: email, password: password) { email, uid in
                    if let email = email, let uid = uid {
                        loginStatus = "✅ 로그인 성공: \(email) (UID: \(uid))"
                    } else {
                        loginStatus = "❌ 로그인 실패"
                    }
                }
            }
            .padding()
            
            Text(loginStatus).foregroundColor(.blue).padding()
            
            Divider()
            
            // ✅ Firebase Storage 이미지 업로드 테스트
            Button("Select Image") {
                isImagePickerPresented.toggle()
            }
            .padding()
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
                
                Button("Upload Image") {
                    StorageManager.shared.uploadImage(image: selectedImage) { result in
                        switch result {
                        case .success(let url):
                            imageDownloadURL = url
                        case .failure(let error):
                            print("❌ 이미지 업로드 실패: \(error.localizedDescription)")
                        }
                    }
                }
                .padding()
            }

            if !imageDownloadURL.isEmpty {
                Text("✅ 다운로드 URL: \(imageDownloadURL)").foregroundColor(.green).padding()
            }
            
            Divider()
            
            // ✅ Firebase Storage 오디오 업로드 테스트
            Button("Select Audio") {
                isAudioPickerPresented.toggle()
            }
            .padding()
            .sheet(isPresented: $isAudioPickerPresented) {
                AudioPicker(audioURL: $selectedAudioURL)
            }

            if let selectedAudioURL = selectedAudioURL {
                Text("Selected Audio: \(selectedAudioURL.lastPathComponent)").padding()
                
                Button("Upload Audio") {
                    StorageManager.shared.uploadAudio(audioURL: selectedAudioURL) { result in
                        switch result {
                        case .success(let url):
                            audioDownloadURL = url
                        case .failure(let error):
                            print("❌ 오디오 업로드 실패: \(error.localizedDescription)")
                        }
                    }
                }
                .padding()
            }

            if !audioDownloadURL.isEmpty {
                Text("✅ 다운로드 URL: \(audioDownloadURL)").foregroundColor(.green).padding()
            }
        }
        .padding()
    }
}


import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}
import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct AudioPicker: UIViewControllerRepresentable {
    @Binding var audioURL: URL?

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.audio])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: AudioPicker

        init(_ parent: AudioPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let firstURL = urls.first {
                parent.audioURL = firstURL
            }
        }
    }
}
