// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/class/redeclaration.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/class/redeclaration.carbon

class Class;

class Class {
  fn F[self: Self](b: bool);
}

fn Class.F[self: Self](b: bool) {}

// CHECK:STDOUT: --- redeclaration.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Class: type = class_type @Class [template]
// CHECK:STDOUT:   %Bool.type: type = fn_type @Bool [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Bool: %Bool.type = struct_value () [template]
// CHECK:STDOUT:   %F.type: type = fn_type @F [template]
// CHECK:STDOUT:   %F: %F.type = struct_value () [template]
// CHECK:STDOUT:   %.2: type = struct_type {} [template]
// CHECK:STDOUT:   %.3: <witness> = complete_type_witness %.2 [template]
// CHECK:STDOUT:   %.4: type = ptr_type %.2 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Bool = %import_ref
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref: %Bool.type = import_ref Core//prelude/types/bool, inst+5, loaded [template = constants.%Bool]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .Class = %Class.decl.loc11
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Class.decl.loc11: type = class_decl @Class [template = constants.%Class] {} {}
// CHECK:STDOUT:   %Class.decl.loc13: type = class_decl @Class [template = constants.%Class] {} {}
// CHECK:STDOUT:   %F.decl: %F.type = fn_decl @F [template = constants.%F] {
// CHECK:STDOUT:     %self.patt: %Class = binding_pattern self
// CHECK:STDOUT:     %self.param_patt: %Class = value_param_pattern %self.patt, runtime_param0
// CHECK:STDOUT:     %b.patt: bool = binding_pattern b
// CHECK:STDOUT:     %b.param_patt: bool = value_param_pattern %b.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %Self.ref.loc17: type = name_ref Self, constants.%Class [template = constants.%Class]
// CHECK:STDOUT:     %bool.make_type.loc17: init type = call constants.%Bool() [template = bool]
// CHECK:STDOUT:     %.loc17_27.1: type = value_of_initializer %bool.make_type.loc17 [template = bool]
// CHECK:STDOUT:     %.loc17_27.2: type = converted %bool.make_type.loc17, %.loc17_27.1 [template = bool]
// CHECK:STDOUT:     %self.param.loc17: %Class = value_param runtime_param0
// CHECK:STDOUT:     %self.loc17: %Class = bind_name self, %self.param.loc17
// CHECK:STDOUT:     %b.param.loc17: bool = value_param runtime_param1
// CHECK:STDOUT:     %b.loc17: bool = bind_name b, %b.param.loc17
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Class {
// CHECK:STDOUT:   %F.decl: %F.type = fn_decl @F [template = constants.%F] {
// CHECK:STDOUT:     %self.patt: %Class = binding_pattern self
// CHECK:STDOUT:     %self.param_patt: %Class = value_param_pattern %self.patt, runtime_param0
// CHECK:STDOUT:     %b.patt: bool = binding_pattern b
// CHECK:STDOUT:     %b.param_patt: bool = value_param_pattern %b.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %Self.ref.loc14: type = name_ref Self, constants.%Class [template = constants.%Class]
// CHECK:STDOUT:     %bool.make_type.loc14: init type = call constants.%Bool() [template = bool]
// CHECK:STDOUT:     %.loc14_23.1: type = value_of_initializer %bool.make_type.loc14 [template = bool]
// CHECK:STDOUT:     %.loc14_23.2: type = converted %bool.make_type.loc14, %.loc14_23.1 [template = bool]
// CHECK:STDOUT:     %self.param.loc14: %Class = value_param runtime_param0
// CHECK:STDOUT:     %self.loc14: %Class = bind_name self, %self.param.loc14
// CHECK:STDOUT:     %b.param.loc14: bool = value_param runtime_param1
// CHECK:STDOUT:     %b.loc14: bool = bind_name b, %b.param.loc14
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.loc15: <witness> = complete_type_witness %.2 [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%Class
// CHECK:STDOUT:   .F = %F.decl
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Bool() -> type = "bool.make_type";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F[%self.param_patt: %Class](%b.param_patt: bool) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
