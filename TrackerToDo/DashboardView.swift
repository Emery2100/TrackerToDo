//
//  DashboardView.swift
//  TrackerToDo
//
//  Created by David Emery on 5/26/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var profiles: [Profile] = Profile.sample
    @State private var path = NavigationPath()
    
    let columns = [
        GridItem(.flexible(), spacing:20),
        GridItem(.flexible(), spacing:20)
    ]
    var body: some View {
        NavigationStack(path: $path){
            ScrollView{
                VStack{
                    VStack{
                        Text("Welcome Back!")
                            .font(.subheadline)
                            .textCase(.uppercase)
                        Text("Who is working today?")
                            .font(.caption)
                    }
                    LazyVGrid(columns: columns, spacing: 25){
                        ForEach($profiles) { $profile in
                            
                            NavigationLink(value: profile) {
                                Image(profile.profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Text(profile.name)
                                    .fontWeight(.bold)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Profile.self){ selectedProfile in
                if let index = profiles.firstIndex(where: { $0.id == selectedProfile.self.id}) {
                    ContentView(profile: $profiles[index])
                }
            }
        }
    }
}
