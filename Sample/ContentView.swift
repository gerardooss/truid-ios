//
//  test.swift
//  Sample
//
//  Created by Hendrik Nicolas Carlo on 21/07/25.
//  Copyright © 2025 Eric. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var textInput: String = ""
    @State var terms1: Bool = false
    @State var terms2: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("EasyCashLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                Spacer()
                
                Image("Customer-Service")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
            }
            .padding(.horizontal)
            .frame(height: 80)
            
            VStack (alignment: .leading, spacing: 30) {
                VStack (alignment: .leading, spacing: 10){
                    Text("Masukkan nomor HP untuk daftar/ masuk")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                    Text("Pastikan kamu pakai kartu SIM yang didaftarkan, dan nyalakan data seluler ya, Easy Frens!")
                        .font(.system(size: 13, weight: .regular, design: .default))
                }
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.gray)
                    
                    TextField("08xx xxxx xxxx", text: $textInput)
                        .keyboardType(.phonePad)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                HStack {
                    Text("Lanjut")
                        .font(.system(size: 16))
                }
                .frame(width: 360, height:56)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                VStack(alignment:.leading, spacing:10){
                    HStack{
                        CheckBoxComponent(isSelected: $terms1)
                        Text("I have read and agreed to the Privacy Policy, Terms of Use and Authorization Letter from Easycash.")
                            .font(.system(size: 11, weight: .regular, design: .default))
                    }
                    HStack{
                        CheckBoxComponent(isSelected: $terms2)
                        Text("I agree to receive promotional information from Easycash.")
                            .font(.system(size: 11, weight: .regular, design: .default))
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
