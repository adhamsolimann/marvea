//
//  API.swift
//  mvp
//
//  Created by adham soliman on 03.02.23.
//
// In case of using a LocationBuilder to parse JSON response to objects,
// make server request here and save it as Locations.json, e.g:
import Foundation

func makeServerRequest() {
    guard let url = URL(string: "http://marvea-backend.adhamsoliman.workers.dev/") else { return }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                // Save the data to a .json file in project
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentDirectory.appendingPathComponent("Locations.json")
                    do {
                        try data.write(to: fileURL)
                    } catch {
                        print(fileURL)
                    }
                }
            } else {
                print("Unsuccessful HTTP response code: \(response.statusCode)")
            }
        }
    }
    task.resume()
}
