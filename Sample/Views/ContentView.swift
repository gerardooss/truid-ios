//
//  test.swift
//  Sample
//
//  Created by Hendrik Nicolas Carlo on 21/07/25.
//  Copyright © 2025 Eric. All rights reserved.
//
// ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var shouldNavigateToResult = false
    @State private var isShowingCellularModal = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // MARK: - Header
                    HStack {
                        Spacer()
                        Image("EasyCashLogo")
                            .resizable().scaledToFit().frame(height: 30)
                        Spacer()
                        Image("Customer-Service")
                            .resizable().scaledToFit().frame(height: 30)
                    }
                    .padding(.horizontal)
                    .frame(height: 80)
                    
                    // MARK: - Body Content
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Masukkan nomor HP untuk daftar/ masuk")
                                .font(.system(size: 20, weight: .semibold))
                            Text("Pastikan kamu pakai kartu SIM yang didaftarkan, dan nyalakan data seluler ya, Easy Frens!")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }

                        HStack {
                            Image(systemName: "phone.fill").foregroundColor(Color("AppSecondaryColor"))
                            TextField("08xx xxxx xxxx", text: $viewModel.phoneNumber)
                                .keyboardType(.phonePad)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("AppSecondaryColor").opacity(0.5), lineWidth: 1)
                        )
                        
                        // 'Lanjut' Button
                        Button(action: {
                            isShowingCellularModal = true
                        }) {
                            Text("Lanjut")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                        }
                        .background(viewModel.isContinueButtonEnabled ? Color("AppPrimaryColor") : Color("AppSecondaryColor"))
                        .cornerRadius(10)
                        .disabled(!viewModel.isContinueButtonEnabled)
                        .sheet(isPresented: $isShowingCellularModal) {
                            CelularModalView(
                                phoneNumber: viewModel.phoneNumber,
                                onContinue: {
                                    viewModel.performPhoneCheck()
                                }
                            )
                            .presentationDetents([.medium])
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                CheckBoxComponent(isSelected: $viewModel.termsAccepted)
                                Text("I have read and agreed to the Privacy Policy, Terms of Use and Authorization Letter from Easycash.")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color("AppSecondaryColor"))
                            }
                            HStack {
                                CheckBoxComponent(isSelected: $viewModel.promotionsAccepted)
                                Text("I agree to receive promotional information from Easycash.")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color("AppSecondaryColor"))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .navigationDestination(isPresented: $shouldNavigateToResult) {
                    // Destination view
                    ResultView(isSuccess: viewModel.checkResult ?? false)
                }
                
                // MARK: - Loading Overlay
                if viewModel.isLoading {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    ProgressView("Verifying...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
            .onChange(of: viewModel.checkResult) { oldValue, newValue in
                if newValue != nil {
                    shouldNavigateToResult = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
