; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_helpers_parallel/drive_group_head_phase/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: argmemonly noinline willreturn
define i1 @apatb_drive_group_head_phase_ir([4 x %struct.HeadCtx]* noalias nonnull dereferenceable(96) %head_ctx_ref, i32 %group_idx, i32 %layer_idx, i1 zeroext %start) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy = alloca [4 x i66], align 512
  call fastcc void @copy_in([4 x %struct.HeadCtx]* nonnull %head_ctx_ref, [4 x i66]* nonnull align 512 %head_ctx_ref_copy)
  %0 = call i1 @apatb_drive_group_head_phase_hw([4 x i66]* %head_ctx_ref_copy, i32 %group_idx, i32 %layer_idx, i1 %start)
  call void @copy_back([4 x %struct.HeadCtx]* %head_ctx_ref, [4 x i66]* %head_ctx_ref_copy)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([4 x %struct.HeadCtx]* noalias readonly, [4 x i66]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx([4 x i66]* align 512 %1, [4 x %struct.HeadCtx]* %0)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx([4 x i66]* noalias align 512 %dst, [4 x %struct.HeadCtx]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x i66]* %dst, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx([4 x i66]* nonnull %dst, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx([4 x i66]* %dst, [4 x %struct.HeadCtx]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [4 x i66]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %3 = getelementptr [4 x i66], [4 x i66]* %dst, i64 0, i64 %for.loop.idx51
  %4 = load i32, i32* %src.addr.01, align 4
  %5 = bitcast i66* %3 to i72*
  %6 = load i72, i72* %5
  %7 = trunc i72 %6 to i66
  %8 = zext i32 %4 to i66
  %9 = and i66 %7, -4294967296
  %.partset20 = or i66 %9, %8
  store i66 %.partset20, i66* %3, align 4
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %10 = load i8, i8* %src.addr.110, align 1
  %11 = zext i8 %10 to i66
  %12 = shl i66 %11, 32
  %13 = and i66 %.partset20, -1095216660481
  %.partset19 = or i66 %13, %12
  store i66 %.partset19, i66* %3, align 1
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %14 = bitcast i1* %src.addr.212 to i8*
  %15 = load i8, i8* %14
  %16 = trunc i8 %15 to i1
  %17 = zext i1 %16 to i66
  %18 = shl i66 %17, 40
  %19 = and i66 %.partset19, -1099511627777
  %.partset18 = or i66 %19, %18
  store i66 %.partset18, i66* %3, align 1
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %20 = bitcast i1* %src.addr.314 to i8*
  %21 = load i8, i8* %20
  %22 = trunc i8 %21 to i1
  %23 = zext i1 %22 to i66
  %24 = shl i66 %23, 41
  %25 = and i66 %.partset18, -2199023255553
  %.partset17 = or i66 %25, %24
  store i66 %.partset17, i66* %3, align 1
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %26 = bitcast i1* %src.addr.416 to i8*
  %27 = load i8, i8* %26
  %28 = trunc i8 %27 to i1
  %29 = zext i1 %28 to i66
  %30 = shl i66 %29, 42
  %31 = and i66 %.partset17, -4398046511105
  %.partset16 = or i66 %31, %30
  store i66 %.partset16, i66* %3, align 1
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %32 = load i8, i8* %src.addr.518, align 1
  %33 = zext i8 %32 to i66
  %34 = shl i66 %33, 43
  %35 = and i66 %.partset16, -2243003720663041
  %.partset15 = or i66 %35, %34
  store i66 %.partset15, i66* %3, align 1
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %36 = bitcast i1* %src.addr.620 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  %39 = zext i1 %38 to i66
  %40 = shl i66 %39, 51
  %41 = and i66 %.partset15, -2251799813685249
  %.partset14 = or i66 %41, %40
  store i66 %.partset14, i66* %3, align 1
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %42 = bitcast i1* %src.addr.722 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  %45 = zext i1 %44 to i66
  %46 = shl i66 %45, 52
  %47 = and i66 %.partset14, -4503599627370497
  %.partset13 = or i66 %47, %46
  store i66 %.partset13, i66* %3, align 1
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %48 = bitcast i1* %src.addr.824 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  %51 = zext i1 %50 to i66
  %52 = shl i66 %51, 53
  %53 = and i66 %.partset13, -9007199254740993
  %.partset12 = or i66 %53, %52
  store i66 %.partset12, i66* %3, align 1
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %54 = bitcast i1* %src.addr.926 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  %57 = zext i1 %56 to i66
  %58 = shl i66 %57, 54
  %59 = and i66 %.partset12, -18014398509481985
  %.partset11 = or i66 %59, %58
  store i66 %.partset11, i66* %3, align 1
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %60 = bitcast i1* %src.addr.1028 to i8*
  %61 = load i8, i8* %60
  %62 = trunc i8 %61 to i1
  %63 = zext i1 %62 to i66
  %64 = shl i66 %63, 55
  %65 = and i66 %.partset11, -36028797018963969
  %.partset10 = or i66 %65, %64
  store i66 %.partset10, i66* %3, align 1
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %66 = bitcast i1* %src.addr.1130 to i8*
  %67 = load i8, i8* %66
  %68 = trunc i8 %67 to i1
  %69 = zext i1 %68 to i66
  %70 = shl i66 %69, 56
  %71 = and i66 %.partset10, -72057594037927937
  %.partset9 = or i66 %71, %70
  store i66 %.partset9, i66* %3, align 1
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %72 = bitcast i1* %src.addr.1232 to i8*
  %73 = load i8, i8* %72
  %74 = trunc i8 %73 to i1
  %75 = zext i1 %74 to i66
  %76 = shl i66 %75, 57
  %77 = and i66 %.partset9, -144115188075855873
  %.partset8 = or i66 %77, %76
  store i66 %.partset8, i66* %3, align 1
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %78 = bitcast i1* %src.addr.1334 to i8*
  %79 = load i8, i8* %78
  %80 = trunc i8 %79 to i1
  %81 = zext i1 %80 to i66
  %82 = shl i66 %81, 58
  %83 = and i66 %.partset8, -288230376151711745
  %.partset7 = or i66 %83, %82
  store i66 %.partset7, i66* %3, align 1
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %84 = bitcast i1* %src.addr.1436 to i8*
  %85 = load i8, i8* %84
  %86 = trunc i8 %85 to i1
  %87 = zext i1 %86 to i66
  %88 = shl i66 %87, 59
  %89 = and i66 %.partset7, -576460752303423489
  %.partset6 = or i66 %89, %88
  store i66 %.partset6, i66* %3, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %90 = bitcast i1* %src.addr.1538 to i8*
  %91 = load i8, i8* %90
  %92 = trunc i8 %91 to i1
  %93 = zext i1 %92 to i66
  %94 = shl i66 %93, 60
  %95 = and i66 %.partset6, -1152921504606846977
  %.partset5 = or i66 %95, %94
  store i66 %.partset5, i66* %3, align 1
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %96 = bitcast i1* %src.addr.1640 to i8*
  %97 = load i8, i8* %96
  %98 = trunc i8 %97 to i1
  %99 = zext i1 %98 to i66
  %100 = shl i66 %99, 61
  %101 = and i66 %.partset5, -2305843009213693953
  %.partset4 = or i66 %101, %100
  store i66 %.partset4, i66* %3, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %102 = bitcast i1* %src.addr.1742 to i8*
  %103 = load i8, i8* %102
  %104 = trunc i8 %103 to i1
  %105 = zext i1 %104 to i66
  %106 = shl i66 %105, 62
  %107 = and i66 %.partset4, -4611686018427387905
  %.partset3 = or i66 %107, %106
  store i66 %.partset3, i66* %3, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %108 = bitcast i1* %src.addr.1844 to i8*
  %109 = load i8, i8* %108
  %110 = trunc i8 %109 to i1
  %111 = zext i1 %110 to i66
  %112 = shl i66 %111, 63
  %113 = and i66 %.partset3, -9223372036854775809
  %.partset2 = or i66 %113, %112
  store i66 %.partset2, i66* %3, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %114 = bitcast i1* %src.addr.1946 to i8*
  %115 = load i8, i8* %114
  %116 = trunc i8 %115 to i1
  %117 = zext i1 %116 to i66
  %118 = shl i66 %117, 64
  %119 = and i66 %.partset2, -18446744073709551617
  %.partset1 = or i66 %119, %118
  store i66 %.partset1, i66* %3, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %120 = bitcast i1* %src.addr.2048 to i8*
  %121 = load i8, i8* %120
  %122 = trunc i8 %121 to i1
  %123 = zext i1 %122 to i66
  %124 = shl i66 %123, 65
  %125 = and i66 %.partset1, 36893488147419103231
  %.partset = or i66 %125, %124
  store i66 %.partset, i66* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([4 x %struct.HeadCtx]* noalias, [4 x i66]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx.4([4 x %struct.HeadCtx]* %0, [4 x i66]* align 512 %1)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx.4([4 x %struct.HeadCtx]* noalias %dst, [4 x i66]* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq [4 x i66]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.7([4 x %struct.HeadCtx]* nonnull %dst, [4 x i66]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.7([4 x %struct.HeadCtx]* %dst, [4 x i66]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [4 x i66]* %src, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [4 x i66], [4 x i66]* %src, i64 0, i64 %for.loop.idx51
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  %4 = bitcast i66* %3 to i72*
  %5 = load i72, i72* %4
  %6 = trunc i72 %5 to i66
  %.partselect20 = trunc i66 %6 to i32
  store i32 %.partselect20, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  %7 = bitcast i66* %3 to i72*
  %8 = load i72, i72* %7
  %9 = trunc i72 %8 to i66
  %10 = lshr i66 %9, 32
  %.partselect19 = trunc i66 %10 to i8
  store i8 %.partselect19, i8* %dst.addr.111, align 1
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  %11 = bitcast i66* %3 to i72*
  %12 = load i72, i72* %11
  %13 = trunc i72 %12 to i66
  %14 = lshr i66 %13, 40
  %.partselect18 = trunc i66 %14 to i1
  store i1 %.partselect18, i1* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  %15 = bitcast i66* %3 to i72*
  %16 = load i72, i72* %15
  %17 = trunc i72 %16 to i66
  %18 = lshr i66 %17, 41
  %.partselect17 = trunc i66 %18 to i1
  store i1 %.partselect17, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  %19 = bitcast i66* %3 to i72*
  %20 = load i72, i72* %19
  %21 = trunc i72 %20 to i66
  %22 = lshr i66 %21, 42
  %.partselect16 = trunc i66 %22 to i1
  store i1 %.partselect16, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  %23 = bitcast i66* %3 to i72*
  %24 = load i72, i72* %23
  %25 = trunc i72 %24 to i66
  %26 = lshr i66 %25, 43
  %.partselect15 = trunc i66 %26 to i8
  store i8 %.partselect15, i8* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  %27 = bitcast i66* %3 to i72*
  %28 = load i72, i72* %27
  %29 = trunc i72 %28 to i66
  %30 = lshr i66 %29, 51
  %.partselect14 = trunc i66 %30 to i1
  store i1 %.partselect14, i1* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  %31 = bitcast i66* %3 to i72*
  %32 = load i72, i72* %31
  %33 = trunc i72 %32 to i66
  %34 = lshr i66 %33, 52
  %.partselect13 = trunc i66 %34 to i1
  store i1 %.partselect13, i1* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  %35 = bitcast i66* %3 to i72*
  %36 = load i72, i72* %35
  %37 = trunc i72 %36 to i66
  %38 = lshr i66 %37, 53
  %.partselect12 = trunc i66 %38 to i1
  store i1 %.partselect12, i1* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  %39 = bitcast i66* %3 to i72*
  %40 = load i72, i72* %39
  %41 = trunc i72 %40 to i66
  %42 = lshr i66 %41, 54
  %.partselect11 = trunc i66 %42 to i1
  store i1 %.partselect11, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  %43 = bitcast i66* %3 to i72*
  %44 = load i72, i72* %43
  %45 = trunc i72 %44 to i66
  %46 = lshr i66 %45, 55
  %.partselect10 = trunc i66 %46 to i1
  store i1 %.partselect10, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  %47 = bitcast i66* %3 to i72*
  %48 = load i72, i72* %47
  %49 = trunc i72 %48 to i66
  %50 = lshr i66 %49, 56
  %.partselect9 = trunc i66 %50 to i1
  store i1 %.partselect9, i1* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  %51 = bitcast i66* %3 to i72*
  %52 = load i72, i72* %51
  %53 = trunc i72 %52 to i66
  %54 = lshr i66 %53, 57
  %.partselect8 = trunc i66 %54 to i1
  store i1 %.partselect8, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  %55 = bitcast i66* %3 to i72*
  %56 = load i72, i72* %55
  %57 = trunc i72 %56 to i66
  %58 = lshr i66 %57, 58
  %.partselect7 = trunc i66 %58 to i1
  store i1 %.partselect7, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  %59 = bitcast i66* %3 to i72*
  %60 = load i72, i72* %59
  %61 = trunc i72 %60 to i66
  %62 = lshr i66 %61, 59
  %.partselect6 = trunc i66 %62 to i1
  store i1 %.partselect6, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  %63 = bitcast i66* %3 to i72*
  %64 = load i72, i72* %63
  %65 = trunc i72 %64 to i66
  %66 = lshr i66 %65, 60
  %.partselect5 = trunc i66 %66 to i1
  store i1 %.partselect5, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  %67 = bitcast i66* %3 to i72*
  %68 = load i72, i72* %67
  %69 = trunc i72 %68 to i66
  %70 = lshr i66 %69, 61
  %.partselect4 = trunc i66 %70 to i1
  store i1 %.partselect4, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  %71 = bitcast i66* %3 to i72*
  %72 = load i72, i72* %71
  %73 = trunc i72 %72 to i66
  %74 = lshr i66 %73, 62
  %.partselect3 = trunc i66 %74 to i1
  store i1 %.partselect3, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  %75 = bitcast i66* %3 to i72*
  %76 = load i72, i72* %75
  %77 = trunc i72 %76 to i66
  %78 = lshr i66 %77, 63
  %.partselect2 = trunc i66 %78 to i1
  store i1 %.partselect2, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  %79 = bitcast i66* %3 to i72*
  %80 = load i72, i72* %79
  %81 = trunc i72 %80 to i66
  %82 = lshr i66 %81, 64
  %.partselect1 = trunc i66 %82 to i1
  store i1 %.partselect1, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
  %83 = bitcast i66* %3 to i72*
  %84 = load i72, i72* %83
  %85 = trunc i72 %84 to i66
  %86 = lshr i66 %85, 65
  %.partselect = trunc i66 %86 to i1
  store i1 %.partselect, i1* %dst.addr.2049, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_drive_group_head_phase_hw([4 x i66]*, i32, i32, i1)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([4 x %struct.HeadCtx]* noalias, [4 x i66]* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a4struct.HeadCtx.4([4 x %struct.HeadCtx]* %0, [4 x i66]* align 512 %1)
  ret void
}

declare i1 @drive_group_head_phase_hw_stub([4 x %struct.HeadCtx]* noalias nonnull, i32, i32, i1 zeroext)

define i1 @drive_group_head_phase_hw_stub_wrapper([4 x i66]*, i32, i32, i1) #5 {
entry:
  %4 = call i8* @malloc(i64 96)
  %5 = bitcast i8* %4 to [4 x %struct.HeadCtx]*
  call void @copy_out([4 x %struct.HeadCtx]* %5, [4 x i66]* %0)
  %6 = call i1 @drive_group_head_phase_hw_stub([4 x %struct.HeadCtx]* %5, i32 %1, i32 %2, i1 %3)
  call void @copy_in([4 x %struct.HeadCtx]* %5, [4 x i66]* %0)
  call void @free(i8* %4)
  ret i1 %6
}

attributes #0 = { argmemonly noinline willreturn "fpga.wrapper.func"="wrapper" }
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
