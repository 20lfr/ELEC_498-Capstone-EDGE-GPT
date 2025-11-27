; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_helpers_parallel/drive_group_head_phase/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i8, i1 }

; Function Attrs: noinline willreturn
define i1 @apatb_drive_group_head_phase_ir([4 x %struct.HeadCtx]* noalias nonnull dereferenceable(48) %head_ctx_ref, i32 %group_idx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy = alloca [4 x i52], align 512
  call fastcc void @copy_in([4 x %struct.HeadCtx]* nonnull %head_ctx_ref, [4 x i52]* nonnull align 512 %head_ctx_ref_copy)
  %0 = call i1 @apatb_drive_group_head_phase_hw([4 x i52]* %head_ctx_ref_copy, i32 %group_idx, i32 %layer_idx, i1 %start)
  call void @copy_back([4 x %struct.HeadCtx]* %head_ctx_ref, [4 x i52]* %head_ctx_ref_copy)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([4 x %struct.HeadCtx]* noalias readonly, [4 x i52]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx([4 x i52]* align 512 %1, [4 x %struct.HeadCtx]* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx([4 x i52]* noalias align 512 %dst, [4 x %struct.HeadCtx]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x i52]* %dst, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx([4 x i52]* nonnull %dst, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx([4 x i52]* %dst, [4 x %struct.HeadCtx]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [4 x i52]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond15 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond15, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx16 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 0
  %3 = getelementptr [4 x i52], [4 x i52]* %dst, i64 0, i64 %for.loop.idx16
  %4 = load i32, i32* %src.addr.01, align 4
  %5 = bitcast i52* %3 to i56*
  %6 = load i56, i56* %5
  %7 = trunc i56 %6 to i52
  %8 = zext i32 %4 to i52
  %9 = and i52 %7, -4294967296
  %.partset6 = or i52 %9, %8
  store i52 %.partset6, i52* %3, align 4
  %src.addr.13 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 1
  %10 = load i8, i8* %src.addr.13, align 1
  %11 = zext i8 %10 to i52
  %12 = shl i52 %11, 32
  %13 = and i52 %.partset6, -1095216660481
  %.partset5 = or i52 %13, %12
  store i52 %.partset5, i52* %3, align 1
  %src.addr.25 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 2
  %14 = bitcast i1* %src.addr.25 to i8*
  %15 = load i8, i8* %14
  %16 = trunc i8 %15 to i1
  %17 = zext i1 %16 to i52
  %18 = shl i52 %17, 40
  %19 = and i52 %.partset5, -1099511627777
  %.partset4 = or i52 %19, %18
  store i52 %.partset4, i52* %3, align 1
  %src.addr.37 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 3
  %20 = bitcast i1* %src.addr.37 to i8*
  %21 = load i8, i8* %20
  %22 = trunc i8 %21 to i1
  %23 = zext i1 %22 to i52
  %24 = shl i52 %23, 41
  %25 = and i52 %.partset4, -2199023255553
  %.partset3 = or i52 %25, %24
  store i52 %.partset3, i52* %3, align 1
  %src.addr.49 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 4
  %26 = bitcast i1* %src.addr.49 to i8*
  %27 = load i8, i8* %26
  %28 = trunc i8 %27 to i1
  %29 = zext i1 %28 to i52
  %30 = shl i52 %29, 42
  %31 = and i52 %.partset3, -4398046511105
  %.partset2 = or i52 %31, %30
  store i52 %.partset2, i52* %3, align 1
  %src.addr.511 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 5
  %32 = load i8, i8* %src.addr.511, align 1
  %33 = zext i8 %32 to i52
  %34 = shl i52 %33, 43
  %35 = and i52 %.partset2, -2243003720663041
  %.partset1 = or i52 %35, %34
  store i52 %.partset1, i52* %3, align 1
  %src.addr.613 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx16, i32 6
  %36 = bitcast i1* %src.addr.613 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  %39 = zext i1 %38 to i52
  %40 = shl i52 %39, 51
  %41 = and i52 %.partset1, 2251799813685247
  %.partset = or i52 %41, %40
  store i52 %.partset, i52* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx16, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([4 x %struct.HeadCtx]* noalias, [4 x i52]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx.4([4 x %struct.HeadCtx]* %0, [4 x i52]* align 512 %1)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx.4([4 x %struct.HeadCtx]* noalias %dst, [4 x i52]* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq [4 x i52]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.7([4 x %struct.HeadCtx]* nonnull %dst, [4 x i52]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.7([4 x %struct.HeadCtx]* %dst, [4 x i52]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [4 x i52]* %src, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond15 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond15, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx16 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [4 x i52], [4 x i52]* %src, i64 0, i64 %for.loop.idx16
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 0
  %4 = bitcast i52* %3 to i56*
  %5 = load i56, i56* %4
  %6 = trunc i56 %5 to i52
  %.partselect6 = trunc i52 %6 to i32
  store i32 %.partselect6, i32* %dst.addr.02, align 4
  %dst.addr.14 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 1
  %7 = bitcast i52* %3 to i56*
  %8 = load i56, i56* %7
  %9 = trunc i56 %8 to i52
  %10 = lshr i52 %9, 32
  %.partselect5 = trunc i52 %10 to i8
  store i8 %.partselect5, i8* %dst.addr.14, align 1
  %dst.addr.26 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 2
  %11 = bitcast i52* %3 to i56*
  %12 = load i56, i56* %11
  %13 = trunc i56 %12 to i52
  %14 = lshr i52 %13, 40
  %.partselect4 = trunc i52 %14 to i1
  store i1 %.partselect4, i1* %dst.addr.26, align 1
  %dst.addr.38 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 3
  %15 = bitcast i52* %3 to i56*
  %16 = load i56, i56* %15
  %17 = trunc i56 %16 to i52
  %18 = lshr i52 %17, 41
  %.partselect3 = trunc i52 %18 to i1
  store i1 %.partselect3, i1* %dst.addr.38, align 1
  %dst.addr.410 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 4
  %19 = bitcast i52* %3 to i56*
  %20 = load i56, i56* %19
  %21 = trunc i56 %20 to i52
  %22 = lshr i52 %21, 42
  %.partselect2 = trunc i52 %22 to i1
  store i1 %.partselect2, i1* %dst.addr.410, align 1
  %dst.addr.512 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 5
  %23 = bitcast i52* %3 to i56*
  %24 = load i56, i56* %23
  %25 = trunc i56 %24 to i52
  %26 = lshr i52 %25, 43
  %.partselect1 = trunc i52 %26 to i8
  store i8 %.partselect1, i8* %dst.addr.512, align 1
  %dst.addr.614 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx16, i32 6
  %27 = bitcast i52* %3 to i56*
  %28 = load i56, i56* %27
  %29 = trunc i56 %28 to i52
  %30 = lshr i52 %29, 51
  %.partselect = trunc i52 %30 to i1
  store i1 %.partselect, i1* %dst.addr.614, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx16, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_drive_group_head_phase_hw([4 x i52]*, i32, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([4 x %struct.HeadCtx]* noalias, [4 x i52]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx.4([4 x %struct.HeadCtx]* %0, [4 x i52]* align 512 %1)
  ret void
}

declare i1 @drive_group_head_phase_hw_stub([4 x %struct.HeadCtx]* noalias nonnull, i32, i32, i1 zeroext)

define i1 @drive_group_head_phase_hw_stub_wrapper([4 x i52]*, i32, i32, i1) #5 {
entry:
  %4 = call i8* @malloc(i64 48)
  %5 = bitcast i8* %4 to [4 x %struct.HeadCtx]*
  call void @copy_out([4 x %struct.HeadCtx]* %5, [4 x i52]* %0)
  %6 = call i1 @drive_group_head_phase_hw_stub([4 x %struct.HeadCtx]* %5, i32 %1, i32 %2, i1 %3)
  call void @copy_in([4 x %struct.HeadCtx]* %5, [4 x i52]* %0)
  call void @free(i8* %4)
  ret i1 %6
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
