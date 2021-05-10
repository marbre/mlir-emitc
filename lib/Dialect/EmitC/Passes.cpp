//===- Passes.cpp - EmitC passes ---------------------------------- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "emitc/Dialect/EmitC/Passes.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"

namespace mlir {
namespace emitc {

void buildMHLOtoEmitCPipeline(OpPassManager &pm) {
  pm.addPass(createConvertMhloRegionOpsToEmitCPass());
  pm.addPass(createConvertMhloToEmitCPass());
}

void registerEmitCMHLOPipeline() {
  PassPipelineRegistration<>("emitc-to-mhlo-pipeline",
                             "Runs the MHLO to EmitC pipeline.",
                             buildMHLOtoEmitCPipeline);
}

} // namespace emitc
} // namespace mlir
