//
//  GCDTimer.swift
//  Pods
//
//  Created by 放羊的贝多芬 on 2021/9/24.
//

import UIKit

open class GCDTimerManager {
    
    public static let shared = GCDTimerManager()
    
    private var timerItems = [String: DispatchSourceTimer]()
        
    public typealias GCDTimerHandler = (GCDTimerManager) -> Void
        
    /// 定制定时器
    /// - Parameters:
    ///   - interval: 间隔
    ///   - identifier: 标识
    ///   - repeats: 是否重复
    ///   - leeway: 精度
    ///   - queue: 队列
    ///   - handler: 回调
    public func scheduleDispatchTimer(interval: DispatchTimeInterval,
                               identifier: String,
                               repeats: Bool = false,
                               leeway: DispatchTimeInterval = .seconds(0),
                               queue: DispatchQueue = .main,
                               handler: @escaping GCDTimerHandler) {
        
        guard identifier.count > 0 else { return }
        var internalTimer = timerItems[identifier]
        if internalTimer == nil {
            internalTimer = DispatchSource.makeTimerSource(queue: queue)
            timerItems[identifier] = internalTimer
            internalTimer?.resume()
        }
    
        internalTimer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            handler(self)
        }
        if repeats {
            internalTimer?.schedule(deadline: .now()+interval, repeating: interval, leeway: leeway)
        } else {
            internalTimer?.schedule(deadline: .now()+interval, leeway: leeway)
        }
    }
    
    /// 取消定时器
    /// - Parameter identifier: 标识
    public func cancelTimer(identifier: String) {
        guard identifier.count > 0 else { return }
        if let interanalTimer = timerItems[identifier] {
            interanalTimer.cancel()
            timerItems.removeValue(forKey: identifier)
        }
    }
    
    
    /// 暂停定时器
    /// - Parameter identifier: 标识
    public func suspendTimer(identifier: String) {
        guard identifier.count > 0 else { return }
        if let interanalTimer = timerItems[identifier] {
            interanalTimer.suspend()
        }
    }
}





























