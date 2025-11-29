; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers_Parallel/drive_group_head_phase/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: inaccessiblemem_or_argmemonly noinline willreturn
define i1 @apatb_drive_group_head_phase_ir([1 x %struct.HeadCtx]* noalias nonnull dereferenceable(24) "partition" %head_ctx_ref, i32 %base_head_idx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy1 = alloca i66, align 512
  call void @copy_in([1 x %struct.HeadCtx]* nonnull %head_ctx_ref, i66* nonnull align 512 %head_ctx_ref_copy1)
  %0 = call i1 @apatb_drive_group_head_phase_hw(i66* %head_ctx_ref_copy1, i32 %base_head_idx, i32 %layer_idx, i1 %start)
  call void @copy_back([1 x %struct.HeadCtx]* %head_ctx_ref, i66* %head_ctx_ref_copy1)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1struct.HeadCtx([1 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [1 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #1 {
entry:
  %0 = icmp eq [1 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [1 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %dst.addr.02 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %dst.addr.111 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  %4 = load i8, i8* %src.addr.110, align 1
  store i8 %4, i8* %dst.addr.111, align 1
  %src.addr.212 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %dst.addr.213 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  %5 = bitcast i1* %src.addr.212 to i8*
  %6 = load i8, i8* %5
  %7 = trunc i8 %6 to i1
  store i1 %7, i1* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %dst.addr.315 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  %8 = bitcast i1* %src.addr.314 to i8*
  %9 = load i8, i8* %8
  %10 = trunc i8 %9 to i1
  store i1 %10, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %dst.addr.417 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  %11 = bitcast i1* %src.addr.416 to i8*
  %12 = load i8, i8* %11
  %13 = trunc i8 %12 to i1
  store i1 %13, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %dst.addr.519 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  %14 = load i8, i8* %src.addr.518, align 1
  store i8 %14, i8* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %dst.addr.621 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  %15 = bitcast i1* %src.addr.620 to i8*
  %16 = load i8, i8* %15
  %17 = trunc i8 %16 to i1
  store i1 %17, i1* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %dst.addr.723 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  %18 = bitcast i1* %src.addr.722 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %dst.addr.825 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  %21 = bitcast i1* %src.addr.824 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %dst.addr.927 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  %24 = bitcast i1* %src.addr.926 to i8*
  %25 = load i8, i8* %24
  %26 = trunc i8 %25 to i1
  store i1 %26, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %dst.addr.1029 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  %27 = bitcast i1* %src.addr.1028 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %dst.addr.1131 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  %30 = bitcast i1* %src.addr.1130 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %dst.addr.1233 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  %33 = bitcast i1* %src.addr.1232 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1233, align 1
  %src.addr.1334 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %dst.addr.1335 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  %36 = bitcast i1* %src.addr.1334 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1335, align 1
  %src.addr.1436 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %dst.addr.1437 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  %39 = bitcast i1* %src.addr.1436 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %dst.addr.1539 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  %42 = bitcast i1* %src.addr.1538 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %dst.addr.1641 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  %45 = bitcast i1* %src.addr.1640 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %dst.addr.1743 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  %48 = bitcast i1* %src.addr.1742 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %dst.addr.1845 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  %51 = bitcast i1* %src.addr.1844 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %dst.addr.1947 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  %54 = bitcast i1* %src.addr.1946 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %dst.addr.2049 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
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
define void @arraycpy_hls.p0a1struct.HeadCtx.3.4(i66* "orig.arg.no"="0" "unpacked"="0" %dst, [1 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq [1 x %struct.HeadCtx]* %src, null
  %1 = icmp eq i66* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  %4 = bitcast i66* %dst to i72*
  %5 = load i72, i72* %4
  %6 = trunc i72 %5 to i66
  %7 = zext i32 %3 to i66
  %8 = and i66 %6, -4294967296
  %.partset = or i66 %8, %7
  store i66 %.partset, i66* %dst, align 4
  %src.addr.110 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %9 = load i8, i8* %src.addr.110, align 1
  %10 = zext i8 %9 to i66
  %11 = shl i66 %10, 32
  %12 = and i66 %.partset, -1095216660481
  %.partset1 = or i66 %12, %11
  store i66 %.partset1, i66* %dst, align 1
  %src.addr.212 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %13 = bitcast i1* %src.addr.212 to i8*
  %14 = load i8, i8* %13
  %15 = trunc i8 %14 to i1
  %16 = zext i1 %15 to i66
  %17 = shl i66 %16, 40
  %18 = and i66 %.partset1, -1099511627777
  %.partset2 = or i66 %18, %17
  store i66 %.partset2, i66* %dst, align 1
  %src.addr.314 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %19 = bitcast i1* %src.addr.314 to i8*
  %20 = load i8, i8* %19
  %21 = trunc i8 %20 to i1
  %22 = zext i1 %21 to i66
  %23 = shl i66 %22, 41
  %24 = and i66 %.partset2, -2199023255553
  %.partset3 = or i66 %24, %23
  store i66 %.partset3, i66* %dst, align 1
  %src.addr.416 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %25 = bitcast i1* %src.addr.416 to i8*
  %26 = load i8, i8* %25
  %27 = trunc i8 %26 to i1
  %28 = zext i1 %27 to i66
  %29 = shl i66 %28, 42
  %30 = and i66 %.partset3, -4398046511105
  %.partset4 = or i66 %30, %29
  store i66 %.partset4, i66* %dst, align 1
  %src.addr.518 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %31 = load i8, i8* %src.addr.518, align 1
  %32 = zext i8 %31 to i66
  %33 = shl i66 %32, 43
  %34 = and i66 %.partset4, -2243003720663041
  %.partset5 = or i66 %34, %33
  store i66 %.partset5, i66* %dst, align 1
  %src.addr.620 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %35 = bitcast i1* %src.addr.620 to i8*
  %36 = load i8, i8* %35
  %37 = trunc i8 %36 to i1
  %38 = zext i1 %37 to i66
  %39 = shl i66 %38, 51
  %40 = and i66 %.partset5, -2251799813685249
  %.partset6 = or i66 %40, %39
  store i66 %.partset6, i66* %dst, align 1
  %src.addr.722 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %41 = bitcast i1* %src.addr.722 to i8*
  %42 = load i8, i8* %41
  %43 = trunc i8 %42 to i1
  %44 = zext i1 %43 to i66
  %45 = shl i66 %44, 52
  %46 = and i66 %.partset6, -4503599627370497
  %.partset7 = or i66 %46, %45
  store i66 %.partset7, i66* %dst, align 1
  %src.addr.824 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %47 = bitcast i1* %src.addr.824 to i8*
  %48 = load i8, i8* %47
  %49 = trunc i8 %48 to i1
  %50 = zext i1 %49 to i66
  %51 = shl i66 %50, 53
  %52 = and i66 %.partset7, -9007199254740993
  %.partset8 = or i66 %52, %51
  store i66 %.partset8, i66* %dst, align 1
  %src.addr.926 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %53 = bitcast i1* %src.addr.926 to i8*
  %54 = load i8, i8* %53
  %55 = trunc i8 %54 to i1
  %56 = zext i1 %55 to i66
  %57 = shl i66 %56, 54
  %58 = and i66 %.partset8, -18014398509481985
  %.partset9 = or i66 %58, %57
  store i66 %.partset9, i66* %dst, align 1
  %src.addr.1028 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %59 = bitcast i1* %src.addr.1028 to i8*
  %60 = load i8, i8* %59
  %61 = trunc i8 %60 to i1
  %62 = zext i1 %61 to i66
  %63 = shl i66 %62, 55
  %64 = and i66 %.partset9, -36028797018963969
  %.partset10 = or i66 %64, %63
  store i66 %.partset10, i66* %dst, align 1
  %src.addr.1130 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %65 = bitcast i1* %src.addr.1130 to i8*
  %66 = load i8, i8* %65
  %67 = trunc i8 %66 to i1
  %68 = zext i1 %67 to i66
  %69 = shl i66 %68, 56
  %70 = and i66 %.partset10, -72057594037927937
  %.partset11 = or i66 %70, %69
  store i66 %.partset11, i66* %dst, align 1
  %src.addr.1232 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %71 = bitcast i1* %src.addr.1232 to i8*
  %72 = load i8, i8* %71
  %73 = trunc i8 %72 to i1
  %74 = zext i1 %73 to i66
  %75 = shl i66 %74, 57
  %76 = and i66 %.partset11, -144115188075855873
  %.partset12 = or i66 %76, %75
  store i66 %.partset12, i66* %dst, align 1
  %src.addr.1334 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %77 = bitcast i1* %src.addr.1334 to i8*
  %78 = load i8, i8* %77
  %79 = trunc i8 %78 to i1
  %80 = zext i1 %79 to i66
  %81 = shl i66 %80, 58
  %82 = and i66 %.partset12, -288230376151711745
  %.partset13 = or i66 %82, %81
  store i66 %.partset13, i66* %dst, align 1
  %src.addr.1436 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %83 = bitcast i1* %src.addr.1436 to i8*
  %84 = load i8, i8* %83
  %85 = trunc i8 %84 to i1
  %86 = zext i1 %85 to i66
  %87 = shl i66 %86, 59
  %88 = and i66 %.partset13, -576460752303423489
  %.partset14 = or i66 %88, %87
  store i66 %.partset14, i66* %dst, align 1
  %src.addr.1538 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %89 = bitcast i1* %src.addr.1538 to i8*
  %90 = load i8, i8* %89
  %91 = trunc i8 %90 to i1
  %92 = zext i1 %91 to i66
  %93 = shl i66 %92, 60
  %94 = and i66 %.partset14, -1152921504606846977
  %.partset15 = or i66 %94, %93
  store i66 %.partset15, i66* %dst, align 1
  %src.addr.1640 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %95 = bitcast i1* %src.addr.1640 to i8*
  %96 = load i8, i8* %95
  %97 = trunc i8 %96 to i1
  %98 = zext i1 %97 to i66
  %99 = shl i66 %98, 61
  %100 = and i66 %.partset15, -2305843009213693953
  %.partset16 = or i66 %100, %99
  store i66 %.partset16, i66* %dst, align 1
  %src.addr.1742 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %101 = bitcast i1* %src.addr.1742 to i8*
  %102 = load i8, i8* %101
  %103 = trunc i8 %102 to i1
  %104 = zext i1 %103 to i66
  %105 = shl i66 %104, 62
  %106 = and i66 %.partset16, -4611686018427387905
  %.partset17 = or i66 %106, %105
  store i66 %.partset17, i66* %dst, align 1
  %src.addr.1844 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %107 = bitcast i1* %src.addr.1844 to i8*
  %108 = load i8, i8* %107
  %109 = trunc i8 %108 to i1
  %110 = zext i1 %109 to i66
  %111 = shl i66 %110, 63
  %112 = and i66 %.partset17, -9223372036854775809
  %.partset18 = or i66 %112, %111
  store i66 %.partset18, i66* %dst, align 1
  %src.addr.1946 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %113 = bitcast i1* %src.addr.1946 to i8*
  %114 = load i8, i8* %113
  %115 = trunc i8 %114 to i1
  %116 = zext i1 %115 to i66
  %117 = shl i66 %116, 64
  %118 = and i66 %.partset18, -18446744073709551617
  %.partset19 = or i66 %118, %117
  store i66 %.partset19, i66* %dst, align 1
  %src.addr.2048 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %119 = bitcast i1* %src.addr.2048 to i8*
  %120 = load i8, i8* %119
  %121 = trunc i8 %120 to i1
  %122 = zext i1 %121 to i66
  %123 = shl i66 %122, 65
  %124 = and i66 %.partset19, 36893488147419103231
  %.partset20 = or i66 %124, %123
  store i66 %.partset20, i66* %dst, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a1struct.HeadCtx.2.5(i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0" %dst, [1 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #2 {
entry:
  %0 = icmp eq i66* %dst, null
  %1 = icmp eq [1 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1struct.HeadCtx.3.4(i66* nonnull %dst, [1 x %struct.HeadCtx]* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in([1 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="0", i66* noalias align 512 "orig.arg.no"="1" "unpacked"="1") #3 {
entry:
  call void @onebyonecpy_hls.p0a1struct.HeadCtx.2.5(i66* align 512 %1, [1 x %struct.HeadCtx]* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a1struct.HeadCtx.11.12([1 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i66* readonly "orig.arg.no"="1" "unpacked"="1" %src, i64 "orig.arg.no"="2" %num) #1 {
entry:
  %0 = icmp eq i66* %src, null
  %1 = icmp eq [1 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr.02 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  %3 = bitcast i66* %src to i72*
  %4 = load i72, i72* %3
  %5 = trunc i72 %4 to i66
  %.partselect = trunc i66 %5 to i32
  store i32 %.partselect, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  %6 = bitcast i66* %src to i72*
  %7 = load i72, i72* %6
  %8 = trunc i72 %7 to i66
  %9 = lshr i66 %8, 32
  %.partselect1 = trunc i66 %9 to i8
  store i8 %.partselect1, i8* %dst.addr.111, align 1
  %dst.addr.213 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  %10 = bitcast i66* %src to i72*
  %11 = load i72, i72* %10
  %12 = trunc i72 %11 to i66
  %13 = lshr i66 %12, 40
  %.partselect2 = trunc i66 %13 to i1
  store i1 %.partselect2, i1* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  %14 = bitcast i66* %src to i72*
  %15 = load i72, i72* %14
  %16 = trunc i72 %15 to i66
  %17 = lshr i66 %16, 41
  %.partselect3 = trunc i66 %17 to i1
  store i1 %.partselect3, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  %18 = bitcast i66* %src to i72*
  %19 = load i72, i72* %18
  %20 = trunc i72 %19 to i66
  %21 = lshr i66 %20, 42
  %.partselect4 = trunc i66 %21 to i1
  store i1 %.partselect4, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  %22 = bitcast i66* %src to i72*
  %23 = load i72, i72* %22
  %24 = trunc i72 %23 to i66
  %25 = lshr i66 %24, 43
  %.partselect5 = trunc i66 %25 to i8
  store i8 %.partselect5, i8* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  %26 = bitcast i66* %src to i72*
  %27 = load i72, i72* %26
  %28 = trunc i72 %27 to i66
  %29 = lshr i66 %28, 51
  %.partselect6 = trunc i66 %29 to i1
  store i1 %.partselect6, i1* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  %30 = bitcast i66* %src to i72*
  %31 = load i72, i72* %30
  %32 = trunc i72 %31 to i66
  %33 = lshr i66 %32, 52
  %.partselect7 = trunc i66 %33 to i1
  store i1 %.partselect7, i1* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  %34 = bitcast i66* %src to i72*
  %35 = load i72, i72* %34
  %36 = trunc i72 %35 to i66
  %37 = lshr i66 %36, 53
  %.partselect8 = trunc i66 %37 to i1
  store i1 %.partselect8, i1* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  %38 = bitcast i66* %src to i72*
  %39 = load i72, i72* %38
  %40 = trunc i72 %39 to i66
  %41 = lshr i66 %40, 54
  %.partselect9 = trunc i66 %41 to i1
  store i1 %.partselect9, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  %42 = bitcast i66* %src to i72*
  %43 = load i72, i72* %42
  %44 = trunc i72 %43 to i66
  %45 = lshr i66 %44, 55
  %.partselect10 = trunc i66 %45 to i1
  store i1 %.partselect10, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  %46 = bitcast i66* %src to i72*
  %47 = load i72, i72* %46
  %48 = trunc i72 %47 to i66
  %49 = lshr i66 %48, 56
  %.partselect11 = trunc i66 %49 to i1
  store i1 %.partselect11, i1* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  %50 = bitcast i66* %src to i72*
  %51 = load i72, i72* %50
  %52 = trunc i72 %51 to i66
  %53 = lshr i66 %52, 57
  %.partselect12 = trunc i66 %53 to i1
  store i1 %.partselect12, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  %54 = bitcast i66* %src to i72*
  %55 = load i72, i72* %54
  %56 = trunc i72 %55 to i66
  %57 = lshr i66 %56, 58
  %.partselect13 = trunc i66 %57 to i1
  store i1 %.partselect13, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  %58 = bitcast i66* %src to i72*
  %59 = load i72, i72* %58
  %60 = trunc i72 %59 to i66
  %61 = lshr i66 %60, 59
  %.partselect14 = trunc i66 %61 to i1
  store i1 %.partselect14, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  %62 = bitcast i66* %src to i72*
  %63 = load i72, i72* %62
  %64 = trunc i72 %63 to i66
  %65 = lshr i66 %64, 60
  %.partselect15 = trunc i66 %65 to i1
  store i1 %.partselect15, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  %66 = bitcast i66* %src to i72*
  %67 = load i72, i72* %66
  %68 = trunc i72 %67 to i66
  %69 = lshr i66 %68, 61
  %.partselect16 = trunc i66 %69 to i1
  store i1 %.partselect16, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  %70 = bitcast i66* %src to i72*
  %71 = load i72, i72* %70
  %72 = trunc i72 %71 to i66
  %73 = lshr i66 %72, 62
  %.partselect17 = trunc i66 %73 to i1
  store i1 %.partselect17, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  %74 = bitcast i66* %src to i72*
  %75 = load i72, i72* %74
  %76 = trunc i72 %75 to i66
  %77 = lshr i66 %76, 63
  %.partselect18 = trunc i66 %77 to i1
  store i1 %.partselect18, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  %78 = bitcast i66* %src to i72*
  %79 = load i72, i72* %78
  %80 = trunc i72 %79 to i66
  %81 = lshr i66 %80, 64
  %.partselect19 = trunc i66 %81 to i1
  store i1 %.partselect19, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [1 x %struct.HeadCtx], [1 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
  %82 = bitcast i66* %src to i72*
  %83 = load i72, i72* %82
  %84 = trunc i72 %83 to i66
  %85 = lshr i66 %84, 65
  %.partselect20 = trunc i66 %85 to i1
  store i1 %.partselect20, i1* %dst.addr.2049, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a1struct.HeadCtx.10.13([1 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1" %src) #2 {
entry:
  %0 = icmp eq [1 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i66* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a1struct.HeadCtx.11.12([1 x %struct.HeadCtx]* nonnull %dst, i66* nonnull %src, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out([1 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1") #4 {
entry:
  call void @onebyonecpy_hls.p0a1struct.HeadCtx.10.13([1 x %struct.HeadCtx]* %0, i66* align 512 %1)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_drive_group_head_phase_hw(i66*, i32, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back([1 x %struct.HeadCtx]* noalias "orig.arg.no"="0", i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1") #4 {
entry:
  call void @onebyonecpy_hls.p0a1struct.HeadCtx.10.13([1 x %struct.HeadCtx]* %0, i66* align 512 %1)
  ret void
}

declare i1 @drive_group_head_phase_hw_stub([1 x %struct.HeadCtx]* noalias nonnull, i32, i32, i1 zeroext)

define i1 @drive_group_head_phase_hw_stub_wrapper(i66*, i32, i32, i1) #5 {
entry:
  %4 = call i8* @malloc(i64 24)
  %5 = bitcast i8* %4 to [1 x %struct.HeadCtx]*
  call void @copy_out([1 x %struct.HeadCtx]* %5, i66* %0)
  %6 = call i1 @drive_group_head_phase_hw_stub([1 x %struct.HeadCtx]* %5, i32 %1, i32 %2, i1 %3)
  call void @copy_in([1 x %struct.HeadCtx]* %5, i66* %0)
  call void @free(i8* %4)
  ret i1 %6
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
!7 = !{!"0", [1 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11}
!11 = !{!"0", %struct.HeadCtx* null}
