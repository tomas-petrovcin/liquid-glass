import AppKit

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
    // No direct glass container effect on macOS; choose a basic material.
    self.material = .underWindowBackground
    self.state = .active
    // spacing has no direct equivalent; retained for API compatibility only.
  }
}
