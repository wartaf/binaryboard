//
//  ImageHelper.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/3/23.
//

import Foundation
import UIKit

protocol ImageHelper{
    init(name: String)
    init(uiImage: UIImage)
    
    func getImage(name: String) -> UIImage?
    func resizeImage(image: UIImage) -> UIImage?
    func uiImageToBoard (uiImage: UIImage) -> [[Int]]
}

func convertToGrayScale(image: UIImage) -> UIImage? {
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        if let cgImg = image.cgImage {
            context?.draw(cgImg, in: imageRect)
            if let makeImg = context?.makeImage() {
                let imageRef = makeImg
                let newImage = UIImage(cgImage: imageRef)
                return newImage
            }
        }
        return UIImage()
    }

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(origin: .zero, size: newSize)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}

func uiImageToBoard(image: UIImage) -> [[Int]] {
    
    guard let cgImage = image.cgImage,
          let data = cgImage.dataProvider?.data,
          let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    assert(cgImage.colorSpace?.model == .rgb)
    //let newColImg = cgImage.copy(colorSpace: .itur_2100_HLG)
    
    let boardSize = Int( max(cgImage.height, cgImage.width) )
    var boardData: [[Int]] = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize)
    
    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
    for y in 0 ..< cgImage.height {
        for x in 0 ..< cgImage.width {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
            boardData[y][x] = ( components.r | components.g | components.b  ) > 127 ? 1 : 0
        }
    }
    return boardData
}

func getBoardGridsFromImage(name: String = "sample15x15.jpg", boardSize: Int = 5) -> [[Int]] {
    let image = UIImage(named: name)!
    //print("size:  ", image.size.height)
    
    var boardData: [[Int]] = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize)
    
    guard let cgImage1 = image.cgImage,
          let data = cgImage1.dataProvider?.data,
          let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    assert(cgImage1.colorSpace?.model == .rgb)
    
    //RESIZE
    let cgContext = CGContext(data: nil, width: boardSize, height: boardSize, bitsPerComponent: cgImage1.bitsPerComponent, bytesPerRow: cgImage1.bytesPerRow, space: cgImage1.colorSpace!, bitmapInfo: cgImage1.bitmapInfo.rawValue)
    //cgContext?.interpolationQuality = .high
    cgContext?.draw(cgImage1, in: .init(x: 0, y: 0, width: boardSize, height: boardSize))
    
    let cgImage: CGImage = (cgContext?.makeImage())!
    
    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
    for y in 0 ..< cgImage.height {
        for x in 0 ..< cgImage.width {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
            boardData[y][x] = ( ( Int(components.r) + Int(components.g) + Int(components.b )) / 3 ) > 127 ? 0 : 1
            print("[x:\(x), y:\(y)] \(components)")
        }
        //print("---")
    }
    return boardData
}


func uiImageToBoardYCBCR(image: UIImage) -> [[Int]] {
    guard let cgImage = image.cgImage,
          let data = cgImage.dataProvider?.data,
          let bytes = CFDataGetBytePtr(data) else {
        fatalError("Couldn't access image data")
    }
    assert(cgImage.colorSpace?.model == .rgb)
    
    let boardSize = Int( max(cgImage.height, cgImage.width) )
    var boardData: [[Int]] = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize)
    
    let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
    for y in 0 ..< cgImage.height {
        for x in 0 ..< cgImage.width {
            let offset = (y * cgImage.bytesPerRow) + (x * bytesPerPixel)
            let components = (r: bytes[offset], g: bytes[offset + 1], b: bytes[offset + 2])
            let ycbcr = (
                y: 16 + (65.481 * Double(components.r / 255)) + (128.553 * Double(components.g / 255)) + (24.966 * Double(components.b / 255)),
                cb: 128 + (-37.797 * Double(components.r / 255)) - (74.203 * Double(components.g / 255)) + (112.0 * Double(components.b / 255)),
                cr: 128 + (112.0 * Double(components.r / 255)) - (93.786 * Double(components.g / 255)) - (18.214 * Double(components.b / 255))
            )
            boardData[y][x] = ( ycbcr.y ) > 125 ? 0 : 1
        }
    }
    return boardData
}


