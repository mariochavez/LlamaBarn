import Foundation

/// Static catalog of available AI models with their configurations and metadata
enum Catalog {

  // MARK: - Public Accessors

  /// Non-deprecated families, used for the catalog browse view.
  static var activeFamilies: [ModelFamily] {
    families.filter { !$0.deprecated }
  }

  /// Returns all catalog entries by traversing the hierarchy
  static func allModels() -> [CatalogEntry] {
    families.flatMap { $0.allModels }
  }

  /// Finds a catalog entry by ID by traversing the hierarchy
  static func findModel(id: String) -> CatalogEntry? {
    allModels().first { $0.id == id }
  }

  // MARK: - Helpers

  /// Helper to create dates concisely for model release dates
  static func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
  }

  /// Builds a CatalogEntry from hierarchy components
  static func entry(family: ModelFamily, size: ModelSize, build: ModelBuild)
    -> CatalogEntry
  {
    let effectiveArgs =
      (family.serverArgs ?? []) + (size.serverArgs ?? []) + (build.serverArgs ?? [])

    // Primary build = the one in size.build (higher quality, e.g. Q8)
    // Quantized builds = the ones in size.quantizedBuilds (lower quality, e.g. Q4)
    let isFullPrecision = build.downloadUrl == size.build.downloadUrl

    // Generate ID from family name + size, normalized to lowercase with dashes.
    // Quantized builds get a quantization suffix to distinguish them. The suffix is
    // the compact quantization label (e.g. "-q4", "-bf16"), expanded to the full
    // label only when sibling builds in the same size would otherwise collide —
    // see quantizationSuffix(for:in:).
    let baseId = "\(family.name) \(size.name)"
      .lowercased()
      .replacingOccurrences(of: " ", with: "-")
    let id =
      isFullPrecision
      ? baseId
      : "\(baseId)-\(quantizationSuffix(for: build, in: size))"

    return CatalogEntry(
      id: id,
      family: family.name,
      parameterCount: size.parameterCount,
      size: size.name,
      ctxWindow: size.ctxWindow,
      fileSize: build.fileSize,
      ctxBytesPer1kTokens: size.ctxBytesPer1kTokens,
      overheadMultiplier: family.overheadMultiplier,
      downloadUrl: build.downloadUrl,
      additionalParts: build.additionalParts,
      mmprojUrl: size.mmproj,
      mmprojLocalFilename: size.mmprojLocalFilename,
      serverArgs: effectiveArgs,
      icon: family.iconName,
      quantization: build.quantization,
      isFullPrecision: isFullPrecision
    )
  }

  /// Unique-within-size suffix for a quantized build's model ID.
  /// Keeps the compact label (e.g. "q4", "q8", "mxfp4") when it is unambiguous,
  /// preserving historical IDs. Expands to the full quantization label only when
  /// two builds in the same size would otherwise share a suffix (e.g. Unsloth's
  /// "UD-*" variants, which all reduce to "ud").
  static func quantizationSuffix(for build: ModelBuild, in size: ModelSize) -> String {
    let short = Format.quantization(build.quantization).lowercased()
    let sharesShort =
      size.quantizedBuilds.filter {
        Format.quantization($0.quantization).lowercased() == short
      }.count > 1
    guard sharesShort else { return short }
    // Disambiguate with the full label, dash-normalized: "UD-Q4_K_S" -> "ud-q4-k-s".
    return build.quantization
      .lowercased()
      .replacingOccurrences(of: "_", with: "-")
  }

}
