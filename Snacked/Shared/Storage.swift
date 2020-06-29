//
//  Storage.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

struct key {
    static let appGroup = "group.de.plontsch.food-tracker.shared"
    static let fileName = "userdata.json"
}

public class Storage {
    
    class func filePath()->URL {
        //        let fileManager = FileManager.default
        //        if let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: key.appGroup) {
        //            let file = directory.appendingPathComponent(key.fileName)
        //            return file
        //        }
        return URL(fileURLWithPath: "?!?!")
    }
    
    // MARK: - Persist Presets
    
    // MARK: - Persist State
    
    class func save(model:Model) {
        
        // Encode
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(model) else {
            fatalError("Error Encode JSON")
        }
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        // Save
        do {
            try jsonString?.write(to: Storage.filePath(), atomically: false, encoding: .utf8)
            print("Saved \(model)")
        }
        catch { fatalError("Error Writing File") }
    }
    
    class func loadItems()->[Item] {
        if let items = load()?.items {
            return items
        }
        return [Item]()
    }

    class func loadPresets()->[Preset] {
        if let presets = load()?.presets {
            return presets
        }
        return defaultPresets()
    }
    
    class func load()->Model? {
        // Read
        do {
            print("Load from \(filePath())")
            let data = try Data(contentsOf: filePath(), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            guard let state = try? jsonDecoder.decode(Model.self, from: data) else {
                print("Error decoding")
                return nil
            }
            return state
        }
        catch { print("No File Loaded") }
            
        return nil
    }
        
}
