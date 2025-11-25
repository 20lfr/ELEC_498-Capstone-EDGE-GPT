; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_head_helpers/Head_Helpers/run_head_group/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i1, i1, i1 }
%struct.HeadResources = type { i1, i32, i8, i1, i32, i8, [8 x i1], [8 x i1], i1, i1, i32, i8 }

; Function Attrs: argmemonly noinline willreturn
define i1 @apatb_run_head_group_ir([8 x %struct.HeadCtx]* noalias nonnull dereferenceable(96) %head_ctx_ref, %struct.HeadResources* noalias nocapture nonnull dereferenceable(44) %res, i32 %layer_idx, i32 %group_idx, i1 zeroext %reset_resources, i1 zeroext %wl_ready, i1 zeroext %dma_done, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1 zeroext %requant_ready, i1 zeroext %requant_done, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i32* noalias nocapture nonnull dereferenceable(4) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, i1* noalias nocapture nonnull dereferenceable(1) %requant_start, i32* noalias nocapture nonnull dereferenceable(4) %requant_op) local_unnamed_addr #0 {
entry:
  %head_ctx_ref_copy = alloca [8 x i46], align 512
  %res_copy = alloca i140, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i32, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %requant_start_copy = alloca i1, align 512
  %requant_op_copy = alloca i32, align 512
  call fastcc void @copy_in([8 x %struct.HeadCtx]* nonnull %head_ctx_ref, [8 x i46]* nonnull align 512 %head_ctx_ref_copy, %struct.HeadResources* nonnull %res, i140* nonnull align 512 %res_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i32* nonnull %wl_addr_sel, i32* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, i1* nonnull %requant_start, i1* nonnull align 512 %requant_start_copy, i32* nonnull %requant_op, i32* nonnull align 512 %requant_op_copy)
  %0 = call i1 @apatb_run_head_group_hw([8 x i46]* %head_ctx_ref_copy, i140* %res_copy, i32 %layer_idx, i32 %group_idx, i1 %reset_resources, i1 %wl_ready, i1 %dma_done, i1 %compute_ready, i1 %compute_done, i1 %requant_ready, i1 %requant_done, i1* %wl_start_copy, i32* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1* %compute_start_copy, i32* %compute_op_copy, i1* %requant_start_copy, i32* %requant_op_copy)
  call void @copy_back([8 x %struct.HeadCtx]* %head_ctx_ref, [8 x i46]* %head_ctx_ref_copy, %struct.HeadResources* %res, i140* %res_copy, i1* %wl_start, i1* %wl_start_copy, i32* %wl_addr_sel, i32* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, i1* %requant_start, i1* %requant_start_copy, i32* %requant_op, i32* %requant_op_copy)
  ret i1 %0
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([8 x %struct.HeadCtx]* noalias readonly, [8 x i46]* noalias align 512, %struct.HeadResources* noalias readonly, i140* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512, i32* noalias readonly, i32* noalias align 512, i32* noalias readonly, i32* noalias align 512, i32* noalias readonly, i32* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a8struct.HeadCtx.18([8 x i46]* align 512 %1, [8 x %struct.HeadCtx]* %0)
  call fastcc void @onebyonecpy_hls.p0struct.HeadResources(i140* align 512 %3, %struct.HeadResources* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %7, i32* %6)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %9, i32* %8)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %11, i32* %10)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %13, i32* %12)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %15, i1* %14)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %17, i32* %16)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %19, i1* %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %21, i32* %20)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a8struct.HeadCtx([8 x %struct.HeadCtx]* noalias %dst, [8 x i46]* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [8 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq [8 x i46]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a8struct.HeadCtx([8 x %struct.HeadCtx]* nonnull %dst, [8 x i46]* nonnull %src, i64 8)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8struct.HeadCtx([8 x %struct.HeadCtx]* %dst, [8 x i46]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x i46]* %src, null
  %1 = icmp eq [8 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond17 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond17, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx18 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [8 x i46], [8 x i46]* %src, i64 0, i64 %for.loop.idx18
  %dst.addr.02 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 0
  %4 = bitcast i46* %3 to i48*
  %5 = load i48, i48* %4
  %6 = trunc i48 %5 to i46
  %.partselect7 = trunc i46 %6 to i32
  store i32 %.partselect7, i32* %dst.addr.02, align 4
  %dst.addr.14 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 1
  %7 = bitcast i46* %3 to i48*
  %8 = load i48, i48* %7
  %9 = trunc i48 %8 to i46
  %10 = lshr i46 %9, 32
  %.partselect6 = trunc i46 %10 to i8
  store i8 %.partselect6, i8* %dst.addr.14, align 1
  %dst.addr.26 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 2
  %11 = bitcast i46* %3 to i48*
  %12 = load i48, i48* %11
  %13 = trunc i48 %12 to i46
  %14 = lshr i46 %13, 40
  %.partselect5 = trunc i46 %14 to i1
  store i1 %.partselect5, i1* %dst.addr.26, align 1
  %dst.addr.38 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 3
  %15 = bitcast i46* %3 to i48*
  %16 = load i48, i48* %15
  %17 = trunc i48 %16 to i46
  %18 = lshr i46 %17, 41
  %.partselect4 = trunc i46 %18 to i1
  store i1 %.partselect4, i1* %dst.addr.38, align 1
  %dst.addr.410 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 4
  %19 = bitcast i46* %3 to i48*
  %20 = load i48, i48* %19
  %21 = trunc i48 %20 to i46
  %22 = lshr i46 %21, 42
  %.partselect3 = trunc i46 %22 to i1
  store i1 %.partselect3, i1* %dst.addr.410, align 1
  %dst.addr.512 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 5
  %23 = bitcast i46* %3 to i48*
  %24 = load i48, i48* %23
  %25 = trunc i48 %24 to i46
  %26 = lshr i46 %25, 43
  %.partselect2 = trunc i46 %26 to i1
  store i1 %.partselect2, i1* %dst.addr.512, align 1
  %dst.addr.614 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 6
  %27 = bitcast i46* %3 to i48*
  %28 = load i48, i48* %27
  %29 = trunc i48 %28 to i46
  %30 = lshr i46 %29, 44
  %.partselect1 = trunc i46 %30 to i1
  store i1 %.partselect1, i1* %dst.addr.614, align 1
  %dst.addr.716 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx18, i32 7
  %31 = bitcast i46* %3 to i48*
  %32 = load i48, i48* %31
  %33 = trunc i48 %32 to i46
  %34 = lshr i46 %33, 45
  %.partselect = trunc i46 %34 to i1
  store i1 %.partselect, i1* %dst.addr.716, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx18, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.HeadResources(i140* noalias align 512 %dst, %struct.HeadResources* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i140* %dst, null
  %1 = icmp eq %struct.HeadResources* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 0
  %3 = bitcast i1* %src.0 to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  %6 = bitcast i140* %dst to i144*
  %7 = load i144, i144* %6
  %8 = trunc i144 %7 to i140
  %9 = zext i1 %5 to i140
  %src.1 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 1
  %10 = load i32, i32* %src.1, align 4
  %11 = zext i32 %10 to i140
  %12 = shl i140 %11, 1
  %src.2 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 2
  %13 = load i8, i8* %src.2, align 1
  %14 = zext i8 %13 to i140
  %15 = shl i140 %14, 33
  %src.3 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 3
  %16 = bitcast i1* %src.3 to i8*
  %17 = load i8, i8* %16
  %18 = trunc i8 %17 to i1
  %19 = zext i1 %18 to i140
  %20 = shl i140 %19, 41
  %src.4 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 4
  %21 = load i32, i32* %src.4, align 4
  %22 = zext i32 %21 to i140
  %23 = shl i140 %22, 42
  %src.5 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 5
  %24 = load i8, i8* %src.5, align 1
  %25 = zext i8 %24 to i140
  %26 = shl i140 %25, 74
  %thr.or = or i140 %20, %26
  %thr.or25 = or i140 %12, %23
  %thr.or26 = or i140 %15, %9
  %thr.and = and i140 %8, -4835703278458516698824704
  %thr.or27 = or i140 %thr.or, %thr.or25
  %thr.or28 = or i140 %thr.or26, %thr.and
  %thr.or29 = or i140 %thr.or27, %thr.or28
  store i140 %thr.or29, i140* %dst, align 512
  %src.6 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 6
  call void @arraycpy_hls.p0a8i1(i140* nonnull %dst, i64 82, [8 x i1]* %src.6, i64 8)
  %src.7 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 7
  call void @arraycpy_hls.p0a8i1(i140* nonnull %dst, i64 90, [8 x i1]* %src.7, i64 8)
  %src.8 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 8
  %27 = bitcast i1* %src.8 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  %30 = bitcast i140* %dst to i144*
  %31 = load i144, i144* %30
  %32 = trunc i144 %31 to i140
  %33 = zext i1 %29 to i140
  %34 = shl i140 %33, 98
  %src.9 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 9
  %35 = bitcast i1* %src.9 to i8*
  %36 = load i8, i8* %35
  %37 = trunc i8 %36 to i1
  %38 = zext i1 %37 to i140
  %39 = shl i140 %38, 99
  %src.10 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 10
  %40 = load i32, i32* %src.10, align 4
  %41 = zext i32 %40 to i140
  %42 = shl i140 %41, 100
  %src.11 = getelementptr %struct.HeadResources, %struct.HeadResources* %src, i64 0, i32 11
  %43 = load i8, i8* %src.11, align 1
  %44 = zext i8 %43 to i140
  %45 = shl i140 %44, 132
  %thr.or20 = or i140 %39, %34
  %thr.and21 = and i140 %32, 316912650057057350374175801343
  %thr.or22 = or i140 %thr.or20, %thr.and21
  %thr.or23 = or i140 %45, %42
  %thr.or24 = or i140 %thr.or22, %thr.or23
  store i140 %thr.or24, i140* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i1* %dst, null
  %1 = icmp eq i1* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = bitcast i1* %src to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  store i1 %5, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i32(i32* noalias align 512 %dst, i32* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i32* %dst, null
  %1 = icmp eq i32* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = load i32, i32* %src, align 4
  store i32 %3, i32* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([8 x %struct.HeadCtx]* noalias, [8 x i46]* noalias readonly align 512, %struct.HeadResources* noalias, i140* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a8struct.HeadCtx([8 x %struct.HeadCtx]* %0, [8 x i46]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0struct.HeadResources.4(%struct.HeadResources* %2, i140* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %12, i32* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %14, i1* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %18, i1* align 512 %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %20, i32* align 512 %21)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.HeadResources.4(%struct.HeadResources* noalias %dst, i140* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.HeadResources* %dst, null
  %1 = icmp eq i140* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 0
  %3 = bitcast i140* %src to i144*
  %4 = load i144, i144* %3
  %5 = trunc i144 %4 to i140
  %.partselect9 = trunc i140 %5 to i1
  store i1 %.partselect9, i1* %dst.0, align 512
  %dst.1 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 1
  %6 = lshr i140 %5, 1
  %.partselect8 = trunc i140 %6 to i32
  store i32 %.partselect8, i32* %dst.1, align 4
  %dst.2 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 2
  %7 = lshr i140 %5, 33
  %.partselect7 = trunc i140 %7 to i8
  store i8 %.partselect7, i8* %dst.2, align 8
  %dst.3 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 3
  %8 = lshr i140 %5, 41
  %.partselect6 = trunc i140 %8 to i1
  store i1 %.partselect6, i1* %dst.3, align 1
  %dst.4 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 4
  %9 = lshr i140 %5, 42
  %.partselect5 = trunc i140 %9 to i32
  store i32 %.partselect5, i32* %dst.4, align 4
  %dst.5 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 5
  %10 = lshr i140 %5, 74
  %.partselect4 = trunc i140 %10 to i8
  store i8 %.partselect4, i8* %dst.5, align 16
  %dst.6 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 6
  call void @arraycpy_hls.p0a8i1.7([8 x i1]* %dst.6, i140* nonnull %src, i64 82, i64 8)
  %dst.7 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 7
  call void @arraycpy_hls.p0a8i1.7([8 x i1]* %dst.7, i140* nonnull %src, i64 90, i64 8)
  %dst.8 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 8
  %11 = lshr i140 %5, 98
  %.partselect3 = trunc i140 %11 to i1
  store i1 %.partselect3, i1* %dst.8, align 1
  %dst.9 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 9
  %12 = lshr i140 %5, 99
  %.partselect2 = trunc i140 %12 to i1
  store i1 %.partselect2, i1* %dst.9, align 2
  %dst.10 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 10
  %13 = lshr i140 %5, 100
  %.partselect1 = trunc i140 %13 to i32
  store i32 %.partselect1, i32* %dst.10, align 4
  %dst.11 = getelementptr %struct.HeadResources, %struct.HeadResources* %dst, i64 0, i32 11
  %14 = lshr i140 %5, 132
  %.partselect = trunc i140 %14 to i8
  store i8 %.partselect, i8* %dst.11, align 8
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8i1.7([8 x i1]* %dst, i140* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq i140* %src, null
  %1 = icmp eq [8 x i1]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [8 x i1], [8 x i1]* %dst, i64 0, i64 %for.loop.idx2
  %3 = add i64 %src_idx, %for.loop.idx2
  %4 = bitcast i140* %src to i144*
  %5 = load i144, i144* %4
  %6 = trunc i144 %5 to i140
  %7 = zext i64 %3 to i140
  %8 = lshr i140 %6, %7
  %.partselect = trunc i140 %8 to i1
  store i1 %.partselect, i1* %dst.addr, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8i1(i140* %dst, i64 %dst_idx, [8 x i1]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x i1]* %src, null
  %1 = icmp eq i140* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = add i64 %dst_idx, %for.loop.idx2
  %src.addr = getelementptr [8 x i1], [8 x i1]* %src, i64 0, i64 %for.loop.idx2
  %4 = bitcast i1* %src.addr to i8*
  %5 = load i8, i8* %4
  %6 = trunc i8 %5 to i1
  %7 = bitcast i140* %dst to i144*
  %8 = load i144, i144* %7
  %9 = trunc i144 %8 to i140
  %10 = zext i64 %3 to i140
  %11 = shl i140 1, %10
  %12 = zext i1 %6 to i140
  %13 = shl i140 %12, %10
  %thr.xor1 = xor i140 %11, -1
  %thr.and2 = and i140 %9, %thr.xor1
  %thr.or3 = or i140 %13, %thr.and2
  store i140 %thr.or3, i140* %dst, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a8struct.HeadCtx.18([8 x i46]* noalias align 512 %dst, [8 x %struct.HeadCtx]* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [8 x i46]* %dst, null
  %1 = icmp eq [8 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a8struct.HeadCtx.21([8 x i46]* nonnull %dst, [8 x %struct.HeadCtx]* nonnull %src, i64 8)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a8struct.HeadCtx.21([8 x i46]* %dst, [8 x %struct.HeadCtx]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [8 x %struct.HeadCtx]* %src, null
  %1 = icmp eq [8 x i46]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond17 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond17, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx18 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 0
  %3 = getelementptr [8 x i46], [8 x i46]* %dst, i64 0, i64 %for.loop.idx18
  %4 = load i32, i32* %src.addr.01, align 4
  %5 = bitcast i46* %3 to i48*
  %6 = load i48, i48* %5
  %7 = trunc i48 %6 to i46
  %8 = zext i32 %4 to i46
  %9 = and i46 %7, -4294967296
  %.partset7 = or i46 %9, %8
  store i46 %.partset7, i46* %3, align 4
  %src.addr.13 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 1
  %10 = load i8, i8* %src.addr.13, align 1
  %11 = zext i8 %10 to i46
  %12 = shl i46 %11, 32
  %13 = and i46 %.partset7, -1095216660481
  %.partset6 = or i46 %13, %12
  store i46 %.partset6, i46* %3, align 1
  %src.addr.25 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 2
  %14 = bitcast i1* %src.addr.25 to i8*
  %15 = load i8, i8* %14
  %16 = trunc i8 %15 to i1
  %17 = zext i1 %16 to i46
  %18 = shl i46 %17, 40
  %19 = and i46 %.partset6, -1099511627777
  %.partset5 = or i46 %19, %18
  store i46 %.partset5, i46* %3, align 1
  %src.addr.37 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 3
  %20 = bitcast i1* %src.addr.37 to i8*
  %21 = load i8, i8* %20
  %22 = trunc i8 %21 to i1
  %23 = zext i1 %22 to i46
  %24 = shl i46 %23, 41
  %25 = and i46 %.partset5, -2199023255553
  %.partset4 = or i46 %25, %24
  store i46 %.partset4, i46* %3, align 1
  %src.addr.49 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 4
  %26 = bitcast i1* %src.addr.49 to i8*
  %27 = load i8, i8* %26
  %28 = trunc i8 %27 to i1
  %29 = zext i1 %28 to i46
  %30 = shl i46 %29, 42
  %31 = and i46 %.partset4, -4398046511105
  %.partset3 = or i46 %31, %30
  store i46 %.partset3, i46* %3, align 1
  %src.addr.511 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 5
  %32 = bitcast i1* %src.addr.511 to i8*
  %33 = load i8, i8* %32
  %34 = trunc i8 %33 to i1
  %35 = zext i1 %34 to i46
  %36 = shl i46 %35, 43
  %37 = and i46 %.partset3, -8796093022209
  %.partset2 = or i46 %37, %36
  store i46 %.partset2, i46* %3, align 1
  %src.addr.613 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 6
  %38 = bitcast i1* %src.addr.613 to i8*
  %39 = load i8, i8* %38
  %40 = trunc i8 %39 to i1
  %41 = zext i1 %40 to i46
  %42 = shl i46 %41, 44
  %43 = and i46 %.partset2, -17592186044417
  %.partset1 = or i46 %43, %42
  store i46 %.partset1, i46* %3, align 1
  %src.addr.715 = getelementptr [8 x %struct.HeadCtx], [8 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx18, i32 7
  %44 = bitcast i1* %src.addr.715 to i8*
  %45 = load i8, i8* %44
  %46 = trunc i8 %45 to i1
  %47 = zext i1 %46 to i46
  %48 = shl i46 %47, 45
  %49 = and i46 %.partset1, 35184372088831
  %.partset = or i46 %49, %48
  store i46 %.partset, i46* %3, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx18, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare i1 @apatb_run_head_group_hw([8 x i46]*, i140*, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1*, i32*, i32*, i32*, i32*, i1*, i32*, i1*, i32*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([8 x %struct.HeadCtx]* noalias, [8 x i46]* noalias readonly align 512, %struct.HeadResources* noalias, i140* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a8struct.HeadCtx([8 x %struct.HeadCtx]* %0, [8 x i46]* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0struct.HeadResources.4(%struct.HeadResources* %2, i140* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %6, i32* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %8, i32* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %12, i32* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %14, i1* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %18, i1* align 512 %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %20, i32* align 512 %21)
  ret void
}

declare i1 @run_head_group_hw_stub([8 x %struct.HeadCtx]* noalias nonnull, %struct.HeadResources* noalias nocapture nonnull, i32, i32, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull)

define i1 @run_head_group_hw_stub_wrapper([8 x i46]*, i140*, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1*, i32*, i32*, i32*, i32*, i1*, i32*, i1*, i32*) #5 {
entry:
  %20 = call i8* @malloc(i64 96)
  %21 = bitcast i8* %20 to [8 x %struct.HeadCtx]*
  %22 = call i8* @malloc(i64 44)
  %23 = bitcast i8* %22 to %struct.HeadResources*
  call void @copy_out([8 x %struct.HeadCtx]* %21, [8 x i46]* %0, %struct.HeadResources* %23, i140* %1, i1* null, i1* %11, i32* null, i32* %12, i32* null, i32* %13, i32* null, i32* %14, i32* null, i32* %15, i1* null, i1* %16, i32* null, i32* %17, i1* null, i1* %18, i32* null, i32* %19)
  %24 = call i1 @run_head_group_hw_stub([8 x %struct.HeadCtx]* %21, %struct.HeadResources* %23, i32 %2, i32 %3, i1 %4, i1 %5, i1 %6, i1 %7, i1 %8, i1 %9, i1 %10, i1* %11, i32* %12, i32* %13, i32* %14, i32* %15, i1* %16, i32* %17, i1* %18, i32* %19)
  call void @copy_in([8 x %struct.HeadCtx]* %21, [8 x i46]* %0, %struct.HeadResources* %23, i140* %1, i1* null, i1* %11, i32* null, i32* %12, i32* null, i32* %13, i32* null, i32* %14, i32* null, i32* %15, i1* null, i1* %16, i32* null, i32* %17, i1* null, i1* %18, i32* null, i32* %19)
  call void @free(i8* %20)
  call void @free(i8* %22)
  ret i1 %24
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
