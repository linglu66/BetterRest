//
//  ContentView.swift
//  BetterRest
//
//  Created by Design Work on 2020-08-16.
//  Copyright © 2020 Ling Lu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date{
           var components = DateComponents()
           components.hour = 7
           components.minute = 0
           return Calendar.current.date(from: components) ?? Date()
       }
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 2
    @State private var showingAlert = false
    @State private var alertMessage = "123"
    @State private var alertTitle = "456"
   

   
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("When do you want to wake up?").font(.headline)){
                
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden().datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header:Text("Desired amount of sleep")
                    .font(.headline)){
                        
                    
                    Stepper(value: $sleepAmount, in: 4...12, step:0.25){
                        Text("\(sleepAmount,specifier: "%g") Hours Total")
                        
                    }
                }
                
                
                Section(header:Text("Daily coffee intake")
                .font(.headline)){
                    Picker(selection: $coffeeAmount, label: Text("\(coffeeAmount) Cups")){
                        ForEach(1..<21){
                            Text("\($0)")
                        }
                    }
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if coffeeAmount == 1{
//                            Text("1 cup")
//                        }else{
//                        Text("\(coffeeAmount) Cups")
//                        }
//
//                    }
                }
                Section(header:Text("Recommended Sleep Time")){
                    Text(self.calculateBedtime()).font(.largeTitle)
                    .foregroundColor(Color(UIColor.systemOrange))
                }
                
            }.navigationBarTitle("BetterRest")
//                .navigationBarItems(trailing: Button(action: calculateBedtime) {
//                    Text("Calculate")
//                })
//                .alert(isPresented: $showingAlert){
//                    Alert(title:Text(alertTitle),message: Text(alertMessage))
//            }
        }
    }
    func calculateBedtime2() -> String {
          let model = SleepCalculator()

          let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
          let hour = (components.hour ?? 0) * 60 * 60
          let minute = (components.minute ?? 0) * 60

          do {
              let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
              let sleepTime = wakeUp - prediction.actualSleep

              let formatter = DateFormatter()
              formatter.timeStyle = .short

              return formatter.string(from: sleepTime)
          } catch {
              return "Sorry, there was a problem calculating your bedtime."
          }
    }
    func calculateBedtime() -> String{
        
        
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (components.hour ?? 0)*60*60
        let minute = (components.minute ?? 0)*60
        
        do{
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep:sleepAmount, coffee:Double(coffeeAmount))
                
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
                formatter.timeStyle = .short
                
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = formatter.string(from: sleepTime)
            
            return formatter.string(from: sleepTime)
        }catch{
//            alertTitle = "Error"
//            alertMessage = "Something went wrong"
            return "Something went wrong"
            
            
        }
//        showingAlert = true
            
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
