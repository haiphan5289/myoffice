//
//  Tracking.swift
//  guest-escort
//
//  Created by MacbookPro on 4/23/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD
import Firebase

// MARK: - Replay
@propertyWrapper
struct Replay<T> {
    private let _event: ReplaySubject<T>
    private let queue: ImmediateSchedulerType
    init(bufferSize: Int, queue: ImmediateSchedulerType) {
        self.queue = queue
        _event = ReplaySubject<T>.create(bufferSize: bufferSize)
    }
    
    init(queue: ImmediateSchedulerType) {
        self.queue = queue
       _event = ReplaySubject<T>.create(bufferSize: 1)
    }
    
    var wrappedValue: T {
        get {
            fatalError("Do not get value from this!!!!")
        }
        
        set {
            _event.onNext(newValue)
        }
    }
    
    var projectedValue: Observable<T> {
        return _event.observeOn(queue)
    }
}

// MARK: - BehaviorReplay
@propertyWrapper
struct VariableReplay<T> {
    private let replay: BehaviorRelay<T>
    
    init(wrappedValue: T) {
        replay = BehaviorRelay(value: wrappedValue)
    }
    
    var wrappedValue: T {
        get {
            return replay.value
        }
        
        set {
            replay.accept(newValue)
        }
    }
    
    var projectedValue: BehaviorRelay<T> {
        return replay
    }
}

public class ActivityProgressIndicator: SharedSequenceConvertibleType {
    public typealias SharingStrategy = DriverSharingStrategy
    public typealias Element = (Bool, Double)
    @VariableReplay private var progress: Double = 0
    @VariableReplay private var _relay: Int = 0
    private var disposeProgress: Disposable?
    private var disposeComplete: Disposable?
    /// Class's constructors.
    public init() {
        setup()
    }
    
    private func setup() {
        let load = Observable.combineLatest($_relay.map ({ $0 > 0 })
            .distinctUntilChanged(), $progress) {
                return ($0, $1)
        }
        _loading = load.asDriver(onErrorJustReturn: (false, 0))
    }
    
    private func createProgress() {
        disposeProgress?.dispose()
        disposeComplete?.dispose()
        
        var current: Double = 0
        disposeProgress = Observable<Int>.interval(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.asyncInstance).bind(onNext: { [weak self](_) in
            guard let wSelf = self, wSelf._relay > 0 else {
                return
            }
            
            let v = wSelf._relay
            current += 1
            let p = min(current / (100 * Double(v)), 1)
            self?.progress = p
        })
        
        disposeComplete = $_relay.filter ({ $0 == 0 }).take(1).bind(onNext: { [weak self](_) in
            self?.disposeProgress?.dispose()
        })
    }
    
    // MARK: Class's public methods
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        return _loading
    }
    
    // MARK: Class's internal methods
// MARK: Class's internal methods
internal func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
    return Observable.using({ () -> ActivityToken<Source.Element> in
        self.increment()
        return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
    }) { t in
        return t.asObservable()
    }
}
    
    // MARK: Class's private methods
    private func increment() {
        _lock.lock()
        _relay += 1
        createProgress()
        _lock.unlock()
    }
    
    private func decrement() {
        _lock.lock()
        _relay -= 1
        _lock.unlock()
    }
    
    /// Class's private properties.
    private let _lock = NSRecursiveLock()
    private var _loading: SharedSequence<SharingStrategy, Element>!
}

public extension ObservableConvertibleType {
    /// Disclaimer
    /// __________
    /// This code is not original. Fiision Studio only copied and pasted base on
    /// Fiision Studio's project management structure.
    ///
    /// If you are looking for original, please:
    /// - seealso:
    ///   [The RxSwift Library Reference]
    ///   (https://github.com/ReactiveX/RxSwift/blob/master/RxExample/RxExample/Services/ActivityIndicator.swift)
    func trackProgressActivity(_ activityIndicator: ActivityProgressIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}

private struct ActivityToken<E> : ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable
    
    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }
    
    func dispose() {
        _dispose.dispose()
    }
    
    func asObservable() -> Observable<E> {
        return _source
    }
}

public protocol ActivityTrackingProgressProtocol: AnyObject {
    var indicator: ActivityProgressIndicator! { get set }
}

public extension ActivityTrackingProgressProtocol {
    var indicator: ActivityProgressIndicator! {
        get {
            guard let r = objc_getAssociatedObject(self, &Loading.name) as? ActivityProgressIndicator else {
                let new = ActivityProgressIndicator()
                // set for next
                objc_setAssociatedObject(self, &Loading.name, new, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return new
            }
            return r
        }
        set {
            objc_setAssociatedObject(self, &Loading.name, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private struct Loading {
    static var name = "indicatorProgress"
}

extension ActivityTrackingProgressProtocol {
    var loadingProgress: Observable<ActivityProgressIndicator.Element> {
        return indicator.asObservable().observeOn(MainScheduler.asyncInstance)
    }
}

final class LoadingManager: NSObject, ManageListenerProtocol {
    internal var listenerManager: [Disposable] = []
    private (set) lazy var lock: NSRecursiveLock = NSRecursiveLock()
    
    static let instance = LoadingManager()
    
    func show() {
        var current: Float = 0
        let disposeProgress = Observable<Int>.interval(0.3, scheduler: MainScheduler.instance).subscribe(onNext: { (_) in
            current += 1
            let p = min(current / 100, 1)
            SVProgressHUD.showProgress(current / 100, status: "\(Int(p * 100))%")
        }, onDisposed: {
           SVProgressHUD.dismiss()
        })
        add(disposeProgress)
    }
    
    func dismiss() {
        cleanUpListener()
    }
    
}

protocol ManageListenerProtocol: AnyObject, SafeAccessProtocol {
    var listenerManager: [Disposable] { get set }
}

extension ManageListenerProtocol {
    func cleanUpListener() {
        excute(block: { [unowned self] in
            self.listenerManager.forEach({ $0.dispose() })
            self.listenerManager.removeAll()
        })
    }
    
    func add(_ disposable: Disposable) {
        excute(block: { [unowned self] in
            self.listenerManager.append(disposable)
        })
    }
}

protocol SafeAccessProtocol {
    var lock: NSRecursiveLock { get }
}

extension SafeAccessProtocol {
    @discardableResult
    func excute<T>(block: () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return block()
    }
}

