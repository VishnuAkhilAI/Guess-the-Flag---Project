//
//  ContentView.swift
//  Guess the Flag - Project
//
//  Created by Vishnu akhil Upparapalle on 23/11/20.
//  Copyright © 2020 Vishnu akhil Upparapalle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()// modifer to shiffle the array
    
    @State private var correctAnswer = Int.random(in: 0...2) // picks a random number in between the range.
    
    @State private var showingScore = false // property for alert (correct or wrong ans)
    @State private var scoreTitle = "" // property to store title inside the alert
    
    @State private var currentScore = 0
    
    var body: some View {
        ZStack {
           // Color.blue.edgesIgnoringSafeArea(.all) // blue backgoud ignoring the safe area
            
            LinearGradient(gradient: Gradient(colors: [.red, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)// liner gradient with colours and position
            
            VStack(spacing:30){
                VStack{
                    Text("Select the correct flag")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3){number in // Adding flages as buttons using foreach
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original) // use original image pic insead of recolourig them as button
                        .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                        
                    }
                    
                }
                
                Text("Your Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                
                Spacer()// To push the views top of the screen
            }
        }
        .alert(isPresented: $showingScore){ // Alert modifer to display the score with scoreTitle property and to call askQuestion funtion
            Alert(title: Text(scoreTitle), message: Text("Your Score is \(currentScore)"), dismissButton: .default(Text("Countinue")){
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int){ // funtion to check if the correct flag is clicked
        
        if number == correctAnswer{
            scoreTitle = "Correct Answer"
            currentScore += 1
        }else{
            scoreTitle = "Wrong! That Flag is \(countries[number])"
            currentScore -= 1
        }
        
        showingScore  = true // show the alert
    }
    
    func askQuestion(){ // funtion to cont the game after the alert
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
