// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/builtins/int/greater.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/builtins/int/greater.carbon

// --- int_greater.carbon

fn Greater(a: i32, b: i32) -> bool = "int.greater";
fn Negate(a: i32) -> i32 = "int.snegate";

class True {}
class False {}

fn F(true_: True, false_: False) {
  false_ as (if Greater(1, 2) then True else False);
  false_ as (if Greater(1, 1) then True else False);
  true_ as (if Greater(1, 0) then True else False);
  false_ as (if Greater(Negate(1), 0) then True else False);
  true_ as (if Greater(0, Negate(1)) then True else False);
}

fn RuntimeCall(a: i32, b: i32) -> bool {
  return Greater(a, b);
}

// CHECK:STDOUT: --- int_greater.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32.type: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Int32: %Int32.type = struct_value () [template]
// CHECK:STDOUT:   %Bool.type: type = fn_type @Bool [template]
// CHECK:STDOUT:   %Bool: %Bool.type = struct_value () [template]
// CHECK:STDOUT:   %Greater.type: type = fn_type @Greater [template]
// CHECK:STDOUT:   %Greater: %Greater.type = struct_value () [template]
// CHECK:STDOUT:   %Negate.type: type = fn_type @Negate [template]
// CHECK:STDOUT:   %Negate: %Negate.type = struct_value () [template]
// CHECK:STDOUT:   %True: type = class_type @True [template]
// CHECK:STDOUT:   %.2: type = struct_type {} [template]
// CHECK:STDOUT:   %.3: <witness> = complete_type_witness %.2 [template]
// CHECK:STDOUT:   %False: type = class_type @False [template]
// CHECK:STDOUT:   %F.type: type = fn_type @F [template]
// CHECK:STDOUT:   %F: %F.type = struct_value () [template]
// CHECK:STDOUT:   %.4: type = ptr_type %.2 [template]
// CHECK:STDOUT:   %.5: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.6: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %.7: bool = bool_literal false [template]
// CHECK:STDOUT:   %.8: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %.9: bool = bool_literal true [template]
// CHECK:STDOUT:   %.10: i32 = int_literal -1 [template]
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
// CHECK:STDOUT:     .Greater = %Greater.decl
// CHECK:STDOUT:     .Negate = %Negate.decl
// CHECK:STDOUT:     .True = %True.decl
// CHECK:STDOUT:     .False = %False.decl
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:     .RuntimeCall = %RuntimeCall.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Greater.decl: %Greater.type = fn_decl @Greater [template = constants.%Greater] {
// CHECK:STDOUT:     %a.patt: i32 = binding_pattern a
// CHECK:STDOUT:     %a.param_patt: i32 = value_param_pattern %a.patt, runtime_param0
// CHECK:STDOUT:     %b.patt: i32 = binding_pattern b
// CHECK:STDOUT:     %b.param_patt: i32 = value_param_pattern %b.patt, runtime_param1
// CHECK:STDOUT:     %return.patt: bool = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: bool = out_param_pattern %return.patt, runtime_param2
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32.loc2_15: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc2_15.1: type = value_of_initializer %int.make_type_32.loc2_15 [template = i32]
// CHECK:STDOUT:     %.loc2_15.2: type = converted %int.make_type_32.loc2_15, %.loc2_15.1 [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc2_23: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc2_23.1: type = value_of_initializer %int.make_type_32.loc2_23 [template = i32]
// CHECK:STDOUT:     %.loc2_23.2: type = converted %int.make_type_32.loc2_23, %.loc2_23.1 [template = i32]
// CHECK:STDOUT:     %bool.make_type: init type = call constants.%Bool() [template = bool]
// CHECK:STDOUT:     %.loc2_31.1: type = value_of_initializer %bool.make_type [template = bool]
// CHECK:STDOUT:     %.loc2_31.2: type = converted %bool.make_type, %.loc2_31.1 [template = bool]
// CHECK:STDOUT:     %a.param: i32 = value_param runtime_param0
// CHECK:STDOUT:     %a: i32 = bind_name a, %a.param
// CHECK:STDOUT:     %b.param: i32 = value_param runtime_param1
// CHECK:STDOUT:     %b: i32 = bind_name b, %b.param
// CHECK:STDOUT:     %return.param: ref bool = out_param runtime_param2
// CHECK:STDOUT:     %return: ref bool = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Negate.decl: %Negate.type = fn_decl @Negate [template = constants.%Negate] {
// CHECK:STDOUT:     %a.patt: i32 = binding_pattern a
// CHECK:STDOUT:     %a.param_patt: i32 = value_param_pattern %a.patt, runtime_param0
// CHECK:STDOUT:     %return.patt: i32 = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: i32 = out_param_pattern %return.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32.loc3_14: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc3_14.1: type = value_of_initializer %int.make_type_32.loc3_14 [template = i32]
// CHECK:STDOUT:     %.loc3_14.2: type = converted %int.make_type_32.loc3_14, %.loc3_14.1 [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc3_22: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc3_22.1: type = value_of_initializer %int.make_type_32.loc3_22 [template = i32]
// CHECK:STDOUT:     %.loc3_22.2: type = converted %int.make_type_32.loc3_22, %.loc3_22.1 [template = i32]
// CHECK:STDOUT:     %a.param: i32 = value_param runtime_param0
// CHECK:STDOUT:     %a: i32 = bind_name a, %a.param
// CHECK:STDOUT:     %return.param: ref i32 = out_param runtime_param1
// CHECK:STDOUT:     %return: ref i32 = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %True.decl: type = class_decl @True [template = constants.%True] {} {}
// CHECK:STDOUT:   %False.decl: type = class_decl @False [template = constants.%False] {} {}
// CHECK:STDOUT:   %F.decl: %F.type = fn_decl @F [template = constants.%F] {
// CHECK:STDOUT:     %true_.patt: %True = binding_pattern true_
// CHECK:STDOUT:     %true_.param_patt: %True = value_param_pattern %true_.patt, runtime_param0
// CHECK:STDOUT:     %false_.patt: %False = binding_pattern false_
// CHECK:STDOUT:     %false_.param_patt: %False = value_param_pattern %false_.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %True.ref.loc8: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:     %False.ref.loc8: type = name_ref False, file.%False.decl [template = constants.%False]
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
// CHECK:STDOUT:     %int.make_type_32.loc16_19: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc16_19.1: type = value_of_initializer %int.make_type_32.loc16_19 [template = i32]
// CHECK:STDOUT:     %.loc16_19.2: type = converted %int.make_type_32.loc16_19, %.loc16_19.1 [template = i32]
// CHECK:STDOUT:     %int.make_type_32.loc16_27: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc16_27.1: type = value_of_initializer %int.make_type_32.loc16_27 [template = i32]
// CHECK:STDOUT:     %.loc16_27.2: type = converted %int.make_type_32.loc16_27, %.loc16_27.1 [template = i32]
// CHECK:STDOUT:     %bool.make_type: init type = call constants.%Bool() [template = bool]
// CHECK:STDOUT:     %.loc16_35.1: type = value_of_initializer %bool.make_type [template = bool]
// CHECK:STDOUT:     %.loc16_35.2: type = converted %bool.make_type, %.loc16_35.1 [template = bool]
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
// CHECK:STDOUT:   %.loc5: <witness> = complete_type_witness %.2 [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%True
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @False {
// CHECK:STDOUT:   %.loc6: <witness> = complete_type_witness %.2 [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%False
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Greater(%a.param_patt: i32, %b.param_patt: i32) -> bool = "int.greater";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Negate(%a.param_patt: i32) -> i32 = "int.snegate";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%true_.param_patt: %True, %false_.param_patt: %False) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %false_.ref.loc9: %False = name_ref false_, %false_
// CHECK:STDOUT:   %Greater.ref.loc9: %Greater.type = name_ref Greater, file.%Greater.decl [template = constants.%Greater]
// CHECK:STDOUT:   %.loc9_25: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc9_28: i32 = int_literal 2 [template = constants.%.6]
// CHECK:STDOUT:   %int.greater.loc9: init bool = call %Greater.ref.loc9(%.loc9_25, %.loc9_28) [template = constants.%.7]
// CHECK:STDOUT:   %.loc9_14.1: bool = value_of_initializer %int.greater.loc9 [template = constants.%.7]
// CHECK:STDOUT:   %.loc9_14.2: bool = converted %int.greater.loc9, %.loc9_14.1 [template = constants.%.7]
// CHECK:STDOUT:   if %.loc9_14.2 br !if.expr.then.loc9 else br !if.expr.else.loc9
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
// CHECK:STDOUT:   %.loc9_14.3: type = block_arg !if.expr.result.loc9 [template = constants.%False]
// CHECK:STDOUT:   %false_.ref.loc10: %False = name_ref false_, %false_
// CHECK:STDOUT:   %Greater.ref.loc10: %Greater.type = name_ref Greater, file.%Greater.decl [template = constants.%Greater]
// CHECK:STDOUT:   %.loc10_25: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc10_28: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %int.greater.loc10: init bool = call %Greater.ref.loc10(%.loc10_25, %.loc10_28) [template = constants.%.7]
// CHECK:STDOUT:   %.loc10_14.1: bool = value_of_initializer %int.greater.loc10 [template = constants.%.7]
// CHECK:STDOUT:   %.loc10_14.2: bool = converted %int.greater.loc10, %.loc10_14.1 [template = constants.%.7]
// CHECK:STDOUT:   if %.loc10_14.2 br !if.expr.then.loc10 else br !if.expr.else.loc10
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc10:
// CHECK:STDOUT:   %True.ref.loc10: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc10(%True.ref.loc10)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc10:
// CHECK:STDOUT:   %False.ref.loc10: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc10(%False.ref.loc10)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc10:
// CHECK:STDOUT:   %.loc10_14.3: type = block_arg !if.expr.result.loc10 [template = constants.%False]
// CHECK:STDOUT:   %true_.ref.loc11: %True = name_ref true_, %true_
// CHECK:STDOUT:   %Greater.ref.loc11: %Greater.type = name_ref Greater, file.%Greater.decl [template = constants.%Greater]
// CHECK:STDOUT:   %.loc11_24: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %.loc11_27: i32 = int_literal 0 [template = constants.%.8]
// CHECK:STDOUT:   %int.greater.loc11: init bool = call %Greater.ref.loc11(%.loc11_24, %.loc11_27) [template = constants.%.9]
// CHECK:STDOUT:   %.loc11_13.1: bool = value_of_initializer %int.greater.loc11 [template = constants.%.9]
// CHECK:STDOUT:   %.loc11_13.2: bool = converted %int.greater.loc11, %.loc11_13.1 [template = constants.%.9]
// CHECK:STDOUT:   if %.loc11_13.2 br !if.expr.then.loc11 else br !if.expr.else.loc11
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc11:
// CHECK:STDOUT:   %True.ref.loc11: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc11(%True.ref.loc11)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc11:
// CHECK:STDOUT:   %False.ref.loc11: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc11(%False.ref.loc11)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc11:
// CHECK:STDOUT:   %.loc11_13.3: type = block_arg !if.expr.result.loc11 [template = constants.%True]
// CHECK:STDOUT:   %false_.ref.loc12: %False = name_ref false_, %false_
// CHECK:STDOUT:   %Greater.ref.loc12: %Greater.type = name_ref Greater, file.%Greater.decl [template = constants.%Greater]
// CHECK:STDOUT:   %Negate.ref.loc12: %Negate.type = name_ref Negate, file.%Negate.decl [template = constants.%Negate]
// CHECK:STDOUT:   %.loc12_32: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %int.snegate.loc12: init i32 = call %Negate.ref.loc12(%.loc12_32) [template = constants.%.10]
// CHECK:STDOUT:   %.loc12_36: i32 = int_literal 0 [template = constants.%.8]
// CHECK:STDOUT:   %.loc12_31.1: i32 = value_of_initializer %int.snegate.loc12 [template = constants.%.10]
// CHECK:STDOUT:   %.loc12_31.2: i32 = converted %int.snegate.loc12, %.loc12_31.1 [template = constants.%.10]
// CHECK:STDOUT:   %int.greater.loc12: init bool = call %Greater.ref.loc12(%.loc12_31.2, %.loc12_36) [template = constants.%.7]
// CHECK:STDOUT:   %.loc12_14.1: bool = value_of_initializer %int.greater.loc12 [template = constants.%.7]
// CHECK:STDOUT:   %.loc12_14.2: bool = converted %int.greater.loc12, %.loc12_14.1 [template = constants.%.7]
// CHECK:STDOUT:   if %.loc12_14.2 br !if.expr.then.loc12 else br !if.expr.else.loc12
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc12:
// CHECK:STDOUT:   %True.ref.loc12: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc12(%True.ref.loc12)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc12:
// CHECK:STDOUT:   %False.ref.loc12: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc12(%False.ref.loc12)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc12:
// CHECK:STDOUT:   %.loc12_14.3: type = block_arg !if.expr.result.loc12 [template = constants.%False]
// CHECK:STDOUT:   %true_.ref.loc13: %True = name_ref true_, %true_
// CHECK:STDOUT:   %Greater.ref.loc13: %Greater.type = name_ref Greater, file.%Greater.decl [template = constants.%Greater]
// CHECK:STDOUT:   %.loc13_24: i32 = int_literal 0 [template = constants.%.8]
// CHECK:STDOUT:   %Negate.ref.loc13: %Negate.type = name_ref Negate, file.%Negate.decl [template = constants.%Negate]
// CHECK:STDOUT:   %.loc13_34: i32 = int_literal 1 [template = constants.%.5]
// CHECK:STDOUT:   %int.snegate.loc13: init i32 = call %Negate.ref.loc13(%.loc13_34) [template = constants.%.10]
// CHECK:STDOUT:   %.loc13_33.1: i32 = value_of_initializer %int.snegate.loc13 [template = constants.%.10]
// CHECK:STDOUT:   %.loc13_33.2: i32 = converted %int.snegate.loc13, %.loc13_33.1 [template = constants.%.10]
// CHECK:STDOUT:   %int.greater.loc13: init bool = call %Greater.ref.loc13(%.loc13_24, %.loc13_33.2) [template = constants.%.9]
// CHECK:STDOUT:   %.loc13_13.1: bool = value_of_initializer %int.greater.loc13 [template = constants.%.9]
// CHECK:STDOUT:   %.loc13_13.2: bool = converted %int.greater.loc13, %.loc13_13.1 [template = constants.%.9]
// CHECK:STDOUT:   if %.loc13_13.2 br !if.expr.then.loc13 else br !if.expr.else.loc13
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc13:
// CHECK:STDOUT:   %True.ref.loc13: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc13(%True.ref.loc13)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc13:
// CHECK:STDOUT:   %False.ref.loc13: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc13(%False.ref.loc13)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc13:
// CHECK:STDOUT:   %.loc13_13.3: type = block_arg !if.expr.result.loc13 [template = constants.%True]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCall(%a.param_patt: i32, %b.param_patt: i32) -> bool {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Greater.ref: %Greater.type = name_ref Greater, file.%Greater.decl [template = constants.%Greater]
// CHECK:STDOUT:   %a.ref: i32 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: i32 = name_ref b, %b
// CHECK:STDOUT:   %int.greater: init bool = call %Greater.ref(%a.ref, %b.ref)
// CHECK:STDOUT:   %.loc17_23.1: bool = value_of_initializer %int.greater
// CHECK:STDOUT:   %.loc17_23.2: bool = converted %int.greater, %.loc17_23.1
// CHECK:STDOUT:   return %.loc17_23.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
