// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/class/generic/redeclare.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/class/generic/redeclare.carbon

// --- valid.carbon

library "[[@TEST_NAME]]";

class Generic(T:! type);

class Generic(T:! type) {
}

// --- fail_mismatch_param_list.carbon

library "[[@TEST_NAME]]";

class A;
// CHECK:STDERR: fail_mismatch_param_list.carbon:[[@LINE+7]]:1: error: redeclaration differs because of parameter list [RedeclParamListDiffers]
// CHECK:STDERR: class A(T:! type) {}
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_mismatch_param_list.carbon:[[@LINE-4]]:1: note: previously declared without parameter list [RedeclParamListPrevious]
// CHECK:STDERR: class A;
// CHECK:STDERR: ^~~~~~~~
// CHECK:STDERR:
class A(T:! type) {}

// --- fail_mismatch_implicit_param_list.carbon

library "[[@TEST_NAME]]";

class B(N:! i32);
// CHECK:STDERR: fail_mismatch_implicit_param_list.carbon:[[@LINE+7]]:1: error: redeclaration differs because of implicit parameter list [RedeclParamListDiffers]
// CHECK:STDERR: class B[T:! type](N:! T) {}
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_mismatch_implicit_param_list.carbon:[[@LINE-4]]:1: note: previously declared without implicit parameter list [RedeclParamListPrevious]
// CHECK:STDERR: class B(N:! i32);
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~
// CHECK:STDERR:
class B[T:! type](N:! T) {}

// --- fail_mismatch_param_count.carbon

library "[[@TEST_NAME]]";

class C(T:! type);
// CHECK:STDERR: fail_mismatch_param_count.carbon:[[@LINE+7]]:1: error: redeclaration differs because of parameter count of 2 [RedeclParamCountDiffers]
// CHECK:STDERR: class C(T:! type, U:! i32) {}
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
// CHECK:STDERR: fail_mismatch_param_count.carbon:[[@LINE-4]]:1: note: previously declared with parameter count of 1 [RedeclParamCountPrevious]
// CHECK:STDERR: class C(T:! type);
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~
// CHECK:STDERR:
class C(T:! type, U:! i32) {}

// --- fail_mismatch_param_type.carbon

library "[[@TEST_NAME]]";

class D(T:! type);
// CHECK:STDERR: fail_mismatch_param_type.carbon:[[@LINE+7]]:9: error: redeclaration differs at parameter 1 [RedeclParamDiffers]
// CHECK:STDERR: class D(T:! i32) {}
// CHECK:STDERR:         ^~~~~~~
// CHECK:STDERR: fail_mismatch_param_type.carbon:[[@LINE-4]]:9: note: previous declaration's corresponding parameter here [RedeclParamPrevious]
// CHECK:STDERR: class D(T:! type);
// CHECK:STDERR:         ^~~~~~~~
// CHECK:STDERR:
class D(T:! i32) {}

// --- fail_mismatch_param_name.carbon

library "[[@TEST_NAME]]";

class E(T:! type);
// CHECK:STDERR: fail_mismatch_param_name.carbon:[[@LINE+6]]:9: error: redeclaration differs at parameter 1 [RedeclParamDiffers]
// CHECK:STDERR: class E(U:! type) {}
// CHECK:STDERR:         ^~~~~~~~
// CHECK:STDERR: fail_mismatch_param_name.carbon:[[@LINE-4]]:9: note: previous declaration's corresponding parameter here [RedeclParamPrevious]
// CHECK:STDERR: class E(T:! type);
// CHECK:STDERR:         ^~~~~~~~
class E(U:! type) {}

