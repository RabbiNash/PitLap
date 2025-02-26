//
//  SettingsView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/01/2025.
//

import SwiftUI
import PersistenceManager
import SwiftData

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    @Query(filter: #Predicate<RaceWeekendEntity> { weekend in
        weekend.year == "2025"
    }, sort: \RaceWeekendEntity.round)
    var model: [RaceWeekendEntity]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Picker("Team", selection: $viewModel.team) {
                        ForEach(F1Team.allCases, id: \.self) { team in
                            Text(team.rawValue.capitalized)
                                .tag(team.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("News Source", selection: $viewModel.source) {
                        ForEach(FeedSource.allCases, id: \.self) { source in
                            Text(source.title)
                                .tag(source.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Toggle("Enable Dark Mode", isOn: $viewModel.darkMode)
                    
                    Section("Notifications") {
                        Toggle("Enable Notifications", isOn: $viewModel.notifications)
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
                    viewModel.didTapConfirm(raceWeekends: model)
                    dismiss()
                } label : {
                    Text("Confirm")
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle())
                
                Text("Version: \(viewModel.appVersion) (\(viewModel.appBuild))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .navigationTitle("Preferences")
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
