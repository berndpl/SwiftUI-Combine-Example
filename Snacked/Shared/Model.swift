//
//  Model.swift
//  Snacked
//
//  Created by Bernd Plontsch on 28.06.20.
//

import Combine
import Foundation

public struct Preset:Codable {
    public var title:String
    public let colorLiteral:String
    public var calories:Double
    var id:UUID = UUID()
    
    init(title: String, calories: Double, colorLiteral:String) {
        self.title = title
        self.calories = calories
        self.colorLiteral = colorLiteral
    }
    
    public var caloriesLabel:String {
        let measurement = Measurement(value: calories, unit: UnitEnergy.calories)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: measurement)
    }
}

struct Item:Identifiable, Codable {
    public var title:String
    public var calories:Double
    public var colorLiteral:String
    public var createDate:Date
    var id:UUID = UUID()
}

class Model: ObservableObject, Codable {
    @Published var items:[Item] = Storage.loadItems() {
        didSet {
            Storage.save(model: self)
        }
    }
    @Published var presets:[Preset] = Storage.loadPresets() {
        didSet {
            Storage.save(model: self)
        }
    }
    
    // MARK: Codable
    
    enum CodingKeys: CodingKey {
        case items, presets
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
        try container.encode(presets, forKey: .presets)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Item].self, forKey: .items)
        presets = try container.decode([Preset].self, forKey: .presets)
    }
    
    init() { }
}

func defaultPresets()->[Preset] {
    let presets:[Preset] = [
        Preset(title: "🍪", calories: 230.0, colorLiteral: "systemPink"),
        Preset(title: "🥪", calories: 560.0, colorLiteral: "systemYellow"),
        Preset(title: "🥤", calories: 140.0, colorLiteral: "systemPurple")
    ]
    return presets
}
