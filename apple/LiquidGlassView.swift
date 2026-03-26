#if os(macOS)
import AppKit
#else
import UIKit
#endif

@objc public enum LiquidGlassEffect: Int {
  case regular
  case clear
  case none

#if compiler(>=6.2)
  #if os(macOS)
  @available(macOS 26.0, *)
  var converted: NSGlassEffectView.Style? {
    switch self {
    case .regular:
      return .regular
    case .clear:
      return .clear
    case .none:
      return nil
    }
  }
  #else
  @available(iOS 26.0, *)
  var converted: UIGlassEffect.Style? {
    switch self {
    case .regular:
      return .regular
    case .clear:
      return .clear
    case .none:
      return nil
    }
  }
  #endif
#endif

}

#if compiler(>=6.2)

#if os(macOS)
@available(macOS 26.0, *)
@objc public class LiquidGlassViewImpl: NSGlassEffectView {
  private var isFirstMount: Bool = true
  @objc public var effectTintColor: NSColor?
  @objc public var interactive: Bool = false

  // Rename to avoid clashing with NSGlassEffectView.style
  @objc public var liquidStyle: LiquidGlassEffect = .regular

  public override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    self.wantsLayer = true
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.wantsLayer = true
  }

  public override func layout() {
    super.layout()
    if self.contentView != nil { return }
    setupView()

    if isFirstMount {
      isFirstMount = false
    }
  }

  @objc public func setupView() {
    guard #available(macOS 26.0, *) else {
      return
    }

    guard let preferredStyle = liquidStyle.converted else {
      // For .none style, we skip applying a glass effect style.
      return
    }

    // Apply to the superclass's style property
    super.style = preferredStyle
    self.tintColor = effectTintColor
    // interactive property doesn't exist on NSGlassEffectView, ignore

    if isFirstMount {
      isFirstMount = false
    }
  }
}
#else
@available(iOS 26.0, *)
@objc public class LiquidGlassViewImpl: UIVisualEffectView {
  private var isFirstMount: Bool = true
  @objc public var effectTintColor: UIColor?
  @objc public var interactive: Bool = false
  @objc public var style: LiquidGlassEffect = .regular

  public override func layoutSubviews() {
    if (self.effect != nil) { return }
    setupView()

    if isFirstMount {
      isFirstMount = false
    }
  }


  @objc public func setupView() {
    guard #available(iOS 26.0, *) else {
      return
    }

    guard let preferredStyle = style.converted else {
      UIView.animate {
        // TODO: Looks like only assigning nil is not working, check this after stable iOS 26 is rolled out.
        self.effect = UIVisualEffect()
      }
      return
    }

    let glassEffect = UIGlassEffect(style: preferredStyle)
    glassEffect.isInteractive = interactive
    glassEffect.tintColor = effectTintColor

    if isFirstMount {
      self.effect = glassEffect
    } else {
      // Animate only the effect is changed after first mount.
      UIView.animate { self.effect = glassEffect }
    }
  }
}
#endif

#else

#if os(macOS)
@objc public class LiquidGlassViewImpl: NSVisualEffectView {
  private var isFirstMount: Bool = true
  @objc public var effectTintColor: NSColor?
  @objc public var interactive: Bool = false

  // Keep the same external API name on older macOS, but it doesn't clash here.
  @objc public var liquidStyle: LiquidGlassEffect = .regular

  public override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    self.wantsLayer = true
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.wantsLayer = true
  }

  public override func layout() {
    super.layout()
    if self.material != .appearanceBased { return }
    setupView()

    if isFirstMount {
      isFirstMount = false
    }
  }

  @objc public func setupView() {
    // Fallback for macOS < 26.0: Use NSVisualEffectView with a suitable material.
    switch liquidStyle {
    case .regular:
      self.material = .hudWindow
    case .clear:
      self.material = .underWindowBackground
    case .none:
      self.state = .inactive
      self.material = .appearanceBased
      return
    }

    self.state = .active
    // NSVisualEffectView does not expose a direct tintColor property; ignore effectTintColor.
    // interactive has no direct mapping on macOS; ignore.
  }
}
#else
@objc public class LiquidGlassViewImpl: UIView {}
#endif

#endif

