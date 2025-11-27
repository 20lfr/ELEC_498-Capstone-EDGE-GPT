; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers_simplified/run_single_head/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i8 }

; Function Attrs: noinline willreturn
define i1 @apatb_run_single_head_ir(%struct.HeadCtx* noalias nonnull dereferenceable(12) %ctx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %ctx_copy = alloca i51, align 512
  call fastcc void @copy_in(%struct.HeadCtx* nonnull %ctx, i51* nonnull align 512 %ctx_copy)
  %0 = call i1 @apatb_run_single_head_hw(i51* %ctx_copy, i32 %layer_idx, i1 %start)
  call void @copy_back(%struct.HeadCtx* %ctx, i51* %ctx_copy)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(%struct.HeadCtx* noalias readonly, i51* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0struct.HeadCtx(i51* align 512 %1, %struct.HeadCtx* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.HeadCtx(i51* noalias align 512 %dst, %struct.HeadCtx* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i51* %dst, null
  %1 = icmp eq %struct.HeadCtx* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 0
  %3 = load i32, i32* %src.0, align 4
  %4 = zext i32 %3 to i51
  %src.1 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 1
  %5 = load i8, i8* %src.1, align 1
  %6 = zext i8 %5 to i51
  %7 = shl i51 %6, 32
  %src.2 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 2
  %8 = bitcast i1* %src.2 to i8*
  %9 = load i8, i8* %8
  %10 = trunc i8 %9 to i1
  %11 = zext i1 %10 to i51
  %12 = shl i51 %11, 40
  %src.3 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 3
  %13 = bitcast i1* %src.3 to i8*
  %14 = load i8, i8* %13
  %15 = trunc i8 %14 to i1
  %16 = zext i1 %15 to i51
  %17 = shl i51 %16, 41
  %src.4 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 4
  %18 = bitcast i1* %src.4 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  %21 = zext i1 %20 to i51
  %22 = shl i51 %21, 42
  %src.5 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 5
  %23 = load i8, i8* %src.5, align 1
  %24 = zext i8 %23 to i51
  %25 = shl i51 %24, 43
  %thr.or10 = or i51 %7, %22
  %thr.or11 = or i51 %12, %4
  %thr.or12 = or i51 %thr.or10, %thr.or11
  %thr.or13 = or i51 %17, %25
  %thr.or14 = or i51 %thr.or12, %thr.or13
  store i51 %thr.or14, i51* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out(%struct.HeadCtx* noalias, i51* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0struct.HeadCtx.4(%struct.HeadCtx* %0, i51* align 512 %1)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.HeadCtx.4(%struct.HeadCtx* noalias %dst, i51* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.HeadCtx* %dst, null
  %1 = icmp eq i51* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 0
  %3 = bitcast i51* %src to i56*
  %4 = load i56, i56* %3
  %5 = trunc i56 %4 to i51
  %.partselect5 = trunc i51 %5 to i32
  store i32 %.partselect5, i32* %dst.0, align 512
  %dst.1 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 1
  %6 = lshr i51 %5, 32
  %.partselect4 = trunc i51 %6 to i8
  store i8 %.partselect4, i8* %dst.1, align 4
  %dst.2 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 2
  %7 = lshr i51 %5, 40
  %.partselect3 = trunc i51 %7 to i1
  store i1 %.partselect3, i1* %dst.2, align 1
  %dst.3 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 3
  %8 = lshr i51 %5, 41
  %.partselect2 = trunc i51 %8 to i1
  store i1 %.partselect2, i1* %dst.3, align 2
  %dst.4 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 4
  %9 = lshr i51 %5, 42
  %.partselect1 = trunc i51 %9 to i1
  store i1 %.partselect1, i1* %dst.4, align 1
  %dst.5 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 5
  %10 = lshr i51 %5, 43
  %.partselect = trunc i51 %10 to i8
  store i8 %.partselect, i8* %dst.5, align 8
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_run_single_head_hw(i51*, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(%struct.HeadCtx* noalias, i51* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0struct.HeadCtx.4(%struct.HeadCtx* %0, i51* align 512 %1)
  ret void
}

declare i1 @run_single_head_hw_stub(%struct.HeadCtx* noalias nonnull, i32, i1 zeroext)

define i1 @run_single_head_hw_stub_wrapper(i51*, i32, i1) #4 {
entry:
  %3 = call i8* @malloc(i64 12)
  %4 = bitcast i8* %3 to %struct.HeadCtx*
  call void @copy_out(%struct.HeadCtx* %4, i51* %0)
  %5 = call i1 @run_single_head_hw_stub(%struct.HeadCtx* %4, i32 %1, i1 %2)
  call void @copy_in(%struct.HeadCtx* %4, i51* %0)
  call void @free(i8* %3)
  ret i1 %5
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
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
