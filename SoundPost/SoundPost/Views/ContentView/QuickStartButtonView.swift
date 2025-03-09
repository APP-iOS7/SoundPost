import SwiftUI
import PhotosUI

struct QuickStartButtonView: View {
    @StateObject var contentViewModel: ContentViewModel
    @StateObject private var quickStartViewModel = QuickStartButtonViewModel()
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            VStack {
                Spacer()
                //tab선택에 따른 뷰 변경
                switch contentViewModel.QuickStartButtonClick {
                case 1 :
                    SelectRecordView(quickStartViewModel: quickStartViewModel)
                        .transition(.scale.animation(.easeOut))
                case 2 :
                    RecordingView(quickStartViewModel: quickStartViewModel)
                        .transition(.asymmetric(insertion: .scale.animation(.easeIn), removal: .scale.animation(.easeOut)))
                case 3 :
                    SelectView(quickStartViewModel: quickStartViewModel)
                        .transition(.asymmetric(insertion: .scale.animation(.easeIn), removal: .move(edge: .bottom).animation(.easeOut)))
                default :
                    TestUIView()
                }
                
            }
            
        }
    }
}

struct SelectView: View {
    @StateObject var quickStartViewModel: QuickStartButtonViewModel
    var body: some View {
        HStack {
            Spacer()
            ImagePickerView(quickStartViewModel: quickStartViewModel)
            Spacer()
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .frame(width: 60, height: 60)
                Button {
                    
                } label: {
                    Text("게시")
                        .foregroundStyle(.black)
                }
                .padding()
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .buttonStyle(.borderedProminent)
                .tint(.primaryNeon.opacity(1))
            }
            Spacer()
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .frame(width: 60, height: 60)
                Button {
                    
                } label: {
                    Text("다시 듣기")
                        .foregroundStyle(.black)
                }
                .padding()
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .buttonStyle(.borderedProminent)
                .tint(.primaryNeon.opacity(1))
            }
            Spacer()
        }
    }
}

struct SelectRecordView: View {
    @StateObject var quickStartViewModel: QuickStartButtonViewModel
    var body: some View {
        HStack {
            Spacer()
            ImagePickerView(quickStartViewModel: quickStartViewModel)
            Spacer()
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear)
                    .frame(width: 60, height: 60)
                Button {
                    
                } label: {
                    Text("녹음파일 선택")
                        .foregroundStyle(.black)
                }
                .padding()
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .buttonStyle(.borderedProminent)
                .tint(.primaryNeon.opacity(1))
            }
            Spacer()
        }
    }
}

struct RecordingView: View {
    @StateObject var quickStartViewModel: QuickStartButtonViewModel
    var body: some View {
        HStack {
            //음성 인식 파형이 그려질 공간
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 7)
        }
        .padding(.bottom)
    }
}

struct ImagePickerView: View {
    @StateObject var quickStartViewModel: QuickStartButtonViewModel
    var body: some View {
        VStack {
            //이미지 선택 시 이미지 , 미 선택 시 검은 화면
            if let _ = quickStartViewModel.selectedImage {
                Image(uiImage: quickStartViewModel.selectedImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(5)
            }
            else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.black)
                    .frame(width: 60, height: 60)
            }
            //이미지 선택 피커
            PhotosPicker(selection: $quickStartViewModel.imageSelection,
                         matching: .any(of: [.images, .not(.videos)])
            ) {
                Text("이미지 선택")
                    .foregroundStyle(.black)
            }
            .onChange(of: quickStartViewModel.imageSelection) {
                quickStartViewModel.setImage(from: quickStartViewModel.imageSelection)
            }
            .padding()
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .buttonStyle(.borderedProminent)
            .tint(.primaryNeon.opacity(1))
        }
    }
}
