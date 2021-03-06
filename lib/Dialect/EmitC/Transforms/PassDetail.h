//===- PassDetail.h - EmitC Transform Pass class details --------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef DIALECT_EMITC_TRANSFORMS_PASSDETAIL_H
#define DIALECT_EMITC_TRANSFORMS_PASSDETAIL_H

#include "mlir/Pass/Pass.h"

namespace mlir {
namespace emitc {

class EmitCDialect;

#define GEN_PASS_CLASSES
#include "emitc/Dialect/EmitC/Transforms/Passes.h.inc"

} // namespace emitc
} // namespace mlir

#endif // DIALECT_EMITC_TRANSFORMS_PASSDETAIL_H
