//
//  UIKitBonMotTests.swift
//  BonMot
//
//  Created by Brian King on 9/3/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import XCTest
import BonMot

#if swift(>=2.3)

class UIKitBonMotTests: XCTestCase {

    let expectedFont = adaptiveStyle.font!

    override static func setUp() {
        super.setUp()
        NamedStyles.shared.registerStyle(forName: "adaptiveStyle", style: adaptiveStyle)
    }
    func testStyleNameGetters() {
        XCTAssertNil(UILabel().bonMotStyleName)
        XCTAssertNil(UITextField().bonMotStyleName)
        XCTAssertNil(UITextView().bonMotStyleName)
        XCTAssertNil(UIButton().bonMotStyleName)
    }

    func testLabelExtensions() {
        let label = UILabel()
        // Make sure the test is valid and the font is different
        XCTAssertNotEqual(label.font, expectedFont)

        label.styledText = "."

        // Assign a style by name and ensure the lookup succeeds
        label.bonMotStyleName = "adaptiveStyle"
        XCTAssertNotNil(label.bonMotStyle)

        XCTAssertEqual(label.styledText, label.text)
        XCTAssertEqual((label.attributedText?.attributes(at: 0, effectiveRange: nil)[NSFontAttributeName] as? UIFont)!, expectedFont)
        BONAssertColor(inAttributes: label.attributedText?.attributes(at: 0, effectiveRange: nil), key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)

        // Update the trait collection and ensure the font grows.
        if #available(iOS 10.0, *) {
            label.adaptText(forTraitCollection: UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.extraLarge.compatible))
            BONAssert(attributes: label.attributedText?.attributes(at: 0, effectiveRange: nil), query: { $0.pointSize }, float: expectedFont.pointSize + 2)
            BONAssertColor(inAttributes: label.attributedText?.attributes(at: 0, effectiveRange: nil), key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)
        }
    }

    func testTextFieldExtensions() {
        let textField = UITextField()
        // Make sure the test is valid and the font is different
        XCTAssertNotEqual(textField.font, expectedFont)

        textField.styledText = "."

        // Assign a style by name and ensure the lookup succeeds
        textField.bonMotStyleName = "adaptiveStyle"
        XCTAssertNotNil(textField.bonMotStyle)

        XCTAssertEqual(textField.styledText, textField.text)
        XCTAssertEqual((textField.attributedText?.attributes(at: 0, effectiveRange: nil)[NSFontAttributeName] as? UIFont)!, expectedFont)
        BONAssertColor(inAttributes: textField.attributedText?.attributes(at: 0, effectiveRange: nil), key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)

        // Update the trait collection and ensure the font grows.
        if #available(iOS 10.0, *) {
            textField.adaptText(forTraitCollection: UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.extraLarge.compatible))
            BONAssert(attributes: textField.attributedText?.attributes(at: 0, effectiveRange: nil), query: { $0.pointSize }, float: expectedFont.pointSize + 2)
            BONAssertColor(inAttributes: textField.attributedText?.attributes(at: 0, effectiveRange: nil), key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)
        }
    }

    func testTextView() {
        let textView = UITextView()
        // Make sure the test is valid and the font is different
        XCTAssertNotEqual(textView.font, expectedFont)

        textView.styledText = "."

        // Assign a style by name and ensure the lookup succeeds
        textView.bonMotStyleName = "adaptiveStyle"
        XCTAssertNotNil(textView.bonMotStyle)

        XCTAssertEqual(textView.styledText, textView.text)
        XCTAssertEqual(textView.attributedText?.attributes(at: 0, effectiveRange: nil)[NSFontAttributeName] as? UIFont, expectedFont)
        BONAssertColor(inAttributes: textView.attributedText?.attributes(at: 0, effectiveRange: nil), key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)

        // Update the trait collection and ensure the font grows.
        if #available(iOS 10.0, *) {
            textView.adaptText(forTraitCollection: UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.extraLarge.compatible))
            BONAssert(attributes: textView.attributedText?.attributes(at: 0, effectiveRange: nil), query: { $0.pointSize }, float: expectedFont.pointSize + 2)
            BONAssertColor(inAttributes: textView.attributedText?.attributes(at: 0, effectiveRange: nil), key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)
        }
    }

    func testButton() {
        let button = UIButton()
        // Make sure the test is valid and the font is different
        XCTAssertNotEqual(button.titleLabel?.font, expectedFont)

        button.styledText = "."

        // Assign a style by name and ensure the lookup succeeds
        button.bonMotStyleName = "adaptiveStyle"
        XCTAssertNotNil(button.bonMotStyle)

        var attributes = button.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)
        XCTAssertEqual((attributes?[NSFontAttributeName] as? UIFont)!, expectedFont)
        BONAssertColor(inAttributes: attributes, key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)

        // Update the trait collection and ensure the font grows.
        if #available(iOS 10.0, *) {
            button.adaptText(forTraitCollection: UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.extraLarge.compatible))
            attributes = button.attributedTitle(for: .normal)?.attributes(at: 0, effectiveRange: nil)
            BONAssert(attributes: attributes, query: { $0.pointSize }, float: expectedFont.pointSize + 2)
            BONAssertColor(inAttributes: attributes, key: NSForegroundColorAttributeName, color: adaptiveStyle.color!)
        }
    }

    func writeTestSegmentedControl() {}
    func writeTestNavigationBar() {}
    func writeTestToolbar() {}
    func writeTestViewController() {}
    func writeTestBarButtonItem() {}

}

#endif
