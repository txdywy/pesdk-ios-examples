//
//  CropEditorViewControllerOptions.swift
//  imglyKit
//
//  Created by Sascha Schwabbauer on 21/01/16.
//  Copyright © 2016 9elements GmbH. All rights reserved.
//

import UIKit

/// Used to configure the crop action buttons. A button and its action are given as parameters.
public typealias CropActionButtonConfigurationClosure = (ImageCaptionButton, CropRatio) -> ()

@objc(IMGLYCropEditorViewControllerOptions) public class CropEditorViewControllerOptions: EditorViewControllerOptions {
    /// Defines all allowed crop ratios. The crop ratio buttons are shown in the given order.
    /// Defaults to `Free`, `1:1`, `4:3` and `16:9`. Setting this to an empty array is ignored.
    public let allowedCropRatios: [CropRatio]

    /// This closure allows further configuration of the action buttons. The closure is called for
    /// each action button and has the button and its corresponding action as parameters.
    public let actionButtonConfigurationClosure: CropActionButtonConfigurationClosure?

    public convenience init() {
        self.init(builder: CropEditorViewControllerOptionsBuilder())
    }

    public init(builder: CropEditorViewControllerOptionsBuilder) {
        allowedCropRatios = builder.allowedCropRatios
        actionButtonConfigurationClosure = builder.actionButtonConfigurationClosure
        super.init(editorBuilder: builder)
    }
}

// swiftlint:disable type_name
@objc(IMGLYCropEditorViewControllerOptionsBuilder) public class CropEditorViewControllerOptionsBuilder: EditorViewControllerOptionsBuilder {
    // swiftlint:enable type_name

    /// Defines all allowed crop ratios. The crop ratio buttons are shown in the given order.
    /// Defaults to `Free`, `1:1`, `4:3` and `16:9`. Setting this to an empty array is ignored.
    public var allowedCropRatios: [CropRatio] = {
        let bundle = NSBundle(forClass: CropEditorViewControllerOptionsBuilder.self)
        let freeCropRatio = CropRatio(ratio: nil, title: Localize("Free"), icon: UIImage(named: "icon_crop_custom", inBundle: bundle, compatibleWithTraitCollection: nil)!)
        let oneToOneCropRatio = CropRatio(ratio: 1, title: Localize("1:1"), icon: UIImage(named: "icon_crop_square", inBundle: bundle, compatibleWithTraitCollection: nil)!)
        let fourToThreeCropRatio = CropRatio(ratio: 4 / 3, title: Localize("4:3"), icon: UIImage(named: "icon_crop_4-3", inBundle: bundle, compatibleWithTraitCollection: nil)!)
        let sixteenToNineCropRatio = CropRatio(ratio: 16 / 9, title: Localize("16:9"), icon: UIImage(named: "icon_crop_16-9", inBundle: bundle, compatibleWithTraitCollection: nil)!)

        return [freeCropRatio, oneToOneCropRatio, fourToThreeCropRatio, sixteenToNineCropRatio]
        }() {
        didSet {
            if allowedCropRatios.count == 0 {
                allowedCropRatios = oldValue
            }
        }
    }

    /// This closure allows further configuration of the action buttons. The closure is called for
    /// each action button and has the button and its corresponding action as parameters.
    public var actionButtonConfigurationClosure: CropActionButtonConfigurationClosure? = nil

    public override init() {
        super.init()

        /// Override inherited properties with default values
        self.title = Localize("Crop")
    }
}
