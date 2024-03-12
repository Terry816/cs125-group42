//
//  InputView.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation
import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    let image: String
    var width = 25.0
    var height = 20.0
    var isSecure = false
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: width, height: height)
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
            }
            .padding(.top, 22)
            VStack(alignment: .leading, spacing: 12){
                Text(title)
                    .foregroundColor(Color(.white))
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
//                    .padding(.leading, 38)
                ZStack(alignment: .leading) {
                        if text.isEmpty {
                        Text(placeholder)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                        }
                    if isSecure {
                        SecureField("", text: $text)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    else{
                        TextField("", text: $text)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
    //            Divider()
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .background(Color.black.opacity(0.2))
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "EMAIL", placeholder: "name@example.com", image: "envelope")
    }
}
