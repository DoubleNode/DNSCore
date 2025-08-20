//
//  DNSAppConstants+Formatters.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCoreThreading
import DNSError
import Foundation
#if !os(macOS)
import UIKit

extension DNSAppConstants {

    // MARK: - Thread-safe formatter factory methods
    // This approach creates formatters on-demand and is fully Sendable-compliant

    /// Returns a currency formatter configured for the current locale
    /// Creates a new instance each time to ensure thread safety
    static var defaultCurrencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter
    }

    /// Returns a currency formatter with no fraction digits
    /// Creates a new instance each time to ensure thread safety
    static var defaultCurrencyIntFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }

    /// Returns a distance formatter configured for the current locale
    /// Creates a new instance each time to ensure thread safety
    static var defaultDistanceFormatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter
    }

    /// Returns an integer formatter configured for the current locale
    /// Creates a new instance each time to ensure thread safety
    static var defaultIntFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }

    /// Returns a percentage formatter configured for the current locale
    /// Creates a new instance each time to ensure thread safety
    static var defaultPercentageFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        return formatter
    }

    // MARK: - Cached formatter access (for performance-critical scenarios)

    private static let currencyFormatterCache = FormatterCache<NumberFormatter> {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter
    }

    private static let currencyIntFormatterCache = FormatterCache<NumberFormatter> {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }

    private static let distanceFormatterCache = FormatterCache<MeasurementFormatter> {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter
    }

    private static let intFormatterCache = FormatterCache<NumberFormatter> {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }

    private static let percentageFormatterCache = FormatterCache<NumberFormatter> {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        return formatter
    }

    /// Returns a cached currency formatter (better performance for repeated use)
    public static func cachedCurrencyFormatter() -> NumberFormatter {
        currencyFormatterCache.formatter
    }

    /// Returns a cached currency int formatter (better performance for repeated use)
    public static func cachedCurrencyIntFormatter() -> NumberFormatter {
        currencyIntFormatterCache.formatter
    }

    /// Returns a cached distance formatter (better performance for repeated use)
    public static func cachedDistanceFormatter() -> MeasurementFormatter {
        distanceFormatterCache.formatter
    }

    /// Returns a cached int formatter (better performance for repeated use)
    public static func cachedIntFormatter() -> NumberFormatter {
        intFormatterCache.formatter
    }

    /// Returns a cached percentage formatter (better performance for repeated use)
    public static func cachedPercentageFormatter() -> NumberFormatter {
        percentageFormatterCache.formatter
    }

    /// Clears all cached formatters to force recreation with current locale
    public static func clearFormatterCache() {
        currencyFormatterCache.clear()
        currencyIntFormatterCache.clear()
        distanceFormatterCache.clear()
        intFormatterCache.clear()
        percentageFormatterCache.clear()
    }

    /// Updates formatters when locale changes
    public static func refreshFormattersForLocaleChange() {
        clearFormatterCache()
        // Pre-warm cache with new locale
        _ = cachedCurrencyFormatter()
        _ = cachedCurrencyIntFormatter()
        _ = cachedDistanceFormatter()
        _ = cachedIntFormatter()
        _ = cachedPercentageFormatter()
    }
}

// MARK: - Thread-safe formatter cache implementation

private final class FormatterCache<T>: @unchecked Sendable {
    private let lock = NSLock()
    private var _formatter: T?
    private let factory: () -> T

    init(factory: @escaping () -> T) {
        self.factory = factory
    }

    var formatter: T {
        lock.lock()
        defer { lock.unlock() }

        if let formatter = _formatter {
            return formatter
        }

        let formatter = factory()
        _formatter = formatter
        return formatter
    }

    func clear() {
        lock.lock()
        defer { lock.unlock() }
        _formatter = nil
    }
}

#endif
