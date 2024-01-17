; ModuleID = '/home/chngh/Desktop/SOC_design/Lab5/vitis_hls_project/hls_caravel_ps/hls_caravel_ps.prj/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<38>" = type { %"struct.ap_int_base<38, false>" }
%"struct.ap_int_base<38, false>" = type { %"struct.ssdm_int<38, false>" }
%"struct.ssdm_int<38, false>" = type { i38 }

; Function Attrs: inaccessiblemem_or_argmemonly noinline
define void @apatb_caravel_ps_ir(%"struct.ap_uint<38>"* nocapture readonly %ps_mprj_in, %"struct.ap_uint<38>"* noalias nocapture nonnull dereferenceable(8) %ps_mprj_out, %"struct.ap_uint<38>"* noalias nocapture nonnull dereferenceable(8) %ps_mprj_en, %"struct.ap_uint<38>"* noalias nonnull dereferenceable(8) %mprj_in, %"struct.ap_uint<38>"* nocapture readonly %mprj_out, %"struct.ap_uint<38>"* nocapture readonly %mprj_en) local_unnamed_addr #0 {
entry:
  %ps_mprj_out_copy = alloca i38, align 512
  %ps_mprj_en_copy = alloca i38, align 512
  %mprj_in_copy = alloca i38, align 512
  call fastcc void @copy_in(%"struct.ap_uint<38>"* nonnull %ps_mprj_out, i38* nonnull align 512 %ps_mprj_out_copy, %"struct.ap_uint<38>"* nonnull %ps_mprj_en, i38* nonnull align 512 %ps_mprj_en_copy, %"struct.ap_uint<38>"* nonnull %mprj_in, i38* nonnull align 512 %mprj_in_copy)
  call void @apatb_caravel_ps_hw(%"struct.ap_uint<38>"* %ps_mprj_in, i38* %ps_mprj_out_copy, i38* %ps_mprj_en_copy, i38* %mprj_in_copy, %"struct.ap_uint<38>"* %mprj_out, %"struct.ap_uint<38>"* %mprj_en)
  call void @copy_back(%"struct.ap_uint<38>"* %ps_mprj_out, i38* %ps_mprj_out_copy, %"struct.ap_uint<38>"* %ps_mprj_en, i38* %ps_mprj_en_copy, %"struct.ap_uint<38>"* %mprj_in, i38* %mprj_in_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_in(%"struct.ap_uint<38>"* noalias readonly "unpacked"="0", i38* noalias nocapture align 512 "unpacked"="1.0", %"struct.ap_uint<38>"* noalias readonly "unpacked"="2", i38* noalias nocapture align 512 "unpacked"="3.0", %"struct.ap_uint<38>"* noalias readonly "unpacked"="4", i38* noalias nocapture align 512 "unpacked"="5.0") unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>"(i38* align 512 %1, %"struct.ap_uint<38>"* %0)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>"(i38* align 512 %3, %"struct.ap_uint<38>"* %2)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>"(i38* align 512 %5, %"struct.ap_uint<38>"* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_out(%"struct.ap_uint<38>"* noalias "unpacked"="0", i38* noalias nocapture readonly align 512 "unpacked"="1.0", %"struct.ap_uint<38>"* noalias "unpacked"="2", i38* noalias nocapture readonly align 512 "unpacked"="3.0", %"struct.ap_uint<38>"* noalias "unpacked"="4", i38* noalias nocapture readonly align 512 "unpacked"="5.0") unnamed_addr #2 {
entry:
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* %0, i38* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* %2, i38* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* %4, i38* align 512 %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* noalias "unpacked"="0" %dst, i38* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #3 {
entry:
  %0 = icmp eq %"struct.ap_uint<38>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<38>", %"struct.ap_uint<38>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i38* %src to i40*
  %2 = load i40, i40* %1
  %3 = trunc i40 %2 to i38
  store i38 %3, i38* %dst.0.0.04, align 8
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>"(i38* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<38>"* noalias readonly "unpacked"="1" %src) unnamed_addr #3 {
entry:
  %0 = icmp eq %"struct.ap_uint<38>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<38>", %"struct.ap_uint<38>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i38* %src.0.0.03 to i40*
  %2 = load i40, i40* %1
  %3 = trunc i40 %2 to i38
  store i38 %3, i38* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

declare void @apatb_caravel_ps_hw(%"struct.ap_uint<38>"*, i38*, i38*, i38*, %"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*)

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @copy_back(%"struct.ap_uint<38>"* noalias "unpacked"="0", i38* noalias nocapture readonly align 512 "unpacked"="1.0", %"struct.ap_uint<38>"* noalias "unpacked"="2", i38* noalias nocapture readonly align 512 "unpacked"="3.0", %"struct.ap_uint<38>"* noalias "unpacked"="4", i38* noalias nocapture readonly align 512 "unpacked"="5.0") unnamed_addr #2 {
entry:
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* %0, i38* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* %2, i38* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<38>.4"(%"struct.ap_uint<38>"* %4, i38* align 512 %5)
  ret void
}

define void @caravel_ps_hw_stub_wrapper(%"struct.ap_uint<38>"*, i38*, i38*, i38*, %"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*) #4 {
entry:
  %6 = alloca %"struct.ap_uint<38>"
  %7 = alloca %"struct.ap_uint<38>"
  %8 = alloca %"struct.ap_uint<38>"
  call void @copy_out(%"struct.ap_uint<38>"* %6, i38* %1, %"struct.ap_uint<38>"* %7, i38* %2, %"struct.ap_uint<38>"* %8, i38* %3)
  call void @caravel_ps_hw_stub(%"struct.ap_uint<38>"* %0, %"struct.ap_uint<38>"* %6, %"struct.ap_uint<38>"* %7, %"struct.ap_uint<38>"* %8, %"struct.ap_uint<38>"* %4, %"struct.ap_uint<38>"* %5)
  call void @copy_in(%"struct.ap_uint<38>"* %6, i38* %1, %"struct.ap_uint<38>"* %7, i38* %2, %"struct.ap_uint<38>"* %8, i38* %3)
  ret void
}

declare void @caravel_ps_hw_stub(%"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*, %"struct.ap_uint<38>"*)

attributes #0 = { inaccessiblemem_or_argmemonly noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse "fpga.wrapper.func"="copyout" }
attributes #3 = { argmemonly noinline norecurse "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
