//
//  SettingsView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/01/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Picker(LocalizedStrings.team, selection: $viewModel.team) {
                        ForEach(F1Team.allCases, id: \.self) { team in
                            Text(team.rawValue.capitalized)
                                .tag(team.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker(LocalizedStrings.newsSource, selection: $viewModel.source) {
                        ForEach(FeedSource.allCases, id: \.self) { source in
                            Text(source.title)
                                .tag(source.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Toggle(LocalizedStrings.darkMode, isOn: $viewModel.darkMode)
                    
                    Section(LocalizedStrings.notifications) {
                        Toggle(LocalizedStrings.enableNotifications, isOn: $viewModel.notifications)
                    }
                    
                    if viewModel.notifications {
                        Section("Notifications - Time Before Event Trigger") {
                            NavigationLink(destination: MultiSelectionPickerView(allItems: viewModel.availableTimes, selectedItems: $viewModel.userSelectedTimes)) {
                                HStack {
                                    Text("Trigger Time")
                                    Spacer()
                                    Text(viewModel.userSelectedTimes.map { $0.title }.joined(separator: " - "))
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        
                        if !viewModel.userSelectedTimes.isEmpty {
                            NavigationLink(destination: MultiSelectionPickerView(allItems: viewModel.allEvents, selectedItems: $viewModel.userSelectedEvents)) {
                                HStack {
                                    Text("Notification Events")
                                    Spacer()
                                    Text(viewModel.userSelectedEvents.map { $0.title }.joined(separator: " - "))
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        
                        NavigationLink(destination: MultiSelectionPickerView(allItems: NotificationTopic.allCases, selectedItems: $viewModel.notificationTopics)) {
                            HStack {
                                Text("Realtime Notification Topics")
                                Spacer()
                                Text(viewModel.notificationTopics.map { $0.title }.joined(separator: " - "))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
                .listStyle(.inset)
                .padding()
                .onChange(of: viewModel.notifications, { _, isEnabled in
                    if !isEnabled {
                        viewModel.clearPendingNotifications()
                    }
                })
                
                Button {
                    viewModel.didTapConfirm()
                    dismiss()
                } label : {
                    Text(LocalizedStrings.confirm)
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle())
                
                Text(LocalizedStrings.version(viewModel.appVersion, viewModel.appBuild))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(LocalizedStrings.disclaimer)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding()
            }
            .navigationTitle(LocalizedStrings.preferences)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                requestNotificationPermission()
            }
        }
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }
}

#Preview {
    SettingsView()
}
