//
//  StoreHelper.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 4/8/23.
//

import Foundation


func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}

func writeAppState(fileName: String = "appstate", str: String = "sample") {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)

    do {
        try str.write(to: url, atomically: true, encoding: .utf8)
        //let input = try String(contentsOf: url)
        //print(input)
    } catch {
        print(error.localizedDescription)
    }
}

func readAppState(fileName: String = "appstate") -> String {
    let url = getDocumentsDirectory().appendingPathComponent(fileName)
    var str = ""
    do {
        str = try String(contentsOf: url)
    } catch {
        print(error.localizedDescription)
    }
    return str
}
