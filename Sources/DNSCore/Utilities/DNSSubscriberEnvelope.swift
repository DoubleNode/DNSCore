//
//  DNSSubscriberEnvelope.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

@preconcurrency import Combine
import Foundation
import os.lock

public final class DNSSubscriberEnvelope: @unchecked Sendable {
    private static let subscribersLock = OSAllocatedUnfairLock(initialState: [AnyCancellable]())

    public static var subscribers: [AnyCancellable] {
        get {
            subscribersLock.withLock { $0 }
        }
        set {
            subscribersLock.withLock { $0 = newValue }
        }
    }

    private static func addSubscriber(_ subscriber: AnyCancellable) {
        subscribersLock.withLock { subscribers in
            subscribers.append(subscriber)
        }
    }

    private static func removeSubscriber(_ subscriber: AnyCancellable) {
        subscribersLock.withLock { subscribers in
            subscribers.removeAll { $0 == subscriber }
        }
    }

    private let subscriberLock = OSAllocatedUnfairLock(initialState: Optional<AnyCancellable>.none)

    private var _subscriber: AnyCancellable? {
        get {
            subscriberLock.withLock { $0 }
        }
        set {
            subscriberLock.withLock { currentSubscriber in
                // Remove old subscriber if it exists
                if let oldSubscriber = currentSubscriber {
                    Self.removeSubscriber(oldSubscriber)
                }

                // Set new subscriber
                currentSubscriber = newValue

                // Add new subscriber if it exists
                if let newSubscriber = newValue {
                    Self.addSubscriber(newSubscriber)
                }
            }
        }
    }

    public required init(with newSubscriber: AnyCancellable? = nil) {
        if let newSubscriber = newSubscriber {
            self.open(with: newSubscriber)
        }
    }

    public func open(with newSubscriber: AnyCancellable) {
        self._subscriber = newSubscriber
    }

    public func close() {
        self._subscriber = nil
    }
}
