; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers_simplified/run_single_head/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i1, i1, i32 }

; Function Attrs: argmemonly noinline willreturn
define i1 @apatb_run_single_head_ir(%struct.HeadCtx* noalias nonnull dereferenceable(16) %ctx, i32 %head_idx, i32 %layer_idx) local_unnamed_addr #0 {
entry:
  %ctx_copy = alloca i77, align 512
  call fastcc void @copy_in(%struct.HeadCtx* nonnull %ctx, i77* nonnull align 512 %ctx_copy)
  %0 = call i1 @apatb_run_single_head_hw(i77* %ctx_copy, i32 %head_idx, i32 %layer_idx)
  call void @copy_back(%struct.HeadCtx* %ctx, i77* %ctx_copy)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(%struct.HeadCtx* noalias readonly, i77* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0struct.HeadCtx(i77* align 512 %1, %struct.HeadCtx* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.HeadCtx(i77* noalias align 512 %dst, %struct.HeadCtx* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i77* %dst, null
  %1 = icmp eq %struct.HeadCtx* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 0
  %3 = load i32, i32* %src.0, align 4
  %4 = zext i32 %3 to i77
  %src.1 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 1
  %5 = load i8, i8* %src.1, align 1
  %6 = zext i8 %5 to i77
  %7 = shl i77 %6, 32
  %src.2 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 2
  %8 = bitcast i1* %src.2 to i8*
  %9 = load i8, i8* %8
  %10 = trunc i8 %9 to i1
  %11 = zext i1 %10 to i77
  %12 = shl i77 %11, 40
  %src.3 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 3
  %13 = bitcast i1* %src.3 to i8*
  %14 = load i8, i8* %13
  %15 = trunc i8 %14 to i1
  %16 = zext i1 %15 to i77
  %17 = shl i77 %16, 41
  %src.4 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 4
  %18 = bitcast i1* %src.4 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  %21 = zext i1 %20 to i77
  %22 = shl i77 %21, 42
  %src.5 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 5
  %23 = bitcast i1* %src.5 to i8*
  %24 = load i8, i8* %23
  %25 = trunc i8 %24 to i1
  %26 = zext i1 %25 to i77
  %27 = shl i77 %26, 43
  %src.6 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 6
  %28 = bitcast i1* %src.6 to i8*
  %29 = load i8, i8* %28
  %30 = trunc i8 %29 to i1
  %31 = zext i1 %30 to i77
  %32 = shl i77 %31, 44
  %src.7 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %src, i64 0, i32 7
  %33 = load i32, i32* %src.7, align 4
  %34 = zext i32 %33 to i77
  %35 = shl i77 %34, 45
  %thr.or15 = or i77 %27, %35
  %thr.or16 = or i77 %17, %32
  %thr.or17 = or i77 %7, %22
  %thr.or18 = or i77 %12, %4
  %thr.or19 = or i77 %thr.or15, %thr.or16
  %thr.or20 = or i77 %thr.or17, %thr.or18
  %thr.or21 = or i77 %thr.or19, %thr.or20
  store i77 %thr.or21, i77* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out(%struct.HeadCtx* noalias, i77* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0struct.HeadCtx.4(%struct.HeadCtx* %0, i77* align 512 %1)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.HeadCtx.4(%struct.HeadCtx* noalias %dst, i77* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.HeadCtx* %dst, null
  %1 = icmp eq i77* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 0
  %3 = bitcast i77* %src to i80*
  %4 = load i80, i80* %3
  %5 = trunc i80 %4 to i77
  %.partselect7 = trunc i77 %5 to i32
  store i32 %.partselect7, i32* %dst.0, align 512
  %dst.1 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 1
  %6 = lshr i77 %5, 32
  %.partselect6 = trunc i77 %6 to i8
  store i8 %.partselect6, i8* %dst.1, align 4
  %dst.2 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 2
  %7 = lshr i77 %5, 40
  %.partselect5 = trunc i77 %7 to i1
  store i1 %.partselect5, i1* %dst.2, align 1
  %dst.3 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 3
  %8 = lshr i77 %5, 41
  %.partselect4 = trunc i77 %8 to i1
  store i1 %.partselect4, i1* %dst.3, align 2
  %dst.4 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 4
  %9 = lshr i77 %5, 42
  %.partselect3 = trunc i77 %9 to i1
  store i1 %.partselect3, i1* %dst.4, align 1
  %dst.5 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 5
  %10 = lshr i77 %5, 43
  %.partselect2 = trunc i77 %10 to i1
  store i1 %.partselect2, i1* %dst.5, align 8
  %dst.6 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 6
  %11 = lshr i77 %5, 44
  %.partselect1 = trunc i77 %11 to i1
  store i1 %.partselect1, i1* %dst.6, align 1
  %dst.7 = getelementptr %struct.HeadCtx, %struct.HeadCtx* %dst, i64 0, i32 7
  %12 = lshr i77 %5, 45
  %.partselect = trunc i77 %12 to i32
  store i32 %.partselect, i32* %dst.7, align 4
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_run_single_head_hw(i77*, i32, i32)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(%struct.HeadCtx* noalias, i77* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0struct.HeadCtx.4(%struct.HeadCtx* %0, i77* align 512 %1)
  ret void
}

declare i1 @run_single_head_hw_stub(%struct.HeadCtx* noalias nonnull, i32, i32)

define i1 @run_single_head_hw_stub_wrapper(i77*, i32, i32) #4 {
entry:
  %3 = call i8* @malloc(i64 16)
  %4 = bitcast i8* %3 to %struct.HeadCtx*
  call void @copy_out(%struct.HeadCtx* %4, i77* %0)
  %5 = call i1 @run_single_head_hw_stub(%struct.HeadCtx* %4, i32 %1, i32 %2)
  call void @copy_in(%struct.HeadCtx* %4, i77* %0)
  call void @free(i8* %3)
  ret i1 %5
}

attributes #0 = { argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
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
