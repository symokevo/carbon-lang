// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/builtins/int/neq.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/builtins/int/neq.carbon

// --- int_neq.carbon

fn Neq(a: i32, b: i32) -> bool = "int.neq";

class True {}
class False {}

fn F(true_: True, false_: False) {
  false_ as (if Neq(1, 1) then True else False);
  true_ as (if Neq(1, 2) then True else False);
}

fn RuntimeCall(a: i32, b: i32) -> bool {
  return Neq(a, b);
}

// CHECK:STDOUT: --- int_neq.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32.type: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Int32: %Int32.type = struct_value () [template]
// CHECK:STDOUT:   %Bool.type: type = fn_type @Bool [template]
// CHECK:STDOUT:   %Bool: %Bool.type = struct_value () [template]
// CHECK:STDOUT:   %Neq.type: type = fn_type @Neq [template]
// CHECK:STDOUT:   %Neq: %Neq.type = struct_value () [template]
// CHECK:STDOUT:   %True: type = class_type @True [template]
// CHECK:STDOUT:   %.2: type = struct_type {} [template]
// CHECK:STDOUT:   %.3: <witness> = complete_type_witness %.2 [template]
// CHECK:STDOUT:   %False: type = class_type @False [template]
// CHECK:STDOUT:   %F.type: type = fn_type @F [template]
// CHECK:STDOUT:   %F: %F.type = struct_value () [template]
// CHECK:STDOUT:   %.4: type = ptr_type %.2 [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.6: bool = bool_literal false [template]
// CHECK:STDOUT:   %.7: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.8: bool = bool_literal true [template]
// CHECK:STDOUT:   %RuntimeCall.type: type = fn_type @RuntimeCall [template]
// CHECK:STDOUT:   %RuntimeCall: %RuntimeCall.type = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Int32 = %import_ref.1
// CHECK:STDOUT:     .Bool = %import_ref.2
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.1: %Int32.type = import_ref Core//prelude/types, inst+15, loaded [template = constants.%Int32]
// CHECK:STDOUT:   %import_ref.2: %Bool.type = import_ref Core//prelude/types/bool, inst+5, loaded [template = constants.%Bool]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .Neq = %Neq.decl
// CHECK:STDOUT:     .True = %True.decl
// CHECK:STDOUT:     .False = %False.decl
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:     .RuntimeCall = %RuntimeCall.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Neq.decl: %Neq.type = fn_decl @Neq [template = constants.%Neq] {
// CHECK:STDOUT:     %a.patt: i32 = binding_pattern a
// CHECK:STDOUT:     %a.param_patt: i32 = value_param_pattern %a.patt, runtime_param0
// CHECK:STDOUT:     %b.patt: i32 = binding_pattern b
// CHECK:STDOUT:     %b.param_patt: i32 = value_param_pattern %b.patt, runtime_param1
// CHECK:STDOUT:     %return.patt: bool = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: bool = out_param_pattern %return.patt, runtime_param2
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32.loc2_11: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc2_11.1: type = value_of_initializer %int.make_type_32.loc2_11 [template = i32]
// CHECK:STDOUT:     %.loc2_11.2: type = converted %int.make_type_32.loc2_11, %.loc2_11.1 [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc2_19: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc2_19.1: type = value_of_initializer %int.make_type_32.loc2_19 [template = i32]
// CHECK:STDOUT:     %.loc2_19.2: type = converted %int.make_type_32.loc2_19, %.loc2_19.1 [template = i32]
// CHECK:STDOUT:     %bool.make_type: init type = call constants.%Bool() [template = bool]
// CHECK:STDOUT:     %.loc2_27.1: type = value_of_initializer %bool.make_type [template = bool]
// CHECK:STDOUT:     %.loc2_27.2: type = converted %bool.make_type, %.loc2_27.1 [template = bool]
// CHECK:STDOUT:     %a.param: i32 = value_param runtime_param0
// CHECK:STDOUT:     %a: i32 = bind_name a, %a.param
// CHECK:STDOUT:     %b.param: i32 = value_param runtime_param1
// CHECK:STDOUT:     %b: i32 = bind_name b, %b.param
// CHECK:STDOUT:     %return.param: ref bool = out_param runtime_param2
// CHECK:STDOUT:     %return: ref bool = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %True.decl: type = class_decl @True [template = constants.%True] {} {}
// CHECK:STDOUT:   %False.decl: type = class_decl @False [template = constants.%False] {} {}
// CHECK:STDOUT:   %F.decl: %F.type = fn_decl @F [template = constants.%F] {
// CHECK:STDOUT:     %true_.patt: %True = binding_pattern true_
// CHECK:STDOUT:     %true_.param_patt: %True = value_param_pattern %true_.patt, runtime_param0
// CHECK:STDOUT:     %false_.patt: %False = binding_pattern false_
// CHECK:STDOUT:     %false_.param_patt: %False = value_param_pattern %false_.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %True.ref.loc7: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:     %False.ref.loc7: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:     %true_.param: %True = value_param runtime_param0
// CHECK:STDOUT:     %true_: %True = bind_name true_, %true_.param
// CHECK:STDOUT:     %false_.param: %False = value_param runtime_param1
// CHECK:STDOUT:     %false_: %False = bind_name false_, %false_.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %RuntimeCall.decl: %RuntimeCall.type = fn_decl @RuntimeCall [template = constants.%RuntimeCall] {
// CHECK:STDOUT:     %a.patt: i32 = binding_pattern a
// CHECK:STDOUT:     %a.param_patt: i32 = value_param_pattern %a.patt, runtime_param0
// CHECK:STDOUT:     %b.patt: i32 = binding_pattern b
// CHECK:STDOUT:     %b.param_patt: i32 = value_param_pattern %b.patt, runtime_param1
// CHECK:STDOUT:     %return.patt: bool = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: bool = out_param_pattern %return.patt, runtime_param2
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32.loc12_19: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc12_19.1: type = value_of_initializer %int.make_type_32.loc12_19 [template = i32]
// CHECK:STDOUT:     %.loc12_19.2: type = converted %int.make_type_32.loc12_19, %.loc12_19.1 [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc12_27: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc12_27.1: type = value_of_initializer %int.make_type_32.loc12_27 [template = i32]
// CHECK:STDOUT:     %.loc12_27.2: type = converted %int.make_type_32.loc12_27, %.loc12_27.1 [template = i32]
// CHECK:STDOUT:     %bool.make_type: init type = call constants.%Bool() [template = bool]
// CHECK:STDOUT:     %.loc12_35.1: type = value_of_initializer %bool.make_type [template = bool]
// CHECK:STDOUT:     %.loc12_35.2: type = converted %bool.make_type, %.loc12_35.1 [template = bool]
// CHECK:STDOUT:     %a.param: i32 = value_param runtime_param0
// CHECK:STDOUT:     %a: i32 = bind_name a, %a.param
// CHECK:STDOUT:     %b.param: i32 = value_param runtime_param1
// CHECK:STDOUT:     %b: i32 = bind_name b, %b.param
// CHECK:STDOUT:     %return.param: ref bool = out_param runtime_param2
// CHECK:STDOUT:     %return: ref bool = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @True {
// CHECK:STDOUT:   %.loc4: <witness> = complete_type_witness %.2 [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%True
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @False {
// CHECK:STDOUT:   %.loc5: <witness> = complete_type_witness %.2 [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%False
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Neq(%a.param_patt: i32, %b.param_patt: i32) -> bool = "int.neq";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%true_.param_patt: %True, %false_.param_patt: %False) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %false_.ref: %False = name_ref false_, %false_
// CHECK:STDOUT:   %Neq.ref.loc8: %Neq.type = name_ref Neq, file.%Neq.decl [template = constants.%Neq]
// CHECK:STDOUT:   %.loc8_21: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc8_24: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %int.neq.loc8: init bool = call %Neq.ref.loc8(%.loc8_21, %.loc8_24) [template = constants.%.6]
// CHECK:STDOUT:   %.loc8_14.1: bool = value_of_initializer %int.neq.loc8 [template = constants.%.6]
// CHECK:STDOUT:   %.loc8_14.2: bool = converted %int.neq.loc8, %.loc8_14.1 [template = constants.%.6]
// CHECK:STDOUT:   if %.loc8_14.2 br !if.expr.then.loc8 else br !if.expr.else.loc8
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc8:
// CHECK:STDOUT:   %True.ref.loc8: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc8(%True.ref.loc8)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc8:
// CHECK:STDOUT:   %False.ref.loc8: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc8(%False.ref.loc8)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc8:
// CHECK:STDOUT:   %.loc8_14.3: type = block_arg !if.expr.result.loc8 [template = constants.%False]
// CHECK:STDOUT:   %true_.ref: %True = name_ref true_, %true_
// CHECK:STDOUT:   %Neq.ref.loc9: %Neq.type = name_ref Neq, file.%Neq.decl [template = constants.%Neq]
// CHECK:STDOUT:   %.loc9_20: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc9_23: i32 = int_literal 2 [template = constants.%.7]
// CHECK:STDOUT:   %int.neq.loc9: init bool = call %Neq.ref.loc9(%.loc9_20, %.loc9_23) [template = constants.%.8]
// CHECK:STDOUT:   %.loc9_13.1: bool = value_of_initializer %int.neq.loc9 [template = constants.%.8]
// CHECK:STDOUT:   %.loc9_13.2: bool = converted %int.neq.loc9, %.loc9_13.1 [template = constants.%.8]
// CHECK:STDOUT:   if %.loc9_13.2 br !if.expr.then.loc9 else br !if.expr.else.loc9
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc9:
// CHECK:STDOUT:   %True.ref.loc9: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc9(%True.ref.loc9)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc9:
// CHECK:STDOUT:   %False.ref.loc9: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc9(%False.ref.loc9)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc9:
// CHECK:STDOUT:   %.loc9_13.3: type = block_arg !if.expr.result.loc9 [template = constants.%True]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCall(%a.param_patt: i32, %b.param_patt: i32) -> bool {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Neq.ref: %Neq.type = name_ref Neq, file.%Neq.decl [template = constants.%Neq]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: i32 = name_ref b, %b
// CHECK:STDOUT:   %int.neq: init bool = call %Neq.ref(%a.ref, %b.ref)
// CHECK:STDOUT:   %.loc13_19.1: bool = value_of_initializer %int.neq
// CHECK:STDOUT:   %.loc13_19.2: bool = converted %int.neq, %.loc13_19.1
// CHECK:STDOUT:   return %.loc13_19.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
