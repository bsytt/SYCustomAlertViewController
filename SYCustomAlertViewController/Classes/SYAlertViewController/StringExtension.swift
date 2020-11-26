//
//  StringExtension.swift
//  DatianFinancial
//
//  Created by gaof on 2018/8/16.
//  Copyright © 2018年 qiaoxy. All rights reserved.
//

import UIKit
import AVFoundation
import CommonCrypto
extension String {
    
    func size(with font: UIFont, maxSize: CGSize) -> CGSize{
        let attrs = [NSAttributedString.Key.font: font]
        let string = NSString(string: self)
        return string.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
    func toObj() -> Dictionary<String,Any>? {
        let data = self.data(using: .utf8)!
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
            {
                return jsonObj
            } else {
                return nil
            }
        } catch let error as NSError {
            return nil
        }
    }
    ///网络路径获取
    func oe_getScreenShotImageFromVideoURL() -> UIImage? {
        let asset = AVAsset(url: URL(string: self)!)
        let gen = AVAssetImageGenerator(asset: asset)
        gen.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 0.0, preferredTimescale: 600)
        var actualTime:CMTime = CMTime()
        var shotImage:UIImage?
        do {
            let image = try gen.copyCGImage(at: time, actualTime: &actualTime)
            shotImage = UIImage(cgImage: image)
        }catch {
            shotImage = nil
        }
        return shotImage
    }
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    //拼接必填星号
    func requiredStar() -> NSMutableAttributedString {
        let muAttri = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray6Color])
        let starAttri = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
        muAttri.append(starAttri)
        return muAttri
    }
    
    func formatterPhone() -> String {
        
        if self.count == 11 {
            let range = Range(NSRange(location: 3, length: 4), in: self)
            let formatterStr = self.replacingCharacters(in: range!, with: "****")
            
            return formatterStr
        }
        return self
    }
    func md5() -> String {
        
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
        
    }
    func changeTextColor(text: String, color: UIColor, range: NSRange) -> NSAttributedString {
        let attributeStr = NSMutableAttributedString(string:text);attributeStr.addAttribute(NSAttributedString.Key.foregroundColor, value:color , range: range)
        return attributeStr
        
    }
   
    func subString(start:Int,length:Int = -1) -> String {
        
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        
        return String(self[st ..< en])
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
    
    /// 根据亩数获得平方米
    ///
    /// - Returns: 面积平方米
    func transformMuToMeter() -> String {
        
        let area = (Double(self) ?? 0) / 0.0015
        return String(format: "%.2f", area)
    }
    
    /// 将平方米转为亩
    func transformMeterToMu() -> String {
        let acreageFloat = (Double(self) ?? 0) / 666.67
        return String(format: "%.1f", acreageFloat)
    }
    
    func getVedioImage(imageBlock:@escaping (UIImage)->()) {
        //异步获取网络视频
        DispatchQueue.global().async {
            //获取网络视频
            let videoURL = URL(string: self)!
            let avAsset = AVURLAsset(url: videoURL )
            
            //生成视频截图
            let generator = AVAssetImageGenerator(asset: avAsset)
            generator.appliesPreferredTrackTransform = true
            let time = CMTimeMakeWithSeconds(0.0,preferredTimescale: 600)
            var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
            do {
                let imageRef:CGImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
                let frameImg = UIImage(cgImage: imageRef)
                
                //在主线程中显示截图
                DispatchQueue.main.async(execute: {
                    imageBlock(frameImg)
                })
            }catch let error {
                print(error)
            }
            
        }
    }
    
    static func windOrientation(wind:String) -> String {
        var windOrientation = ""
        switch wind {
        case "0.0":
            windOrientation = "北风"
        case "22.5":
            windOrientation = "北东北风"
        case "45.0":
            windOrientation = "东北风"
        case "67.5":
            windOrientation = "东东北风"
        case "90.0":
            windOrientation = "东风"
        case "112.5":
            windOrientation = "东东南风"
        case "135.0":
            windOrientation = "东南风"
        case "157.5":
            windOrientation = "南东南风"
        case "180.0":
            windOrientation = "南风"
        case "202.5":
            windOrientation = "南西南风"
        case "225.0":
            windOrientation = "西南风"
        case "247.5":
            windOrientation = "西西南风"
        case "270.0":
            windOrientation = "西风"
        case "295.5":
            windOrientation = "西西北风"
        case "315.0":
            windOrientation = "西北风"
        case "337.5":
            windOrientation = "北西北风"
        default:
            break
        }
        return windOrientation
    }
    static func toWeekWithNumber(num:String) -> String {
        var week = ""
        switch num {
        case "1":
            week = "每周一"
        case "2":
            week = "每周二"
        case "3":
            week = "每周三"
        case "4":
            week = "每周四"
        case "5":
            week = "每周五"
        case "6":
            week = "每周六"
        case "7":
            week = "每周日"
        default:
            break
        }
        return week
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func getFileSize() -> UInt64  {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: self, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: self)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = self.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    } catch  {
                        print("error :\(error)")
                    }
                }
            } else {    // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: self)
                    size += attr[FileAttributeKey.size] as! UInt64
                    
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }
    func hasEmoji()->Bool {
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@",pattern)
        return pred.evaluate(with: self)
    }
    func containsEmoji()->Bool{
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x00A0...0x00AF,
                 0x2030...0x204F,
                 0x2120...0x213F,
                 0x2190...0x21AF,
                 0x2310...0x329F,
                 0x1F000...0x1F9CF,
                 0x1F600...0x1F64F,
                 0x1F300...0x1F5FF,
                 0x1F680...0x1F6FF,
                 0x2600...0x26FF,
                 0x2700...0x27BF,
                 0xFE00...0xFE0F:
                return true
            default:
                continue
            }
        }

        return false
    }
}
