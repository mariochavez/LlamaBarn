import Foundation

extension Catalog {
  static let uQwen36 = ModelFamily(
    name: "U-Qwen 3.6",
    series: "qwen",
    description:
      "Unsloth's dynamic GGUF variants of Qwen 3.6 with extended context support and agentic coding capabilities.",
    serverArgs: [
      "--temp", "0.6",
      "--top-k", "20",
      "--top-p", "0.95",
      "--min-p", "0",
      // Unsloth dynamic GGUF optimizations
      "--gpu-layers", "99",
      "--flash-attn", "1",
      "--cache-type-k", "q8_0",
      "--cache-type-v", "q8_0",
      "--no-mmap",
    ],
    overheadMultiplier: 1.1,
    sizes: [
      ModelSize(
        name: "35B-A3B",
        parameterCount: 34_660_610_688,
        releaseDate: date(2026, 4, 18),
        ctxWindow: 262_144,
        ctxBytesPer1kTokens: 20_971_520,
        mmproj: URL(
          string:
            "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/mmproj-F16.gguf"
        )!,
        mmprojLocalFilename: "Qwen3.6-35B-A3B-mmproj-F16.gguf",
        // Primary build is Unsloth's dynamic 8-bit (UD-Q8_K_XL) so the U-Qwen
        // family serves UD-flavored weights by default; plain Q8_0 stays as a
        // slightly smaller non-dynamic fallback in quantizedBuilds below.
        build: ModelBuild(
          quantization: "UD-Q8_K_XL",
          fileSize: 38_500_000_000,
          downloadUrl: URL(
            string:
              "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q8_K_XL.gguf"
          )!
        ),
        quantizedBuilds: [
          ModelBuild(
            quantization: "UD-IQ4_XS",
            fileSize: 17_700_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-IQ4_XS.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q4_K_S",
            fileSize: 20_900_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q4_K_S.gguf"
            )!
          ),
          ModelBuild(
            quantization: "MXFP4_MOE",
            fileSize: 21_700_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-MXFP4_MOE.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-IQ4_NL",
            fileSize: 18_000_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-IQ4_NL.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q4_K_M",
            fileSize: 22_100_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q4_K_M.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-IQ4_NL_XL",
            fileSize: 19_500_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-IQ4_NL_XL.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q4_K_XL",
            fileSize: 22_400_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q5_K_S",
            fileSize: 24_900_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q5_K_S.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q5_K_M",
            fileSize: 26_500_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q5_K_M.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q5_K_XL",
            fileSize: 26_600_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q5_K_XL.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q6_K",
            fileSize: 29_300_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q6_K.gguf"
            )!
          ),
          ModelBuild(
            quantization: "UD-Q6_K_XL",
            fileSize: 31_800_000_000,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q6_K_XL.gguf"
            )!
          ),
          ModelBuild(
            quantization: "Q8_0",
            fileSize: 36_903_140_320,
            downloadUrl: URL(
              string:
                "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-Q8_0.gguf"
            )!
          ),
        ]
      ),
    ]
  )
}
