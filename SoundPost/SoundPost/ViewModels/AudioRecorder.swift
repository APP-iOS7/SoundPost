import AVFoundation

class AudioRecorder: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioRecorder: AVAudioRecorder?
    //    @Published var isRecording = false
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var timer : String = "00:00"
    @Published var time: Double = 0
    @Published var isRecording = false
    
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isPaused = false
    var audioFilename : URL?
    //녹음 설정 초기화
    override init() {
        super.init()
        let session = AVAudioSession.sharedInstance()
        do {
            //오디오 세션의 카테고리를 녹음과 재생으로 설정 , 오디오 세션을 활성화
            try session.setCategory(.playAndRecord, options: [.allowAirPlay,.allowBluetooth,.defaultToSpeaker])
            try session.setActive(true)
            //마이크 사용 권한 요청
            AVAudioApplication.requestRecordPermission { allowed in
                if !allowed {
                    print("Recording not allowed by the user" as! Error)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func setRecording() {
        self.timer = "00:00"
        self.countSec = 0
    }
    func startRecording() {
        
        let fileURL = getDocumentsDirectory().appendingPathComponent("SoundPost_\(UUID().uuidString).m4a")
        audioFilename = fileURL

        do {
            countSec = 0
            print("🎙️ Starting recording at: \(fileURL.path)")

            let recorder = try AVAudioRecorder(url: fileURL, settings: [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 48000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ])

            recorder.prepareToRecord()
            recorder.record()
            
            self.audioRecorder = recorder // 🔹 강한 참조 유지
            self.isRecording = true
            print("✅ Recording started")

            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.timer = String(format: "%02d:%02d", self.countSec / 60, self.countSec % 60)
                if self.countSec >= 90 {
                    self.stopRecording()
                    self.countSec = 0
                } else {
                    self.countSec += 1
                }
            }
        } catch {
            print("❌ Failed to setup recorder: \(error.localizedDescription)")
            self.audioRecorder = nil
        }
    }
    func stopRecording() {
        guard let recorder = self.audioRecorder else {
            print("❌ Attempted to stop recording, but no active recorder found")
            return
        }
        time = recorder.currentTime
        recorder.stop()
        print("🛑 Recording stopped")

        self.isRecording = false
        timerCount?.invalidate()

        if let fileURL = audioFilename {
            print("✅ Recording saved at: \(fileURL.path)")
            print("📂 File exists? \(FileManager.default.fileExists(atPath: fileURL.path))")
        } else {
            print("⚠️ audioFilename is nil after recording")
        }
    }
    func deleteRecord() {
        audioRecorder?.deleteRecording()
    }
    func playRecord() {
        if let audioFilename = audioFilename {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                self.isPlaying = true
                self.isPaused = false
            } catch {
                print("Failed to play record: \(error.localizedDescription)")
            }
        }
    }
    func stopRecord() {
        audioPlayer?.stop()
        self.isPlaying = false
    }
}
