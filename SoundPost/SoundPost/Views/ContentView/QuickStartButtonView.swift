import SwiftUI

struct QuickStartButtonView: View {
    @StateObject var contentViewModel: ContentViewModel
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            VStack {
                Spacer()
                //tab선택에 따른 뷰 변경
                switch contentViewModel.QuickStartButtonClick {
                case 1 :
                    SelectRecordView()
                        .transition(.scale.animation(.easeOut))
                case 2 :
                    RecordingView()
                        .transition(.asymmetric(insertion: .scale.animation(.easeIn), removal: .scale.animation(.easeOut)))
                case 3 :
                    SelectView()
                        .transition(.asymmetric(insertion: .scale.animation(.easeIn), removal: .move(edge: .bottom).animation(.easeOut)))
                default :
                    TestUIView()
                }
                
            }
            
        }
    }
}

struct SelectView: View {
    var body: some View {
            HStack {
                Spacer()
                VStack {
                    //이미지 들어갈 곳
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.green)
                        .frame(width: 60, height: 60)
                    Button {
                        
                    } label: {
                        Text("이미지 선택")
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
    var body: some View {
        HStack {
            Spacer()
            VStack {
                //이미지 들어갈 곳
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.green)
                    .frame(width: 60, height: 60)
                Button {
                    
                } label: {
                    Text("이미지 선택")
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
    var body: some View {
        HStack {
            //음성 인식 파형이 그려질 공간
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 7)
        }
        .padding(.bottom)
    }
}
