//
//  DictionaryConvertible.swift
//  SoundPost
//
//  Created by 이재용 on 3/9/25.
//

import Foundation
import FirebaseCore

protocol DictionaryConvertible: Codable {
    var dictionaryRepresentation: [String: Any]? { get }
    static func from(dictionary: [String: Any]) -> Self?
}

extension DictionaryConvertible {
    // 🔹 Dictionary → Model 변환
    static func from(dictionary: [String: Any]) -> Self? {
           do {
               let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
               let model = try JSONDecoder().decode(Self.self, from: data)
               return model
           } catch {
               print("❌ Dictionary → Model 변환 실패: \(error)")
               return nil
           }
       }
    
    // 🔹 Model → Dictionary 변환
    var dictionaryRepresentation: [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            print ("DICT IS HERE!!")
            print(dictionary)
            return dictionary
        } catch {
            print ("모델 딕셔너리 변환 실패")
            return nil
        }
    }
}
