//
//  Inspire.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

public struct Inspire {

    /// 当前实例
    public static var current = Inspire()
    
    /// 颜色
    public struct InColor {
        
        /// 主题色
        public var theme = UIColor("#FF6868")
        
        /// 强调色
        public var accent = UIColor("#1BCBFA")
        
        /// 背景色
        public var background = UIColor("#EFEFEF")
        
        /// 成功的颜色
        public var success = UIColor("#34C749")
        
        /// 警告的颜色
        public var warning = UIColor("#FDBD41")
        
        /// 失败的颜色
        public var failure = UIColor("#F44336")
    }
    
    /// 字体
    public struct InFont {
        public enum Style: String {
            case title = "title"
            case body = "body"
            case number = "number"
            case code = "code"
        }
        
        /// 标题部分字体名
        public var title = "ChalkboardSE-Bold"
        /// 正文部分字体名
        public var body = "ChalkboardSE-Regular"
        /// 数字部分字体名
        public var number = "Courier"
        /// 代码部分字体名
        public var code = "Menlo-Regular"
        
        /// 字号缩放倍数
        public var scale = CGFloat(1)
        
    }
    
    /// 布局
    public struct InLayout {
        
        /// 圆角
        public struct CornerRadius {
            public var large = CGFloat(16)
            public var medium = CGFloat(12)
            public var regular = CGFloat(8)
            public var small = CGFloat(4)
        }
        
        /// 填充
        public var padding = CGFloat(8)
        
        /// 余量
        public var margin = CGFloat(16)
        
        /// 圆角
        public var cornerRadius = CornerRadius()
        
        /// 行高
        public var rowHeight = CGFloat(50)
        
    }

    
    /// 颜色
    public var color = InColor()
    
    /// 字体
    public var font = InFont()
    
    /// 布局
    public var layout = InLayout()
    
    /// 创建默认实例
    public init() {
        
    }
    
    
}


// MARK: - 多主题
extension Inspire {
    
    /// 根据字典来创建主题模型
    ///
    /// - Parameter dictionary: 字典
    public init(_ dictionary: [String: Any]) {
        if let dict = dictionary["Color"] as? [String: String] {
            color.theme = UIColor(dict["theme"] ?? "#FF6868")
            color.accent = UIColor(dict["accent"] ?? "#1BCBFA")
            color.background = UIColor(dict["background"] ?? "#EFEFEF")
            color.success = UIColor(dict["background"] ?? "#34C749")
            color.warning = UIColor(dict["warning"] ?? "#FDBD41")
            color.failure = UIColor(dict["failure"] ?? "#F44336")
        }
        if let dict = dictionary["Font"] as? [String: String] {
            font.title = dict["title"] ?? "Courier"
            font.body = dict["body"] ?? "Courier"
            font.number = dict["number"] ?? "Courier"
            font.code = dict["code"] ?? "Courier"
            if let str = dict["scale"] {
                if let d = Double(str) {
                    font.scale = CGFloat(d)
                }
            }
        }
        if let dict = dictionary["Layout"] as? [String: Any] {
            if let str = dict["padding"] as? String {
                if let d = Double(str) {
                    layout.padding = CGFloat(d)
                }
            }
            if let str = dict["margin"] as? String {
                if let d = Double(str) {
                    layout.margin = CGFloat(d)
                }
            }
            if let str = dict["rowHeight"] as? String {
                if let d = Double(str) {
                    layout.rowHeight = CGFloat(d)
                }
            }
            if let dict2 = dict["cornerRadius"] as? [String: String] {
                if let str = dict2["large"] {
                    if let d = Double(str) {
                        layout.cornerRadius.large = CGFloat(d)
                    }
                }
                if let str = dict2["medium"] {
                    if let d = Double(str) {
                        layout.cornerRadius.medium = CGFloat(d)
                    }
                }
                if let str = dict2["regular"] {
                    if let d = Double(str) {
                        layout.cornerRadius.regular = CGFloat(d)
                    }
                }
                if let str = dict2["small"] {
                    if let d = Double(str) {
                        layout.cornerRadius.small = CGFloat(d)
                    }
                }
            }
            
        }
    }
    
    /// 应用主题
    ///
    /// - Parameter ins: 主题模型
    public static func apply(_ ins: Inspire) {
        current = ins
    }
    
    /// 导出主题
    ///
    /// - Returns: 字典
    public func export() -> [String: [String: Any]] {
        var result = [String: [String: Any]]()
        let fontDict = [InFont.Style.title.rawValue: font.title,
                        InFont.Style.body.rawValue: font.body,
                        InFont.Style.number.rawValue: font.number,
                        InFont.Style.code.rawValue: font.code,
                        "scale": String(Double(font.scale))]
        let colorDict = ["theme": color.theme.hexString,
                         "accent": color.accent.hexString,
                         "background": color.background.hexString,
                         "success": color.success.hexString,
                         "warning": color.warning.hexString,
                         "failure": color.failure.hexString]
        var layoutDict = [String: Any]()
        layoutDict["padding"] = String(Double(layout.padding))
        layoutDict["margin"] = String(Double(layout.margin))
        layoutDict["rowHeight"] = String(Double(layout.rowHeight))
        let cornerRadiusDict = ["large": String(Double(layout.cornerRadius.large)),
                                "medium": String(Double(layout.cornerRadius.medium)),
                                "regular": String(Double(layout.cornerRadius.regular)),
                                "small": String(Double(layout.cornerRadius.small))]
        layoutDict["cornerRadius"] = cornerRadiusDict
        result["Font"] = fontDict
        result["Color"] = colorDict
        result["Layout"] = layoutDict
        return result
    }
    
}
