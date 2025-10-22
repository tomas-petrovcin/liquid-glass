import AppKit

@objc public enum LiquidGlassEffect: Int {
  case regular
  case clear
  case none
}

@objc public class LiquidGlassViewImpl: NSVisualEffectView {
  private var isFirstMount: Bool = true
  @objc public var effectTintColor: NSColor?
  @objc public var interactive: Bool = false
  @objc public var style: LiquidGlassEffect = .regular

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
    // There is no direct macOS equivalent of iOS 18 UIGlassEffect yet exposed in public SDKs.
    // Use NSVisualEffectView with a suitable material as a basic fallback.
    switch style {
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
    // NSVisualEffectView does not expose a direct tintColor property; ignore effectTintColor for now.
    // interactive has no direct mapping on macOS; ignore.
  }
}
