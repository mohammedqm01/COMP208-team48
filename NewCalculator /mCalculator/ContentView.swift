//
//  ContentView.swift
//  mCalculator
//
//  Created by mohammed qasim on 17/04/2023.
//




import SwiftUI

struct ContentView: View {
    @State private var components: [Component] = [Component(id: UUID(), weightage: "", score: "")]
    @State private var subjectName: String = ""
    @State private var subjects: [Subject] = []

    private func calculateTotalScore() {
        var totalScore: Double = 0.0

        for component in components {
            guard let weightage = Double(component.weightage), let score = Double(component.score) else {
                return
            }
            totalScore += (score * weightage) / 100
        }

        if !subjectName.isEmpty {
            let newSubject = Subject(id: UUID(), name: subjectName, weightage: components, totalScore: totalScore)
            subjects.append(newSubject)
        }

        components = [Component(id: UUID(), weightage: "", score: "")]
        subjectName = ""
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter subject name", text: $subjectName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            ForEach(components.indices, id: \.self) { index in
                HStack {
                    TextField("Percentage", text: $components[index].weightage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 100)

                    TextField("Score", text: $components[index].score)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
            }

            Button(action: {
                components.append(Component(id: UUID(), weightage: "", score: ""))
            }) {
                Text("Add More Grade")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: calculateTotalScore) {
                Text("Calculate Total")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            List {
                ForEach(subjects) { subject in
                    VStack(alignment: .leading) {
                        
                        
                        HStack {
                            Text(subject.name)
                                .font(.headline)
                            Text("Overall: \(subject.totalScore, specifier: "%.2f")")
                                .font(.subheadline)
                        }

                        
                        
                        

                        ForEach(subject.weightage) { component in
                            HStack {
                                Text("Percentage: \(component.weightage)%")
                                Text("Score: \(component.score)")
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct Component: Identifiable {
    let id: UUID
    var weightage: String
    var score: String
}

struct Subject: Identifiable {
    let id: UUID
    let name: String
    let weightage: [Component]
    let totalScore: Double
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
