import SwiftUI
import AVKit

struct AudioPlayerView: View {
    @ObservedObject var viewModel: AudioPlayerViewModel
    
    init(url: URL) {
        self.viewModel = AudioPlayerViewModel(url: url)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // 재생/일시정지 버튼
            Button {
                viewModel.playOrPause()
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: 30, height: 30)
                } else {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .disabled(viewModel.isLoading || viewModel.loadError)
            
            // 슬라이더 및 시간 표시
            VStack(spacing: 2) {
                if viewModel.loadError {
                    Text("오디오를 불러올 수 없습니다")
                        .font(.caption)
                        .foregroundColor(.red)
                } else {
                    // 진행 슬라이더
                    ProgressSlider(value: viewModel.currentTime, total: viewModel.duration) { newPosition in
                        viewModel.seek(to: newPosition * viewModel.duration)
                    }
                    
                    // 시간 표시
                    HStack {
                        Text(formatTime(viewModel.currentTime))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        if viewModel.isLoading {
                            Text("로딩 중...")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        } else {
                            Text(formatTime(viewModel.duration))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        guard time.isFinite, time >= 0 else { return "0:00" }
        
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct ProgressSlider: View {
    let value: Double
    let total: Double
    let onChanged: (Double) -> Void
    
    private var progress: Double {
        guard total > 0, value.isFinite, total.isFinite else { return 0 }
        return min(max(value / total, 0), 1)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 배경 트랙
                Capsule()
                    .fill(.tertiary)
                    .frame(height: 3)
                
                // 재생 진행 트랙
                Capsule()
                    .fill(.foreground)
                    .frame(width: geometry.size.width * progress, height: 3)
            }
            .gesture(
                SpatialTapGesture(coordinateSpace: .local)
                    .onEnded { value in
                        let percentage = value.location.x / geometry.size.width
                        onChanged(min(max(Double(percentage), 0), 1))
                    }
            )
        }
        .frame(height: 3)
    }
}

#Preview("From URL") {
    if let url = URL(string: "https://filesamples.com/samples/audio/aac/sample3.aac") {
        AudioPlayerView(url: url)
    } else {
        Text("Preview audio URL not found")
    }
}

#Preview("From Bundle") {
    if let url = Bundle.main.url(forResource: "sampleAudio", withExtension: "m4a") {
        AudioPlayerView(url: url)
    } else {
        Text("Preview audio URL not found")
    }
}

