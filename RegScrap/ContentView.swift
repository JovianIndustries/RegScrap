//
//  ContentView.swift
//  RegScrap
//
//  Created by Sebastian Bularca on 2020-02-06.
//  Copyright © 2020 Sebastian Bularca. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var regnum: String = ""
    @State private var isWaitingforInput: Bool = false
    @State var canInterract: Bool = false;
    
    var regsteal = RegSteal()
    
    var body: some View {
        VStack {
            Text("REG. NR.")
                .font(.system(size: 25.0))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextField("ABC123", text: $regnum)
                .font(.largeTitle)
                .foregroundColor(Color.red)
                .padding(.all, 5.0)
                .frame(width: 200.0, height: 50.0).multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(UITextAutocapitalizationType.allCharacters)
            
            Button(action:
                {
                    if (self.regnum.count == 6){
                        withAnimation(){
                            self.isWaitingforInput.toggle()
                        }
                        self.regsteal.submitRegistration(s: self.regnum)
                        self.regnum = ""
                    }
            } )
            {
                Text("SUBMIT")
                    .font(.system(size: 19.0))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.all, 10.0)
                    .frame(width: 120.0, height: 40)
                    .background(Color.red)
            }.padding().sheet(isPresented: $isWaitingforInput){
                if (self.regsteal.carFound){
                    ResultsView()
                }
                else {
                    CarNotFoundView(regNr: self.regnum)
                }
            }
        }
    }
}

struct ResultsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Text(RegSteal.extractedCarData.regNumber)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10.0)
                }
            Divider()
            ForEach(0 ..< RegSteal.extractedCarData.sections.count) {
                if (RegSteal.extractedCarData.data[$0] != ""){
                    CarDataView(carData: RegSteal.extractedCarData.data[$0], dataType: RegSteal.extractedCarData.sections[$0])
                }
            }
            VStack{
                Button(action: {self.presentationMode.wrappedValue.dismiss() })
                {
                    HStack {
                        Text("BACK")
                            .font(.system(size: 19.0))
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.all, 5.0)
                            .frame(width: 120.0, height: 40)
                            .background( Color.red)
                    }
                }.padding()
            }
        }
    }
}

struct CarNotFoundView : View {
    
    @Environment(\.presentationMode) var presentationMode
    var regNr: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("There was no car found associated with the registration number \(regNr) !")
                    .font(.system(size: 19.0))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.all, 5.0)
                    .background( Color.yellow)
            }

            Button(action: {self.presentationMode.wrappedValue.dismiss() })
            {
                HStack {
                    Text("BACK")
                        .font(.system(size: 19.0))
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.all, 5.0)
                        .frame(width: 120.0, height: 40)
                        .background( Color.red)
                }
            }.padding()
        }
    }
}

struct CarDataView: View {
    var carData: String
    var dataType: String
    var body: some View {
        VStack {
            HStack {
                Text(dataType)
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                    .padding(.leading, 5.0)
                Spacer()
                Text(carData)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 10.0)
            }
            Divider()
        }
    }
}
