import SwiftUI
import PhotosUI

struct QuickStartButtonView: View {
    let user: User?
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject private var quickStartViewModel : QuickStartButtonViewModel
    
    init(user: User?, contentViewModel: ContentViewModel) {
        self.user = user
        self.contentViewModel = contentViewModel
        self.quickStartViewModel = .init(uploader: self.user)
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            VStack {
                Spacer()
                //tab선택에 따른 뷰 변경
                if contentViewModel.QuickStartButtonClick == 1 {
                    SelectRecordView(quickStartViewModel: quickStartViewModel)
                        .transition(.scale.animation(.easeOut))
                } else if contentViewModel.QuickStartButtonClick == 2 {
                    RecordingView(quickStartViewModel: quickStartViewModel)
                        .transition(.asymmetric(insertion: .scale.animation(.easeIn), removal: .scale.animation(.easeOut)))
                } else if contentViewModel.QuickStartButtonClick == 3 {
                    SelectView(quickStartViewModel: quickStartViewModel, contentViewModel: contentViewModel)
                        .transition(.asymmetric(insertion: .scale.animation(.easeIn), removal: .move(edge: .bottom).animation(.easeOut)))
                }
            }
            .onChange(of: quickStartViewModel.audioRecoder.countSec) { _, sec in
                print("\(sec)")
                if sec >= 90 {  // 90초가 되었을 때 트리거
                    quickStartViewModel.stopRecoring()
                    contentViewModel.QuickStartButtonClick = 3
                }
            }
            .onChange(of: contentViewModel.QuickStartButtonClick) { _, click in
                if click != 3 && quickStartViewModel.audioRecoder.isPlaying {
                    quickStartViewModel.audioRecoder.audioPlayer?.stop()
                    quickStartViewModel.audioRecoder.isPlaying = false
                }
                switch click {
                case 2:
                    quickStartViewModel.startRecoring()
                    print("recording")
                case 3:
                    quickStartViewModel.stopRecoring()
                    print("stop")
                default:
                    break
                }
            }
            
        }
    }
}

struct SelectView: View {
    @ObservedObject var quickStartViewModel: QuickStartButtonViewModel
    @ObservedObject var contentViewModel: ContentViewModel
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
                    contentViewModel.QuickStartClose()
                    Task {
                        await quickStartViewModel.NewPostUpload()
                    }
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
                    .overlay(
                        VStack{
                            Text(quickStartViewModel.timeStamp())
                        }
                    )
                Button {
                    quickStartViewModel.playRecoed()
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
    @ObservedObject var quickStartViewModel: QuickStartButtonViewModel
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
    @ObservedObject var quickStartViewModel: QuickStartButtonViewModel
    var body: some View {
        HStack {
            //음성 인식 파형이 그려질 공간
            //ToDo: 녹음 시간 카운트
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 7)
                .overlay(
                    Text(quickStartViewModel.audioRecoder.timer)
                                            .foregroundStyle(.white)
                    
                )
        }
        .padding(.bottom)
    }
}

struct ImagePickerView: View {
    @ObservedObject var quickStartViewModel: QuickStartButtonViewModel
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
                    .fill(Color.clear)
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
