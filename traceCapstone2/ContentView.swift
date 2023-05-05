import SwiftUI

struct ContentView: View {
    @State private var selectedMeasurement = 0
    @State private var selectedUnit = 0
    @State private var quantityString = ""
    let measurements = ["Feet", "Inches", "Miles", "Yards"]
    let units = ["Meters", "Centimeters", "Kilometers"]

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
            Form {
                Section(header: Text("Measurement to convert")) {
                    Picker("Measurement", selection: $selectedMeasurement) {
                        ForEach(0 ..< measurements.count) {
                            Text(self.measurements[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Quantity")) {
                    TextField("Enter quantity", text: $quantityString)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Converted value")) {
                    HStack {
                        Text("\(convertedMeasurement, specifier: "%.2f")")
                        Picker("Unit", selection: $selectedUnit) {
                            ForEach(0 ..< units.count) {
                                Text(self.units[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .padding()
            .navigationTitle("Measurement Converter")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
