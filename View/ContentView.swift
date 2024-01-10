//
//  ContentView.swift
//  PomodoroFocus
//
//  Created by SwiftieDev on 15/12/2023.
//  MARK: SwiftieDev

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var selectedTab = 0
    @State private var indicatorOffset: CGFloat = -3.5
    
    init() {
        _selectedTab = State(initialValue: 0)
        _indicatorOffset = State(initialValue:  UIScreen.main.bounds.width / -3.5)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Pomodoro")
                            .foregroundColor(selectedTab == 0 ? .white : .gray)
                            .onTapGesture {
                                selectedTab = 0
                                indicatorOffset = UIScreen.main.bounds.width / -3.5
                            }
                        Spacer()
                        Text("Short break")
                            .foregroundColor(selectedTab == 1 ? .white : .gray)
                            .onTapGesture {
                                selectedTab = 1
                                indicatorOffset = 1
                            }
                        Spacer()
                        Text("Long break")
                            .foregroundColor(selectedTab == 2 ? .white : .gray)
                            .onTapGesture {
                                selectedTab = 2
                                indicatorOffset = UIScreen.main.bounds.width / 3.5
                            }
                        Spacer()
                    }
                    .font(.title3)
                    .bold()
                    .padding()
                    
                    Rectangle()
                        .fill(Color(.purpleTheme))
                        .frame(width: UIScreen.main.bounds.width / 8, height: 2)
                        .offset(x: indicatorOffset, y: 0)
                    
                    TabView(selection: $selectedTab) {
                        WorkTimerView(viewModel: viewModel)
                            .tag(0)
                        
                        ShortTimerView(viewModel: viewModel)
                            .tag(1)
                        
                        LongTimerView(viewModel: viewModel)
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
