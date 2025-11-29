; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers_Parallel/drive_group_head_phase/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define i1 @apatb_drive_group_head_phase_ir([2 x %struct.HeadCtx]* noalias nonnull dereferenceable(48) "partition" %head_ctx_ref, i32 %base_head_idx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy_0 = alloca i66, align 512
  %head_ctx_ref_copy_1 = alloca i66, align 512
  call void @copy_in([2 x %struct.HeadCtx]* nonnull %head_ctx_ref, i66* nonnull align 512 %head_ctx_ref_copy_0, i66* nonnull align 512 %head_ctx_ref_copy_1)
  %0 = call i1 @apatb_drive_group_head_phase_hw(i66* %head_ctx_ref_copy_0, i66* %head_ctx_ref_copy_1, i32 %base_head_idx, i32 %layer_idx, i1 %start)
  call void @copy_back([2 x %struct.HeadCtx]* %head_ctx_ref, i66* %head_ctx_ref_copy_0, i66* %head_ctx_ref_copy_1)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2struct.HeadCtx([2 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [2 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #1 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %dst.addr.02 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %dst.addr.111 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  %4 = load i8, i8* %src.addr.110, align 1
  store i8 %4, i8* %dst.addr.111, align 1
  %src.addr.212 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %dst.addr.213 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  %5 = bitcast i1* %src.addr.212 to i8*
  %6 = load i8, i8* %5
  %7 = trunc i8 %6 to i1
  store i1 %7, i1* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %dst.addr.315 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  %8 = bitcast i1* %src.addr.314 to i8*
  %9 = load i8, i8* %8
  %10 = trunc i8 %9 to i1
  store i1 %10, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %dst.addr.417 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  %11 = bitcast i1* %src.addr.416 to i8*
  %12 = load i8, i8* %11
  %13 = trunc i8 %12 to i1
  store i1 %13, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %dst.addr.519 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  %14 = load i8, i8* %src.addr.518, align 1
  store i8 %14, i8* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %dst.addr.621 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  %15 = bitcast i1* %src.addr.620 to i8*
  %16 = load i8, i8* %15
  %17 = trunc i8 %16 to i1
  store i1 %17, i1* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %dst.addr.723 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  %18 = bitcast i1* %src.addr.722 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %dst.addr.825 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  %21 = bitcast i1* %src.addr.824 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %dst.addr.927 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  %24 = bitcast i1* %src.addr.926 to i8*
  %25 = load i8, i8* %24
  %26 = trunc i8 %25 to i1
  store i1 %26, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %dst.addr.1029 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  %27 = bitcast i1* %src.addr.1028 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %dst.addr.1131 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  %30 = bitcast i1* %src.addr.1130 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %dst.addr.1233 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  %33 = bitcast i1* %src.addr.1232 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1233, align 1
  %src.addr.1334 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %dst.addr.1335 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  %36 = bitcast i1* %src.addr.1334 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1335, align 1
  %src.addr.1436 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %dst.addr.1437 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  %39 = bitcast i1* %src.addr.1436 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %dst.addr.1539 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  %42 = bitcast i1* %src.addr.1538 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %dst.addr.1641 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  %45 = bitcast i1* %src.addr.1640 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %dst.addr.1743 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  %48 = bitcast i1* %src.addr.1742 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %dst.addr.1845 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  %51 = bitcast i1* %src.addr.1844 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %dst.addr.1947 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  %54 = bitcast i1* %src.addr.1946 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %dst.addr.2049 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
  %57 = bitcast i1* %src.addr.2048 to i8*
  %58 = load i8, i8* %57
  %59 = trunc i8 %58 to i1
  store i1 %59, i1* %dst.addr.2049, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2struct.HeadCtx.3.4(i66* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i66* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, [2 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i66* %dst_0, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %dst.addr.2049.exit, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %dst.addr.2049.exit ]
  %src.addr.01 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx51, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i66* %dst_0 to i72*
  %5 = load i72, i72* %4
  %6 = trunc i72 %5 to i66
  %7 = zext i32 %3 to i66
  %8 = and i66 %6, -4294967296
  %.partset41 = or i66 %8, %7
  store i66 %.partset41, i66* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i66* %dst_1 to i72*
  %10 = load i72, i72* %9
  %11 = trunc i72 %10 to i66
  %12 = zext i32 %3 to i66
  %13 = and i66 %11, -4294967296
  %.partset = or i66 %13, %12
  store i66 %.partset, i66* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %14 = load i8, i8* %src.addr.110, align 1
  switch i64 %for.loop.idx51, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %15 = bitcast i66* %dst_0 to i72*
  %16 = load i72, i72* %15
  %17 = trunc i72 %16 to i66
  %18 = zext i8 %14 to i66
  %19 = shl i66 %18, 32
  %20 = and i66 %17, -1095216660481
  %.partset40 = or i66 %20, %19
  store i66 %.partset40, i66* %dst_0, align 1
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %21 = bitcast i66* %dst_1 to i72*
  %22 = load i72, i72* %21
  %23 = trunc i72 %22 to i66
  %24 = zext i8 %14 to i66
  %25 = shl i66 %24, 32
  %26 = and i66 %23, -1095216660481
  %.partset1 = or i66 %26, %25
  store i66 %.partset1, i66* %dst_1, align 1
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %27 = bitcast i1* %src.addr.212 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  switch i64 %for.loop.idx51, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %30 = bitcast i66* %dst_0 to i72*
  %31 = load i72, i72* %30
  %32 = trunc i72 %31 to i66
  %33 = zext i1 %29 to i66
  %34 = shl i66 %33, 40
  %35 = and i66 %32, -1099511627777
  %.partset39 = or i66 %35, %34
  store i66 %.partset39, i66* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %36 = bitcast i66* %dst_1 to i72*
  %37 = load i72, i72* %36
  %38 = trunc i72 %37 to i66
  %39 = zext i1 %29 to i66
  %40 = shl i66 %39, 40
  %41 = and i66 %38, -1099511627777
  %.partset2 = or i66 %41, %40
  store i66 %.partset2, i66* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %42 = bitcast i1* %src.addr.314 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  switch i64 %for.loop.idx51, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %45 = bitcast i66* %dst_0 to i72*
  %46 = load i72, i72* %45
  %47 = trunc i72 %46 to i66
  %48 = zext i1 %44 to i66
  %49 = shl i66 %48, 41
  %50 = and i66 %47, -2199023255553
  %.partset38 = or i66 %50, %49
  store i66 %.partset38, i66* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %51 = bitcast i66* %dst_1 to i72*
  %52 = load i72, i72* %51
  %53 = trunc i72 %52 to i66
  %54 = zext i1 %44 to i66
  %55 = shl i66 %54, 41
  %56 = and i66 %53, -2199023255553
  %.partset3 = or i66 %56, %55
  store i66 %.partset3, i66* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %57 = bitcast i1* %src.addr.416 to i8*
  %58 = load i8, i8* %57
  %59 = trunc i8 %58 to i1
  switch i64 %for.loop.idx51, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %60 = bitcast i66* %dst_0 to i72*
  %61 = load i72, i72* %60
  %62 = trunc i72 %61 to i66
  %63 = zext i1 %59 to i66
  %64 = shl i66 %63, 42
  %65 = and i66 %62, -4398046511105
  %.partset37 = or i66 %65, %64
  store i66 %.partset37, i66* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %66 = bitcast i66* %dst_1 to i72*
  %67 = load i72, i72* %66
  %68 = trunc i72 %67 to i66
  %69 = zext i1 %59 to i66
  %70 = shl i66 %69, 42
  %71 = and i66 %68, -4398046511105
  %.partset4 = or i66 %71, %70
  store i66 %.partset4, i66* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %72 = load i8, i8* %src.addr.518, align 1
  switch i64 %for.loop.idx51, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %73 = bitcast i66* %dst_0 to i72*
  %74 = load i72, i72* %73
  %75 = trunc i72 %74 to i66
  %76 = zext i8 %72 to i66
  %77 = shl i66 %76, 43
  %78 = and i66 %75, -2243003720663041
  %.partset36 = or i66 %78, %77
  store i66 %.partset36, i66* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %79 = bitcast i66* %dst_1 to i72*
  %80 = load i72, i72* %79
  %81 = trunc i72 %80 to i66
  %82 = zext i8 %72 to i66
  %83 = shl i66 %82, 43
  %84 = and i66 %81, -2243003720663041
  %.partset5 = or i66 %84, %83
  store i66 %.partset5, i66* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %85 = bitcast i1* %src.addr.620 to i8*
  %86 = load i8, i8* %85
  %87 = trunc i8 %86 to i1
  switch i64 %for.loop.idx51, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %88 = bitcast i66* %dst_0 to i72*
  %89 = load i72, i72* %88
  %90 = trunc i72 %89 to i66
  %91 = zext i1 %87 to i66
  %92 = shl i66 %91, 51
  %93 = and i66 %90, -2251799813685249
  %.partset35 = or i66 %93, %92
  store i66 %.partset35, i66* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %94 = bitcast i66* %dst_1 to i72*
  %95 = load i72, i72* %94
  %96 = trunc i72 %95 to i66
  %97 = zext i1 %87 to i66
  %98 = shl i66 %97, 51
  %99 = and i66 %96, -2251799813685249
  %.partset6 = or i66 %99, %98
  store i66 %.partset6, i66* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %100 = bitcast i1* %src.addr.722 to i8*
  %101 = load i8, i8* %100
  %102 = trunc i8 %101 to i1
  switch i64 %for.loop.idx51, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %103 = bitcast i66* %dst_0 to i72*
  %104 = load i72, i72* %103
  %105 = trunc i72 %104 to i66
  %106 = zext i1 %102 to i66
  %107 = shl i66 %106, 52
  %108 = and i66 %105, -4503599627370497
  %.partset34 = or i66 %108, %107
  store i66 %.partset34, i66* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %109 = bitcast i66* %dst_1 to i72*
  %110 = load i72, i72* %109
  %111 = trunc i72 %110 to i66
  %112 = zext i1 %102 to i66
  %113 = shl i66 %112, 52
  %114 = and i66 %111, -4503599627370497
  %.partset7 = or i66 %114, %113
  store i66 %.partset7, i66* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %115 = bitcast i1* %src.addr.824 to i8*
  %116 = load i8, i8* %115
  %117 = trunc i8 %116 to i1
  switch i64 %for.loop.idx51, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %118 = bitcast i66* %dst_0 to i72*
  %119 = load i72, i72* %118
  %120 = trunc i72 %119 to i66
  %121 = zext i1 %117 to i66
  %122 = shl i66 %121, 53
  %123 = and i66 %120, -9007199254740993
  %.partset33 = or i66 %123, %122
  store i66 %.partset33, i66* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %124 = bitcast i66* %dst_1 to i72*
  %125 = load i72, i72* %124
  %126 = trunc i72 %125 to i66
  %127 = zext i1 %117 to i66
  %128 = shl i66 %127, 53
  %129 = and i66 %126, -9007199254740993
  %.partset8 = or i66 %129, %128
  store i66 %.partset8, i66* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %130 = bitcast i1* %src.addr.926 to i8*
  %131 = load i8, i8* %130
  %132 = trunc i8 %131 to i1
  switch i64 %for.loop.idx51, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %133 = bitcast i66* %dst_0 to i72*
  %134 = load i72, i72* %133
  %135 = trunc i72 %134 to i66
  %136 = zext i1 %132 to i66
  %137 = shl i66 %136, 54
  %138 = and i66 %135, -18014398509481985
  %.partset32 = or i66 %138, %137
  store i66 %.partset32, i66* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %139 = bitcast i66* %dst_1 to i72*
  %140 = load i72, i72* %139
  %141 = trunc i72 %140 to i66
  %142 = zext i1 %132 to i66
  %143 = shl i66 %142, 54
  %144 = and i66 %141, -18014398509481985
  %.partset9 = or i66 %144, %143
  store i66 %.partset9, i66* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %145 = bitcast i1* %src.addr.1028 to i8*
  %146 = load i8, i8* %145
  %147 = trunc i8 %146 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %148 = bitcast i66* %dst_0 to i72*
  %149 = load i72, i72* %148
  %150 = trunc i72 %149 to i66
  %151 = zext i1 %147 to i66
  %152 = shl i66 %151, 55
  %153 = and i66 %150, -36028797018963969
  %.partset31 = or i66 %153, %152
  store i66 %.partset31, i66* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %154 = bitcast i66* %dst_1 to i72*
  %155 = load i72, i72* %154
  %156 = trunc i72 %155 to i66
  %157 = zext i1 %147 to i66
  %158 = shl i66 %157, 55
  %159 = and i66 %156, -36028797018963969
  %.partset10 = or i66 %159, %158
  store i66 %.partset10, i66* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %160 = bitcast i1* %src.addr.1130 to i8*
  %161 = load i8, i8* %160
  %162 = trunc i8 %161 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %163 = bitcast i66* %dst_0 to i72*
  %164 = load i72, i72* %163
  %165 = trunc i72 %164 to i66
  %166 = zext i1 %162 to i66
  %167 = shl i66 %166, 56
  %168 = and i66 %165, -72057594037927937
  %.partset30 = or i66 %168, %167
  store i66 %.partset30, i66* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %169 = bitcast i66* %dst_1 to i72*
  %170 = load i72, i72* %169
  %171 = trunc i72 %170 to i66
  %172 = zext i1 %162 to i66
  %173 = shl i66 %172, 56
  %174 = and i66 %171, -72057594037927937
  %.partset11 = or i66 %174, %173
  store i66 %.partset11, i66* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %175 = bitcast i1* %src.addr.1232 to i8*
  %176 = load i8, i8* %175
  %177 = trunc i8 %176 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %178 = bitcast i66* %dst_0 to i72*
  %179 = load i72, i72* %178
  %180 = trunc i72 %179 to i66
  %181 = zext i1 %177 to i66
  %182 = shl i66 %181, 57
  %183 = and i66 %180, -144115188075855873
  %.partset29 = or i66 %183, %182
  store i66 %.partset29, i66* %dst_0, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %184 = bitcast i66* %dst_1 to i72*
  %185 = load i72, i72* %184
  %186 = trunc i72 %185 to i66
  %187 = zext i1 %177 to i66
  %188 = shl i66 %187, 57
  %189 = and i66 %186, -144115188075855873
  %.partset12 = or i66 %189, %188
  store i66 %.partset12, i66* %dst_1, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %190 = bitcast i1* %src.addr.1334 to i8*
  %191 = load i8, i8* %190
  %192 = trunc i8 %191 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %193 = bitcast i66* %dst_0 to i72*
  %194 = load i72, i72* %193
  %195 = trunc i72 %194 to i66
  %196 = zext i1 %192 to i66
  %197 = shl i66 %196, 58
  %198 = and i66 %195, -288230376151711745
  %.partset28 = or i66 %198, %197
  store i66 %.partset28, i66* %dst_0, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %199 = bitcast i66* %dst_1 to i72*
  %200 = load i72, i72* %199
  %201 = trunc i72 %200 to i66
  %202 = zext i1 %192 to i66
  %203 = shl i66 %202, 58
  %204 = and i66 %201, -288230376151711745
  %.partset13 = or i66 %204, %203
  store i66 %.partset13, i66* %dst_1, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %205 = bitcast i1* %src.addr.1436 to i8*
  %206 = load i8, i8* %205
  %207 = trunc i8 %206 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %208 = bitcast i66* %dst_0 to i72*
  %209 = load i72, i72* %208
  %210 = trunc i72 %209 to i66
  %211 = zext i1 %207 to i66
  %212 = shl i66 %211, 59
  %213 = and i66 %210, -576460752303423489
  %.partset27 = or i66 %213, %212
  store i66 %.partset27, i66* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %214 = bitcast i66* %dst_1 to i72*
  %215 = load i72, i72* %214
  %216 = trunc i72 %215 to i66
  %217 = zext i1 %207 to i66
  %218 = shl i66 %217, 59
  %219 = and i66 %216, -576460752303423489
  %.partset14 = or i66 %219, %218
  store i66 %.partset14, i66* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %220 = bitcast i1* %src.addr.1538 to i8*
  %221 = load i8, i8* %220
  %222 = trunc i8 %221 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %223 = bitcast i66* %dst_0 to i72*
  %224 = load i72, i72* %223
  %225 = trunc i72 %224 to i66
  %226 = zext i1 %222 to i66
  %227 = shl i66 %226, 60
  %228 = and i66 %225, -1152921504606846977
  %.partset26 = or i66 %228, %227
  store i66 %.partset26, i66* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %229 = bitcast i66* %dst_1 to i72*
  %230 = load i72, i72* %229
  %231 = trunc i72 %230 to i66
  %232 = zext i1 %222 to i66
  %233 = shl i66 %232, 60
  %234 = and i66 %231, -1152921504606846977
  %.partset15 = or i66 %234, %233
  store i66 %.partset15, i66* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %235 = bitcast i1* %src.addr.1640 to i8*
  %236 = load i8, i8* %235
  %237 = trunc i8 %236 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %238 = bitcast i66* %dst_0 to i72*
  %239 = load i72, i72* %238
  %240 = trunc i72 %239 to i66
  %241 = zext i1 %237 to i66
  %242 = shl i66 %241, 61
  %243 = and i66 %240, -2305843009213693953
  %.partset25 = or i66 %243, %242
  store i66 %.partset25, i66* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %244 = bitcast i66* %dst_1 to i72*
  %245 = load i72, i72* %244
  %246 = trunc i72 %245 to i66
  %247 = zext i1 %237 to i66
  %248 = shl i66 %247, 61
  %249 = and i66 %246, -2305843009213693953
  %.partset16 = or i66 %249, %248
  store i66 %.partset16, i66* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %250 = bitcast i1* %src.addr.1742 to i8*
  %251 = load i8, i8* %250
  %252 = trunc i8 %251 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %253 = bitcast i66* %dst_0 to i72*
  %254 = load i72, i72* %253
  %255 = trunc i72 %254 to i66
  %256 = zext i1 %252 to i66
  %257 = shl i66 %256, 62
  %258 = and i66 %255, -4611686018427387905
  %.partset24 = or i66 %258, %257
  store i66 %.partset24, i66* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %259 = bitcast i66* %dst_1 to i72*
  %260 = load i72, i72* %259
  %261 = trunc i72 %260 to i66
  %262 = zext i1 %252 to i66
  %263 = shl i66 %262, 62
  %264 = and i66 %261, -4611686018427387905
  %.partset17 = or i66 %264, %263
  store i66 %.partset17, i66* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %265 = bitcast i1* %src.addr.1844 to i8*
  %266 = load i8, i8* %265
  %267 = trunc i8 %266 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %268 = bitcast i66* %dst_0 to i72*
  %269 = load i72, i72* %268
  %270 = trunc i72 %269 to i66
  %271 = zext i1 %267 to i66
  %272 = shl i66 %271, 63
  %273 = and i66 %270, -9223372036854775809
  %.partset23 = or i66 %273, %272
  store i66 %.partset23, i66* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %274 = bitcast i66* %dst_1 to i72*
  %275 = load i72, i72* %274
  %276 = trunc i72 %275 to i66
  %277 = zext i1 %267 to i66
  %278 = shl i66 %277, 63
  %279 = and i66 %276, -9223372036854775809
  %.partset18 = or i66 %279, %278
  store i66 %.partset18, i66* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %280 = bitcast i1* %src.addr.1946 to i8*
  %281 = load i8, i8* %280
  %282 = trunc i8 %281 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %283 = bitcast i66* %dst_0 to i72*
  %284 = load i72, i72* %283
  %285 = trunc i72 %284 to i66
  %286 = zext i1 %282 to i66
  %287 = shl i66 %286, 64
  %288 = and i66 %285, -18446744073709551617
  %.partset22 = or i66 %288, %287
  store i66 %.partset22, i66* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %289 = bitcast i66* %dst_1 to i72*
  %290 = load i72, i72* %289
  %291 = trunc i72 %290 to i66
  %292 = zext i1 %282 to i66
  %293 = shl i66 %292, 64
  %294 = and i66 %291, -18446744073709551617
  %.partset19 = or i66 %294, %293
  store i66 %.partset19, i66* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %295 = bitcast i1* %src.addr.2048 to i8*
  %296 = load i8, i8* %295
  %297 = trunc i8 %296 to i1
  switch i64 %for.loop.idx51, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %298 = bitcast i66* %dst_0 to i72*
  %299 = load i72, i72* %298
  %300 = trunc i72 %299 to i66
  %301 = zext i1 %297 to i66
  %302 = shl i66 %301, 65
  %303 = and i66 %300, 36893488147419103231
  %.partset21 = or i66 %303, %302
  store i66 %.partset21, i66* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %304 = bitcast i66* %dst_1 to i72*
  %305 = load i72, i72* %304
  %306 = trunc i72 %305 to i66
  %307 = zext i1 %297 to i66
  %308 = shl i66 %307, 65
  %309 = and i66 %306, 36893488147419103231
  %.partset20 = or i66 %309, %308
  store i66 %.partset20, i66* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.2049.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a2struct.HeadCtx.2.5(i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, [2 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #2 {
entry:
  %0 = icmp eq i66* %dst_0, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2struct.HeadCtx.3.4(i66* nonnull %dst_0, i66* %dst_1, [2 x %struct.HeadCtx]* nonnull %src, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in([2 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="0", i66* noalias align 512 "orig.arg.no"="1" "unpacked"="1.0" %_0, i66* noalias align 512 "orig.arg.no"="1" "unpacked"="1.1" %_1) #3 {
entry:
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.2.5(i66* align 512 %_0, i66* align 512 %_1, [2 x %struct.HeadCtx]* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a2struct.HeadCtx.11.12([2 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i66* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i66* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq i66* %src_0, null
  %1 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.2048.exit, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.2048.exit ]
  %dst.addr.02 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  switch i64 %for.loop.idx51, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
  ]

src.addr.01.case.0:                               ; preds = %for.loop
  %3 = bitcast i66* %src_0 to i72*
  %4 = load i72, i72* %3
  %5 = trunc i72 %4 to i66
  %_0.partselect = trunc i66 %5 to i32
  br label %src.addr.01.exit

src.addr.01.case.1:                               ; preds = %for.loop
  %6 = bitcast i66* %src_1 to i72*
  %7 = load i72, i72* %6
  %8 = trunc i72 %7 to i66
  %_1.partselect = trunc i66 %8 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %9 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ undef, %for.loop ]
  store i32 %9, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  switch i64 %for.loop.idx51, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %10 = bitcast i66* %src_0 to i72*
  %11 = load i72, i72* %10
  %12 = trunc i72 %11 to i66
  %13 = lshr i66 %12, 32
  %_01.partselect = trunc i66 %13 to i8
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %14 = bitcast i66* %src_1 to i72*
  %15 = load i72, i72* %14
  %16 = trunc i72 %15 to i66
  %17 = lshr i66 %16, 32
  %_12.partselect = trunc i66 %17 to i8
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %18 = phi i8 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ undef, %src.addr.01.exit ]
  store i8 %18, i8* %dst.addr.111, align 1
  %dst.addr.213 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  switch i64 %for.loop.idx51, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %19 = bitcast i66* %src_0 to i72*
  %20 = load i72, i72* %19
  %21 = trunc i72 %20 to i66
  %22 = lshr i66 %21, 40
  %_03.partselect = trunc i66 %22 to i1
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %23 = bitcast i66* %src_1 to i72*
  %24 = load i72, i72* %23
  %25 = trunc i72 %24 to i66
  %26 = lshr i66 %25, 40
  %_14.partselect = trunc i66 %26 to i1
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %27 = phi i1 [ %_03.partselect, %src.addr.212.case.0 ], [ %_14.partselect, %src.addr.212.case.1 ], [ undef, %src.addr.110.exit ]
  store i1 %27, i1* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  switch i64 %for.loop.idx51, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %28 = bitcast i66* %src_0 to i72*
  %29 = load i72, i72* %28
  %30 = trunc i72 %29 to i66
  %31 = lshr i66 %30, 41
  %_05.partselect = trunc i66 %31 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %32 = bitcast i66* %src_1 to i72*
  %33 = load i72, i72* %32
  %34 = trunc i72 %33 to i66
  %35 = lshr i66 %34, 41
  %_16.partselect = trunc i66 %35 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %36 = phi i1 [ %_05.partselect, %src.addr.314.case.0 ], [ %_16.partselect, %src.addr.314.case.1 ], [ undef, %src.addr.212.exit ]
  store i1 %36, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  switch i64 %for.loop.idx51, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %37 = bitcast i66* %src_0 to i72*
  %38 = load i72, i72* %37
  %39 = trunc i72 %38 to i66
  %40 = lshr i66 %39, 42
  %_07.partselect = trunc i66 %40 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %41 = bitcast i66* %src_1 to i72*
  %42 = load i72, i72* %41
  %43 = trunc i72 %42 to i66
  %44 = lshr i66 %43, 42
  %_18.partselect = trunc i66 %44 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %45 = phi i1 [ %_07.partselect, %src.addr.416.case.0 ], [ %_18.partselect, %src.addr.416.case.1 ], [ undef, %src.addr.314.exit ]
  store i1 %45, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  switch i64 %for.loop.idx51, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %46 = bitcast i66* %src_0 to i72*
  %47 = load i72, i72* %46
  %48 = trunc i72 %47 to i66
  %49 = lshr i66 %48, 43
  %_09.partselect = trunc i66 %49 to i8
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %50 = bitcast i66* %src_1 to i72*
  %51 = load i72, i72* %50
  %52 = trunc i72 %51 to i66
  %53 = lshr i66 %52, 43
  %_110.partselect = trunc i66 %53 to i8
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %54 = phi i8 [ %_09.partselect, %src.addr.518.case.0 ], [ %_110.partselect, %src.addr.518.case.1 ], [ undef, %src.addr.416.exit ]
  store i8 %54, i8* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  switch i64 %for.loop.idx51, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %55 = bitcast i66* %src_0 to i72*
  %56 = load i72, i72* %55
  %57 = trunc i72 %56 to i66
  %58 = lshr i66 %57, 51
  %_011.partselect = trunc i66 %58 to i1
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %59 = bitcast i66* %src_1 to i72*
  %60 = load i72, i72* %59
  %61 = trunc i72 %60 to i66
  %62 = lshr i66 %61, 51
  %_112.partselect = trunc i66 %62 to i1
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %63 = phi i1 [ %_011.partselect, %src.addr.620.case.0 ], [ %_112.partselect, %src.addr.620.case.1 ], [ undef, %src.addr.518.exit ]
  store i1 %63, i1* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  switch i64 %for.loop.idx51, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %64 = bitcast i66* %src_0 to i72*
  %65 = load i72, i72* %64
  %66 = trunc i72 %65 to i66
  %67 = lshr i66 %66, 52
  %_013.partselect = trunc i66 %67 to i1
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %68 = bitcast i66* %src_1 to i72*
  %69 = load i72, i72* %68
  %70 = trunc i72 %69 to i66
  %71 = lshr i66 %70, 52
  %_114.partselect = trunc i66 %71 to i1
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %72 = phi i1 [ %_013.partselect, %src.addr.722.case.0 ], [ %_114.partselect, %src.addr.722.case.1 ], [ undef, %src.addr.620.exit ]
  store i1 %72, i1* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  switch i64 %for.loop.idx51, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %73 = bitcast i66* %src_0 to i72*
  %74 = load i72, i72* %73
  %75 = trunc i72 %74 to i66
  %76 = lshr i66 %75, 53
  %_015.partselect = trunc i66 %76 to i1
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %77 = bitcast i66* %src_1 to i72*
  %78 = load i72, i72* %77
  %79 = trunc i72 %78 to i66
  %80 = lshr i66 %79, 53
  %_116.partselect = trunc i66 %80 to i1
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %81 = phi i1 [ %_015.partselect, %src.addr.824.case.0 ], [ %_116.partselect, %src.addr.824.case.1 ], [ undef, %src.addr.722.exit ]
  store i1 %81, i1* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  switch i64 %for.loop.idx51, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %82 = bitcast i66* %src_0 to i72*
  %83 = load i72, i72* %82
  %84 = trunc i72 %83 to i66
  %85 = lshr i66 %84, 54
  %_017.partselect = trunc i66 %85 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %86 = bitcast i66* %src_1 to i72*
  %87 = load i72, i72* %86
  %88 = trunc i72 %87 to i66
  %89 = lshr i66 %88, 54
  %_118.partselect = trunc i66 %89 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %90 = phi i1 [ %_017.partselect, %src.addr.926.case.0 ], [ %_118.partselect, %src.addr.926.case.1 ], [ undef, %src.addr.824.exit ]
  store i1 %90, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  switch i64 %for.loop.idx51, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %91 = bitcast i66* %src_0 to i72*
  %92 = load i72, i72* %91
  %93 = trunc i72 %92 to i66
  %94 = lshr i66 %93, 55
  %_019.partselect = trunc i66 %94 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %95 = bitcast i66* %src_1 to i72*
  %96 = load i72, i72* %95
  %97 = trunc i72 %96 to i66
  %98 = lshr i66 %97, 55
  %_120.partselect = trunc i66 %98 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %99 = phi i1 [ %_019.partselect, %src.addr.1028.case.0 ], [ %_120.partselect, %src.addr.1028.case.1 ], [ undef, %src.addr.926.exit ]
  store i1 %99, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  switch i64 %for.loop.idx51, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %100 = bitcast i66* %src_0 to i72*
  %101 = load i72, i72* %100
  %102 = trunc i72 %101 to i66
  %103 = lshr i66 %102, 56
  %_021.partselect = trunc i66 %103 to i1
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %104 = bitcast i66* %src_1 to i72*
  %105 = load i72, i72* %104
  %106 = trunc i72 %105 to i66
  %107 = lshr i66 %106, 56
  %_122.partselect = trunc i66 %107 to i1
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %108 = phi i1 [ %_021.partselect, %src.addr.1130.case.0 ], [ %_122.partselect, %src.addr.1130.case.1 ], [ undef, %src.addr.1028.exit ]
  store i1 %108, i1* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  switch i64 %for.loop.idx51, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %109 = bitcast i66* %src_0 to i72*
  %110 = load i72, i72* %109
  %111 = trunc i72 %110 to i66
  %112 = lshr i66 %111, 57
  %_023.partselect = trunc i66 %112 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %113 = bitcast i66* %src_1 to i72*
  %114 = load i72, i72* %113
  %115 = trunc i72 %114 to i66
  %116 = lshr i66 %115, 57
  %_124.partselect = trunc i66 %116 to i1
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %117 = phi i1 [ %_023.partselect, %src.addr.1232.case.0 ], [ %_124.partselect, %src.addr.1232.case.1 ], [ undef, %src.addr.1130.exit ]
  store i1 %117, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  switch i64 %for.loop.idx51, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %118 = bitcast i66* %src_0 to i72*
  %119 = load i72, i72* %118
  %120 = trunc i72 %119 to i66
  %121 = lshr i66 %120, 58
  %_025.partselect = trunc i66 %121 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %122 = bitcast i66* %src_1 to i72*
  %123 = load i72, i72* %122
  %124 = trunc i72 %123 to i66
  %125 = lshr i66 %124, 58
  %_126.partselect = trunc i66 %125 to i1
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %126 = phi i1 [ %_025.partselect, %src.addr.1334.case.0 ], [ %_126.partselect, %src.addr.1334.case.1 ], [ undef, %src.addr.1232.exit ]
  store i1 %126, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  switch i64 %for.loop.idx51, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %127 = bitcast i66* %src_0 to i72*
  %128 = load i72, i72* %127
  %129 = trunc i72 %128 to i66
  %130 = lshr i66 %129, 59
  %_027.partselect = trunc i66 %130 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %131 = bitcast i66* %src_1 to i72*
  %132 = load i72, i72* %131
  %133 = trunc i72 %132 to i66
  %134 = lshr i66 %133, 59
  %_128.partselect = trunc i66 %134 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %135 = phi i1 [ %_027.partselect, %src.addr.1436.case.0 ], [ %_128.partselect, %src.addr.1436.case.1 ], [ undef, %src.addr.1334.exit ]
  store i1 %135, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  switch i64 %for.loop.idx51, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %136 = bitcast i66* %src_0 to i72*
  %137 = load i72, i72* %136
  %138 = trunc i72 %137 to i66
  %139 = lshr i66 %138, 60
  %_029.partselect = trunc i66 %139 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %140 = bitcast i66* %src_1 to i72*
  %141 = load i72, i72* %140
  %142 = trunc i72 %141 to i66
  %143 = lshr i66 %142, 60
  %_130.partselect = trunc i66 %143 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %144 = phi i1 [ %_029.partselect, %src.addr.1538.case.0 ], [ %_130.partselect, %src.addr.1538.case.1 ], [ undef, %src.addr.1436.exit ]
  store i1 %144, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  switch i64 %for.loop.idx51, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %145 = bitcast i66* %src_0 to i72*
  %146 = load i72, i72* %145
  %147 = trunc i72 %146 to i66
  %148 = lshr i66 %147, 61
  %_031.partselect = trunc i66 %148 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %149 = bitcast i66* %src_1 to i72*
  %150 = load i72, i72* %149
  %151 = trunc i72 %150 to i66
  %152 = lshr i66 %151, 61
  %_132.partselect = trunc i66 %152 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %153 = phi i1 [ %_031.partselect, %src.addr.1640.case.0 ], [ %_132.partselect, %src.addr.1640.case.1 ], [ undef, %src.addr.1538.exit ]
  store i1 %153, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  switch i64 %for.loop.idx51, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %154 = bitcast i66* %src_0 to i72*
  %155 = load i72, i72* %154
  %156 = trunc i72 %155 to i66
  %157 = lshr i66 %156, 62
  %_033.partselect = trunc i66 %157 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %158 = bitcast i66* %src_1 to i72*
  %159 = load i72, i72* %158
  %160 = trunc i72 %159 to i66
  %161 = lshr i66 %160, 62
  %_134.partselect = trunc i66 %161 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %162 = phi i1 [ %_033.partselect, %src.addr.1742.case.0 ], [ %_134.partselect, %src.addr.1742.case.1 ], [ undef, %src.addr.1640.exit ]
  store i1 %162, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  switch i64 %for.loop.idx51, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %163 = bitcast i66* %src_0 to i72*
  %164 = load i72, i72* %163
  %165 = trunc i72 %164 to i66
  %166 = lshr i66 %165, 63
  %_035.partselect = trunc i66 %166 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %167 = bitcast i66* %src_1 to i72*
  %168 = load i72, i72* %167
  %169 = trunc i72 %168 to i66
  %170 = lshr i66 %169, 63
  %_136.partselect = trunc i66 %170 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %171 = phi i1 [ %_035.partselect, %src.addr.1844.case.0 ], [ %_136.partselect, %src.addr.1844.case.1 ], [ undef, %src.addr.1742.exit ]
  store i1 %171, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  switch i64 %for.loop.idx51, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %172 = bitcast i66* %src_0 to i72*
  %173 = load i72, i72* %172
  %174 = trunc i72 %173 to i66
  %175 = lshr i66 %174, 64
  %_037.partselect = trunc i66 %175 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %176 = bitcast i66* %src_1 to i72*
  %177 = load i72, i72* %176
  %178 = trunc i72 %177 to i66
  %179 = lshr i66 %178, 64
  %_138.partselect = trunc i66 %179 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %180 = phi i1 [ %_037.partselect, %src.addr.1946.case.0 ], [ %_138.partselect, %src.addr.1946.case.1 ], [ undef, %src.addr.1844.exit ]
  store i1 %180, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [2 x %struct.HeadCtx], [2 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
  switch i64 %for.loop.idx51, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %181 = bitcast i66* %src_0 to i72*
  %182 = load i72, i72* %181
  %183 = trunc i72 %182 to i66
  %184 = lshr i66 %183, 65
  %_039.partselect = trunc i66 %184 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %185 = bitcast i66* %src_1 to i72*
  %186 = load i72, i72* %185
  %187 = trunc i72 %186 to i66
  %188 = lshr i66 %187, 65
  %_140.partselect = trunc i66 %188 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %189 = phi i1 [ %_039.partselect, %src.addr.2048.case.0 ], [ %_140.partselect, %src.addr.2048.case.1 ], [ undef, %src.addr.1946.exit ]
  store i1 %189, i1* %dst.addr.2049, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.2048.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a2struct.HeadCtx.10.13([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1) #2 {
entry:
  %0 = icmp eq [2 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i66* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a2struct.HeadCtx.11.12([2 x %struct.HeadCtx]* nonnull %dst, i66* nonnull %src_0, i66* %src_1, i64 2)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %_0, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %_1) #4 {
entry:
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.10.13([2 x %struct.HeadCtx]* %0, i66* align 512 %_0, i66* align 512 %_1)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_drive_group_head_phase_hw(i66*, i66*, i32, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back([2 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %_0, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %_1) #4 {
entry:
  call void @onebyonecpy_hls.p0a2struct.HeadCtx.10.13([2 x %struct.HeadCtx]* %0, i66* align 512 %_0, i66* align 512 %_1)
  ret void
}

declare i1 @drive_group_head_phase_hw_stub([2 x %struct.HeadCtx]* noalias nonnull, i32, i32, i1 zeroext)

define i1 @drive_group_head_phase_hw_stub_wrapper(i66*, i66*, i32, i32, i1) #5 {
entry:
  %5 = call i8* @malloc(i64 48)
  %6 = bitcast i8* %5 to [2 x %struct.HeadCtx]*
  call void @copy_out([2 x %struct.HeadCtx]* %6, i66* %0, i66* %1)
  %7 = call i1 @drive_group_head_phase_hw_stub([2 x %struct.HeadCtx]* %6, i32 %2, i32 %3, i1 %4)
  call void @copy_in([2 x %struct.HeadCtx]* %6, i66* %0, i66* %1)
  call void @free(i8* %5)
  ret i1 %7
}

attributes #0 = { inaccessiblemem_or_argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}
!datalayout.transforms.on.top = !{!5}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = !{!6, !8, !10}
!6 = !{!7}
!7 = !{!"0", [2 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12}
!11 = !{!"0.0", %struct.HeadCtx* null}
!12 = !{!"0.1", %struct.HeadCtx* null}
