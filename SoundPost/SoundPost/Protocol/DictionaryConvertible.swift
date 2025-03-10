//
//  DictionaryConvertible.swift
//  SoundPost
//
//  Created by 이재용 on 3/9/25.
//

import Foundation

protocol DictionaryConvertible: Codable {
    var dictionaryRepresentation: [String: Any]? { get }
    static func from(dictionary: [String: Any]) -> Self?
}

extension DictionaryConvertible {
    // 🔹 Dictionary → Model 변환
    static func from(dictionary: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
              let model = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        return model
    }

    // 🔹 Model → Dictionary 변환
    var dictionaryRepresentation: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
