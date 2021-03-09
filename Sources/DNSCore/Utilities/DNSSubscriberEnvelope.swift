//
//  DNSSubscriberEnvelope.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import Combine

public class DNSSubscriberEnvelope {
    public static var subscribers: [AnyCancellable] = []
    
    var subscriber: AnyCancellable? {
        willSet {
            guard newValue != subscriber else { return }
            guard let oldSubscriber = subscriber else { return }
            DNSSubscriberEnvelope.subscribers.removeAll { $0 == oldSubscriber }
        }
        didSet {
            guard oldValue != subscriber else { return }
            guard let newSubscriber = subscriber else { return }
            DNSSubscriberEnvelope.subscribers.append(newSubscriber)
        }
    }

    public required init(with newSubscriber: AnyCancellable? = nil) {
        guard let newSubscriber = subscriber else { return }
        self.open(with: newSubscriber)
    }
    public func open(with newSubscriber: AnyCancellable) {
        self.subscriber = newSubscriber
    }
    public func close() {
        self.subscriber = nil
    }
}
