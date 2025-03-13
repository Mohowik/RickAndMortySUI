//
//  OnBoardingScreen.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 02.03.2025.
//

import SwiftUI

struct OnBoardingScreen: View {
    
    @State private var text: String = ""
    @State private var isListPresented: Bool = false
    
    private var isEnabled: Bool {
        text.replacingOccurrences(of: " ", with: "").count > 3
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true),
                                   isActive: $isListPresented) {
                        EmptyView()
                    }
                    
                    Image(.iconDialogueCloud)
                        .overlay {
                            dialogueCloudView
                        }
                        .padding(.top, 61)
                        .padding(.trailing, 44)
                    Image(.iconPickleRick)
                        .padding(.leading, 137)
                        .padding(.top, -60)
                    Text("Вошли и вышли,\n приключение на 20 минут")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.rmGreenDark)
                        .padding(.top, 48)
                    Spacer()
                    buttonView
                    
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
            }
            .background(.rmGreenLight)
        }
    }
}

#Preview {
    OnBoardingScreen()
}

private extension OnBoardingScreen {
    
    var dialogueCloudView: some View {
        
        VStack(spacing: 11) {
            
            Text("I am Pickle")
                .font(.system(size: 32,
                              weight: .regular,
                              design: .default))
            
            TextField("  Enter your name",
                      text: $text)
            .frame(height: 35)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .opacity(0.1)
            )
            .padding(.leading, 46)
            .padding(.trailing, 41)
            .onSubmit {
                if isEnabled {
                    isListPresented = true
                }
            }
            Spacer()
        }
        .padding(.top, 32)
    }
    
    var buttonView: some View {
        
        Text("waba laba dab dab")
            .font(.system(size: 19,
                          weight: .bold,
                          design: .default))
            .foregroundStyle(.rmGreenCyan)
            .opacity(isEnabled ? 1 : 0.5)
            .frame(height: 44)
            .padding(.horizontal, 37)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .foregroundStyle(isEnabled ? .white : .rmGreenLight)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.rmGreenCyan)
                    .opacity(isEnabled ? 1 : 0.5)
            )
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.rmGreenCyan)
                    .padding(EdgeInsets(top: 5,
                                        leading: -5,
                                        bottom: -5,
                                        trailing: 5))
                    .opacity(isEnabled ? 1 : 0.5)
            )
            .padding(.bottom, 84)
            .onTapGesture {
                if isEnabled {
                    isListPresented = true
                }
            }
    }
}
