/// A line of a source file.
public struct SourceLine: Hashable {

  /// The source file containing the position.
  public let source: SourceFile

  /// The 1-based index of the line in `file`.
  public let number: Int

  /// Creates an instance representing the line at `index` in `source`.
  init(_ index: Int, in source: SourceFile) {
    self.source = source
    self.number = index
  }

  /// The source text contained in this line.
  public var text: Substring { source[bounds] }

  /// The bounds of this line, including any trailing newline.
  public var bounds: SourceSpan { source.bounds(of: self) }

}

extension SourceLine: CustomStringConvertible {

  public var description: String { "\(source.name):\(number)" }

}
