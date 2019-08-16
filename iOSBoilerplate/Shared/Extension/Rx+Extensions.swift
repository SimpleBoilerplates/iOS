//
//  Rx+Extensions.swift
//  iOSBoilerplate
//
//  Created by sadman samee on 8/14/19.
//  Copyright © 2019 sadman samee. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType {
    func currentAndPrevious() -> Observable<(current: Element, previous: Element)> {
        return multicast({ () -> PublishSubject<Element> in PublishSubject<Element>() }) { (values: Observable<Element>) -> Observable<(current: Element, previous: Element)> in
            let pastValues = Observable.merge(values.take(1), values)

            return Observable.combineLatest(values.asObservable(), pastValues) { current, previous in
                (current: current, previous: previous)
            }
        }
    }
}

infix operator <->

func <-><T: Equatable>(lhs: BehaviorRelay<T>, rhs: BehaviorRelay<T>) -> Disposable {
    typealias ItemType = (current: T, previous: T)

    return Observable.combineLatest(lhs.currentAndPrevious(), rhs.currentAndPrevious())
            .filter { (first: ItemType, second: ItemType) -> Bool in
                first.current != second.current
            }
            .subscribe(onNext: { (first: ItemType, second: ItemType) in
                if first.current != first.previous {
                    rhs.accept(first.current)
                } else if second.current != second.previous {
                    lhs.accept(second.current)
                }
            })
}

func <-><T: Equatable>(lhs: ControlProperty<T>, rhs: BehaviorRelay<T>) -> Disposable {
    typealias ItemType = (current: T, previous: T)

    return Observable.combineLatest(lhs.currentAndPrevious(), rhs.currentAndPrevious())
            .filter { (first: ItemType, second: ItemType) -> Bool in
                first.current != second.current
            }
            .subscribe(onNext: { (first: ItemType, second: ItemType) in
                if first.current != first.previous {
                    rhs.accept(first.current)
                } else if second.current != second.previous {
                    lhs.onNext(second.current)
                }
            })
}
