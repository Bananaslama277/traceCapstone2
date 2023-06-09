import SwiftUI
//Creates ugly custom colors
struct CustomColor {
    static let brightRed = Color("brightRed")
    static let darkBrown = Color("darkBrown")
    static let lime = Color("lime")
    static let magenta1 = Color("magenta1")
}

struct ContentView: View {
        @State private var selectedMeasurement = 0
    @State private var selectedUnit = 0
    @State private var quantityString = ""
    let measurements = ["Feet", "Inches", "Miles", "Yards"]
    let units = ["Meters", "Centimeters", "Kilometers"]
    
    //For rotation effect
    @State private var angle = 0.0
    @State private var borderThickness = 1.0
    
    @State var deathSpinCount = 0
    @State var faceImageArray = 0
    @State var faceImage = ["Image", "blood"]
    var convertedMeasurement: Double {
        let quantity = Double(quantityString) ?? 0.0
        var convertedValue: Double = 0.0
        switch selectedMeasurement {
        case 0: // Feet
            convertedValue = quantity * 0.3048
        case 1: // Inches
            convertedValue = quantity * 0.0254
        case 2: // Miles
            convertedValue = quantity * 1609.34
        case 3: // Yards
            convertedValue = quantity * 0.9144
        default:
            break
        }
        switch selectedUnit {
        case 0: // Meters
            break
        case 1: // Centimeters
            convertedValue *= 100
        case 2: // Kilometers
            convertedValue /= 1000
        default:
            break
        }
        return convertedValue
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                
                //Unpleasant gradient
                Rectangle()
                    .fill(Gradient(colors: [CustomColor.brightRed, CustomColor.darkBrown, CustomColor.magenta1, CustomColor.lime]))
                        .ignoresSafeArea()

                VStack{
                    
                    Text("Super Cool Awesome Measurement Converter")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(CustomColor.lime)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    Form {
                        
                        
                        Section(header: Text("Measurement to convert")) {
                            Picker("Measurement", selection: $selectedMeasurement) {
                                ForEach(0 ..< measurements.count) {
                                    Text(self.measurements[$0])

                                }
                            }

                            .pickerStyle(SegmentedPickerStyle())

                        }                            .foregroundColor(CustomColor.lime)

                        
                        
                        Section(header: Text("Quantity")) {
                            TextField("Enter quantity", text: $quantityString)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                        }                            .foregroundColor(CustomColor.lime)

                        
                        
                        Section(header: Text("Converted value")
                            .foregroundColor(CustomColor.lime)){
                            HStack {
                                Text("\(convertedMeasurement, specifier: "%.2f")")
                                Picker("Unit", selection: $selectedUnit) {
                                    ForEach(0 ..< units.count) {
                                        Text(self.units[$0])
                                            .padding()
                                    }

                                }.pickerStyle(SegmentedPickerStyle())
                                
                            }.foregroundColor(CustomColor.brightRed)
                                .fontWeight(.semibold)
                            }
                        
                    }.scrollContentBackground(.hidden)
                    .font(.headline)
                    .fontWeight(.heavy)
                    
                    VStack{
                        
                        // Face spins when tapped, dies after 10
                        Button(action: {
                            angle += 360
                            borderThickness += 1
                            deathSpinCount += 1
                            if (deathSpinCount >= 10) {
                                faceImageArray = 1
                            }
                            
                        }) { Image (faceImage[faceImageArray])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding(.vertical)
                        .frame(maxWidth: UIScreen.main.bounds.width,
                               maxHeight: UIScreen.main.bounds.height)
                        .rotationEffect(.degrees(angle))
                        .animation(.default, value: angle)
                        
                        //Revives face when tapped
                        Button(action: {
                            faceImageArray = 0
                            deathSpinCount = 0
                        }) { Text ("The sun smiles at you with eternal malice.")
                                .fontWeight(.bold)
                                .foregroundColor(Color("brightRed"))
                                .multilineTextAlignment(.center)
                            
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
