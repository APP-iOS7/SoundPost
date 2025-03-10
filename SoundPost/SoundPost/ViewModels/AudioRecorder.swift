import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder!
    var audioPlayer = AVAudioPlayer()
    var audioFilename : URL {
        (FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?.appendingPathComponent("recording.m4a", conformingTo: .audio))!
    }
    //녹음 설정 초기화
    override init() {
        super.init()
        let session = AVAudioSession.sharedInstance()
        do {
            //오디오 세션의 카테고리를 녹음과 재생으로 설정 , 오디오 세션을 활성화
            try session.setCategory(.playAndRecord, options: .defaultToSpeaker)
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
    
    
    func isRecording() -> Bool {
        return audioRecorder.isRecording
    }
    func startRecording() {
        //녹음 설정
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        //녹음 파일 경로 설정
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.prepareToRecord()
        } catch {
            print("Failed to setup recorder: \(error)")
        }
        
        audioRecorder.record(forDuration: 90)
    }
    func stopRecording() {
        audioRecorder.stop()
    }
    func deleteRecord() {
        audioRecorder.deleteRecording()
    }
    func playRecord() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer.play()
        } catch {
            print("Failed to play record: \(error)")
        }
    }
    
}
