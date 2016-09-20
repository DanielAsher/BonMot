//
//  AdaptiveStyleTests.swift
//
//  Created by Brian King on 9/2/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import XCTest
import BonMot

@available(iOS 10.0, *)
let defaultTraitCollection = UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.large.compatible)

// These tests rely on iOS 10.0 APIs. Test method needs to be updated to run on iOS 9.0
@available(iOS 10.0, *)
class AdaptiveStyleTests: XCTestCase {

    func testFontControlSizeAdaption() {
        let inputFont = UIFont.systemFont(ofSize: 28)
        let style = BonMot(.font(inputFont), .adapt(.control))
        print(style.attributes())
        let testAttributes = { (contentSizeCategory: BonMotContentSizeCategory) -> StyleAttributes in
            let traitCollection = UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
            return NSAttributedString.adapt(attributes: style.attributes(), to: traitCollection)
        }
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraSmall.compatible), query: { $0.pointSize }, float: 25)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.small.compatible), query: { $0.pointSize }, float: 26)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.medium.compatible), query: { $0.pointSize }, float: 27)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.large.compatible), query: { $0.pointSize }, float: 28)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraLarge.compatible), query: { $0.pointSize }, float: 30)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraLarge.compatible), query: { $0.pointSize }, float: 32)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraExtraLarge.compatible), query: { $0.pointSize }, float: 34)

        // Ensure the accessibility ranges are capped at XXXL
        for size in [UIContentSizeCategory.accessibilityMedium.compatible,
                     UIContentSizeCategory.accessibilityLarge.compatible,
                     UIContentSizeCategory.accessibilityExtraLarge.compatible,
                     UIContentSizeCategory.accessibilityExtraExtraLarge.compatible,
                     UIContentSizeCategory.accessibilityExtraExtraExtraLarge.compatible] {
            BONAssert(attributes: testAttributes(size), query: { $0.pointSize }, float: 34)
        }
    }

    func testFontBodySizeAdaption() {
        let inputFont = UIFont.systemFont(ofSize: 28)
        let style = BonMot(.font(inputFont), .adapt(.body))
        let testAttributes = { (contentSizeCategory: BonMotContentSizeCategory) -> StyleAttributes in
            let traitCollection = UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
            return NSAttributedString.adapt(attributes: style.attributes(), to: traitCollection)
        }
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraSmall.compatible), query: { $0.pointSize }, float: 25)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.small.compatible), query: { $0.pointSize }, float: 26)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.medium.compatible), query: { $0.pointSize }, float: 27)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.large.compatible), query: { $0.pointSize }, float: 28)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraLarge.compatible), query: { $0.pointSize }, float: 30)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraLarge.compatible), query: { $0.pointSize }, float: 32)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraExtraLarge.compatible), query: { $0.pointSize }, float: 34)

        // Ensure body keeps growing
        BONAssert(attributes: testAttributes(UIContentSizeCategory.accessibilityMedium.compatible), query: { $0.pointSize }, float: 39)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.accessibilityLarge.compatible), query: { $0.pointSize }, float: 44)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.accessibilityExtraLarge.compatible), query: { $0.pointSize }, float: 51)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.accessibilityExtraExtraLarge.compatible), query: { $0.pointSize }, float: 58)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.accessibilityExtraExtraExtraLarge.compatible), query: { $0.pointSize }, float: 64)
    }

    func testPreferredFontDoesNotAdapt() {
        let font = UIFont.preferredFont(forTextStyle: titleTextStyle, compatibleWith: defaultTraitCollection)
        let style = BonMot(.font(font))
        let testAttributes = { (contentSizeCategory: BonMotContentSizeCategory) -> StyleAttributes in
            let traitCollection = UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
            return NSAttributedString.adapt(attributes: style.attributes(), to: traitCollection)
        }
        // Ensure the font doesn't change sizes since it was added to the chain as a font, and `.preferred was not added.
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraSmall.compatible), query: { $0.pointSize }, float: font.pointSize)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.small.compatible), query: { $0.pointSize }, float: font.pointSize)
    }

    func testTextStyleAdapt() {
        let style = BonMot(.textStyle(titleTextStyle), .adapt(.preferred))
        let testAttributes = { (contentSizeCategory: BonMotContentSizeCategory) -> StyleAttributes in
            let traitCollection = UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
            return NSAttributedString.adapt(attributes: style.attributes(), to: traitCollection)
        }
        // Ensure the font doesn't change sizes since it was added to the chain as a font, and `.preferred was not added.
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraSmall.compatible), query: { $0.pointSize }, float: 25)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.small.compatible), query: { $0.pointSize }, float: 26)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.medium.compatible), query: { $0.pointSize }, float: 27)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.large.compatible), query: { $0.pointSize }, float: 28)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraLarge.compatible), query: { $0.pointSize }, float: 30)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraLarge.compatible), query: { $0.pointSize }, float: 32)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraExtraLarge.compatible), query: { $0.pointSize }, float: 34)
    }

    func testPreferredFontWithPreferredAdaptation() {
        let font = UIFont.preferredFont(forTextStyle: titleTextStyle, compatibleWith: defaultTraitCollection)
        let style = BonMot(.font(font), .adapt(.preferred))
        let testAttributes = { (contentSizeCategory: BonMotContentSizeCategory) -> StyleAttributes in
            let traitCollection = UITraitCollection(preferredContentSizeCategory: contentSizeCategory)
            return NSAttributedString.adapt(attributes: style.attributes(), to: traitCollection)
        }
        // Ensure the font doesn't change sizes since it was added to the chain as a font, and `.preferred was not added.
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraSmall.compatible), query: { $0.pointSize }, float: 25)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.small.compatible), query: { $0.pointSize }, float: 26)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.medium.compatible), query: { $0.pointSize }, float: 27)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.large.compatible), query: { $0.pointSize }, float: 28)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraLarge.compatible), query: { $0.pointSize }, float: 30)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraLarge.compatible), query: { $0.pointSize }, float: 32)
        BONAssert(attributes: testAttributes(UIContentSizeCategory.extraExtraExtraLarge.compatible), query: { $0.pointSize }, float: 34)
    }

}