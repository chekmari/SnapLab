//
//  Filtres.swift
//  SnapLab
//
//  Created by macbook on 25.05.2023.
//

import UIKit
import CoreImage

class ImageFilterManager {
    
    
    // MARK: - МЕТОДЫ ДЛЯ "ФИЛЬТРЫ"
    
    static func applySepiaFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        // Создание фильтра сепия
        guard let sepiaFilter = CIFilter(name: "CISepiaTone") else {
            return nil
        }
        
        // Установка входного изображения для фильтра
        sepiaFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Установка параметров фильтра
        sepiaFilter.setValue(0.8, forKey: kCIInputIntensityKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = sepiaFilter.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    
    // Применение фильтра CIPhotoEffectChrome
    static func applyChromeFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
           
        guard let filter = CIFilter(name: "CIPhotoEffectChrome") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = filter.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
           
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    // Применение фильтра CIPhotoEffectMono
    static func applyMonoFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIPhotoEffectMono")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
           
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    // Применение фильтра CIPhotoEffectNoir
    static func applyNoirFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
           
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    // Применение фильтра CIPhotoEffectInstant
    static func applyInstantFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIPhotoEffectInstant")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
           
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    // Применение фильтра CIPhotoEffectTonal
    static func applyTonalFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIPhotoEffectTonal")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
           
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    // Применение фильтра CIPhotoEffectTransfer
    static func applyTransferFilter(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        
        let filter = CIFilter(name: "CIPhotoEffectTransfer")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        // Получение отфильтрованного изображения
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        // Преобразование CIImage в UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
           
        let filteredImage = UIImage(cgImage: cgImage).fixOrientation()
        return filteredImage
    }
    
    // Применение фильтра "Без фильтра"
    static func applyNoFilter(to image: UIImage) -> UIImage? {
        return image
    }
    
    
    // MARK: - МЕТОДЫ ДЛЯ "ПОДРОБНЫЕ НАСТРОЙКИ"
    
    
    // Применение фильтра Контраст
    static func applyContrastFilter(to image: UIImage, contrast: Float) -> UIImage? {
        let ciImage = CIImage(image: image)
            
        guard let filter = CIFilter(name: "CIColorControls") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(contrast, forKey: kCIInputContrastKey)
            
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            
        return UIImage(cgImage: cgImage)
        }
        
    // Применение фильтра Резкость
    static func applySharpnessFilter(to image: UIImage, sharpness: Float) -> UIImage? {
        let ciImage = CIImage(image: image)
            
        guard let filter = CIFilter(name: "CISharpenLuminance") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(sharpness, forKey: kCIInputSharpnessKey)
            
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            
        return UIImage(cgImage: cgImage)
    }
        
    // Применение фильтра Яркость
    static func applyBrightnessFilter(to image: UIImage, brightness: Float) -> UIImage? {
        let ciImage = CIImage(image: image)
            
        guard let filter = CIFilter(name: "CIColorControls") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(brightness, forKey: kCIInputBrightnessKey)
            
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            
        return UIImage(cgImage: cgImage)
        }
        
    // Применение фильтра Насыщенность
    static func applySaturationFilter(to image: UIImage, saturation: Float) -> UIImage? {
        let ciImage = CIImage(image: image)
            
        guard let filter = CIFilter(name: "CIColorControls") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(saturation, forKey: kCIInputSaturationKey)
            
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
            
        return UIImage(cgImage: cgImage)
        }
    
    // Примененте фильтра Шум
    static func applyNoiseFilter(to image: UIImage, noise: Float) -> UIImage? {
        let ciImage = CIImage(image: image)
        
        guard let filter = CIFilter(name: "CINoiseReduction") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(noise, forKey: kCIInputSharpnessKey)
        
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }

    
    
}
    

