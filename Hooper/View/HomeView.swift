//
//  HomeView.swift
//  Hooper
//
//  Created by Andrey Fernandez on 10/19/24.
//

import SwiftUI

struct Response: Codable {
    let data: [Game]
}

struct Game: Codable {
    let gameId: String
    let gameStatus: String
    let gameDateTime: Date
    let homeTeam: Team
    let awayTeam: Team
    let pointsLeader: Player?
}

struct Team: Codable {
    let teamId: Int
    let teamName: String
    let teamCity: String
    let teamTricode: String
    let teamSlug: String
    let wins: Int
    let losses: Int
    let score: Int
    let seed: Int
    let lightLogo: String
    let darkLogo: String
}

struct Player: Codable {
    let playerId: Int
    let firstName: String
    let lastName: String
    let teamId: Int
    let teamName: String
    let teamCity: String
    let teamTricode: String
    let points: Double
    let headshot: String
}

struct HomeView: View {
    @State private var ongoingGames = [Game]()
    @State private var upcomingGames = [Game]()
    @State private var ongoingDate = Date()
    @State private var upcomingDate = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                HStack {
                    VStack {
                        Text("Hi User")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom("RedditSans-Bold", size: 24))
                        Text("Welcome back")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom("RedditSans-Regular", size: 16))
                    }
                    
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 40))
                }
                .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(red: 0.988, green: 0.988, blue: 0.988))
                        .frame(width: 350, height: 200)
                        .padding()
                        .opacity(0.5)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.961, green: 0.373, blue: 0.592), Color(red: 0.98, green: 0.404, blue: 0.518), Color(red: 0.98, green: 0.431, blue: 0.451)]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 348, height: 198)
                        .padding()
                    
                    VStack {
                        if !ongoingGames.isEmpty {
                            HStack {
                                VStack {
                                    Image("\(ongoingGames[0].awayTeam.teamSlug)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75, alignment: .bottom)
                                    
                                    Text("\(ongoingGames[0].awayTeam.teamName)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.custom("RedditSans-Bold", size: 16))
                                    Text("\(ongoingGames[0].awayTeam.wins) - \(ongoingGames[0].awayTeam.losses)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.custom("RedditSans-Bold", size: 16))
                                        .opacity(0.75)
                                }
                                
                                VStack {
                                    Text("\(ongoingGames[0].gameStatus)".uppercased())
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.custom("RedditSans-Regular", size: 16))
                                        .opacity(0.75)
                                    Text("\(ongoingGames[0].homeTeam.score) - \(ongoingGames[0].awayTeam.score)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.custom("RedditSans-Bold", size: 24))
                                }
                                
                                VStack {
                                    Image("\(ongoingGames[0].homeTeam.teamSlug)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 75, alignment: .bottom)
                                    
                                    Text("\(ongoingGames[0].homeTeam.teamName)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.custom("RedditSans-Bold", size: 16))
                                    Text("\(ongoingGames[0].homeTeam.wins) - \(ongoingGames[0].homeTeam.losses)")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.custom("RedditSans-Bold", size: 16))
                                        .opacity(0.75)
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            ProgressView()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding()
                }
                .frame(width: 350, height: 200)
                
                VStack {
                    Text("Ongoing Games")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("RedditSans-Bold", size: 24))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            if !ongoingGames.isEmpty {
                                ForEach(1..<ongoingGames.count, id: \.self) { index in
                                    let game = ongoingGames[index]
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color(red: 0.988, green: 0.988, blue: 0.988))
                                            .frame(width: 175, height: 200)
                                            .padding()
                                            .opacity(0.5)
                                        
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.961, green: 0.373, blue: 0.592), Color(red: 0.98, green: 0.404, blue: 0.518), Color(red: 0.98, green: 0.431, blue: 0.451)]), startPoint: .leading, endPoint: .trailing))
                                            .frame(width: 173, height: 198)
                                            .padding()
                                        
                                        VStack {
                                            HStack {
                                                Text("\(game.gameStatus)".uppercased())
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal, 15)
                                                    .background(.black.opacity(0.25))
                                                    .clipShape(Capsule())
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                            .padding(.bottom, 5)
                                            
                                            HStack {
                                                Image("\(game.awayTeam.teamSlug)")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 60)
                                                
                                                Spacer()
                                                
                                                Image("\(game.homeTeam.teamSlug)")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 60)
                                            }
                                            .padding(.horizontal)
                                            
                                            HStack {
                                                Text("\(game.awayTeam.teamName)")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                Text("\(game.awayTeam.score)")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.horizontal)
                                            
                                            HStack {
                                                Text("\(game.homeTeam.teamName)")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                Text("\(game.homeTeam.score)")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.horizontal)
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(width: 175, height: 200)
                                    
                                }
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
                .padding()
                
                VStack {
                    Text("Upcoming Games")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("RedditSans-Bold", size: 24))
                    
                    VStack(spacing: 20) {
                        if !upcomingGames.isEmpty {
                            ForEach(upcomingGames, id: \.gameId) { game in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color(red: 0.988, green: 0.988, blue: 0.988))
                                        .frame(width: 350, height: 75)
                                        .padding()
                                        .opacity(0.5)
                                    
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.961, green: 0.373, blue: 0.592), Color(red: 0.98, green: 0.404, blue: 0.518), Color(red: 0.98, green: 0.431, blue: 0.451)]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: 348, height: 73)
                                        .padding()
                                    
                                        HStack {
                                            
                                            Image("\(game.awayTeam.teamSlug)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            
                                            Text(game.awayTeam.teamName)
                                                .font(.custom("RedditSans-Bold", size: 16))
                                            
                                            Spacer()
                                            
                                            Text(game.gameDateTime, style: .time)
                                                .font(.custom("RedditSans-Regular", size: 14))
                                                .opacity(0.75)
                                            
                                            
                                            Spacer()
                                            
                                            
                                            Text(game.homeTeam.teamName)
                                                .font(.custom("RedditSans-Bold", size: 16))
                                            
                                            Image("\(game.homeTeam.teamSlug)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        }
                                    .frame(width: 350)
                                    .padding(.horizontal)
                                }
                            }
                        } else {
                            ProgressView()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
        .background(Color(red: 0.086, green: 0.09, blue: 0.118))
        .task {
            await loadOngoingGames()
            await loadUpcomingGames()
        }
    }
    
    func loadOngoingGames() async {
        var date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddyyyy"
        
        while ongoingGames.isEmpty {
            let result = formatter.string(from: date)
            print("Loading ongoing games for date: \(result)")
            await fetchGames(for: "10182024", isOngoing: true)
            
            if ongoingGames.isEmpty {
                if let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: date) {
                    date = previousDate
                } else {
                    print("Error adjusting date backward")
                    break
                }
            } else {
                ongoingDate = date
            }
        }
    }
    
    func loadUpcomingGames() async {
        var date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddyyyy"
        
        while upcomingGames.isEmpty {
            let result = formatter.string(from: date)
            print("Loading upcoming games for date: \(result)")
            await fetchGames(for: "10222024", isOngoing: false)
            
            if upcomingGames.isEmpty {
                if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                    date = nextDate
                } else {
                    print("Error adjusting date forward")
                    break
                }
            } else {
                upcomingDate = date
            }
        }
    }
    
    func fetchGames(for dateString: String, isOngoing: Bool) async {
        guard let url = URL(string: "https://hooperapi.onrender.com/games/\(dateString)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodedResponse = try decoder.decode(Response.self, from: data)
                
                if isOngoing {
                    ongoingGames = decodedResponse.data
                } else {
                    upcomingGames = decodedResponse.data
                }
            } catch {
                print("Decoding error: \(error)")
            }
        } catch {
            print("Network error: \(error)")
        }
    }
    
}

#Preview {
    HomeView()
}