// CHECK:STDOUT: --- valid.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt.1: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %Generic.type: type = generic_class_type @Generic [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Generic.1: %Generic.type = struct_value () [template]
// CHECK:STDOUT:   %Generic.2: type = class_type @Generic, @Generic(%T) [symbolic]
// CHECK:STDOUT:   %T.patt.2: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %.2: type = struct_type {} [template]
// CHECK:STDOUT:   %.3: <witness> = complete_type_witness %.2 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .Generic = %Generic.decl.loc4
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %Generic.decl.loc4: %Generic.type = class_decl @Generic [template = constants.%Generic.1] {
// CHECK:STDOUT:     %T.patt.loc6: type = symbolic_binding_pattern T, 0 [symbolic = constants.%T.patt.2]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc6, runtime_param<invalid> [symbolic = constants.%T.patt.2]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param.loc4: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc4_15.1: type = bind_symbolic_name T, 0, %T.param.loc4 [symbolic = %T.loc4_15.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Generic.decl.loc6: %Generic.type = class_decl @Generic [template = constants.%Generic.1] {
// CHECK:STDOUT:     %T.patt.loc6: type = symbolic_binding_pattern T, 0 [symbolic = constants.%T.patt.2]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc6, runtime_param<invalid> [symbolic = constants.%T.patt.2]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param.loc6: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc6: type = bind_symbolic_name T, 0, %T.param.loc6 [symbolic = constants.%T]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @Generic(%T.loc4_15.1: type) {
// CHECK:STDOUT:   %T.loc4_15.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc4_15.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc4: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4 (constants.%T.patt.1)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   class {
// CHECK:STDOUT:     %.loc7: <witness> = complete_type_witness %.2 [template = constants.%.3]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = constants.%Generic.2
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Generic(constants.%T) {
// CHECK:STDOUT:   %T.loc4_15.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc4 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_mismatch_param_list.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %A: type = class_type @A [template]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %.type: type = generic_class_type @.1 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %.2: %.type = struct_value () [template]
// CHECK:STDOUT:   %.3: type = class_type @.1, @.1(%T) [symbolic]
// CHECK:STDOUT:   %.4: type = struct_type {} [template]
// CHECK:STDOUT:   %.5: <witness> = complete_type_witness %.4 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .A = %A.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %A.decl: type = class_decl @A [template = constants.%A] {} {}
// CHECK:STDOUT:   %.decl: %.type = class_decl @.1 [template = constants.%.2] {
// CHECK:STDOUT:     %T.patt.loc12_9.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc12_9.1, runtime_param<invalid> [symbolic = %T.patt.loc12_9.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc12_9.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @A;
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @.1(%T.loc12_9.1: type) {
// CHECK:STDOUT:   %T.loc12_9.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc12_9.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   class {
// CHECK:STDOUT:     %.loc12: <witness> = complete_type_witness %.4 [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = constants.%.3
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @.1(constants.%T) {
// CHECK:STDOUT:   %T.loc12_9.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc12_9.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_mismatch_implicit_param_list.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Int32.type: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Int32: %Int32.type = struct_value () [template]
// CHECK:STDOUT:   %N.1: i32 = bind_symbolic_name N, 0 [symbolic]
// CHECK:STDOUT:   %N.patt.1: i32 = symbolic_binding_pattern N, 0 [symbolic]
// CHECK:STDOUT:   %B.type: type = generic_class_type @B [template]
// CHECK:STDOUT:   %B.1: %B.type = struct_value () [template]
// CHECK:STDOUT:   %B.2: type = class_type @B, @B(%N.1) [symbolic]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %N.2: %T = bind_symbolic_name N, 1 [symbolic]
// CHECK:STDOUT:   %N.patt.2: %T = symbolic_binding_pattern N, 1 [symbolic]
// CHECK:STDOUT:   %.type: type = generic_class_type @.1 [template]
// CHECK:STDOUT:   %.2: %.type = struct_value () [template]
// CHECK:STDOUT:   %.3: type = class_type @.1, @.1(%T, %N.2) [symbolic]
// CHECK:STDOUT:   %.4: type = struct_type {} [template]
// CHECK:STDOUT:   %.5: <witness> = complete_type_witness %.4 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Int32 = %import_ref
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref: %Int32.type = import_ref Core//prelude/types, inst+15, loaded [template = constants.%Int32]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .B = %B.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %B.decl: %B.type = class_decl @B [template = constants.%B.1] {
// CHECK:STDOUT:     %N.patt.loc4_9.1: i32 = symbolic_binding_pattern N, 0 [symbolic = %N.patt.loc4_9.2 (constants.%N.patt.1)]
// CHECK:STDOUT:     %N.param_patt: i32 = value_param_pattern %N.patt.loc4_9.1, runtime_param<invalid> [symbolic = %N.patt.loc4_9.2 (constants.%N.patt.1)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc4_13.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc4_13.2: type = converted %int.make_type_32, %.loc4_13.1 [template = i32]
// CHECK:STDOUT:     %N.param: i32 = value_param runtime_param<invalid>
// CHECK:STDOUT:     %N.loc4_9.1: i32 = bind_symbolic_name N, 0, %N.param [symbolic = %N.loc4_9.2 (constants.%N.1)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.decl: %.type = class_decl @.1 [template = constants.%.2] {
// CHECK:STDOUT:     %T.patt.loc12_9.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc12_9.1, runtime_param<invalid> [symbolic = %T.patt.loc12_9.2 (constants.%T.patt)]
// CHECK:STDOUT:     %N.patt.loc12_19.1: @.1.%T.loc12_9.2 (%T) = symbolic_binding_pattern N, 1 [symbolic = %N.patt.loc12_19.2 (constants.%N.patt.2)]
// CHECK:STDOUT:     %N.param_patt: @.1.%T.loc12_9.2 (%T) = value_param_pattern %N.patt.loc12_19.1, runtime_param<invalid> [symbolic = %N.patt.loc12_19.2 (constants.%N.patt.2)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.ref: type = name_ref T, %T.loc12_9.1 [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc12_9.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:     %N.param: @.1.%T.loc12_9.2 (%T) = value_param runtime_param<invalid>
// CHECK:STDOUT:     %N.loc12_19.1: @.1.%T.loc12_9.2 (%T) = bind_symbolic_name N, 1, %N.param [symbolic = %N.loc12_19.2 (constants.%N.2)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @B(%N.loc4_9.1: i32) {
// CHECK:STDOUT:   %N.loc4_9.2: i32 = bind_symbolic_name N, 0 [symbolic = %N.loc4_9.2 (constants.%N.1)]
// CHECK:STDOUT:   %N.patt.loc4_9.2: i32 = symbolic_binding_pattern N, 0 [symbolic = %N.patt.loc4_9.2 (constants.%N.patt.1)]
// CHECK:STDOUT:
// CHECK:STDOUT:   class;
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @.1(%T.loc12_9.1: type, %N.loc12_19.1: @.1.%T.loc12_9.2 (%T)) {
// CHECK:STDOUT:   %T.loc12_9.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc12_9.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt)]
// CHECK:STDOUT:   %N.loc12_19.2: %T = bind_symbolic_name N, 1 [symbolic = %N.loc12_19.2 (constants.%N.2)]
// CHECK:STDOUT:   %N.patt.loc12_19.2: %T = symbolic_binding_pattern N, 1 [symbolic = %N.patt.loc12_19.2 (constants.%N.patt.2)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   class {
// CHECK:STDOUT:     %.loc12: <witness> = complete_type_witness %.4 [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = constants.%.3
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: specific @B(constants.%N.1) {
// CHECK:STDOUT:   %N.loc4_9.2 => constants.%N.1
// CHECK:STDOUT:   %N.patt.loc4_9.2 => constants.%N.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @.1(constants.%T, constants.%N.2) {
// CHECK:STDOUT:   %T.loc12_9.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc12_9.2 => constants.%T
// CHECK:STDOUT:   %N.loc12_19.2 => constants.%N.2
// CHECK:STDOUT:   %N.patt.loc12_19.2 => constants.%N.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_mismatch_param_count.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt.1: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %C.type: type = generic_class_type @C [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %C.1: %C.type = struct_value () [template]
// CHECK:STDOUT:   %C.2: type = class_type @C, @C(%T) [symbolic]
// CHECK:STDOUT:   %T.patt.2: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %Int32.type: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %Int32: %Int32.type = struct_value () [template]
// CHECK:STDOUT:   %U: i32 = bind_symbolic_name U, 1 [symbolic]
// CHECK:STDOUT:   %U.patt: i32 = symbolic_binding_pattern U, 1 [symbolic]
// CHECK:STDOUT:   %.type: type = generic_class_type @.1 [template]
// CHECK:STDOUT:   %.2: %.type = struct_value () [template]
// CHECK:STDOUT:   %.3: type = class_type @.1, @.1(%T, %U) [symbolic]
// CHECK:STDOUT:   %.4: type = struct_type {} [template]
// CHECK:STDOUT:   %.5: <witness> = complete_type_witness %.4 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Int32 = %import_ref
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref: %Int32.type = import_ref Core//prelude/types, inst+15, loaded [template = constants.%Int32]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .C = %C.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %C.decl: %C.type = class_decl @C [template = constants.%C.1] {
// CHECK:STDOUT:     %T.patt.loc4_9.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_9.2 (constants.%T.patt.1)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc4_9.1, runtime_param<invalid> [symbolic = %T.patt.loc4_9.2 (constants.%T.patt.1)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc4_9.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc4_9.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.decl: %.type = class_decl @.1 [template = constants.%.2] {
// CHECK:STDOUT:     %T.patt.loc12_9.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt.2)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc12_9.1, runtime_param<invalid> [symbolic = %T.patt.loc12_9.2 (constants.%T.patt.2)]
// CHECK:STDOUT:     %U.patt.loc12_19.1: i32 = symbolic_binding_pattern U, 1 [symbolic = %U.patt.loc12_19.2 (constants.%U.patt)]
// CHECK:STDOUT:     %U.param_patt: i32 = value_param_pattern %U.patt.loc12_19.1, runtime_param<invalid> [symbolic = %U.patt.loc12_19.2 (constants.%U.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc12_23.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc12_23.2: type = converted %int.make_type_32, %.loc12_23.1 [template = i32]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc12_9.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:     %U.param: i32 = value_param runtime_param<invalid>
// CHECK:STDOUT:     %U.loc12_19.1: i32 = bind_symbolic_name U, 1, %U.param [symbolic = %U.loc12_19.2 (constants.%U)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @C(%T.loc4_9.1: type) {
// CHECK:STDOUT:   %T.loc4_9.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc4_9.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc4_9.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_9.2 (constants.%T.patt.1)]
// CHECK:STDOUT:
// CHECK:STDOUT:   class;
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @.1(%T.loc12_9.1: type, %U.loc12_19.1: i32) {
// CHECK:STDOUT:   %T.loc12_9.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc12_9.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc12_9.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt.2)]
// CHECK:STDOUT:   %U.loc12_19.2: i32 = bind_symbolic_name U, 1 [symbolic = %U.loc12_19.2 (constants.%U)]
// CHECK:STDOUT:   %U.patt.loc12_19.2: i32 = symbolic_binding_pattern U, 1 [symbolic = %U.patt.loc12_19.2 (constants.%U.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   class {
// CHECK:STDOUT:     %.loc12_29: <witness> = complete_type_witness %.4 [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = constants.%.3
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: specific @C(constants.%T) {
// CHECK:STDOUT:   %T.loc4_9.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc4_9.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @.1(constants.%T, constants.%U) {
// CHECK:STDOUT:   %T.loc12_9.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc12_9.2 => constants.%T
// CHECK:STDOUT:   %U.loc12_19.2 => constants.%U
// CHECK:STDOUT:   %U.patt.loc12_19.2 => constants.%U
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_mismatch_param_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T.1: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt.1: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %D.type: type = generic_class_type @D [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %D.1: %D.type = struct_value () [template]
// CHECK:STDOUT:   %D.2: type = class_type @D, @D(%T.1) [symbolic]
// CHECK:STDOUT:   %Int32.type: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %Int32: %Int32.type = struct_value () [template]
// CHECK:STDOUT:   %T.2: i32 = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt.2: i32 = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %.type: type = generic_class_type @.1 [template]
// CHECK:STDOUT:   %.2: %.type = struct_value () [template]
// CHECK:STDOUT:   %.3: type = class_type @.1, @.1(%T.2) [symbolic]
// CHECK:STDOUT:   %.4: type = struct_type {} [template]
// CHECK:STDOUT:   %.5: <witness> = complete_type_witness %.4 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Int32 = %import_ref
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref: %Int32.type = import_ref Core//prelude/types, inst+15, loaded [template = constants.%Int32]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .D = %D.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %D.decl: %D.type = class_decl @D [template = constants.%D.1] {
// CHECK:STDOUT:     %T.patt.loc4_9.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_9.2 (constants.%T.patt.1)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc4_9.1, runtime_param<invalid> [symbolic = %T.patt.loc4_9.2 (constants.%T.patt.1)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc4_9.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc4_9.2 (constants.%T.1)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.decl: %.type = class_decl @.1 [template = constants.%.2] {
// CHECK:STDOUT:     %T.patt.loc12_9.1: i32 = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt.2)]
// CHECK:STDOUT:     %T.param_patt: i32 = value_param_pattern %T.patt.loc12_9.1, runtime_param<invalid> [symbolic = %T.patt.loc12_9.2 (constants.%T.patt.2)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc12_13.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc12_13.2: type = converted %int.make_type_32, %.loc12_13.1 [template = i32]
// CHECK:STDOUT:     %T.param: i32 = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc12_9.1: i32 = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc12_9.2 (constants.%T.2)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @D(%T.loc4_9.1: type) {
// CHECK:STDOUT:   %T.loc4_9.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc4_9.2 (constants.%T.1)]
// CHECK:STDOUT:   %T.patt.loc4_9.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_9.2 (constants.%T.patt.1)]
// CHECK:STDOUT:
// CHECK:STDOUT:   class;
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @.1(%T.loc12_9.1: i32) {
// CHECK:STDOUT:   %T.loc12_9.2: i32 = bind_symbolic_name T, 0 [symbolic = %T.loc12_9.2 (constants.%T.2)]
// CHECK:STDOUT:   %T.patt.loc12_9.2: i32 = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc12_9.2 (constants.%T.patt.2)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   class {
// CHECK:STDOUT:     %.loc12_19: <witness> = complete_type_witness %.4 [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = constants.%.3
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: specific @D(constants.%T.1) {
// CHECK:STDOUT:   %T.loc4_9.2 => constants.%T.1
// CHECK:STDOUT:   %T.patt.loc4_9.2 => constants.%T.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @.1(constants.%T.2) {
// CHECK:STDOUT:   %T.loc12_9.2 => constants.%T.2
// CHECK:STDOUT:   %T.patt.loc12_9.2 => constants.%T.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_mismatch_param_name.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %E.type: type = generic_class_type @E [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %E.1: %E.type = struct_value () [template]
// CHECK:STDOUT:   %E.2: type = class_type @E, @E(%T) [symbolic]
// CHECK:STDOUT:   %U: type = bind_symbolic_name U, 0 [symbolic]
// CHECK:STDOUT:   %U.patt: type = symbolic_binding_pattern U, 0 [symbolic]
// CHECK:STDOUT:   %.type: type = generic_class_type @.1 [template]
// CHECK:STDOUT:   %.2: %.type = struct_value () [template]
// CHECK:STDOUT:   %.3: type = class_type @.1, @.1(%U) [symbolic]
// CHECK:STDOUT:   %.4: type = struct_type {} [template]
// CHECK:STDOUT:   %.5: <witness> = complete_type_witness %.4 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     import Core//prelude
// CHECK:STDOUT:     import Core//prelude/operators
// CHECK:STDOUT:     import Core//prelude/types
// CHECK:STDOUT:     import Core//prelude/operators/arithmetic
// CHECK:STDOUT:     import Core//prelude/operators/as
// CHECK:STDOUT:     import Core//prelude/operators/bitwise
// CHECK:STDOUT:     import Core//prelude/operators/comparison
// CHECK:STDOUT:     import Core//prelude/types/bool
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .E = %E.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %E.decl: %E.type = class_decl @E [template = constants.%E.1] {
// CHECK:STDOUT:     %T.patt.loc4_9.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_9.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc4_9.1, runtime_param<invalid> [symbolic = %T.patt.loc4_9.2 (constants.%T.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc4_9.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc4_9.2 (constants.%T)]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.decl: %.type = class_decl @.1 [template = constants.%.2] {
// CHECK:STDOUT:     %U.patt.loc11_9.1: type = symbolic_binding_pattern U, 0 [symbolic = %U.patt.loc11_9.2 (constants.%U.patt)]
// CHECK:STDOUT:     %U.param_patt: type = value_param_pattern %U.patt.loc11_9.1, runtime_param<invalid> [symbolic = %U.patt.loc11_9.2 (constants.%U.patt)]
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %U.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %U.loc11_9.1: type = bind_symbolic_name U, 0, %U.param [symbolic = %U.loc11_9.2 (constants.%U)]
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @E(%T.loc4_9.1: type) {
// CHECK:STDOUT:   %T.loc4_9.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc4_9.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc4_9.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc4_9.2 (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT:   class;
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic class @.1(%U.loc11_9.1: type) {
// CHECK:STDOUT:   %U.loc11_9.2: type = bind_symbolic_name U, 0 [symbolic = %U.loc11_9.2 (constants.%U)]
// CHECK:STDOUT:   %U.patt.loc11_9.2: type = symbolic_binding_pattern U, 0 [symbolic = %U.patt.loc11_9.2 (constants.%U.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:
// CHECK:STDOUT:   class {
// CHECK:STDOUT:     %.loc11: <witness> = complete_type_witness %.4 [template = constants.%.5]
// CHECK:STDOUT:
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = constants.%.3
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @E(constants.%T) {
// CHECK:STDOUT:   %T.loc4_9.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc4_9.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @.1(constants.%U) {
// CHECK:STDOUT:   %U.loc11_9.2 => constants.%U
// CHECK:STDOUT:   %U.patt.loc11_9.2 => constants.%U
// CHECK:STDOUT: }
// CHECK:STDOUT:
