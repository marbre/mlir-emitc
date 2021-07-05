// RUN: emitc-translate -mlir-to-cpp %s | FileCheck %s -check-prefix=DEFAULT
// RUN: emitc-translate -mlir-to-cpp-forward-declared %s | FileCheck %s -check-prefix=FWDDECL

func @test_for(%arg0 : index, %arg1 : index, %arg2 : index) {
  scf.for %i0 = %arg0 to %arg1 step %arg2 {
    %0 = emitc.call "f"() : () -> i32
  }
  return
}
// DEFAULT: void test_for(size_t [[START:[^ ]*]], size_t [[STOP:[^ ]*]], size_t [[STEP:[^ ]*]]) {
// DEFAULT-NEXT: for (size_t [[ITER:[^ ]*]] = [[START]]; [[ITER]] < [[STOP]]; [[ITER]] += [[STEP]]) {
// DEFAULT-NEXT: int32_t [[V4:[^ ]*]] = f();
// DEFAULT-NEXT: }
// DEFAULT-EMPTY:
// DEFAULT-NEXT: return;

// FWDDECL: void test_for(size_t [[START:[^ ]*]], size_t [[STOP:[^ ]*]], size_t [[STEP:[^ ]*]]) {
// FWDDECL-NEXT: int32_t [[V4:[^ ]*]];
// FWDDECL-NEXT: for (size_t [[ITER:[^ ]*]] = [[START]]; [[ITER]] < [[STOP]]; [[ITER]] += [[STEP]]) {
// FWDDECL-NEXT: [[V4]] = f();
// FWDDECL-NEXT: }
// FWDDECL-EMPTY:
// FWDDECL-NEXT: return;

func @test_for_yield() {
  %start = constant 0 : index
  %stop = constant 10 : index
  %step = constant 1 : index

  %s0 = constant 0 : i32
  %p0 = constant 1.0 : f32
  
  %result:2 = scf.for %iter = %start to %stop step %step iter_args(%si = %s0, %pi = %p0) -> (i32, f32) {
    %sn = emitc.call "add"(%si, %iter) : (i32, index) -> i32
    %pn = emitc.call "mul"(%pi, %iter) : (f32, index) -> f32
    scf.yield %sn, %pn : i32, f32
  }

  return
}
// DEFAULT: void test_for_yield() {
// DEFAULT-NEXT: size_t [[START:[^ ]*]]{0};
// DEFAULT-NEXT: size_t [[STOP:[^ ]*]]{10};
// DEFAULT-NEXT: size_t [[STEP:[^ ]*]]{1};
// DEFAULT-NEXT: int32_t [[S0:[^ ]*]]{0};
// DEFAULT-NEXT: float [[P0:[^ ]*]]{(float)1.000000000e+00};
// DEFAULT-NEXT: int32_t [[SE:[^ ]*]];
// DEFAULT-NEXT: float [[PE:[^ ]*]];
// DEFAULT-NEXT: int32_t [[SI:[^ ]*]] = [[S0]];
// DEFAULT-NEXT: float [[PI:[^ ]*]] = [[P0]];
// DEFAULT-NEXT: for (size_t [[ITER:[^ ]*]] = [[START]]; [[ITER]] < [[STOP]]; [[ITER]] += [[STEP]]) {
// DEFAULT-NEXT: int32_t [[SN:[^ ]*]] = add([[SI]], [[ITER]]);
// DEFAULT-NEXT: float [[PN:[^ ]*]] = mul([[PI]], [[ITER]]);
// DEFAULT-NEXT: [[SI]] = [[SN]];
// DEFAULT-NEXT: [[PI]] = [[PN]];
// DEFAULT-NEXT: }
// DEFAULT-NEXT: [[SE]] = [[SI]];
// DEFAULT-NEXT: [[PE]] = [[PI]];
// DEFAULT-EMPTY:
// DEFAULT-NEXT: return;

// FWDDECL: void test_for_yield() {
// FWDDECL-NEXT: size_t [[START:[^ ]*]];
// FWDDECL-NEXT: size_t [[STOP:[^ ]*]];
// FWDDECL-NEXT: size_t [[STEP:[^ ]*]];
// FWDDECL-NEXT: int32_t [[S0:[^ ]*]];
// FWDDECL-NEXT: float [[P0:[^ ]*]];
// FWDDECL-NEXT: int32_t [[SE:[^ ]*]];
// FWDDECL-NEXT: float [[PE:[^ ]*]];
// FWDDECL-NEXT: int32_t [[SN:[^ ]*]];
// FWDDECL-NEXT: float [[PN:[^ ]*]];
// FWDDECL-NEXT: [[START]] = 0;
// FWDDECL-NEXT: [[STOP]] = 10;
// FWDDECL-NEXT: [[STEP]] = 1;
// FWDDECL-NEXT: [[S0]] = 0;
// FWDDECL-NEXT: [[P0]] = (float)1.000000000e+00;
// FWDDECL-NEXT: int32_t [[SI:[^ ]*]] = [[S0]];
// FWDDECL-NEXT: float [[PI:[^ ]*]] = [[P0]];
// FWDDECL-NEXT: for (size_t [[ITER:[^ ]*]] = [[START]]; [[ITER]] < [[STOP]]; [[ITER]] += [[STEP]]) {
// FWDDECL-NEXT: [[SN]] = add([[SI]], [[ITER]]);
// FWDDECL-NEXT: [[PN]] = mul([[PI]], [[ITER]]);
// FWDDECL-NEXT: [[SI]] = [[SN]];
// FWDDECL-NEXT: [[PI]] = [[PN]];
// FWDDECL-NEXT: }
// FWDDECL-NEXT: [[SE]] = [[SI]];
// FWDDECL-NEXT: [[PE]] = [[PI]];
// FWDDECL-EMPTY:
// FWDDECL-NEXT: return;
