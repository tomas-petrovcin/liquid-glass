#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if compiler(>=6.2)

#if os(macOS)
@available(macOS 26.0, *)
@objc public class LiquidGlassConatinerViewImpl: NSGlassEffectContainerView {
  @objc public override var spacing: CGFloat {
    didSet {
      setupView()
    }
  }

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
    setupView()
  }

  private func setupView() {
    self.spacing = spacing
  }
}
#else
@available(iOS 26.0, *)
@objc public class LiquidGlassConatinerViewImpl: UIVisualEffectView {
  @objc public var spacing: CGFloat = 0 {
    didSet {
      setupView()
    }
  }

  public override func layoutSubviews() {
    setupView()
  }

  private func setupView() {
    let effect = UIGlassContainerEffect()
    effect.spacing = spacing
    self.effect = effect
  }
}
#endif

#else

#if os(macOS)
@objc public class LiquidGlassConatinerViewImpl: NSVisualEffectView {
  @objc public var spacing: CGFloat = 0 {
    didSet {
      setupView()
    }
  }

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
    setupView()
  }

  private func setupView() {
    // Fallback for macOS < 26.0: Use NSVisualEffectView with a basic material.
    self.material = .underWindowBackground
    self.state = .active
    // spacing has no direct equivalent; retained for API compatibility only.
  }
}
#else
@objc public class LiquidGlassConatinerViewImpl: UIView {}
#endif

#endif
