//
//  TextFieldValidModifier.swift
//  SoundPost
//
//  Created by 이재용 on 3/7/25.
//

import SwiftUI

struct TextFieldValidModifier: ViewModifier {
    @Binding var isValid: Bool
    
    func body(content: Content) -> some View {
        content
            .border(isValid ? Color.primaryNeon : Color.red, width: 1)
    }
}
