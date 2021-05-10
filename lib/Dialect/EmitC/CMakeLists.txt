set(LLVM_OPTIONAL_SOURCES
  IR/EmitCDialect.cpp
  Passes.cpp
)

add_mlir_dialect_library(MLIREmitC
  IR/EmitCDialect.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/emitc/Dialect/EmitC

  DEPENDS
  MLIREmitCIncGen

  LINK_COMPONENTS
  Support

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRSideEffectInterfaces
  )

  add_mlir_library(MLIREmitCPasses
    Passes.cpp

    DEPENDS
    MLIRMHLOToEmitC
    MLIRMHLORegionOpsToEmitC

    LINK_COMPONENTS
    Core

    LINK_LIBS PUBLIC
    MLIRIR
    MLIRPass
    MLIRTransformUtils
  )


add_subdirectory(Conversion)
