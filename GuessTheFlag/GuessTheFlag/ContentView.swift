//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by mac on 2022-04-30.
//

import SwiftUI

struct FlagImage: View {
    var arr:String
    
    var body: some View {
        Image(arr)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(color: .white, radius: 70, x: 5, y: 5)
    }
}



struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var score = 0
    
    
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
            LinearGradient(colors: [.blue,.black], startPoint: .top, endPoint: .bottom)
//            RadialGradient(stops: [
//                .init(color: .blue, location: 0.7),
//                .init(color: .red, location: 0.3)
//            ], center: .top, startRadius:550, endRadius: 70)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing:30) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label: {
                            
                            //FlagImage(arr: countries, num: number)
                            FlagImage(arr:countries[number])
//                            Image(countries[number])
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(color: .white, radius: 70, x: 5, y: 5)
                        }
                        
                    }
                }
            
                .frame(maxWidth:.infinity)
                .padding(.vertical,10)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }.padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue",action: askQuestion)
        }message: {
            Text("Your score is \(currentScore)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 10
            currentScore = 10
            
        }else{
            scoreTitle = "Wrong"
            currentScore = 0
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
