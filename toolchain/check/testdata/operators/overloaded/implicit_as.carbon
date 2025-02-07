// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/check/testdata/operators/overloaded/implicit_as.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/check/testdata/operators/overloaded/implicit_as.carbon

class X {
  var n: i32;
}

impl i32 as Core.ImplicitAs(X) {
  fn Convert[self: i32]() -> X { return {.n = self}; }
}

impl X as Core.ImplicitAs(i32) {
  fn Convert[self: X]() -> i32 { return self.n; }
}

// TODO: fn Sink(T:! type, x: T);
// ... once we stop deducing `T` from the type of the second argument in this case.
fn Sink_i32(n: i32);
fn Sink_X(x: X);
fn Source(T:! type) -> T { return Source(T); }

fn Test() {
  Sink_i32(Source(X));
  Sink_X(Source(i32));
}

// CHECK:STDOUT: --- implicit_as.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %X: type = class_type @X [template]
// CHECK:STDOUT:   %Int32.type: type = fn_type @Int32 [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %Int32: %Int32.type = struct_value () [template]
// CHECK:STDOUT:   %.2: type = unbound_element_type %X, i32 [template]
// CHECK:STDOUT:   %.3: type = struct_type {.n: i32} [template]
// CHECK:STDOUT:   %.4: <witness> = complete_type_witness %.3 [template]
// CHECK:STDOUT:   %ImplicitAs.type.1: type = generic_interface_type @ImplicitAs [template]
// CHECK:STDOUT:   %ImplicitAs: %ImplicitAs.type.1 = struct_value () [template]
// CHECK:STDOUT:   %Dest: type = bind_symbolic_name Dest, 0 [symbolic]
// CHECK:STDOUT:   %ImplicitAs.type.2: type = interface_type @ImplicitAs, @ImplicitAs(%Dest) [symbolic]
// CHECK:STDOUT:   %Self.1: @ImplicitAs.%ImplicitAs.type (%ImplicitAs.type.2) = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %Dest.patt: type = symbolic_binding_pattern Dest, 0 [symbolic]
// CHECK:STDOUT:   %Self.2: %ImplicitAs.type.2 = bind_symbolic_name Self, 1 [symbolic]
// CHECK:STDOUT:   %Convert.type.1: type = fn_type @Convert.1, @ImplicitAs(%Dest) [symbolic]
// CHECK:STDOUT:   %Convert.1: %Convert.type.1 = struct_value () [symbolic]
// CHECK:STDOUT:   %.5: type = assoc_entity_type %ImplicitAs.type.2, %Convert.type.1 [symbolic]
// CHECK:STDOUT:   %.6: %.5 = assoc_entity element0, imports.%import_ref.6 [symbolic]
// CHECK:STDOUT:   %ImplicitAs.type.3: type = interface_type @ImplicitAs, @ImplicitAs(%X) [template]
// CHECK:STDOUT:   %Convert.type.2: type = fn_type @Convert.2 [template]
// CHECK:STDOUT:   %Convert.2: %Convert.type.2 = struct_value () [template]
// CHECK:STDOUT:   %Convert.type.3: type = fn_type @Convert.1, @ImplicitAs(%X) [template]
// CHECK:STDOUT:   %Convert.3: %Convert.type.3 = struct_value () [template]
// CHECK:STDOUT:   %.7: type = assoc_entity_type %ImplicitAs.type.3, %Convert.type.3 [template]
// CHECK:STDOUT:   %.8: %.7 = assoc_entity element0, imports.%import_ref.6 [template]
// CHECK:STDOUT:   %.9: <witness> = interface_witness (%Convert.2) [template]
// CHECK:STDOUT:   %.10: type = ptr_type %.3 [template]
// CHECK:STDOUT:   %ImplicitAs.type.4: type = interface_type @ImplicitAs, @ImplicitAs(i32) [template]
// CHECK:STDOUT:   %Convert.type.4: type = fn_type @Convert.3 [template]
// CHECK:STDOUT:   %Convert.4: %Convert.type.4 = struct_value () [template]
// CHECK:STDOUT:   %Convert.type.5: type = fn_type @Convert.1, @ImplicitAs(i32) [template]
// CHECK:STDOUT:   %Convert.5: %Convert.type.5 = struct_value () [template]
// CHECK:STDOUT:   %.11: type = assoc_entity_type %ImplicitAs.type.4, %Convert.type.5 [template]
// CHECK:STDOUT:   %.12: %.11 = assoc_entity element0, imports.%import_ref.6 [template]
// CHECK:STDOUT:   %.13: <witness> = interface_witness (%Convert.4) [template]
// CHECK:STDOUT:   %Sink_i32.type: type = fn_type @Sink_i32 [template]
// CHECK:STDOUT:   %Sink_i32: %Sink_i32.type = struct_value () [template]
// CHECK:STDOUT:   %Sink_X.type: type = fn_type @Sink_X [template]
// CHECK:STDOUT:   %Sink_X: %Sink_X.type = struct_value () [template]
// CHECK:STDOUT:   %T: type = bind_symbolic_name T, 0 [symbolic]
// CHECK:STDOUT:   %T.patt: type = symbolic_binding_pattern T, 0 [symbolic]
// CHECK:STDOUT:   %Source.type: type = fn_type @Source [template]
// CHECK:STDOUT:   %Source: %Source.type = struct_value () [template]
// CHECK:STDOUT:   %.14: <specific function> = specific_function %Source, @Source(%T) [symbolic]
// CHECK:STDOUT:   %Test.type: type = fn_type @Test [template]
// CHECK:STDOUT:   %Test: %Test.type = struct_value () [template]
// CHECK:STDOUT:   %.15: <specific function> = specific_function %Source, @Source(%X) [template]
// CHECK:STDOUT:   %.16: %.5 = assoc_entity element0, imports.%import_ref.7 [symbolic]
// CHECK:STDOUT:   %.17: <specific function> = specific_function %Source, @Source(i32) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: imports {
// CHECK:STDOUT:   %Core: <namespace> = namespace file.%Core.import, [template] {
// CHECK:STDOUT:     .Int32 = %import_ref.1
// CHECK:STDOUT:     .ImplicitAs = %import_ref.2
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
// CHECK:STDOUT:   %import_ref.2: %ImplicitAs.type.1 = import_ref Core//prelude/operators/as, inst+49, loaded [template = constants.%ImplicitAs]
// CHECK:STDOUT:   %import_ref.3 = import_ref Core//prelude/operators/as, inst+55, unloaded
// CHECK:STDOUT:   %import_ref.4: @ImplicitAs.%.1 (%.5) = import_ref Core//prelude/operators/as, inst+77, loaded [symbolic = @ImplicitAs.%.2 (constants.%.16)]
// CHECK:STDOUT:   %import_ref.5: @ImplicitAs.%Convert.type (%Convert.type.1) = import_ref Core//prelude/operators/as, inst+70, loaded [symbolic = @ImplicitAs.%Convert (constants.%Convert.1)]
// CHECK:STDOUT:   %import_ref.6 = import_ref Core//prelude/operators/as, inst+70, unloaded
// CHECK:STDOUT:   %import_ref.7 = import_ref Core//prelude/operators/as, inst+70, unloaded
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = imports.%Core
// CHECK:STDOUT:     .X = %X.decl
// CHECK:STDOUT:     .Sink_i32 = %Sink_i32.decl
// CHECK:STDOUT:     .Sink_X = %Sink_X.decl
// CHECK:STDOUT:     .Source = %Source.decl
// CHECK:STDOUT:     .Test = %Test.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core.import = import Core
// CHECK:STDOUT:   %X.decl: type = class_decl @X [template = constants.%X] {} {}
// CHECK:STDOUT:   impl_decl @impl.1 [template] {} {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc15_6.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc15_6.2: type = converted %int.make_type_32, %.loc15_6.1 [template = i32]
// CHECK:STDOUT:     %Core.ref: <namespace> = name_ref Core, imports.%Core [template = imports.%Core]
// CHECK:STDOUT:     %ImplicitAs.ref: %ImplicitAs.type.1 = name_ref ImplicitAs, imports.%import_ref.2 [template = constants.%ImplicitAs]
// CHECK:STDOUT:     %X.ref: type = name_ref X, file.%X.decl [template = constants.%X]
// CHECK:STDOUT:     %ImplicitAs.type: type = interface_type @ImplicitAs, @ImplicitAs(constants.%X) [template = constants.%ImplicitAs.type.3]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   impl_decl @impl.2 [template] {} {
// CHECK:STDOUT:     %X.ref: type = name_ref X, file.%X.decl [template = constants.%X]
// CHECK:STDOUT:     %Core.ref: <namespace> = name_ref Core, imports.%Core [template = imports.%Core]
// CHECK:STDOUT:     %ImplicitAs.ref: %ImplicitAs.type.1 = name_ref ImplicitAs, imports.%import_ref.2 [template = constants.%ImplicitAs]
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc19_26.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc19_26.2: type = converted %int.make_type_32, %.loc19_26.1 [template = i32]
// CHECK:STDOUT:     %ImplicitAs.type: type = interface_type @ImplicitAs, @ImplicitAs(i32) [template = constants.%ImplicitAs.type.4]
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Sink_i32.decl: %Sink_i32.type = fn_decl @Sink_i32 [template = constants.%Sink_i32] {
// CHECK:STDOUT:     %n.patt: i32 = binding_pattern n
// CHECK:STDOUT:     %n.param_patt: i32 = value_param_pattern %n.patt, runtime_param0
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc25_16.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc25_16.2: type = converted %int.make_type_32, %.loc25_16.1 [template = i32]
// CHECK:STDOUT:     %n.param: i32 = value_param runtime_param0
// CHECK:STDOUT:     %n: i32 = bind_name n, %n.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Sink_X.decl: %Sink_X.type = fn_decl @Sink_X [template = constants.%Sink_X] {
// CHECK:STDOUT:     %x.patt: %X = binding_pattern x
// CHECK:STDOUT:     %x.param_patt: %X = value_param_pattern %x.patt, runtime_param0
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %X.ref: type = name_ref X, file.%X.decl [template = constants.%X]
// CHECK:STDOUT:     %x.param: %X = value_param runtime_param0
// CHECK:STDOUT:     %x: %X = bind_name x, %x.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Source.decl: %Source.type = fn_decl @Source [template = constants.%Source] {
// CHECK:STDOUT:     %T.patt.loc27_11.1: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc27_11.2 (constants.%T.patt)]
// CHECK:STDOUT:     %T.param_patt: type = value_param_pattern %T.patt.loc27_11.1, runtime_param<invalid> [symbolic = %T.patt.loc27_11.2 (constants.%T.patt)]
// CHECK:STDOUT:     %return.patt: @Source.%T.loc27_11.2 (%T) = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: @Source.%T.loc27_11.2 (%T) = out_param_pattern %return.patt, runtime_param0
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %T.ref.loc27_24: type = name_ref T, %T.loc27_11.1 [symbolic = %T.loc27_11.2 (constants.%T)]
// CHECK:STDOUT:     %T.param: type = value_param runtime_param<invalid>
// CHECK:STDOUT:     %T.loc27_11.1: type = bind_symbolic_name T, 0, %T.param [symbolic = %T.loc27_11.2 (constants.%T)]
// CHECK:STDOUT:     %return.param: ref @Source.%T.loc27_11.2 (%T) = out_param runtime_param0
// CHECK:STDOUT:     %return: ref @Source.%T.loc27_11.2 (%T) = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Test.decl: %Test.type = fn_decl @Test [template = constants.%Test] {} {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: generic interface @ImplicitAs(constants.%Dest: type) {
// CHECK:STDOUT:   %Dest: type = bind_symbolic_name Dest, 0 [symbolic = %Dest (constants.%Dest)]
// CHECK:STDOUT:   %Dest.patt: type = symbolic_binding_pattern Dest, 0 [symbolic = %Dest.patt (constants.%Dest.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %ImplicitAs.type: type = interface_type @ImplicitAs, @ImplicitAs(%Dest) [symbolic = %ImplicitAs.type (constants.%ImplicitAs.type.2)]
// CHECK:STDOUT:   %Self: %ImplicitAs.type.2 = bind_symbolic_name Self, 1 [symbolic = %Self (constants.%Self.2)]
// CHECK:STDOUT:   %Convert.type: type = fn_type @Convert.1, @ImplicitAs(%Dest) [symbolic = %Convert.type (constants.%Convert.type.1)]
// CHECK:STDOUT:   %Convert: @ImplicitAs.%Convert.type (%Convert.type.1) = struct_value () [symbolic = %Convert (constants.%Convert.1)]
// CHECK:STDOUT:   %.1: type = assoc_entity_type @ImplicitAs.%ImplicitAs.type (%ImplicitAs.type.2), @ImplicitAs.%Convert.type (%Convert.type.1) [symbolic = %.1 (constants.%.5)]
// CHECK:STDOUT:   %.2: @ImplicitAs.%.1 (%.5) = assoc_entity element0, imports.%import_ref.6 [symbolic = %.2 (constants.%.6)]
// CHECK:STDOUT:
// CHECK:STDOUT:   interface {
// CHECK:STDOUT:   !members:
// CHECK:STDOUT:     .Self = imports.%import_ref.3
// CHECK:STDOUT:     .Convert = imports.%import_ref.4
// CHECK:STDOUT:     witness = (imports.%import_ref.5)
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.1: %.loc15_6.2 as %ImplicitAs.type {
// CHECK:STDOUT:   %Convert.decl: %Convert.type.2 = fn_decl @Convert.2 [template = constants.%Convert.2] {
// CHECK:STDOUT:     %self.patt: i32 = binding_pattern self
// CHECK:STDOUT:     %self.param_patt: i32 = value_param_pattern %self.patt, runtime_param0
// CHECK:STDOUT:     %return.patt: %X = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: %X = out_param_pattern %return.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc16_20.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc16_20.2: type = converted %int.make_type_32, %.loc16_20.1 [template = i32]
// CHECK:STDOUT:     %X.ref: type = name_ref X, file.%X.decl [template = constants.%X]
// CHECK:STDOUT:     %self.param: i32 = value_param runtime_param0
// CHECK:STDOUT:     %self: i32 = bind_name self, %self.param
// CHECK:STDOUT:     %return.param: ref %X = out_param runtime_param1
// CHECK:STDOUT:     %return: ref %X = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.loc15_32: <witness> = interface_witness (%Convert.decl) [template = constants.%.9]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Convert = %Convert.decl
// CHECK:STDOUT:   witness = %.loc15_32
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: impl @impl.2: %X.ref as %ImplicitAs.type {
// CHECK:STDOUT:   %Convert.decl: %Convert.type.4 = fn_decl @Convert.3 [template = constants.%Convert.4] {
// CHECK:STDOUT:     %self.patt: %X = binding_pattern self
// CHECK:STDOUT:     %self.param_patt: %X = value_param_pattern %self.patt, runtime_param0
// CHECK:STDOUT:     %return.patt: i32 = return_slot_pattern
// CHECK:STDOUT:     %return.param_patt: i32 = out_param_pattern %return.patt, runtime_param1
// CHECK:STDOUT:   } {
// CHECK:STDOUT:     %X.ref: type = name_ref X, file.%X.decl [template = constants.%X]
// CHECK:STDOUT:     %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:     %.loc20_28.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:     %.loc20_28.2: type = converted %int.make_type_32, %.loc20_28.1 [template = i32]
// CHECK:STDOUT:     %self.param: %X = value_param runtime_param0
// CHECK:STDOUT:     %self: %X = bind_name self, %self.param
// CHECK:STDOUT:     %return.param: ref i32 = out_param runtime_param1
// CHECK:STDOUT:     %return: ref i32 = return_slot %return.param
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %.loc19_32: <witness> = interface_witness (%Convert.decl) [template = constants.%.13]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Convert = %Convert.decl
// CHECK:STDOUT:   witness = %.loc19_32
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @X {
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:   %.loc12_10.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc12_10.2: type = converted %int.make_type_32, %.loc12_10.1 [template = i32]
// CHECK:STDOUT:   %.loc12_8: %.2 = field_decl n, element0 [template]
// CHECK:STDOUT:   %.loc13: <witness> = complete_type_witness %.3 [template = constants.%.4]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%X
// CHECK:STDOUT:   .n = %.loc12_8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Int32() -> type = "int.make_type_32";
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @Convert.1(constants.%Dest: type, constants.%Self.1: @ImplicitAs.%ImplicitAs.type (%ImplicitAs.type.2)) {
// CHECK:STDOUT:   %Dest: type = bind_symbolic_name Dest, 0 [symbolic = %Dest (constants.%Dest)]
// CHECK:STDOUT:   %ImplicitAs.type: type = interface_type @ImplicitAs, @ImplicitAs(%Dest) [symbolic = %ImplicitAs.type (constants.%ImplicitAs.type.2)]
// CHECK:STDOUT:   %Self: %ImplicitAs.type.2 = bind_symbolic_name Self, 1 [symbolic = %Self (constants.%Self.2)]
// CHECK:STDOUT:
// CHECK:STDOUT:   fn[%self.param_patt: @Convert.1.%Self (%Self.2)]() -> @Convert.1.%Dest (%Dest);
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Convert.2[%self.param_patt: i32]() -> %return: %X {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %self.ref: i32 = name_ref self, %self
// CHECK:STDOUT:   %.loc16_51.1: %.3 = struct_literal (%self.ref)
// CHECK:STDOUT:   %.loc16_51.2: ref i32 = class_element_access %return, element0
// CHECK:STDOUT:   %.loc16_51.3: init i32 = initialize_from %self.ref to %.loc16_51.2
// CHECK:STDOUT:   %.loc16_51.4: init %X = class_init (%.loc16_51.3), %return
// CHECK:STDOUT:   %.loc16_52: init %X = converted %.loc16_51.1, %.loc16_51.4
// CHECK:STDOUT:   return %.loc16_52 to %return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Convert.3[%self.param_patt: %X]() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %self.ref: %X = name_ref self, %self
// CHECK:STDOUT:   %n.ref: %.2 = name_ref n, @X.%.loc12_8 [template = @X.%.loc12_8]
// CHECK:STDOUT:   %.loc20_45.1: ref i32 = class_element_access %self.ref, element0
// CHECK:STDOUT:   %.loc20_45.2: i32 = bind_value %.loc20_45.1
// CHECK:STDOUT:   return %.loc20_45.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Sink_i32(%n.param_patt: i32);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Sink_X(%x.param_patt: %X);
// CHECK:STDOUT:
// CHECK:STDOUT: generic fn @Source(%T.loc27_11.1: type) {
// CHECK:STDOUT:   %T.loc27_11.2: type = bind_symbolic_name T, 0 [symbolic = %T.loc27_11.2 (constants.%T)]
// CHECK:STDOUT:   %T.patt.loc27_11.2: type = symbolic_binding_pattern T, 0 [symbolic = %T.patt.loc27_11.2 (constants.%T.patt)]
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %.loc27_35.2: <specific function> = specific_function constants.%Source, @Source(%T.loc27_11.2) [symbolic = %.loc27_35.2 (constants.%.14)]
// CHECK:STDOUT:
// CHECK:STDOUT:   fn(%T.param_patt: type) -> @Source.%T.loc27_11.2 (%T) {
// CHECK:STDOUT:   !entry:
// CHECK:STDOUT:     %Source.ref: %Source.type = name_ref Source, file.%Source.decl [template = constants.%Source]
// CHECK:STDOUT:     %T.ref.loc27_42: type = name_ref T, %T.loc27_11.1 [symbolic = %T.loc27_11.2 (constants.%T)]
// CHECK:STDOUT:     %.loc27_35.1: <specific function> = specific_function %Source.ref, @Source(constants.%T) [symbolic = %.loc27_35.2 (constants.%.14)]
// CHECK:STDOUT:     %Source.call: init @Source.%T.loc27_11.2 (%T) = call %.loc27_35.1()
// CHECK:STDOUT:     %.loc27_44.1: @Source.%T.loc27_11.2 (%T) = value_of_initializer %Source.call
// CHECK:STDOUT:     %.loc27_44.2: @Source.%T.loc27_11.2 (%T) = converted %Source.call, %.loc27_44.1
// CHECK:STDOUT:     return %.loc27_44.2
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Test() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Sink_i32.ref: %Sink_i32.type = name_ref Sink_i32, file.%Sink_i32.decl [template = constants.%Sink_i32]
// CHECK:STDOUT:   %Source.ref.loc30: %Source.type = name_ref Source, file.%Source.decl [template = constants.%Source]
// CHECK:STDOUT:   %X.ref: type = name_ref X, file.%X.decl [template = constants.%X]
// CHECK:STDOUT:   %.loc30_12: <specific function> = specific_function %Source.ref.loc30, @Source(constants.%X) [template = constants.%.15]
// CHECK:STDOUT:   %.loc30_18.1: ref %X = temporary_storage
// CHECK:STDOUT:   %Source.call.loc30: init %X = call %.loc30_12() to %.loc30_18.1
// CHECK:STDOUT:   %ImplicitAs.type.loc30: type = interface_type @ImplicitAs, @ImplicitAs(i32) [template = constants.%ImplicitAs.type.4]
// CHECK:STDOUT:   %.loc30_18.2: %.11 = specific_constant imports.%import_ref.4, @ImplicitAs(i32) [template = constants.%.12]
// CHECK:STDOUT:   %Convert.ref.loc30: %.11 = name_ref Convert, %.loc30_18.2 [template = constants.%.12]
// CHECK:STDOUT:   %.loc30_18.3: ref %X = temporary %.loc30_18.1, %Source.call.loc30
// CHECK:STDOUT:   %.loc30_18.4: %Convert.type.5 = interface_witness_access constants.%.13, element0 [template = constants.%Convert.4]
// CHECK:STDOUT:   %.loc30_18.5: <bound method> = bound_method %.loc30_18.3, %.loc30_18.4
// CHECK:STDOUT:   %.loc30_18.6: %X = bind_value %.loc30_18.3
// CHECK:STDOUT:   %Convert.call.loc30: init i32 = call %.loc30_18.5(%.loc30_18.6)
// CHECK:STDOUT:   %.loc30_18.7: init i32 = converted %Source.call.loc30, %Convert.call.loc30
// CHECK:STDOUT:   %.loc30_18.8: ref i32 = temporary_storage
// CHECK:STDOUT:   %.loc30_18.9: ref i32 = temporary %.loc30_18.8, %.loc30_18.7
// CHECK:STDOUT:   %.loc30_18.10: %X = bind_value %.loc30_18.9
// CHECK:STDOUT:   %Sink_i32.call: init %.1 = call %Sink_i32.ref(%.loc30_18.10)
// CHECK:STDOUT:   %Sink_X.ref: %Sink_X.type = name_ref Sink_X, file.%Sink_X.decl [template = constants.%Sink_X]
// CHECK:STDOUT:   %Source.ref.loc31: %Source.type = name_ref Source, file.%Source.decl [template = constants.%Source]
// CHECK:STDOUT:   %int.make_type_32: init type = call constants.%Int32() [template = i32]
// CHECK:STDOUT:   %.loc31_16.1: type = value_of_initializer %int.make_type_32 [template = i32]
// CHECK:STDOUT:   %.loc31_16.2: type = converted %int.make_type_32, %.loc31_16.1 [template = i32]
// CHECK:STDOUT:   %.loc31_10: <specific function> = specific_function %Source.ref.loc31, @Source(i32) [template = constants.%.17]
// CHECK:STDOUT:   %Source.call.loc31: init i32 = call %.loc31_10()
// CHECK:STDOUT:   %ImplicitAs.type.loc31: type = interface_type @ImplicitAs, @ImplicitAs(constants.%X) [template = constants.%ImplicitAs.type.3]
// CHECK:STDOUT:   %.loc31_16.3: %.7 = specific_constant imports.%import_ref.4, @ImplicitAs(constants.%X) [template = constants.%.8]
// CHECK:STDOUT:   %Convert.ref.loc31: %.7 = name_ref Convert, %.loc31_16.3 [template = constants.%.8]
// CHECK:STDOUT:   %.loc31_16.4: ref i32 = temporary_storage
// CHECK:STDOUT:   %.loc31_16.5: ref i32 = temporary %.loc31_16.4, %Source.call.loc31
// CHECK:STDOUT:   %.loc31_16.6: %Convert.type.3 = interface_witness_access constants.%.9, element0 [template = constants.%Convert.2]
// CHECK:STDOUT:   %.loc31_16.7: <bound method> = bound_method %.loc31_16.5, %.loc31_16.6
// CHECK:STDOUT:   %.loc31_16.8: ref %X = temporary_storage
// CHECK:STDOUT:   %.loc31_16.9: i32 = bind_value %.loc31_16.5
// CHECK:STDOUT:   %Convert.call.loc31: init %X = call %.loc31_16.7(%.loc31_16.9) to %.loc31_16.8
// CHECK:STDOUT:   %.loc31_16.10: init %X = converted %Source.call.loc31, %Convert.call.loc31
// CHECK:STDOUT:   %.loc31_16.11: ref %X = temporary %.loc31_16.8, %.loc31_16.10
// CHECK:STDOUT:   %.loc31_16.12: i32 = bind_value %.loc31_16.11
// CHECK:STDOUT:   %Sink_X.call: init %.1 = call %Sink_X.ref(%.loc31_16.12)
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(constants.%Dest) {
// CHECK:STDOUT:   %Dest => constants.%Dest
// CHECK:STDOUT:   %Dest.patt => constants.%Dest
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(@ImplicitAs.%Dest) {
// CHECK:STDOUT:   %Dest => constants.%Dest
// CHECK:STDOUT:   %Dest.patt => constants.%Dest
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(@Convert.1.%Dest) {
// CHECK:STDOUT:   %Dest => constants.%Dest
// CHECK:STDOUT:   %Dest.patt => constants.%Dest
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Convert.1(constants.%Dest, constants.%Self.1) {
// CHECK:STDOUT:   %Dest => constants.%Dest
// CHECK:STDOUT:   %ImplicitAs.type => constants.%ImplicitAs.type.2
// CHECK:STDOUT:   %Self => constants.%Self.1
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(constants.%X) {
// CHECK:STDOUT:   %Dest => constants.%X
// CHECK:STDOUT:   %Dest.patt => constants.%X
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %ImplicitAs.type => constants.%ImplicitAs.type.3
// CHECK:STDOUT:   %Self => constants.%Self.2
// CHECK:STDOUT:   %Convert.type => constants.%Convert.type.3
// CHECK:STDOUT:   %Convert => constants.%Convert.3
// CHECK:STDOUT:   %.1 => constants.%.7
// CHECK:STDOUT:   %.2 => constants.%.8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Convert.1(constants.%X, i32) {
// CHECK:STDOUT:   %Dest => constants.%X
// CHECK:STDOUT:   %ImplicitAs.type => constants.%ImplicitAs.type.3
// CHECK:STDOUT:   %Self => i32
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @ImplicitAs(i32) {
// CHECK:STDOUT:   %Dest => i32
// CHECK:STDOUT:   %Dest.patt => i32
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %ImplicitAs.type => constants.%ImplicitAs.type.4
// CHECK:STDOUT:   %Self => constants.%Self.2
// CHECK:STDOUT:   %Convert.type => constants.%Convert.type.5
// CHECK:STDOUT:   %Convert => constants.%Convert.5
// CHECK:STDOUT:   %.1 => constants.%.11
// CHECK:STDOUT:   %.2 => constants.%.12
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Convert.1(i32, constants.%X) {
// CHECK:STDOUT:   %Dest => i32
// CHECK:STDOUT:   %ImplicitAs.type => constants.%ImplicitAs.type.4
// CHECK:STDOUT:   %Self => constants.%X
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Source(constants.%T) {
// CHECK:STDOUT:   %T.loc27_11.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc27_11.2 => constants.%T
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %.loc27_35.2 => constants.%.14
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Source(@Source.%T.loc27_11.2) {
// CHECK:STDOUT:   %T.loc27_11.2 => constants.%T
// CHECK:STDOUT:   %T.patt.loc27_11.2 => constants.%T
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Source(constants.%X) {
// CHECK:STDOUT:   %T.loc27_11.2 => constants.%X
// CHECK:STDOUT:   %T.patt.loc27_11.2 => constants.%X
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %.loc27_35.2 => constants.%.15
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: specific @Source(i32) {
// CHECK:STDOUT:   %T.loc27_11.2 => i32
// CHECK:STDOUT:   %T.patt.loc27_11.2 => i32
// CHECK:STDOUT:
// CHECK:STDOUT: !definition:
// CHECK:STDOUT:   %.loc27_35.2 => constants.%.17
// CHECK:STDOUT: }
// CHECK:STDOUT:
