; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_total/Scheduler_FSM_Including_heads/scheduler_hls/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.HeadCtx = type { i32, i8, i1, i1, i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1 }

; Function Attrs: noinline willreturn
define void @apatb_scheduler_hls_ir(i1 zeroext %cntrl_start, i1 zeroext %cntrl_reset_n, i32* noalias nocapture nonnull dereferenceable(4) %cntrl_layer_idx, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_busy, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_start_out, i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i32* noalias nocapture nonnull dereferenceable(4) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %dma_done, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1 zeroext %requant_ready, i1 zeroext %requant_done, [4 x %struct.HeadCtx]* noalias nonnull dereferenceable(96) "partition" %head_ctx_ref, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, i1* noalias nocapture nonnull dereferenceable(1) %requant_start, i32* noalias nocapture nonnull dereferenceable(4) %requant_op, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i1* noalias nocapture nonnull dereferenceable(1) %done, i32* noalias nocapture nonnull dereferenceable(4) %debug_compute_done, i32* noalias nocapture nonnull dereferenceable(4) %STATE) local_unnamed_addr #0 {
entry:
  %cntrl_layer_idx_copy = alloca i32, align 512
  %cntrl_busy_copy = alloca i1, align 512
  %cntrl_start_out_copy = alloca i1, align 512
  %axis_in_ready_copy = alloca i1, align 512
  %wl_start_copy = alloca i1, align 512
  %wl_addr_sel_copy = alloca i32, align 512
  %wl_layer_copy = alloca i32, align 512
  %wl_head_copy = alloca i32, align 512
  %wl_tile_copy = alloca i32, align 512
  %head_ctx_ref_copy_0 = alloca i66, align 512
  %head_ctx_ref_copy_1 = alloca i66, align 512
  %head_ctx_ref_copy_2 = alloca i66, align 512
  %head_ctx_ref_copy_3 = alloca i66, align 512
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %requant_start_copy = alloca i1, align 512
  %requant_op_copy = alloca i32, align 512
  %stream_start_copy = alloca i1, align 512
  %done_copy = alloca i1, align 512
  %debug_compute_done_copy = alloca i32, align 512
  %STATE_copy = alloca i32, align 512
  call void @copy_in(i32* nonnull %cntrl_layer_idx, i32* nonnull align 512 %cntrl_layer_idx_copy, i1* nonnull %cntrl_busy, i1* nonnull align 512 %cntrl_busy_copy, i1* nonnull %cntrl_start_out, i1* nonnull align 512 %cntrl_start_out_copy, i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i32* nonnull %wl_addr_sel, i32* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, [4 x %struct.HeadCtx]* nonnull %head_ctx_ref, i66* nonnull align 512 %head_ctx_ref_copy_0, i66* nonnull align 512 %head_ctx_ref_copy_1, i66* nonnull align 512 %head_ctx_ref_copy_2, i66* nonnull align 512 %head_ctx_ref_copy_3, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, i1* nonnull %requant_start, i1* nonnull align 512 %requant_start_copy, i32* nonnull %requant_op, i32* nonnull align 512 %requant_op_copy, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i1* nonnull %done, i1* nonnull align 512 %done_copy, i32* nonnull %debug_compute_done, i32* nonnull align 512 %debug_compute_done_copy, i32* nonnull %STATE, i32* nonnull align 512 %STATE_copy)
  call void @apatb_scheduler_hls_hw(i1 %cntrl_start, i1 %cntrl_reset_n, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy_copy, i1* %cntrl_start_out_copy, i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %wl_ready, i1* %wl_start_copy, i32* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %dma_done, i1 %compute_ready, i1 %compute_done, i1 %requant_ready, i1 %requant_done, i66* %head_ctx_ref_copy_0, i66* %head_ctx_ref_copy_1, i66* %head_ctx_ref_copy_2, i66* %head_ctx_ref_copy_3, i1* %compute_start_copy, i32* %compute_op_copy, i1* %requant_start_copy, i32* %requant_op_copy, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i1* %done_copy, i32* %debug_compute_done_copy, i32* %STATE_copy)
  call void @copy_back(i32* %cntrl_layer_idx, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy, i1* %cntrl_busy_copy, i1* %cntrl_start_out, i1* %cntrl_start_out_copy, i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i32* %wl_addr_sel, i32* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, [4 x %struct.HeadCtx]* %head_ctx_ref, i66* %head_ctx_ref_copy_0, i66* %head_ctx_ref_copy_1, i66* %head_ctx_ref_copy_2, i66* %head_ctx_ref_copy_3, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, i1* %requant_start, i1* %requant_start_copy, i32* %requant_op, i32* %requant_op_copy, i1* %stream_start, i1* %stream_start_copy, i1* %done, i1* %done_copy, i32* %debug_compute_done, i32* %debug_compute_done_copy, i32* %STATE, i32* %STATE_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i32(i32* noalias align 512 %dst, i32* noalias readonly %src) unnamed_addr #1 {
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
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #1 {
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
define void @arraycpy_hls.p0a4struct.HeadCtx([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) local_unnamed_addr #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
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
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  store i32 %3, i32* %dst.addr.02, align 4
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  %4 = load i8, i8* %src.addr.110, align 1
  store i8 %4, i8* %dst.addr.111, align 1
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  %5 = bitcast i1* %src.addr.212 to i8*
  %6 = load i8, i8* %5
  %7 = trunc i8 %6 to i1
  store i1 %7, i1* %dst.addr.213, align 1
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  %8 = bitcast i1* %src.addr.314 to i8*
  %9 = load i8, i8* %8
  %10 = trunc i8 %9 to i1
  store i1 %10, i1* %dst.addr.315, align 1
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  %11 = bitcast i1* %src.addr.416 to i8*
  %12 = load i8, i8* %11
  %13 = trunc i8 %12 to i1
  store i1 %13, i1* %dst.addr.417, align 1
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  %14 = load i8, i8* %src.addr.518, align 1
  store i8 %14, i8* %dst.addr.519, align 1
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  %15 = bitcast i1* %src.addr.620 to i8*
  %16 = load i8, i8* %15
  %17 = trunc i8 %16 to i1
  store i1 %17, i1* %dst.addr.621, align 1
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  %18 = bitcast i1* %src.addr.722 to i8*
  %19 = load i8, i8* %18
  %20 = trunc i8 %19 to i1
  store i1 %20, i1* %dst.addr.723, align 1
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  %21 = bitcast i1* %src.addr.824 to i8*
  %22 = load i8, i8* %21
  %23 = trunc i8 %22 to i1
  store i1 %23, i1* %dst.addr.825, align 1
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  %24 = bitcast i1* %src.addr.926 to i8*
  %25 = load i8, i8* %24
  %26 = trunc i8 %25 to i1
  store i1 %26, i1* %dst.addr.927, align 1
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  %27 = bitcast i1* %src.addr.1028 to i8*
  %28 = load i8, i8* %27
  %29 = trunc i8 %28 to i1
  store i1 %29, i1* %dst.addr.1029, align 1
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  %30 = bitcast i1* %src.addr.1130 to i8*
  %31 = load i8, i8* %30
  %32 = trunc i8 %31 to i1
  store i1 %32, i1* %dst.addr.1131, align 1
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  %33 = bitcast i1* %src.addr.1232 to i8*
  %34 = load i8, i8* %33
  %35 = trunc i8 %34 to i1
  store i1 %35, i1* %dst.addr.1233, align 1
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  %36 = bitcast i1* %src.addr.1334 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  store i1 %38, i1* %dst.addr.1335, align 1
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  %39 = bitcast i1* %src.addr.1436 to i8*
  %40 = load i8, i8* %39
  %41 = trunc i8 %40 to i1
  store i1 %41, i1* %dst.addr.1437, align 1
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  %42 = bitcast i1* %src.addr.1538 to i8*
  %43 = load i8, i8* %42
  %44 = trunc i8 %43 to i1
  store i1 %44, i1* %dst.addr.1539, align 1
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  %45 = bitcast i1* %src.addr.1640 to i8*
  %46 = load i8, i8* %45
  %47 = trunc i8 %46 to i1
  store i1 %47, i1* %dst.addr.1641, align 1
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  %48 = bitcast i1* %src.addr.1742 to i8*
  %49 = load i8, i8* %48
  %50 = trunc i8 %49 to i1
  store i1 %50, i1* %dst.addr.1743, align 1
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  %51 = bitcast i1* %src.addr.1844 to i8*
  %52 = load i8, i8* %51
  %53 = trunc i8 %52 to i1
  store i1 %53, i1* %dst.addr.1845, align 1
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  %54 = bitcast i1* %src.addr.1946 to i8*
  %55 = load i8, i8* %54
  %56 = trunc i8 %55 to i1
  store i1 %56, i1* %dst.addr.1947, align 1
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
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
define void @arraycpy_hls.p0a4struct.HeadCtx.11.12(i66* "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i66* "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i66* "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i66* "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* readonly "orig.arg.no"="1" %src, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %src, null
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
  %src.addr.01 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 0
  %3 = load i32, i32* %src.addr.01, align 4
  switch i64 %for.loop.idx51, label %dst.addr.02.exit [
    i64 0, label %dst.addr.02.case.0
    i64 1, label %dst.addr.02.case.1
    i64 2, label %dst.addr.02.case.2
    i64 3, label %dst.addr.02.case.3
  ]

dst.addr.02.case.0:                               ; preds = %for.loop
  %4 = bitcast i66* %dst_0 to i72*
  %5 = load i72, i72* %4
  %6 = trunc i72 %5 to i66
  %7 = zext i32 %3 to i66
  %8 = and i66 %6, -4294967296
  %.partset83 = or i66 %8, %7
  store i66 %.partset83, i66* %dst_0, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.1:                               ; preds = %for.loop
  %9 = bitcast i66* %dst_1 to i72*
  %10 = load i72, i72* %9
  %11 = trunc i72 %10 to i66
  %12 = zext i32 %3 to i66
  %13 = and i66 %11, -4294967296
  %.partset42 = or i66 %13, %12
  store i66 %.partset42, i66* %dst_1, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.2:                               ; preds = %for.loop
  %14 = bitcast i66* %dst_2 to i72*
  %15 = load i72, i72* %14
  %16 = trunc i72 %15 to i66
  %17 = zext i32 %3 to i66
  %18 = and i66 %16, -4294967296
  %.partset41 = or i66 %18, %17
  store i66 %.partset41, i66* %dst_2, align 4
  br label %dst.addr.02.exit

dst.addr.02.case.3:                               ; preds = %for.loop
  %19 = bitcast i66* %dst_3 to i72*
  %20 = load i72, i72* %19
  %21 = trunc i72 %20 to i66
  %22 = zext i32 %3 to i66
  %23 = and i66 %21, -4294967296
  %.partset = or i66 %23, %22
  store i66 %.partset, i66* %dst_3, align 4
  br label %dst.addr.02.exit

dst.addr.02.exit:                                 ; preds = %dst.addr.02.case.3, %dst.addr.02.case.2, %dst.addr.02.case.1, %dst.addr.02.case.0, %for.loop
  %src.addr.110 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 1
  %24 = load i8, i8* %src.addr.110, align 1
  switch i64 %for.loop.idx51, label %dst.addr.111.exit [
    i64 0, label %dst.addr.111.case.0
    i64 1, label %dst.addr.111.case.1
    i64 2, label %dst.addr.111.case.2
    i64 3, label %dst.addr.111.case.3
  ]

dst.addr.111.case.0:                              ; preds = %dst.addr.02.exit
  %25 = bitcast i66* %dst_0 to i72*
  %26 = load i72, i72* %25
  %27 = trunc i72 %26 to i66
  %28 = zext i8 %24 to i66
  %29 = shl i66 %28, 32
  %30 = and i66 %27, -1095216660481
  %.partset82 = or i66 %30, %29
  store i66 %.partset82, i66* %dst_0, align 1
  br label %dst.addr.111.exit

dst.addr.111.case.1:                              ; preds = %dst.addr.02.exit
  %31 = bitcast i66* %dst_1 to i72*
  %32 = load i72, i72* %31
  %33 = trunc i72 %32 to i66
  %34 = zext i8 %24 to i66
  %35 = shl i66 %34, 32
  %36 = and i66 %33, -1095216660481
  %.partset43 = or i66 %36, %35
  store i66 %.partset43, i66* %dst_1, align 1
  br label %dst.addr.111.exit

dst.addr.111.case.2:                              ; preds = %dst.addr.02.exit
  %37 = bitcast i66* %dst_2 to i72*
  %38 = load i72, i72* %37
  %39 = trunc i72 %38 to i66
  %40 = zext i8 %24 to i66
  %41 = shl i66 %40, 32
  %42 = and i66 %39, -1095216660481
  %.partset40 = or i66 %42, %41
  store i66 %.partset40, i66* %dst_2, align 1
  br label %dst.addr.111.exit

dst.addr.111.case.3:                              ; preds = %dst.addr.02.exit
  %43 = bitcast i66* %dst_3 to i72*
  %44 = load i72, i72* %43
  %45 = trunc i72 %44 to i66
  %46 = zext i8 %24 to i66
  %47 = shl i66 %46, 32
  %48 = and i66 %45, -1095216660481
  %.partset1 = or i66 %48, %47
  store i66 %.partset1, i66* %dst_3, align 1
  br label %dst.addr.111.exit

dst.addr.111.exit:                                ; preds = %dst.addr.111.case.3, %dst.addr.111.case.2, %dst.addr.111.case.1, %dst.addr.111.case.0, %dst.addr.02.exit
  %src.addr.212 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 2
  %49 = bitcast i1* %src.addr.212 to i8*
  %50 = load i8, i8* %49
  %51 = trunc i8 %50 to i1
  switch i64 %for.loop.idx51, label %dst.addr.213.exit [
    i64 0, label %dst.addr.213.case.0
    i64 1, label %dst.addr.213.case.1
    i64 2, label %dst.addr.213.case.2
    i64 3, label %dst.addr.213.case.3
  ]

dst.addr.213.case.0:                              ; preds = %dst.addr.111.exit
  %52 = bitcast i66* %dst_0 to i72*
  %53 = load i72, i72* %52
  %54 = trunc i72 %53 to i66
  %55 = zext i1 %51 to i66
  %56 = shl i66 %55, 40
  %57 = and i66 %54, -1099511627777
  %.partset81 = or i66 %57, %56
  store i66 %.partset81, i66* %dst_0, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.1:                              ; preds = %dst.addr.111.exit
  %58 = bitcast i66* %dst_1 to i72*
  %59 = load i72, i72* %58
  %60 = trunc i72 %59 to i66
  %61 = zext i1 %51 to i66
  %62 = shl i66 %61, 40
  %63 = and i66 %60, -1099511627777
  %.partset44 = or i66 %63, %62
  store i66 %.partset44, i66* %dst_1, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.2:                              ; preds = %dst.addr.111.exit
  %64 = bitcast i66* %dst_2 to i72*
  %65 = load i72, i72* %64
  %66 = trunc i72 %65 to i66
  %67 = zext i1 %51 to i66
  %68 = shl i66 %67, 40
  %69 = and i66 %66, -1099511627777
  %.partset39 = or i66 %69, %68
  store i66 %.partset39, i66* %dst_2, align 1
  br label %dst.addr.213.exit

dst.addr.213.case.3:                              ; preds = %dst.addr.111.exit
  %70 = bitcast i66* %dst_3 to i72*
  %71 = load i72, i72* %70
  %72 = trunc i72 %71 to i66
  %73 = zext i1 %51 to i66
  %74 = shl i66 %73, 40
  %75 = and i66 %72, -1099511627777
  %.partset2 = or i66 %75, %74
  store i66 %.partset2, i66* %dst_3, align 1
  br label %dst.addr.213.exit

dst.addr.213.exit:                                ; preds = %dst.addr.213.case.3, %dst.addr.213.case.2, %dst.addr.213.case.1, %dst.addr.213.case.0, %dst.addr.111.exit
  %src.addr.314 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 3
  %76 = bitcast i1* %src.addr.314 to i8*
  %77 = load i8, i8* %76
  %78 = trunc i8 %77 to i1
  switch i64 %for.loop.idx51, label %dst.addr.315.exit [
    i64 0, label %dst.addr.315.case.0
    i64 1, label %dst.addr.315.case.1
    i64 2, label %dst.addr.315.case.2
    i64 3, label %dst.addr.315.case.3
  ]

dst.addr.315.case.0:                              ; preds = %dst.addr.213.exit
  %79 = bitcast i66* %dst_0 to i72*
  %80 = load i72, i72* %79
  %81 = trunc i72 %80 to i66
  %82 = zext i1 %78 to i66
  %83 = shl i66 %82, 41
  %84 = and i66 %81, -2199023255553
  %.partset80 = or i66 %84, %83
  store i66 %.partset80, i66* %dst_0, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.1:                              ; preds = %dst.addr.213.exit
  %85 = bitcast i66* %dst_1 to i72*
  %86 = load i72, i72* %85
  %87 = trunc i72 %86 to i66
  %88 = zext i1 %78 to i66
  %89 = shl i66 %88, 41
  %90 = and i66 %87, -2199023255553
  %.partset45 = or i66 %90, %89
  store i66 %.partset45, i66* %dst_1, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.2:                              ; preds = %dst.addr.213.exit
  %91 = bitcast i66* %dst_2 to i72*
  %92 = load i72, i72* %91
  %93 = trunc i72 %92 to i66
  %94 = zext i1 %78 to i66
  %95 = shl i66 %94, 41
  %96 = and i66 %93, -2199023255553
  %.partset38 = or i66 %96, %95
  store i66 %.partset38, i66* %dst_2, align 1
  br label %dst.addr.315.exit

dst.addr.315.case.3:                              ; preds = %dst.addr.213.exit
  %97 = bitcast i66* %dst_3 to i72*
  %98 = load i72, i72* %97
  %99 = trunc i72 %98 to i66
  %100 = zext i1 %78 to i66
  %101 = shl i66 %100, 41
  %102 = and i66 %99, -2199023255553
  %.partset3 = or i66 %102, %101
  store i66 %.partset3, i66* %dst_3, align 1
  br label %dst.addr.315.exit

dst.addr.315.exit:                                ; preds = %dst.addr.315.case.3, %dst.addr.315.case.2, %dst.addr.315.case.1, %dst.addr.315.case.0, %dst.addr.213.exit
  %src.addr.416 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 4
  %103 = bitcast i1* %src.addr.416 to i8*
  %104 = load i8, i8* %103
  %105 = trunc i8 %104 to i1
  switch i64 %for.loop.idx51, label %dst.addr.417.exit [
    i64 0, label %dst.addr.417.case.0
    i64 1, label %dst.addr.417.case.1
    i64 2, label %dst.addr.417.case.2
    i64 3, label %dst.addr.417.case.3
  ]

dst.addr.417.case.0:                              ; preds = %dst.addr.315.exit
  %106 = bitcast i66* %dst_0 to i72*
  %107 = load i72, i72* %106
  %108 = trunc i72 %107 to i66
  %109 = zext i1 %105 to i66
  %110 = shl i66 %109, 42
  %111 = and i66 %108, -4398046511105
  %.partset79 = or i66 %111, %110
  store i66 %.partset79, i66* %dst_0, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.1:                              ; preds = %dst.addr.315.exit
  %112 = bitcast i66* %dst_1 to i72*
  %113 = load i72, i72* %112
  %114 = trunc i72 %113 to i66
  %115 = zext i1 %105 to i66
  %116 = shl i66 %115, 42
  %117 = and i66 %114, -4398046511105
  %.partset46 = or i66 %117, %116
  store i66 %.partset46, i66* %dst_1, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.2:                              ; preds = %dst.addr.315.exit
  %118 = bitcast i66* %dst_2 to i72*
  %119 = load i72, i72* %118
  %120 = trunc i72 %119 to i66
  %121 = zext i1 %105 to i66
  %122 = shl i66 %121, 42
  %123 = and i66 %120, -4398046511105
  %.partset37 = or i66 %123, %122
  store i66 %.partset37, i66* %dst_2, align 1
  br label %dst.addr.417.exit

dst.addr.417.case.3:                              ; preds = %dst.addr.315.exit
  %124 = bitcast i66* %dst_3 to i72*
  %125 = load i72, i72* %124
  %126 = trunc i72 %125 to i66
  %127 = zext i1 %105 to i66
  %128 = shl i66 %127, 42
  %129 = and i66 %126, -4398046511105
  %.partset4 = or i66 %129, %128
  store i66 %.partset4, i66* %dst_3, align 1
  br label %dst.addr.417.exit

dst.addr.417.exit:                                ; preds = %dst.addr.417.case.3, %dst.addr.417.case.2, %dst.addr.417.case.1, %dst.addr.417.case.0, %dst.addr.315.exit
  %src.addr.518 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 5
  %130 = load i8, i8* %src.addr.518, align 1
  switch i64 %for.loop.idx51, label %dst.addr.519.exit [
    i64 0, label %dst.addr.519.case.0
    i64 1, label %dst.addr.519.case.1
    i64 2, label %dst.addr.519.case.2
    i64 3, label %dst.addr.519.case.3
  ]

dst.addr.519.case.0:                              ; preds = %dst.addr.417.exit
  %131 = bitcast i66* %dst_0 to i72*
  %132 = load i72, i72* %131
  %133 = trunc i72 %132 to i66
  %134 = zext i8 %130 to i66
  %135 = shl i66 %134, 43
  %136 = and i66 %133, -2243003720663041
  %.partset78 = or i66 %136, %135
  store i66 %.partset78, i66* %dst_0, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.1:                              ; preds = %dst.addr.417.exit
  %137 = bitcast i66* %dst_1 to i72*
  %138 = load i72, i72* %137
  %139 = trunc i72 %138 to i66
  %140 = zext i8 %130 to i66
  %141 = shl i66 %140, 43
  %142 = and i66 %139, -2243003720663041
  %.partset47 = or i66 %142, %141
  store i66 %.partset47, i66* %dst_1, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.2:                              ; preds = %dst.addr.417.exit
  %143 = bitcast i66* %dst_2 to i72*
  %144 = load i72, i72* %143
  %145 = trunc i72 %144 to i66
  %146 = zext i8 %130 to i66
  %147 = shl i66 %146, 43
  %148 = and i66 %145, -2243003720663041
  %.partset36 = or i66 %148, %147
  store i66 %.partset36, i66* %dst_2, align 1
  br label %dst.addr.519.exit

dst.addr.519.case.3:                              ; preds = %dst.addr.417.exit
  %149 = bitcast i66* %dst_3 to i72*
  %150 = load i72, i72* %149
  %151 = trunc i72 %150 to i66
  %152 = zext i8 %130 to i66
  %153 = shl i66 %152, 43
  %154 = and i66 %151, -2243003720663041
  %.partset5 = or i66 %154, %153
  store i66 %.partset5, i66* %dst_3, align 1
  br label %dst.addr.519.exit

dst.addr.519.exit:                                ; preds = %dst.addr.519.case.3, %dst.addr.519.case.2, %dst.addr.519.case.1, %dst.addr.519.case.0, %dst.addr.417.exit
  %src.addr.620 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 6
  %155 = bitcast i1* %src.addr.620 to i8*
  %156 = load i8, i8* %155
  %157 = trunc i8 %156 to i1
  switch i64 %for.loop.idx51, label %dst.addr.621.exit [
    i64 0, label %dst.addr.621.case.0
    i64 1, label %dst.addr.621.case.1
    i64 2, label %dst.addr.621.case.2
    i64 3, label %dst.addr.621.case.3
  ]

dst.addr.621.case.0:                              ; preds = %dst.addr.519.exit
  %158 = bitcast i66* %dst_0 to i72*
  %159 = load i72, i72* %158
  %160 = trunc i72 %159 to i66
  %161 = zext i1 %157 to i66
  %162 = shl i66 %161, 51
  %163 = and i66 %160, -2251799813685249
  %.partset77 = or i66 %163, %162
  store i66 %.partset77, i66* %dst_0, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.1:                              ; preds = %dst.addr.519.exit
  %164 = bitcast i66* %dst_1 to i72*
  %165 = load i72, i72* %164
  %166 = trunc i72 %165 to i66
  %167 = zext i1 %157 to i66
  %168 = shl i66 %167, 51
  %169 = and i66 %166, -2251799813685249
  %.partset48 = or i66 %169, %168
  store i66 %.partset48, i66* %dst_1, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.2:                              ; preds = %dst.addr.519.exit
  %170 = bitcast i66* %dst_2 to i72*
  %171 = load i72, i72* %170
  %172 = trunc i72 %171 to i66
  %173 = zext i1 %157 to i66
  %174 = shl i66 %173, 51
  %175 = and i66 %172, -2251799813685249
  %.partset35 = or i66 %175, %174
  store i66 %.partset35, i66* %dst_2, align 1
  br label %dst.addr.621.exit

dst.addr.621.case.3:                              ; preds = %dst.addr.519.exit
  %176 = bitcast i66* %dst_3 to i72*
  %177 = load i72, i72* %176
  %178 = trunc i72 %177 to i66
  %179 = zext i1 %157 to i66
  %180 = shl i66 %179, 51
  %181 = and i66 %178, -2251799813685249
  %.partset6 = or i66 %181, %180
  store i66 %.partset6, i66* %dst_3, align 1
  br label %dst.addr.621.exit

dst.addr.621.exit:                                ; preds = %dst.addr.621.case.3, %dst.addr.621.case.2, %dst.addr.621.case.1, %dst.addr.621.case.0, %dst.addr.519.exit
  %src.addr.722 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 7
  %182 = bitcast i1* %src.addr.722 to i8*
  %183 = load i8, i8* %182
  %184 = trunc i8 %183 to i1
  switch i64 %for.loop.idx51, label %dst.addr.723.exit [
    i64 0, label %dst.addr.723.case.0
    i64 1, label %dst.addr.723.case.1
    i64 2, label %dst.addr.723.case.2
    i64 3, label %dst.addr.723.case.3
  ]

dst.addr.723.case.0:                              ; preds = %dst.addr.621.exit
  %185 = bitcast i66* %dst_0 to i72*
  %186 = load i72, i72* %185
  %187 = trunc i72 %186 to i66
  %188 = zext i1 %184 to i66
  %189 = shl i66 %188, 52
  %190 = and i66 %187, -4503599627370497
  %.partset76 = or i66 %190, %189
  store i66 %.partset76, i66* %dst_0, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.1:                              ; preds = %dst.addr.621.exit
  %191 = bitcast i66* %dst_1 to i72*
  %192 = load i72, i72* %191
  %193 = trunc i72 %192 to i66
  %194 = zext i1 %184 to i66
  %195 = shl i66 %194, 52
  %196 = and i66 %193, -4503599627370497
  %.partset49 = or i66 %196, %195
  store i66 %.partset49, i66* %dst_1, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.2:                              ; preds = %dst.addr.621.exit
  %197 = bitcast i66* %dst_2 to i72*
  %198 = load i72, i72* %197
  %199 = trunc i72 %198 to i66
  %200 = zext i1 %184 to i66
  %201 = shl i66 %200, 52
  %202 = and i66 %199, -4503599627370497
  %.partset34 = or i66 %202, %201
  store i66 %.partset34, i66* %dst_2, align 1
  br label %dst.addr.723.exit

dst.addr.723.case.3:                              ; preds = %dst.addr.621.exit
  %203 = bitcast i66* %dst_3 to i72*
  %204 = load i72, i72* %203
  %205 = trunc i72 %204 to i66
  %206 = zext i1 %184 to i66
  %207 = shl i66 %206, 52
  %208 = and i66 %205, -4503599627370497
  %.partset7 = or i66 %208, %207
  store i66 %.partset7, i66* %dst_3, align 1
  br label %dst.addr.723.exit

dst.addr.723.exit:                                ; preds = %dst.addr.723.case.3, %dst.addr.723.case.2, %dst.addr.723.case.1, %dst.addr.723.case.0, %dst.addr.621.exit
  %src.addr.824 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 8
  %209 = bitcast i1* %src.addr.824 to i8*
  %210 = load i8, i8* %209
  %211 = trunc i8 %210 to i1
  switch i64 %for.loop.idx51, label %dst.addr.825.exit [
    i64 0, label %dst.addr.825.case.0
    i64 1, label %dst.addr.825.case.1
    i64 2, label %dst.addr.825.case.2
    i64 3, label %dst.addr.825.case.3
  ]

dst.addr.825.case.0:                              ; preds = %dst.addr.723.exit
  %212 = bitcast i66* %dst_0 to i72*
  %213 = load i72, i72* %212
  %214 = trunc i72 %213 to i66
  %215 = zext i1 %211 to i66
  %216 = shl i66 %215, 53
  %217 = and i66 %214, -9007199254740993
  %.partset75 = or i66 %217, %216
  store i66 %.partset75, i66* %dst_0, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.1:                              ; preds = %dst.addr.723.exit
  %218 = bitcast i66* %dst_1 to i72*
  %219 = load i72, i72* %218
  %220 = trunc i72 %219 to i66
  %221 = zext i1 %211 to i66
  %222 = shl i66 %221, 53
  %223 = and i66 %220, -9007199254740993
  %.partset50 = or i66 %223, %222
  store i66 %.partset50, i66* %dst_1, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.2:                              ; preds = %dst.addr.723.exit
  %224 = bitcast i66* %dst_2 to i72*
  %225 = load i72, i72* %224
  %226 = trunc i72 %225 to i66
  %227 = zext i1 %211 to i66
  %228 = shl i66 %227, 53
  %229 = and i66 %226, -9007199254740993
  %.partset33 = or i66 %229, %228
  store i66 %.partset33, i66* %dst_2, align 1
  br label %dst.addr.825.exit

dst.addr.825.case.3:                              ; preds = %dst.addr.723.exit
  %230 = bitcast i66* %dst_3 to i72*
  %231 = load i72, i72* %230
  %232 = trunc i72 %231 to i66
  %233 = zext i1 %211 to i66
  %234 = shl i66 %233, 53
  %235 = and i66 %232, -9007199254740993
  %.partset8 = or i66 %235, %234
  store i66 %.partset8, i66* %dst_3, align 1
  br label %dst.addr.825.exit

dst.addr.825.exit:                                ; preds = %dst.addr.825.case.3, %dst.addr.825.case.2, %dst.addr.825.case.1, %dst.addr.825.case.0, %dst.addr.723.exit
  %src.addr.926 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 9
  %236 = bitcast i1* %src.addr.926 to i8*
  %237 = load i8, i8* %236
  %238 = trunc i8 %237 to i1
  switch i64 %for.loop.idx51, label %dst.addr.927.exit [
    i64 0, label %dst.addr.927.case.0
    i64 1, label %dst.addr.927.case.1
    i64 2, label %dst.addr.927.case.2
    i64 3, label %dst.addr.927.case.3
  ]

dst.addr.927.case.0:                              ; preds = %dst.addr.825.exit
  %239 = bitcast i66* %dst_0 to i72*
  %240 = load i72, i72* %239
  %241 = trunc i72 %240 to i66
  %242 = zext i1 %238 to i66
  %243 = shl i66 %242, 54
  %244 = and i66 %241, -18014398509481985
  %.partset74 = or i66 %244, %243
  store i66 %.partset74, i66* %dst_0, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.1:                              ; preds = %dst.addr.825.exit
  %245 = bitcast i66* %dst_1 to i72*
  %246 = load i72, i72* %245
  %247 = trunc i72 %246 to i66
  %248 = zext i1 %238 to i66
  %249 = shl i66 %248, 54
  %250 = and i66 %247, -18014398509481985
  %.partset51 = or i66 %250, %249
  store i66 %.partset51, i66* %dst_1, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.2:                              ; preds = %dst.addr.825.exit
  %251 = bitcast i66* %dst_2 to i72*
  %252 = load i72, i72* %251
  %253 = trunc i72 %252 to i66
  %254 = zext i1 %238 to i66
  %255 = shl i66 %254, 54
  %256 = and i66 %253, -18014398509481985
  %.partset32 = or i66 %256, %255
  store i66 %.partset32, i66* %dst_2, align 1
  br label %dst.addr.927.exit

dst.addr.927.case.3:                              ; preds = %dst.addr.825.exit
  %257 = bitcast i66* %dst_3 to i72*
  %258 = load i72, i72* %257
  %259 = trunc i72 %258 to i66
  %260 = zext i1 %238 to i66
  %261 = shl i66 %260, 54
  %262 = and i66 %259, -18014398509481985
  %.partset9 = or i66 %262, %261
  store i66 %.partset9, i66* %dst_3, align 1
  br label %dst.addr.927.exit

dst.addr.927.exit:                                ; preds = %dst.addr.927.case.3, %dst.addr.927.case.2, %dst.addr.927.case.1, %dst.addr.927.case.0, %dst.addr.825.exit
  %src.addr.1028 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 10
  %263 = bitcast i1* %src.addr.1028 to i8*
  %264 = load i8, i8* %263
  %265 = trunc i8 %264 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1029.exit [
    i64 0, label %dst.addr.1029.case.0
    i64 1, label %dst.addr.1029.case.1
    i64 2, label %dst.addr.1029.case.2
    i64 3, label %dst.addr.1029.case.3
  ]

dst.addr.1029.case.0:                             ; preds = %dst.addr.927.exit
  %266 = bitcast i66* %dst_0 to i72*
  %267 = load i72, i72* %266
  %268 = trunc i72 %267 to i66
  %269 = zext i1 %265 to i66
  %270 = shl i66 %269, 55
  %271 = and i66 %268, -36028797018963969
  %.partset73 = or i66 %271, %270
  store i66 %.partset73, i66* %dst_0, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.1:                             ; preds = %dst.addr.927.exit
  %272 = bitcast i66* %dst_1 to i72*
  %273 = load i72, i72* %272
  %274 = trunc i72 %273 to i66
  %275 = zext i1 %265 to i66
  %276 = shl i66 %275, 55
  %277 = and i66 %274, -36028797018963969
  %.partset52 = or i66 %277, %276
  store i66 %.partset52, i66* %dst_1, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.2:                             ; preds = %dst.addr.927.exit
  %278 = bitcast i66* %dst_2 to i72*
  %279 = load i72, i72* %278
  %280 = trunc i72 %279 to i66
  %281 = zext i1 %265 to i66
  %282 = shl i66 %281, 55
  %283 = and i66 %280, -36028797018963969
  %.partset31 = or i66 %283, %282
  store i66 %.partset31, i66* %dst_2, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.case.3:                             ; preds = %dst.addr.927.exit
  %284 = bitcast i66* %dst_3 to i72*
  %285 = load i72, i72* %284
  %286 = trunc i72 %285 to i66
  %287 = zext i1 %265 to i66
  %288 = shl i66 %287, 55
  %289 = and i66 %286, -36028797018963969
  %.partset10 = or i66 %289, %288
  store i66 %.partset10, i66* %dst_3, align 1
  br label %dst.addr.1029.exit

dst.addr.1029.exit:                               ; preds = %dst.addr.1029.case.3, %dst.addr.1029.case.2, %dst.addr.1029.case.1, %dst.addr.1029.case.0, %dst.addr.927.exit
  %src.addr.1130 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 11
  %290 = bitcast i1* %src.addr.1130 to i8*
  %291 = load i8, i8* %290
  %292 = trunc i8 %291 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1131.exit [
    i64 0, label %dst.addr.1131.case.0
    i64 1, label %dst.addr.1131.case.1
    i64 2, label %dst.addr.1131.case.2
    i64 3, label %dst.addr.1131.case.3
  ]

dst.addr.1131.case.0:                             ; preds = %dst.addr.1029.exit
  %293 = bitcast i66* %dst_0 to i72*
  %294 = load i72, i72* %293
  %295 = trunc i72 %294 to i66
  %296 = zext i1 %292 to i66
  %297 = shl i66 %296, 56
  %298 = and i66 %295, -72057594037927937
  %.partset72 = or i66 %298, %297
  store i66 %.partset72, i66* %dst_0, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.1:                             ; preds = %dst.addr.1029.exit
  %299 = bitcast i66* %dst_1 to i72*
  %300 = load i72, i72* %299
  %301 = trunc i72 %300 to i66
  %302 = zext i1 %292 to i66
  %303 = shl i66 %302, 56
  %304 = and i66 %301, -72057594037927937
  %.partset53 = or i66 %304, %303
  store i66 %.partset53, i66* %dst_1, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.2:                             ; preds = %dst.addr.1029.exit
  %305 = bitcast i66* %dst_2 to i72*
  %306 = load i72, i72* %305
  %307 = trunc i72 %306 to i66
  %308 = zext i1 %292 to i66
  %309 = shl i66 %308, 56
  %310 = and i66 %307, -72057594037927937
  %.partset30 = or i66 %310, %309
  store i66 %.partset30, i66* %dst_2, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.case.3:                             ; preds = %dst.addr.1029.exit
  %311 = bitcast i66* %dst_3 to i72*
  %312 = load i72, i72* %311
  %313 = trunc i72 %312 to i66
  %314 = zext i1 %292 to i66
  %315 = shl i66 %314, 56
  %316 = and i66 %313, -72057594037927937
  %.partset11 = or i66 %316, %315
  store i66 %.partset11, i66* %dst_3, align 1
  br label %dst.addr.1131.exit

dst.addr.1131.exit:                               ; preds = %dst.addr.1131.case.3, %dst.addr.1131.case.2, %dst.addr.1131.case.1, %dst.addr.1131.case.0, %dst.addr.1029.exit
  %src.addr.1232 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 12
  %317 = bitcast i1* %src.addr.1232 to i8*
  %318 = load i8, i8* %317
  %319 = trunc i8 %318 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1233.exit [
    i64 0, label %dst.addr.1233.case.0
    i64 1, label %dst.addr.1233.case.1
    i64 2, label %dst.addr.1233.case.2
    i64 3, label %dst.addr.1233.case.3
  ]

dst.addr.1233.case.0:                             ; preds = %dst.addr.1131.exit
  %320 = bitcast i66* %dst_0 to i72*
  %321 = load i72, i72* %320
  %322 = trunc i72 %321 to i66
  %323 = zext i1 %319 to i66
  %324 = shl i66 %323, 57
  %325 = and i66 %322, -144115188075855873
  %.partset71 = or i66 %325, %324
  store i66 %.partset71, i66* %dst_0, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.1:                             ; preds = %dst.addr.1131.exit
  %326 = bitcast i66* %dst_1 to i72*
  %327 = load i72, i72* %326
  %328 = trunc i72 %327 to i66
  %329 = zext i1 %319 to i66
  %330 = shl i66 %329, 57
  %331 = and i66 %328, -144115188075855873
  %.partset54 = or i66 %331, %330
  store i66 %.partset54, i66* %dst_1, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.2:                             ; preds = %dst.addr.1131.exit
  %332 = bitcast i66* %dst_2 to i72*
  %333 = load i72, i72* %332
  %334 = trunc i72 %333 to i66
  %335 = zext i1 %319 to i66
  %336 = shl i66 %335, 57
  %337 = and i66 %334, -144115188075855873
  %.partset29 = or i66 %337, %336
  store i66 %.partset29, i66* %dst_2, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.case.3:                             ; preds = %dst.addr.1131.exit
  %338 = bitcast i66* %dst_3 to i72*
  %339 = load i72, i72* %338
  %340 = trunc i72 %339 to i66
  %341 = zext i1 %319 to i66
  %342 = shl i66 %341, 57
  %343 = and i66 %340, -144115188075855873
  %.partset12 = or i66 %343, %342
  store i66 %.partset12, i66* %dst_3, align 1
  br label %dst.addr.1233.exit

dst.addr.1233.exit:                               ; preds = %dst.addr.1233.case.3, %dst.addr.1233.case.2, %dst.addr.1233.case.1, %dst.addr.1233.case.0, %dst.addr.1131.exit
  %src.addr.1334 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 13
  %344 = bitcast i1* %src.addr.1334 to i8*
  %345 = load i8, i8* %344
  %346 = trunc i8 %345 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1335.exit [
    i64 0, label %dst.addr.1335.case.0
    i64 1, label %dst.addr.1335.case.1
    i64 2, label %dst.addr.1335.case.2
    i64 3, label %dst.addr.1335.case.3
  ]

dst.addr.1335.case.0:                             ; preds = %dst.addr.1233.exit
  %347 = bitcast i66* %dst_0 to i72*
  %348 = load i72, i72* %347
  %349 = trunc i72 %348 to i66
  %350 = zext i1 %346 to i66
  %351 = shl i66 %350, 58
  %352 = and i66 %349, -288230376151711745
  %.partset70 = or i66 %352, %351
  store i66 %.partset70, i66* %dst_0, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.1:                             ; preds = %dst.addr.1233.exit
  %353 = bitcast i66* %dst_1 to i72*
  %354 = load i72, i72* %353
  %355 = trunc i72 %354 to i66
  %356 = zext i1 %346 to i66
  %357 = shl i66 %356, 58
  %358 = and i66 %355, -288230376151711745
  %.partset55 = or i66 %358, %357
  store i66 %.partset55, i66* %dst_1, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.2:                             ; preds = %dst.addr.1233.exit
  %359 = bitcast i66* %dst_2 to i72*
  %360 = load i72, i72* %359
  %361 = trunc i72 %360 to i66
  %362 = zext i1 %346 to i66
  %363 = shl i66 %362, 58
  %364 = and i66 %361, -288230376151711745
  %.partset28 = or i66 %364, %363
  store i66 %.partset28, i66* %dst_2, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.case.3:                             ; preds = %dst.addr.1233.exit
  %365 = bitcast i66* %dst_3 to i72*
  %366 = load i72, i72* %365
  %367 = trunc i72 %366 to i66
  %368 = zext i1 %346 to i66
  %369 = shl i66 %368, 58
  %370 = and i66 %367, -288230376151711745
  %.partset13 = or i66 %370, %369
  store i66 %.partset13, i66* %dst_3, align 1
  br label %dst.addr.1335.exit

dst.addr.1335.exit:                               ; preds = %dst.addr.1335.case.3, %dst.addr.1335.case.2, %dst.addr.1335.case.1, %dst.addr.1335.case.0, %dst.addr.1233.exit
  %src.addr.1436 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 14
  %371 = bitcast i1* %src.addr.1436 to i8*
  %372 = load i8, i8* %371
  %373 = trunc i8 %372 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1437.exit [
    i64 0, label %dst.addr.1437.case.0
    i64 1, label %dst.addr.1437.case.1
    i64 2, label %dst.addr.1437.case.2
    i64 3, label %dst.addr.1437.case.3
  ]

dst.addr.1437.case.0:                             ; preds = %dst.addr.1335.exit
  %374 = bitcast i66* %dst_0 to i72*
  %375 = load i72, i72* %374
  %376 = trunc i72 %375 to i66
  %377 = zext i1 %373 to i66
  %378 = shl i66 %377, 59
  %379 = and i66 %376, -576460752303423489
  %.partset69 = or i66 %379, %378
  store i66 %.partset69, i66* %dst_0, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.1:                             ; preds = %dst.addr.1335.exit
  %380 = bitcast i66* %dst_1 to i72*
  %381 = load i72, i72* %380
  %382 = trunc i72 %381 to i66
  %383 = zext i1 %373 to i66
  %384 = shl i66 %383, 59
  %385 = and i66 %382, -576460752303423489
  %.partset56 = or i66 %385, %384
  store i66 %.partset56, i66* %dst_1, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.2:                             ; preds = %dst.addr.1335.exit
  %386 = bitcast i66* %dst_2 to i72*
  %387 = load i72, i72* %386
  %388 = trunc i72 %387 to i66
  %389 = zext i1 %373 to i66
  %390 = shl i66 %389, 59
  %391 = and i66 %388, -576460752303423489
  %.partset27 = or i66 %391, %390
  store i66 %.partset27, i66* %dst_2, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.case.3:                             ; preds = %dst.addr.1335.exit
  %392 = bitcast i66* %dst_3 to i72*
  %393 = load i72, i72* %392
  %394 = trunc i72 %393 to i66
  %395 = zext i1 %373 to i66
  %396 = shl i66 %395, 59
  %397 = and i66 %394, -576460752303423489
  %.partset14 = or i66 %397, %396
  store i66 %.partset14, i66* %dst_3, align 1
  br label %dst.addr.1437.exit

dst.addr.1437.exit:                               ; preds = %dst.addr.1437.case.3, %dst.addr.1437.case.2, %dst.addr.1437.case.1, %dst.addr.1437.case.0, %dst.addr.1335.exit
  %src.addr.1538 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 15
  %398 = bitcast i1* %src.addr.1538 to i8*
  %399 = load i8, i8* %398
  %400 = trunc i8 %399 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1539.exit [
    i64 0, label %dst.addr.1539.case.0
    i64 1, label %dst.addr.1539.case.1
    i64 2, label %dst.addr.1539.case.2
    i64 3, label %dst.addr.1539.case.3
  ]

dst.addr.1539.case.0:                             ; preds = %dst.addr.1437.exit
  %401 = bitcast i66* %dst_0 to i72*
  %402 = load i72, i72* %401
  %403 = trunc i72 %402 to i66
  %404 = zext i1 %400 to i66
  %405 = shl i66 %404, 60
  %406 = and i66 %403, -1152921504606846977
  %.partset68 = or i66 %406, %405
  store i66 %.partset68, i66* %dst_0, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.1:                             ; preds = %dst.addr.1437.exit
  %407 = bitcast i66* %dst_1 to i72*
  %408 = load i72, i72* %407
  %409 = trunc i72 %408 to i66
  %410 = zext i1 %400 to i66
  %411 = shl i66 %410, 60
  %412 = and i66 %409, -1152921504606846977
  %.partset57 = or i66 %412, %411
  store i66 %.partset57, i66* %dst_1, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.2:                             ; preds = %dst.addr.1437.exit
  %413 = bitcast i66* %dst_2 to i72*
  %414 = load i72, i72* %413
  %415 = trunc i72 %414 to i66
  %416 = zext i1 %400 to i66
  %417 = shl i66 %416, 60
  %418 = and i66 %415, -1152921504606846977
  %.partset26 = or i66 %418, %417
  store i66 %.partset26, i66* %dst_2, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.case.3:                             ; preds = %dst.addr.1437.exit
  %419 = bitcast i66* %dst_3 to i72*
  %420 = load i72, i72* %419
  %421 = trunc i72 %420 to i66
  %422 = zext i1 %400 to i66
  %423 = shl i66 %422, 60
  %424 = and i66 %421, -1152921504606846977
  %.partset15 = or i66 %424, %423
  store i66 %.partset15, i66* %dst_3, align 1
  br label %dst.addr.1539.exit

dst.addr.1539.exit:                               ; preds = %dst.addr.1539.case.3, %dst.addr.1539.case.2, %dst.addr.1539.case.1, %dst.addr.1539.case.0, %dst.addr.1437.exit
  %src.addr.1640 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 16
  %425 = bitcast i1* %src.addr.1640 to i8*
  %426 = load i8, i8* %425
  %427 = trunc i8 %426 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1641.exit [
    i64 0, label %dst.addr.1641.case.0
    i64 1, label %dst.addr.1641.case.1
    i64 2, label %dst.addr.1641.case.2
    i64 3, label %dst.addr.1641.case.3
  ]

dst.addr.1641.case.0:                             ; preds = %dst.addr.1539.exit
  %428 = bitcast i66* %dst_0 to i72*
  %429 = load i72, i72* %428
  %430 = trunc i72 %429 to i66
  %431 = zext i1 %427 to i66
  %432 = shl i66 %431, 61
  %433 = and i66 %430, -2305843009213693953
  %.partset67 = or i66 %433, %432
  store i66 %.partset67, i66* %dst_0, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.1:                             ; preds = %dst.addr.1539.exit
  %434 = bitcast i66* %dst_1 to i72*
  %435 = load i72, i72* %434
  %436 = trunc i72 %435 to i66
  %437 = zext i1 %427 to i66
  %438 = shl i66 %437, 61
  %439 = and i66 %436, -2305843009213693953
  %.partset58 = or i66 %439, %438
  store i66 %.partset58, i66* %dst_1, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.2:                             ; preds = %dst.addr.1539.exit
  %440 = bitcast i66* %dst_2 to i72*
  %441 = load i72, i72* %440
  %442 = trunc i72 %441 to i66
  %443 = zext i1 %427 to i66
  %444 = shl i66 %443, 61
  %445 = and i66 %442, -2305843009213693953
  %.partset25 = or i66 %445, %444
  store i66 %.partset25, i66* %dst_2, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.case.3:                             ; preds = %dst.addr.1539.exit
  %446 = bitcast i66* %dst_3 to i72*
  %447 = load i72, i72* %446
  %448 = trunc i72 %447 to i66
  %449 = zext i1 %427 to i66
  %450 = shl i66 %449, 61
  %451 = and i66 %448, -2305843009213693953
  %.partset16 = or i66 %451, %450
  store i66 %.partset16, i66* %dst_3, align 1
  br label %dst.addr.1641.exit

dst.addr.1641.exit:                               ; preds = %dst.addr.1641.case.3, %dst.addr.1641.case.2, %dst.addr.1641.case.1, %dst.addr.1641.case.0, %dst.addr.1539.exit
  %src.addr.1742 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 17
  %452 = bitcast i1* %src.addr.1742 to i8*
  %453 = load i8, i8* %452
  %454 = trunc i8 %453 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1743.exit [
    i64 0, label %dst.addr.1743.case.0
    i64 1, label %dst.addr.1743.case.1
    i64 2, label %dst.addr.1743.case.2
    i64 3, label %dst.addr.1743.case.3
  ]

dst.addr.1743.case.0:                             ; preds = %dst.addr.1641.exit
  %455 = bitcast i66* %dst_0 to i72*
  %456 = load i72, i72* %455
  %457 = trunc i72 %456 to i66
  %458 = zext i1 %454 to i66
  %459 = shl i66 %458, 62
  %460 = and i66 %457, -4611686018427387905
  %.partset66 = or i66 %460, %459
  store i66 %.partset66, i66* %dst_0, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.1:                             ; preds = %dst.addr.1641.exit
  %461 = bitcast i66* %dst_1 to i72*
  %462 = load i72, i72* %461
  %463 = trunc i72 %462 to i66
  %464 = zext i1 %454 to i66
  %465 = shl i66 %464, 62
  %466 = and i66 %463, -4611686018427387905
  %.partset59 = or i66 %466, %465
  store i66 %.partset59, i66* %dst_1, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.2:                             ; preds = %dst.addr.1641.exit
  %467 = bitcast i66* %dst_2 to i72*
  %468 = load i72, i72* %467
  %469 = trunc i72 %468 to i66
  %470 = zext i1 %454 to i66
  %471 = shl i66 %470, 62
  %472 = and i66 %469, -4611686018427387905
  %.partset24 = or i66 %472, %471
  store i66 %.partset24, i66* %dst_2, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.case.3:                             ; preds = %dst.addr.1641.exit
  %473 = bitcast i66* %dst_3 to i72*
  %474 = load i72, i72* %473
  %475 = trunc i72 %474 to i66
  %476 = zext i1 %454 to i66
  %477 = shl i66 %476, 62
  %478 = and i66 %475, -4611686018427387905
  %.partset17 = or i66 %478, %477
  store i66 %.partset17, i66* %dst_3, align 1
  br label %dst.addr.1743.exit

dst.addr.1743.exit:                               ; preds = %dst.addr.1743.case.3, %dst.addr.1743.case.2, %dst.addr.1743.case.1, %dst.addr.1743.case.0, %dst.addr.1641.exit
  %src.addr.1844 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 18
  %479 = bitcast i1* %src.addr.1844 to i8*
  %480 = load i8, i8* %479
  %481 = trunc i8 %480 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1845.exit [
    i64 0, label %dst.addr.1845.case.0
    i64 1, label %dst.addr.1845.case.1
    i64 2, label %dst.addr.1845.case.2
    i64 3, label %dst.addr.1845.case.3
  ]

dst.addr.1845.case.0:                             ; preds = %dst.addr.1743.exit
  %482 = bitcast i66* %dst_0 to i72*
  %483 = load i72, i72* %482
  %484 = trunc i72 %483 to i66
  %485 = zext i1 %481 to i66
  %486 = shl i66 %485, 63
  %487 = and i66 %484, -9223372036854775809
  %.partset65 = or i66 %487, %486
  store i66 %.partset65, i66* %dst_0, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.1:                             ; preds = %dst.addr.1743.exit
  %488 = bitcast i66* %dst_1 to i72*
  %489 = load i72, i72* %488
  %490 = trunc i72 %489 to i66
  %491 = zext i1 %481 to i66
  %492 = shl i66 %491, 63
  %493 = and i66 %490, -9223372036854775809
  %.partset60 = or i66 %493, %492
  store i66 %.partset60, i66* %dst_1, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.2:                             ; preds = %dst.addr.1743.exit
  %494 = bitcast i66* %dst_2 to i72*
  %495 = load i72, i72* %494
  %496 = trunc i72 %495 to i66
  %497 = zext i1 %481 to i66
  %498 = shl i66 %497, 63
  %499 = and i66 %496, -9223372036854775809
  %.partset23 = or i66 %499, %498
  store i66 %.partset23, i66* %dst_2, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.case.3:                             ; preds = %dst.addr.1743.exit
  %500 = bitcast i66* %dst_3 to i72*
  %501 = load i72, i72* %500
  %502 = trunc i72 %501 to i66
  %503 = zext i1 %481 to i66
  %504 = shl i66 %503, 63
  %505 = and i66 %502, -9223372036854775809
  %.partset18 = or i66 %505, %504
  store i66 %.partset18, i66* %dst_3, align 1
  br label %dst.addr.1845.exit

dst.addr.1845.exit:                               ; preds = %dst.addr.1845.case.3, %dst.addr.1845.case.2, %dst.addr.1845.case.1, %dst.addr.1845.case.0, %dst.addr.1743.exit
  %src.addr.1946 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 19
  %506 = bitcast i1* %src.addr.1946 to i8*
  %507 = load i8, i8* %506
  %508 = trunc i8 %507 to i1
  switch i64 %for.loop.idx51, label %dst.addr.1947.exit [
    i64 0, label %dst.addr.1947.case.0
    i64 1, label %dst.addr.1947.case.1
    i64 2, label %dst.addr.1947.case.2
    i64 3, label %dst.addr.1947.case.3
  ]

dst.addr.1947.case.0:                             ; preds = %dst.addr.1845.exit
  %509 = bitcast i66* %dst_0 to i72*
  %510 = load i72, i72* %509
  %511 = trunc i72 %510 to i66
  %512 = zext i1 %508 to i66
  %513 = shl i66 %512, 64
  %514 = and i66 %511, -18446744073709551617
  %.partset64 = or i66 %514, %513
  store i66 %.partset64, i66* %dst_0, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.1:                             ; preds = %dst.addr.1845.exit
  %515 = bitcast i66* %dst_1 to i72*
  %516 = load i72, i72* %515
  %517 = trunc i72 %516 to i66
  %518 = zext i1 %508 to i66
  %519 = shl i66 %518, 64
  %520 = and i66 %517, -18446744073709551617
  %.partset61 = or i66 %520, %519
  store i66 %.partset61, i66* %dst_1, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.2:                             ; preds = %dst.addr.1845.exit
  %521 = bitcast i66* %dst_2 to i72*
  %522 = load i72, i72* %521
  %523 = trunc i72 %522 to i66
  %524 = zext i1 %508 to i66
  %525 = shl i66 %524, 64
  %526 = and i66 %523, -18446744073709551617
  %.partset22 = or i66 %526, %525
  store i66 %.partset22, i66* %dst_2, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.case.3:                             ; preds = %dst.addr.1845.exit
  %527 = bitcast i66* %dst_3 to i72*
  %528 = load i72, i72* %527
  %529 = trunc i72 %528 to i66
  %530 = zext i1 %508 to i66
  %531 = shl i66 %530, 64
  %532 = and i66 %529, -18446744073709551617
  %.partset19 = or i66 %532, %531
  store i66 %.partset19, i66* %dst_3, align 1
  br label %dst.addr.1947.exit

dst.addr.1947.exit:                               ; preds = %dst.addr.1947.case.3, %dst.addr.1947.case.2, %dst.addr.1947.case.1, %dst.addr.1947.case.0, %dst.addr.1845.exit
  %src.addr.2048 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %src, i64 0, i64 %for.loop.idx51, i32 20
  %533 = bitcast i1* %src.addr.2048 to i8*
  %534 = load i8, i8* %533
  %535 = trunc i8 %534 to i1
  switch i64 %for.loop.idx51, label %dst.addr.2049.exit [
    i64 0, label %dst.addr.2049.case.0
    i64 1, label %dst.addr.2049.case.1
    i64 2, label %dst.addr.2049.case.2
    i64 3, label %dst.addr.2049.case.3
  ]

dst.addr.2049.case.0:                             ; preds = %dst.addr.1947.exit
  %536 = bitcast i66* %dst_0 to i72*
  %537 = load i72, i72* %536
  %538 = trunc i72 %537 to i66
  %539 = zext i1 %535 to i66
  %540 = shl i66 %539, 65
  %541 = and i66 %538, 36893488147419103231
  %.partset63 = or i66 %541, %540
  store i66 %.partset63, i66* %dst_0, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.1:                             ; preds = %dst.addr.1947.exit
  %542 = bitcast i66* %dst_1 to i72*
  %543 = load i72, i72* %542
  %544 = trunc i72 %543 to i66
  %545 = zext i1 %535 to i66
  %546 = shl i66 %545, 65
  %547 = and i66 %544, 36893488147419103231
  %.partset62 = or i66 %547, %546
  store i66 %.partset62, i66* %dst_1, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.2:                             ; preds = %dst.addr.1947.exit
  %548 = bitcast i66* %dst_2 to i72*
  %549 = load i72, i72* %548
  %550 = trunc i72 %549 to i66
  %551 = zext i1 %535 to i66
  %552 = shl i66 %551, 65
  %553 = and i66 %550, 36893488147419103231
  %.partset21 = or i66 %553, %552
  store i66 %.partset21, i66* %dst_2, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.case.3:                             ; preds = %dst.addr.1947.exit
  %554 = bitcast i66* %dst_3 to i72*
  %555 = load i72, i72* %554
  %556 = trunc i72 %555 to i66
  %557 = zext i1 %535 to i66
  %558 = shl i66 %557, 65
  %559 = and i66 %556, 36893488147419103231
  %.partset20 = or i66 %559, %558
  store i66 %.partset20, i66* %dst_3, align 1
  br label %dst.addr.2049.exit

dst.addr.2049.exit:                               ; preds = %dst.addr.2049.case.3, %dst.addr.2049.case.2, %dst.addr.2049.case.1, %dst.addr.2049.case.0, %dst.addr.1947.exit
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %dst.addr.2049.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.10.13(i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0.0" %dst_0, i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0.1" %dst_1, i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0.2" %dst_2, i66* noalias align 512 "orig.arg.no"="0" "unpacked"="0.3" %dst_3, [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="1" %src) #1 {
entry:
  %0 = icmp eq i66* %dst_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.11.12(i66* nonnull %dst_0, i66* %dst_1, i66* %dst_2, i66* %dst_3, [4 x %struct.HeadCtx]* nonnull %src, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_in(i32* noalias readonly "orig.arg.no"="0", i32* noalias align 512 "orig.arg.no"="1", i1* noalias readonly "orig.arg.no"="2", i1* noalias align 512 "orig.arg.no"="3", i1* noalias readonly "orig.arg.no"="4", i1* noalias align 512 "orig.arg.no"="5", i1* noalias readonly "orig.arg.no"="6", i1* noalias align 512 "orig.arg.no"="7", i1* noalias readonly "orig.arg.no"="8", i1* noalias align 512 "orig.arg.no"="9", i32* noalias readonly "orig.arg.no"="10", i32* noalias align 512 "orig.arg.no"="11", i32* noalias readonly "orig.arg.no"="12", i32* noalias align 512 "orig.arg.no"="13", i32* noalias readonly "orig.arg.no"="14", i32* noalias align 512 "orig.arg.no"="15", i32* noalias readonly "orig.arg.no"="16", i32* noalias align 512 "orig.arg.no"="17", [4 x %struct.HeadCtx]* noalias readonly "orig.arg.no"="18", i66* noalias align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i66* noalias align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i66* noalias align 512 "orig.arg.no"="19" "unpacked"="19.2" %_2, i66* noalias align 512 "orig.arg.no"="19" "unpacked"="19.3" %_3, i1* noalias readonly "orig.arg.no"="20", i1* noalias align 512 "orig.arg.no"="21", i32* noalias readonly "orig.arg.no"="22", i32* noalias align 512 "orig.arg.no"="23", i1* noalias readonly "orig.arg.no"="24", i1* noalias align 512 "orig.arg.no"="25", i32* noalias readonly "orig.arg.no"="26", i32* noalias align 512 "orig.arg.no"="27", i1* noalias readonly "orig.arg.no"="28", i1* noalias align 512 "orig.arg.no"="29", i1* noalias readonly "orig.arg.no"="30", i1* noalias align 512 "orig.arg.no"="31", i32* noalias readonly "orig.arg.no"="32", i32* noalias align 512 "orig.arg.no"="33", i32* noalias readonly "orig.arg.no"="34", i32* noalias align 512 "orig.arg.no"="35") #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %1, i32* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %9, i1* %8)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %11, i32* %10)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %13, i32* %12)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %15, i32* %14)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %17, i32* %16)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.10.13(i66* align 512 %_0, i66* align 512 %_1, i66* align 512 %_2, i66* align 512 %_3, [4 x %struct.HeadCtx]* %18)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %20, i1* %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %22, i32* %21)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %24, i1* %23)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %26, i32* %25)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %28, i1* %27)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %30, i1* %29)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %32, i32* %31)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %34, i32* %33)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a4struct.HeadCtx.19.20([4 x %struct.HeadCtx]* "orig.arg.no"="0" %dst, i66* readonly "orig.arg.no"="1" "unpacked"="1.0" %src_0, i66* readonly "orig.arg.no"="1" "unpacked"="1.1" %src_1, i66* readonly "orig.arg.no"="1" "unpacked"="1.2" %src_2, i66* readonly "orig.arg.no"="1" "unpacked"="1.3" %src_3, i64 "orig.arg.no"="2" %num) #2 {
entry:
  %0 = icmp eq i66* %src_0, null
  %1 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond50 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond50, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %src.addr.2048.exit, %for.loop.lr.ph
  %for.loop.idx51 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %src.addr.2048.exit ]
  %dst.addr.02 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 0
  switch i64 %for.loop.idx51, label %src.addr.01.exit [
    i64 0, label %src.addr.01.case.0
    i64 1, label %src.addr.01.case.1
    i64 2, label %src.addr.01.case.2
    i64 3, label %src.addr.01.case.3
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

src.addr.01.case.2:                               ; preds = %for.loop
  %9 = bitcast i66* %src_2 to i72*
  %10 = load i72, i72* %9
  %11 = trunc i72 %10 to i66
  %_2.partselect = trunc i66 %11 to i32
  br label %src.addr.01.exit

src.addr.01.case.3:                               ; preds = %for.loop
  %12 = bitcast i66* %src_3 to i72*
  %13 = load i72, i72* %12
  %14 = trunc i72 %13 to i66
  %_3.partselect = trunc i66 %14 to i32
  br label %src.addr.01.exit

src.addr.01.exit:                                 ; preds = %src.addr.01.case.3, %src.addr.01.case.2, %src.addr.01.case.1, %src.addr.01.case.0, %for.loop
  %15 = phi i32 [ %_0.partselect, %src.addr.01.case.0 ], [ %_1.partselect, %src.addr.01.case.1 ], [ %_2.partselect, %src.addr.01.case.2 ], [ %_3.partselect, %src.addr.01.case.3 ], [ undef, %for.loop ]
  store i32 %15, i32* %dst.addr.02, align 4
  %dst.addr.111 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 1
  switch i64 %for.loop.idx51, label %src.addr.110.exit [
    i64 0, label %src.addr.110.case.0
    i64 1, label %src.addr.110.case.1
    i64 2, label %src.addr.110.case.2
    i64 3, label %src.addr.110.case.3
  ]

src.addr.110.case.0:                              ; preds = %src.addr.01.exit
  %16 = bitcast i66* %src_0 to i72*
  %17 = load i72, i72* %16
  %18 = trunc i72 %17 to i66
  %19 = lshr i66 %18, 32
  %_01.partselect = trunc i66 %19 to i8
  br label %src.addr.110.exit

src.addr.110.case.1:                              ; preds = %src.addr.01.exit
  %20 = bitcast i66* %src_1 to i72*
  %21 = load i72, i72* %20
  %22 = trunc i72 %21 to i66
  %23 = lshr i66 %22, 32
  %_12.partselect = trunc i66 %23 to i8
  br label %src.addr.110.exit

src.addr.110.case.2:                              ; preds = %src.addr.01.exit
  %24 = bitcast i66* %src_2 to i72*
  %25 = load i72, i72* %24
  %26 = trunc i72 %25 to i66
  %27 = lshr i66 %26, 32
  %_23.partselect = trunc i66 %27 to i8
  br label %src.addr.110.exit

src.addr.110.case.3:                              ; preds = %src.addr.01.exit
  %28 = bitcast i66* %src_3 to i72*
  %29 = load i72, i72* %28
  %30 = trunc i72 %29 to i66
  %31 = lshr i66 %30, 32
  %_34.partselect = trunc i66 %31 to i8
  br label %src.addr.110.exit

src.addr.110.exit:                                ; preds = %src.addr.110.case.3, %src.addr.110.case.2, %src.addr.110.case.1, %src.addr.110.case.0, %src.addr.01.exit
  %32 = phi i8 [ %_01.partselect, %src.addr.110.case.0 ], [ %_12.partselect, %src.addr.110.case.1 ], [ %_23.partselect, %src.addr.110.case.2 ], [ %_34.partselect, %src.addr.110.case.3 ], [ undef, %src.addr.01.exit ]
  store i8 %32, i8* %dst.addr.111, align 1
  %dst.addr.213 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 2
  switch i64 %for.loop.idx51, label %src.addr.212.exit [
    i64 0, label %src.addr.212.case.0
    i64 1, label %src.addr.212.case.1
    i64 2, label %src.addr.212.case.2
    i64 3, label %src.addr.212.case.3
  ]

src.addr.212.case.0:                              ; preds = %src.addr.110.exit
  %33 = bitcast i66* %src_0 to i72*
  %34 = load i72, i72* %33
  %35 = trunc i72 %34 to i66
  %36 = lshr i66 %35, 40
  %_05.partselect = trunc i66 %36 to i1
  br label %src.addr.212.exit

src.addr.212.case.1:                              ; preds = %src.addr.110.exit
  %37 = bitcast i66* %src_1 to i72*
  %38 = load i72, i72* %37
  %39 = trunc i72 %38 to i66
  %40 = lshr i66 %39, 40
  %_16.partselect = trunc i66 %40 to i1
  br label %src.addr.212.exit

src.addr.212.case.2:                              ; preds = %src.addr.110.exit
  %41 = bitcast i66* %src_2 to i72*
  %42 = load i72, i72* %41
  %43 = trunc i72 %42 to i66
  %44 = lshr i66 %43, 40
  %_27.partselect = trunc i66 %44 to i1
  br label %src.addr.212.exit

src.addr.212.case.3:                              ; preds = %src.addr.110.exit
  %45 = bitcast i66* %src_3 to i72*
  %46 = load i72, i72* %45
  %47 = trunc i72 %46 to i66
  %48 = lshr i66 %47, 40
  %_38.partselect = trunc i66 %48 to i1
  br label %src.addr.212.exit

src.addr.212.exit:                                ; preds = %src.addr.212.case.3, %src.addr.212.case.2, %src.addr.212.case.1, %src.addr.212.case.0, %src.addr.110.exit
  %49 = phi i1 [ %_05.partselect, %src.addr.212.case.0 ], [ %_16.partselect, %src.addr.212.case.1 ], [ %_27.partselect, %src.addr.212.case.2 ], [ %_38.partselect, %src.addr.212.case.3 ], [ undef, %src.addr.110.exit ]
  store i1 %49, i1* %dst.addr.213, align 1
  %dst.addr.315 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 3
  switch i64 %for.loop.idx51, label %src.addr.314.exit [
    i64 0, label %src.addr.314.case.0
    i64 1, label %src.addr.314.case.1
    i64 2, label %src.addr.314.case.2
    i64 3, label %src.addr.314.case.3
  ]

src.addr.314.case.0:                              ; preds = %src.addr.212.exit
  %50 = bitcast i66* %src_0 to i72*
  %51 = load i72, i72* %50
  %52 = trunc i72 %51 to i66
  %53 = lshr i66 %52, 41
  %_09.partselect = trunc i66 %53 to i1
  br label %src.addr.314.exit

src.addr.314.case.1:                              ; preds = %src.addr.212.exit
  %54 = bitcast i66* %src_1 to i72*
  %55 = load i72, i72* %54
  %56 = trunc i72 %55 to i66
  %57 = lshr i66 %56, 41
  %_110.partselect = trunc i66 %57 to i1
  br label %src.addr.314.exit

src.addr.314.case.2:                              ; preds = %src.addr.212.exit
  %58 = bitcast i66* %src_2 to i72*
  %59 = load i72, i72* %58
  %60 = trunc i72 %59 to i66
  %61 = lshr i66 %60, 41
  %_211.partselect = trunc i66 %61 to i1
  br label %src.addr.314.exit

src.addr.314.case.3:                              ; preds = %src.addr.212.exit
  %62 = bitcast i66* %src_3 to i72*
  %63 = load i72, i72* %62
  %64 = trunc i72 %63 to i66
  %65 = lshr i66 %64, 41
  %_312.partselect = trunc i66 %65 to i1
  br label %src.addr.314.exit

src.addr.314.exit:                                ; preds = %src.addr.314.case.3, %src.addr.314.case.2, %src.addr.314.case.1, %src.addr.314.case.0, %src.addr.212.exit
  %66 = phi i1 [ %_09.partselect, %src.addr.314.case.0 ], [ %_110.partselect, %src.addr.314.case.1 ], [ %_211.partselect, %src.addr.314.case.2 ], [ %_312.partselect, %src.addr.314.case.3 ], [ undef, %src.addr.212.exit ]
  store i1 %66, i1* %dst.addr.315, align 1
  %dst.addr.417 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 4
  switch i64 %for.loop.idx51, label %src.addr.416.exit [
    i64 0, label %src.addr.416.case.0
    i64 1, label %src.addr.416.case.1
    i64 2, label %src.addr.416.case.2
    i64 3, label %src.addr.416.case.3
  ]

src.addr.416.case.0:                              ; preds = %src.addr.314.exit
  %67 = bitcast i66* %src_0 to i72*
  %68 = load i72, i72* %67
  %69 = trunc i72 %68 to i66
  %70 = lshr i66 %69, 42
  %_013.partselect = trunc i66 %70 to i1
  br label %src.addr.416.exit

src.addr.416.case.1:                              ; preds = %src.addr.314.exit
  %71 = bitcast i66* %src_1 to i72*
  %72 = load i72, i72* %71
  %73 = trunc i72 %72 to i66
  %74 = lshr i66 %73, 42
  %_114.partselect = trunc i66 %74 to i1
  br label %src.addr.416.exit

src.addr.416.case.2:                              ; preds = %src.addr.314.exit
  %75 = bitcast i66* %src_2 to i72*
  %76 = load i72, i72* %75
  %77 = trunc i72 %76 to i66
  %78 = lshr i66 %77, 42
  %_215.partselect = trunc i66 %78 to i1
  br label %src.addr.416.exit

src.addr.416.case.3:                              ; preds = %src.addr.314.exit
  %79 = bitcast i66* %src_3 to i72*
  %80 = load i72, i72* %79
  %81 = trunc i72 %80 to i66
  %82 = lshr i66 %81, 42
  %_316.partselect = trunc i66 %82 to i1
  br label %src.addr.416.exit

src.addr.416.exit:                                ; preds = %src.addr.416.case.3, %src.addr.416.case.2, %src.addr.416.case.1, %src.addr.416.case.0, %src.addr.314.exit
  %83 = phi i1 [ %_013.partselect, %src.addr.416.case.0 ], [ %_114.partselect, %src.addr.416.case.1 ], [ %_215.partselect, %src.addr.416.case.2 ], [ %_316.partselect, %src.addr.416.case.3 ], [ undef, %src.addr.314.exit ]
  store i1 %83, i1* %dst.addr.417, align 1
  %dst.addr.519 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 5
  switch i64 %for.loop.idx51, label %src.addr.518.exit [
    i64 0, label %src.addr.518.case.0
    i64 1, label %src.addr.518.case.1
    i64 2, label %src.addr.518.case.2
    i64 3, label %src.addr.518.case.3
  ]

src.addr.518.case.0:                              ; preds = %src.addr.416.exit
  %84 = bitcast i66* %src_0 to i72*
  %85 = load i72, i72* %84
  %86 = trunc i72 %85 to i66
  %87 = lshr i66 %86, 43
  %_017.partselect = trunc i66 %87 to i8
  br label %src.addr.518.exit

src.addr.518.case.1:                              ; preds = %src.addr.416.exit
  %88 = bitcast i66* %src_1 to i72*
  %89 = load i72, i72* %88
  %90 = trunc i72 %89 to i66
  %91 = lshr i66 %90, 43
  %_118.partselect = trunc i66 %91 to i8
  br label %src.addr.518.exit

src.addr.518.case.2:                              ; preds = %src.addr.416.exit
  %92 = bitcast i66* %src_2 to i72*
  %93 = load i72, i72* %92
  %94 = trunc i72 %93 to i66
  %95 = lshr i66 %94, 43
  %_219.partselect = trunc i66 %95 to i8
  br label %src.addr.518.exit

src.addr.518.case.3:                              ; preds = %src.addr.416.exit
  %96 = bitcast i66* %src_3 to i72*
  %97 = load i72, i72* %96
  %98 = trunc i72 %97 to i66
  %99 = lshr i66 %98, 43
  %_320.partselect = trunc i66 %99 to i8
  br label %src.addr.518.exit

src.addr.518.exit:                                ; preds = %src.addr.518.case.3, %src.addr.518.case.2, %src.addr.518.case.1, %src.addr.518.case.0, %src.addr.416.exit
  %100 = phi i8 [ %_017.partselect, %src.addr.518.case.0 ], [ %_118.partselect, %src.addr.518.case.1 ], [ %_219.partselect, %src.addr.518.case.2 ], [ %_320.partselect, %src.addr.518.case.3 ], [ undef, %src.addr.416.exit ]
  store i8 %100, i8* %dst.addr.519, align 1
  %dst.addr.621 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 6
  switch i64 %for.loop.idx51, label %src.addr.620.exit [
    i64 0, label %src.addr.620.case.0
    i64 1, label %src.addr.620.case.1
    i64 2, label %src.addr.620.case.2
    i64 3, label %src.addr.620.case.3
  ]

src.addr.620.case.0:                              ; preds = %src.addr.518.exit
  %101 = bitcast i66* %src_0 to i72*
  %102 = load i72, i72* %101
  %103 = trunc i72 %102 to i66
  %104 = lshr i66 %103, 51
  %_021.partselect = trunc i66 %104 to i1
  br label %src.addr.620.exit

src.addr.620.case.1:                              ; preds = %src.addr.518.exit
  %105 = bitcast i66* %src_1 to i72*
  %106 = load i72, i72* %105
  %107 = trunc i72 %106 to i66
  %108 = lshr i66 %107, 51
  %_122.partselect = trunc i66 %108 to i1
  br label %src.addr.620.exit

src.addr.620.case.2:                              ; preds = %src.addr.518.exit
  %109 = bitcast i66* %src_2 to i72*
  %110 = load i72, i72* %109
  %111 = trunc i72 %110 to i66
  %112 = lshr i66 %111, 51
  %_223.partselect = trunc i66 %112 to i1
  br label %src.addr.620.exit

src.addr.620.case.3:                              ; preds = %src.addr.518.exit
  %113 = bitcast i66* %src_3 to i72*
  %114 = load i72, i72* %113
  %115 = trunc i72 %114 to i66
  %116 = lshr i66 %115, 51
  %_324.partselect = trunc i66 %116 to i1
  br label %src.addr.620.exit

src.addr.620.exit:                                ; preds = %src.addr.620.case.3, %src.addr.620.case.2, %src.addr.620.case.1, %src.addr.620.case.0, %src.addr.518.exit
  %117 = phi i1 [ %_021.partselect, %src.addr.620.case.0 ], [ %_122.partselect, %src.addr.620.case.1 ], [ %_223.partselect, %src.addr.620.case.2 ], [ %_324.partselect, %src.addr.620.case.3 ], [ undef, %src.addr.518.exit ]
  store i1 %117, i1* %dst.addr.621, align 1
  %dst.addr.723 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 7
  switch i64 %for.loop.idx51, label %src.addr.722.exit [
    i64 0, label %src.addr.722.case.0
    i64 1, label %src.addr.722.case.1
    i64 2, label %src.addr.722.case.2
    i64 3, label %src.addr.722.case.3
  ]

src.addr.722.case.0:                              ; preds = %src.addr.620.exit
  %118 = bitcast i66* %src_0 to i72*
  %119 = load i72, i72* %118
  %120 = trunc i72 %119 to i66
  %121 = lshr i66 %120, 52
  %_025.partselect = trunc i66 %121 to i1
  br label %src.addr.722.exit

src.addr.722.case.1:                              ; preds = %src.addr.620.exit
  %122 = bitcast i66* %src_1 to i72*
  %123 = load i72, i72* %122
  %124 = trunc i72 %123 to i66
  %125 = lshr i66 %124, 52
  %_126.partselect = trunc i66 %125 to i1
  br label %src.addr.722.exit

src.addr.722.case.2:                              ; preds = %src.addr.620.exit
  %126 = bitcast i66* %src_2 to i72*
  %127 = load i72, i72* %126
  %128 = trunc i72 %127 to i66
  %129 = lshr i66 %128, 52
  %_227.partselect = trunc i66 %129 to i1
  br label %src.addr.722.exit

src.addr.722.case.3:                              ; preds = %src.addr.620.exit
  %130 = bitcast i66* %src_3 to i72*
  %131 = load i72, i72* %130
  %132 = trunc i72 %131 to i66
  %133 = lshr i66 %132, 52
  %_328.partselect = trunc i66 %133 to i1
  br label %src.addr.722.exit

src.addr.722.exit:                                ; preds = %src.addr.722.case.3, %src.addr.722.case.2, %src.addr.722.case.1, %src.addr.722.case.0, %src.addr.620.exit
  %134 = phi i1 [ %_025.partselect, %src.addr.722.case.0 ], [ %_126.partselect, %src.addr.722.case.1 ], [ %_227.partselect, %src.addr.722.case.2 ], [ %_328.partselect, %src.addr.722.case.3 ], [ undef, %src.addr.620.exit ]
  store i1 %134, i1* %dst.addr.723, align 1
  %dst.addr.825 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 8
  switch i64 %for.loop.idx51, label %src.addr.824.exit [
    i64 0, label %src.addr.824.case.0
    i64 1, label %src.addr.824.case.1
    i64 2, label %src.addr.824.case.2
    i64 3, label %src.addr.824.case.3
  ]

src.addr.824.case.0:                              ; preds = %src.addr.722.exit
  %135 = bitcast i66* %src_0 to i72*
  %136 = load i72, i72* %135
  %137 = trunc i72 %136 to i66
  %138 = lshr i66 %137, 53
  %_029.partselect = trunc i66 %138 to i1
  br label %src.addr.824.exit

src.addr.824.case.1:                              ; preds = %src.addr.722.exit
  %139 = bitcast i66* %src_1 to i72*
  %140 = load i72, i72* %139
  %141 = trunc i72 %140 to i66
  %142 = lshr i66 %141, 53
  %_130.partselect = trunc i66 %142 to i1
  br label %src.addr.824.exit

src.addr.824.case.2:                              ; preds = %src.addr.722.exit
  %143 = bitcast i66* %src_2 to i72*
  %144 = load i72, i72* %143
  %145 = trunc i72 %144 to i66
  %146 = lshr i66 %145, 53
  %_231.partselect = trunc i66 %146 to i1
  br label %src.addr.824.exit

src.addr.824.case.3:                              ; preds = %src.addr.722.exit
  %147 = bitcast i66* %src_3 to i72*
  %148 = load i72, i72* %147
  %149 = trunc i72 %148 to i66
  %150 = lshr i66 %149, 53
  %_332.partselect = trunc i66 %150 to i1
  br label %src.addr.824.exit

src.addr.824.exit:                                ; preds = %src.addr.824.case.3, %src.addr.824.case.2, %src.addr.824.case.1, %src.addr.824.case.0, %src.addr.722.exit
  %151 = phi i1 [ %_029.partselect, %src.addr.824.case.0 ], [ %_130.partselect, %src.addr.824.case.1 ], [ %_231.partselect, %src.addr.824.case.2 ], [ %_332.partselect, %src.addr.824.case.3 ], [ undef, %src.addr.722.exit ]
  store i1 %151, i1* %dst.addr.825, align 1
  %dst.addr.927 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 9
  switch i64 %for.loop.idx51, label %src.addr.926.exit [
    i64 0, label %src.addr.926.case.0
    i64 1, label %src.addr.926.case.1
    i64 2, label %src.addr.926.case.2
    i64 3, label %src.addr.926.case.3
  ]

src.addr.926.case.0:                              ; preds = %src.addr.824.exit
  %152 = bitcast i66* %src_0 to i72*
  %153 = load i72, i72* %152
  %154 = trunc i72 %153 to i66
  %155 = lshr i66 %154, 54
  %_033.partselect = trunc i66 %155 to i1
  br label %src.addr.926.exit

src.addr.926.case.1:                              ; preds = %src.addr.824.exit
  %156 = bitcast i66* %src_1 to i72*
  %157 = load i72, i72* %156
  %158 = trunc i72 %157 to i66
  %159 = lshr i66 %158, 54
  %_134.partselect = trunc i66 %159 to i1
  br label %src.addr.926.exit

src.addr.926.case.2:                              ; preds = %src.addr.824.exit
  %160 = bitcast i66* %src_2 to i72*
  %161 = load i72, i72* %160
  %162 = trunc i72 %161 to i66
  %163 = lshr i66 %162, 54
  %_235.partselect = trunc i66 %163 to i1
  br label %src.addr.926.exit

src.addr.926.case.3:                              ; preds = %src.addr.824.exit
  %164 = bitcast i66* %src_3 to i72*
  %165 = load i72, i72* %164
  %166 = trunc i72 %165 to i66
  %167 = lshr i66 %166, 54
  %_336.partselect = trunc i66 %167 to i1
  br label %src.addr.926.exit

src.addr.926.exit:                                ; preds = %src.addr.926.case.3, %src.addr.926.case.2, %src.addr.926.case.1, %src.addr.926.case.0, %src.addr.824.exit
  %168 = phi i1 [ %_033.partselect, %src.addr.926.case.0 ], [ %_134.partselect, %src.addr.926.case.1 ], [ %_235.partselect, %src.addr.926.case.2 ], [ %_336.partselect, %src.addr.926.case.3 ], [ undef, %src.addr.824.exit ]
  store i1 %168, i1* %dst.addr.927, align 1
  %dst.addr.1029 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 10
  switch i64 %for.loop.idx51, label %src.addr.1028.exit [
    i64 0, label %src.addr.1028.case.0
    i64 1, label %src.addr.1028.case.1
    i64 2, label %src.addr.1028.case.2
    i64 3, label %src.addr.1028.case.3
  ]

src.addr.1028.case.0:                             ; preds = %src.addr.926.exit
  %169 = bitcast i66* %src_0 to i72*
  %170 = load i72, i72* %169
  %171 = trunc i72 %170 to i66
  %172 = lshr i66 %171, 55
  %_037.partselect = trunc i66 %172 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.1:                             ; preds = %src.addr.926.exit
  %173 = bitcast i66* %src_1 to i72*
  %174 = load i72, i72* %173
  %175 = trunc i72 %174 to i66
  %176 = lshr i66 %175, 55
  %_138.partselect = trunc i66 %176 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.2:                             ; preds = %src.addr.926.exit
  %177 = bitcast i66* %src_2 to i72*
  %178 = load i72, i72* %177
  %179 = trunc i72 %178 to i66
  %180 = lshr i66 %179, 55
  %_239.partselect = trunc i66 %180 to i1
  br label %src.addr.1028.exit

src.addr.1028.case.3:                             ; preds = %src.addr.926.exit
  %181 = bitcast i66* %src_3 to i72*
  %182 = load i72, i72* %181
  %183 = trunc i72 %182 to i66
  %184 = lshr i66 %183, 55
  %_340.partselect = trunc i66 %184 to i1
  br label %src.addr.1028.exit

src.addr.1028.exit:                               ; preds = %src.addr.1028.case.3, %src.addr.1028.case.2, %src.addr.1028.case.1, %src.addr.1028.case.0, %src.addr.926.exit
  %185 = phi i1 [ %_037.partselect, %src.addr.1028.case.0 ], [ %_138.partselect, %src.addr.1028.case.1 ], [ %_239.partselect, %src.addr.1028.case.2 ], [ %_340.partselect, %src.addr.1028.case.3 ], [ undef, %src.addr.926.exit ]
  store i1 %185, i1* %dst.addr.1029, align 1
  %dst.addr.1131 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 11
  switch i64 %for.loop.idx51, label %src.addr.1130.exit [
    i64 0, label %src.addr.1130.case.0
    i64 1, label %src.addr.1130.case.1
    i64 2, label %src.addr.1130.case.2
    i64 3, label %src.addr.1130.case.3
  ]

src.addr.1130.case.0:                             ; preds = %src.addr.1028.exit
  %186 = bitcast i66* %src_0 to i72*
  %187 = load i72, i72* %186
  %188 = trunc i72 %187 to i66
  %189 = lshr i66 %188, 56
  %_041.partselect = trunc i66 %189 to i1
  br label %src.addr.1130.exit

src.addr.1130.case.1:                             ; preds = %src.addr.1028.exit
  %190 = bitcast i66* %src_1 to i72*
  %191 = load i72, i72* %190
  %192 = trunc i72 %191 to i66
  %193 = lshr i66 %192, 56
  %_142.partselect = trunc i66 %193 to i1
  br label %src.addr.1130.exit

src.addr.1130.case.2:                             ; preds = %src.addr.1028.exit
  %194 = bitcast i66* %src_2 to i72*
  %195 = load i72, i72* %194
  %196 = trunc i72 %195 to i66
  %197 = lshr i66 %196, 56
  %_243.partselect = trunc i66 %197 to i1
  br label %src.addr.1130.exit

src.addr.1130.case.3:                             ; preds = %src.addr.1028.exit
  %198 = bitcast i66* %src_3 to i72*
  %199 = load i72, i72* %198
  %200 = trunc i72 %199 to i66
  %201 = lshr i66 %200, 56
  %_344.partselect = trunc i66 %201 to i1
  br label %src.addr.1130.exit

src.addr.1130.exit:                               ; preds = %src.addr.1130.case.3, %src.addr.1130.case.2, %src.addr.1130.case.1, %src.addr.1130.case.0, %src.addr.1028.exit
  %202 = phi i1 [ %_041.partselect, %src.addr.1130.case.0 ], [ %_142.partselect, %src.addr.1130.case.1 ], [ %_243.partselect, %src.addr.1130.case.2 ], [ %_344.partselect, %src.addr.1130.case.3 ], [ undef, %src.addr.1028.exit ]
  store i1 %202, i1* %dst.addr.1131, align 1
  %dst.addr.1233 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 12
  switch i64 %for.loop.idx51, label %src.addr.1232.exit [
    i64 0, label %src.addr.1232.case.0
    i64 1, label %src.addr.1232.case.1
    i64 2, label %src.addr.1232.case.2
    i64 3, label %src.addr.1232.case.3
  ]

src.addr.1232.case.0:                             ; preds = %src.addr.1130.exit
  %203 = bitcast i66* %src_0 to i72*
  %204 = load i72, i72* %203
  %205 = trunc i72 %204 to i66
  %206 = lshr i66 %205, 57
  %_045.partselect = trunc i66 %206 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.1:                             ; preds = %src.addr.1130.exit
  %207 = bitcast i66* %src_1 to i72*
  %208 = load i72, i72* %207
  %209 = trunc i72 %208 to i66
  %210 = lshr i66 %209, 57
  %_146.partselect = trunc i66 %210 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.2:                             ; preds = %src.addr.1130.exit
  %211 = bitcast i66* %src_2 to i72*
  %212 = load i72, i72* %211
  %213 = trunc i72 %212 to i66
  %214 = lshr i66 %213, 57
  %_247.partselect = trunc i66 %214 to i1
  br label %src.addr.1232.exit

src.addr.1232.case.3:                             ; preds = %src.addr.1130.exit
  %215 = bitcast i66* %src_3 to i72*
  %216 = load i72, i72* %215
  %217 = trunc i72 %216 to i66
  %218 = lshr i66 %217, 57
  %_348.partselect = trunc i66 %218 to i1
  br label %src.addr.1232.exit

src.addr.1232.exit:                               ; preds = %src.addr.1232.case.3, %src.addr.1232.case.2, %src.addr.1232.case.1, %src.addr.1232.case.0, %src.addr.1130.exit
  %219 = phi i1 [ %_045.partselect, %src.addr.1232.case.0 ], [ %_146.partselect, %src.addr.1232.case.1 ], [ %_247.partselect, %src.addr.1232.case.2 ], [ %_348.partselect, %src.addr.1232.case.3 ], [ undef, %src.addr.1130.exit ]
  store i1 %219, i1* %dst.addr.1233, align 1
  %dst.addr.1335 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 13
  switch i64 %for.loop.idx51, label %src.addr.1334.exit [
    i64 0, label %src.addr.1334.case.0
    i64 1, label %src.addr.1334.case.1
    i64 2, label %src.addr.1334.case.2
    i64 3, label %src.addr.1334.case.3
  ]

src.addr.1334.case.0:                             ; preds = %src.addr.1232.exit
  %220 = bitcast i66* %src_0 to i72*
  %221 = load i72, i72* %220
  %222 = trunc i72 %221 to i66
  %223 = lshr i66 %222, 58
  %_049.partselect = trunc i66 %223 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.1:                             ; preds = %src.addr.1232.exit
  %224 = bitcast i66* %src_1 to i72*
  %225 = load i72, i72* %224
  %226 = trunc i72 %225 to i66
  %227 = lshr i66 %226, 58
  %_150.partselect = trunc i66 %227 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.2:                             ; preds = %src.addr.1232.exit
  %228 = bitcast i66* %src_2 to i72*
  %229 = load i72, i72* %228
  %230 = trunc i72 %229 to i66
  %231 = lshr i66 %230, 58
  %_251.partselect = trunc i66 %231 to i1
  br label %src.addr.1334.exit

src.addr.1334.case.3:                             ; preds = %src.addr.1232.exit
  %232 = bitcast i66* %src_3 to i72*
  %233 = load i72, i72* %232
  %234 = trunc i72 %233 to i66
  %235 = lshr i66 %234, 58
  %_352.partselect = trunc i66 %235 to i1
  br label %src.addr.1334.exit

src.addr.1334.exit:                               ; preds = %src.addr.1334.case.3, %src.addr.1334.case.2, %src.addr.1334.case.1, %src.addr.1334.case.0, %src.addr.1232.exit
  %236 = phi i1 [ %_049.partselect, %src.addr.1334.case.0 ], [ %_150.partselect, %src.addr.1334.case.1 ], [ %_251.partselect, %src.addr.1334.case.2 ], [ %_352.partselect, %src.addr.1334.case.3 ], [ undef, %src.addr.1232.exit ]
  store i1 %236, i1* %dst.addr.1335, align 1
  %dst.addr.1437 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 14
  switch i64 %for.loop.idx51, label %src.addr.1436.exit [
    i64 0, label %src.addr.1436.case.0
    i64 1, label %src.addr.1436.case.1
    i64 2, label %src.addr.1436.case.2
    i64 3, label %src.addr.1436.case.3
  ]

src.addr.1436.case.0:                             ; preds = %src.addr.1334.exit
  %237 = bitcast i66* %src_0 to i72*
  %238 = load i72, i72* %237
  %239 = trunc i72 %238 to i66
  %240 = lshr i66 %239, 59
  %_053.partselect = trunc i66 %240 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.1:                             ; preds = %src.addr.1334.exit
  %241 = bitcast i66* %src_1 to i72*
  %242 = load i72, i72* %241
  %243 = trunc i72 %242 to i66
  %244 = lshr i66 %243, 59
  %_154.partselect = trunc i66 %244 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.2:                             ; preds = %src.addr.1334.exit
  %245 = bitcast i66* %src_2 to i72*
  %246 = load i72, i72* %245
  %247 = trunc i72 %246 to i66
  %248 = lshr i66 %247, 59
  %_255.partselect = trunc i66 %248 to i1
  br label %src.addr.1436.exit

src.addr.1436.case.3:                             ; preds = %src.addr.1334.exit
  %249 = bitcast i66* %src_3 to i72*
  %250 = load i72, i72* %249
  %251 = trunc i72 %250 to i66
  %252 = lshr i66 %251, 59
  %_356.partselect = trunc i66 %252 to i1
  br label %src.addr.1436.exit

src.addr.1436.exit:                               ; preds = %src.addr.1436.case.3, %src.addr.1436.case.2, %src.addr.1436.case.1, %src.addr.1436.case.0, %src.addr.1334.exit
  %253 = phi i1 [ %_053.partselect, %src.addr.1436.case.0 ], [ %_154.partselect, %src.addr.1436.case.1 ], [ %_255.partselect, %src.addr.1436.case.2 ], [ %_356.partselect, %src.addr.1436.case.3 ], [ undef, %src.addr.1334.exit ]
  store i1 %253, i1* %dst.addr.1437, align 1
  %dst.addr.1539 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 15
  switch i64 %for.loop.idx51, label %src.addr.1538.exit [
    i64 0, label %src.addr.1538.case.0
    i64 1, label %src.addr.1538.case.1
    i64 2, label %src.addr.1538.case.2
    i64 3, label %src.addr.1538.case.3
  ]

src.addr.1538.case.0:                             ; preds = %src.addr.1436.exit
  %254 = bitcast i66* %src_0 to i72*
  %255 = load i72, i72* %254
  %256 = trunc i72 %255 to i66
  %257 = lshr i66 %256, 60
  %_057.partselect = trunc i66 %257 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.1:                             ; preds = %src.addr.1436.exit
  %258 = bitcast i66* %src_1 to i72*
  %259 = load i72, i72* %258
  %260 = trunc i72 %259 to i66
  %261 = lshr i66 %260, 60
  %_158.partselect = trunc i66 %261 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.2:                             ; preds = %src.addr.1436.exit
  %262 = bitcast i66* %src_2 to i72*
  %263 = load i72, i72* %262
  %264 = trunc i72 %263 to i66
  %265 = lshr i66 %264, 60
  %_259.partselect = trunc i66 %265 to i1
  br label %src.addr.1538.exit

src.addr.1538.case.3:                             ; preds = %src.addr.1436.exit
  %266 = bitcast i66* %src_3 to i72*
  %267 = load i72, i72* %266
  %268 = trunc i72 %267 to i66
  %269 = lshr i66 %268, 60
  %_360.partselect = trunc i66 %269 to i1
  br label %src.addr.1538.exit

src.addr.1538.exit:                               ; preds = %src.addr.1538.case.3, %src.addr.1538.case.2, %src.addr.1538.case.1, %src.addr.1538.case.0, %src.addr.1436.exit
  %270 = phi i1 [ %_057.partselect, %src.addr.1538.case.0 ], [ %_158.partselect, %src.addr.1538.case.1 ], [ %_259.partselect, %src.addr.1538.case.2 ], [ %_360.partselect, %src.addr.1538.case.3 ], [ undef, %src.addr.1436.exit ]
  store i1 %270, i1* %dst.addr.1539, align 1
  %dst.addr.1641 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 16
  switch i64 %for.loop.idx51, label %src.addr.1640.exit [
    i64 0, label %src.addr.1640.case.0
    i64 1, label %src.addr.1640.case.1
    i64 2, label %src.addr.1640.case.2
    i64 3, label %src.addr.1640.case.3
  ]

src.addr.1640.case.0:                             ; preds = %src.addr.1538.exit
  %271 = bitcast i66* %src_0 to i72*
  %272 = load i72, i72* %271
  %273 = trunc i72 %272 to i66
  %274 = lshr i66 %273, 61
  %_061.partselect = trunc i66 %274 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.1:                             ; preds = %src.addr.1538.exit
  %275 = bitcast i66* %src_1 to i72*
  %276 = load i72, i72* %275
  %277 = trunc i72 %276 to i66
  %278 = lshr i66 %277, 61
  %_162.partselect = trunc i66 %278 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.2:                             ; preds = %src.addr.1538.exit
  %279 = bitcast i66* %src_2 to i72*
  %280 = load i72, i72* %279
  %281 = trunc i72 %280 to i66
  %282 = lshr i66 %281, 61
  %_263.partselect = trunc i66 %282 to i1
  br label %src.addr.1640.exit

src.addr.1640.case.3:                             ; preds = %src.addr.1538.exit
  %283 = bitcast i66* %src_3 to i72*
  %284 = load i72, i72* %283
  %285 = trunc i72 %284 to i66
  %286 = lshr i66 %285, 61
  %_364.partselect = trunc i66 %286 to i1
  br label %src.addr.1640.exit

src.addr.1640.exit:                               ; preds = %src.addr.1640.case.3, %src.addr.1640.case.2, %src.addr.1640.case.1, %src.addr.1640.case.0, %src.addr.1538.exit
  %287 = phi i1 [ %_061.partselect, %src.addr.1640.case.0 ], [ %_162.partselect, %src.addr.1640.case.1 ], [ %_263.partselect, %src.addr.1640.case.2 ], [ %_364.partselect, %src.addr.1640.case.3 ], [ undef, %src.addr.1538.exit ]
  store i1 %287, i1* %dst.addr.1641, align 1
  %dst.addr.1743 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 17
  switch i64 %for.loop.idx51, label %src.addr.1742.exit [
    i64 0, label %src.addr.1742.case.0
    i64 1, label %src.addr.1742.case.1
    i64 2, label %src.addr.1742.case.2
    i64 3, label %src.addr.1742.case.3
  ]

src.addr.1742.case.0:                             ; preds = %src.addr.1640.exit
  %288 = bitcast i66* %src_0 to i72*
  %289 = load i72, i72* %288
  %290 = trunc i72 %289 to i66
  %291 = lshr i66 %290, 62
  %_065.partselect = trunc i66 %291 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.1:                             ; preds = %src.addr.1640.exit
  %292 = bitcast i66* %src_1 to i72*
  %293 = load i72, i72* %292
  %294 = trunc i72 %293 to i66
  %295 = lshr i66 %294, 62
  %_166.partselect = trunc i66 %295 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.2:                             ; preds = %src.addr.1640.exit
  %296 = bitcast i66* %src_2 to i72*
  %297 = load i72, i72* %296
  %298 = trunc i72 %297 to i66
  %299 = lshr i66 %298, 62
  %_267.partselect = trunc i66 %299 to i1
  br label %src.addr.1742.exit

src.addr.1742.case.3:                             ; preds = %src.addr.1640.exit
  %300 = bitcast i66* %src_3 to i72*
  %301 = load i72, i72* %300
  %302 = trunc i72 %301 to i66
  %303 = lshr i66 %302, 62
  %_368.partselect = trunc i66 %303 to i1
  br label %src.addr.1742.exit

src.addr.1742.exit:                               ; preds = %src.addr.1742.case.3, %src.addr.1742.case.2, %src.addr.1742.case.1, %src.addr.1742.case.0, %src.addr.1640.exit
  %304 = phi i1 [ %_065.partselect, %src.addr.1742.case.0 ], [ %_166.partselect, %src.addr.1742.case.1 ], [ %_267.partselect, %src.addr.1742.case.2 ], [ %_368.partselect, %src.addr.1742.case.3 ], [ undef, %src.addr.1640.exit ]
  store i1 %304, i1* %dst.addr.1743, align 1
  %dst.addr.1845 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 18
  switch i64 %for.loop.idx51, label %src.addr.1844.exit [
    i64 0, label %src.addr.1844.case.0
    i64 1, label %src.addr.1844.case.1
    i64 2, label %src.addr.1844.case.2
    i64 3, label %src.addr.1844.case.3
  ]

src.addr.1844.case.0:                             ; preds = %src.addr.1742.exit
  %305 = bitcast i66* %src_0 to i72*
  %306 = load i72, i72* %305
  %307 = trunc i72 %306 to i66
  %308 = lshr i66 %307, 63
  %_069.partselect = trunc i66 %308 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.1:                             ; preds = %src.addr.1742.exit
  %309 = bitcast i66* %src_1 to i72*
  %310 = load i72, i72* %309
  %311 = trunc i72 %310 to i66
  %312 = lshr i66 %311, 63
  %_170.partselect = trunc i66 %312 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.2:                             ; preds = %src.addr.1742.exit
  %313 = bitcast i66* %src_2 to i72*
  %314 = load i72, i72* %313
  %315 = trunc i72 %314 to i66
  %316 = lshr i66 %315, 63
  %_271.partselect = trunc i66 %316 to i1
  br label %src.addr.1844.exit

src.addr.1844.case.3:                             ; preds = %src.addr.1742.exit
  %317 = bitcast i66* %src_3 to i72*
  %318 = load i72, i72* %317
  %319 = trunc i72 %318 to i66
  %320 = lshr i66 %319, 63
  %_372.partselect = trunc i66 %320 to i1
  br label %src.addr.1844.exit

src.addr.1844.exit:                               ; preds = %src.addr.1844.case.3, %src.addr.1844.case.2, %src.addr.1844.case.1, %src.addr.1844.case.0, %src.addr.1742.exit
  %321 = phi i1 [ %_069.partselect, %src.addr.1844.case.0 ], [ %_170.partselect, %src.addr.1844.case.1 ], [ %_271.partselect, %src.addr.1844.case.2 ], [ %_372.partselect, %src.addr.1844.case.3 ], [ undef, %src.addr.1742.exit ]
  store i1 %321, i1* %dst.addr.1845, align 1
  %dst.addr.1947 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 19
  switch i64 %for.loop.idx51, label %src.addr.1946.exit [
    i64 0, label %src.addr.1946.case.0
    i64 1, label %src.addr.1946.case.1
    i64 2, label %src.addr.1946.case.2
    i64 3, label %src.addr.1946.case.3
  ]

src.addr.1946.case.0:                             ; preds = %src.addr.1844.exit
  %322 = bitcast i66* %src_0 to i72*
  %323 = load i72, i72* %322
  %324 = trunc i72 %323 to i66
  %325 = lshr i66 %324, 64
  %_073.partselect = trunc i66 %325 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.1:                             ; preds = %src.addr.1844.exit
  %326 = bitcast i66* %src_1 to i72*
  %327 = load i72, i72* %326
  %328 = trunc i72 %327 to i66
  %329 = lshr i66 %328, 64
  %_174.partselect = trunc i66 %329 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.2:                             ; preds = %src.addr.1844.exit
  %330 = bitcast i66* %src_2 to i72*
  %331 = load i72, i72* %330
  %332 = trunc i72 %331 to i66
  %333 = lshr i66 %332, 64
  %_275.partselect = trunc i66 %333 to i1
  br label %src.addr.1946.exit

src.addr.1946.case.3:                             ; preds = %src.addr.1844.exit
  %334 = bitcast i66* %src_3 to i72*
  %335 = load i72, i72* %334
  %336 = trunc i72 %335 to i66
  %337 = lshr i66 %336, 64
  %_376.partselect = trunc i66 %337 to i1
  br label %src.addr.1946.exit

src.addr.1946.exit:                               ; preds = %src.addr.1946.case.3, %src.addr.1946.case.2, %src.addr.1946.case.1, %src.addr.1946.case.0, %src.addr.1844.exit
  %338 = phi i1 [ %_073.partselect, %src.addr.1946.case.0 ], [ %_174.partselect, %src.addr.1946.case.1 ], [ %_275.partselect, %src.addr.1946.case.2 ], [ %_376.partselect, %src.addr.1946.case.3 ], [ undef, %src.addr.1844.exit ]
  store i1 %338, i1* %dst.addr.1947, align 1
  %dst.addr.2049 = getelementptr [4 x %struct.HeadCtx], [4 x %struct.HeadCtx]* %dst, i64 0, i64 %for.loop.idx51, i32 20
  switch i64 %for.loop.idx51, label %src.addr.2048.exit [
    i64 0, label %src.addr.2048.case.0
    i64 1, label %src.addr.2048.case.1
    i64 2, label %src.addr.2048.case.2
    i64 3, label %src.addr.2048.case.3
  ]

src.addr.2048.case.0:                             ; preds = %src.addr.1946.exit
  %339 = bitcast i66* %src_0 to i72*
  %340 = load i72, i72* %339
  %341 = trunc i72 %340 to i66
  %342 = lshr i66 %341, 65
  %_077.partselect = trunc i66 %342 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.1:                             ; preds = %src.addr.1946.exit
  %343 = bitcast i66* %src_1 to i72*
  %344 = load i72, i72* %343
  %345 = trunc i72 %344 to i66
  %346 = lshr i66 %345, 65
  %_178.partselect = trunc i66 %346 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.2:                             ; preds = %src.addr.1946.exit
  %347 = bitcast i66* %src_2 to i72*
  %348 = load i72, i72* %347
  %349 = trunc i72 %348 to i66
  %350 = lshr i66 %349, 65
  %_279.partselect = trunc i66 %350 to i1
  br label %src.addr.2048.exit

src.addr.2048.case.3:                             ; preds = %src.addr.1946.exit
  %351 = bitcast i66* %src_3 to i72*
  %352 = load i72, i72* %351
  %353 = trunc i72 %352 to i66
  %354 = lshr i66 %353, 65
  %_380.partselect = trunc i66 %354 to i1
  br label %src.addr.2048.exit

src.addr.2048.exit:                               ; preds = %src.addr.2048.case.3, %src.addr.2048.case.2, %src.addr.2048.case.1, %src.addr.2048.case.0, %src.addr.1946.exit
  %355 = phi i1 [ %_077.partselect, %src.addr.2048.case.0 ], [ %_178.partselect, %src.addr.2048.case.1 ], [ %_279.partselect, %src.addr.2048.case.2 ], [ %_380.partselect, %src.addr.2048.case.3 ], [ undef, %src.addr.1946.exit ]
  store i1 %355, i1* %dst.addr.2049, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx51, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %src.addr.2048.exit, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @onebyonecpy_hls.p0a4struct.HeadCtx.18.21([4 x %struct.HeadCtx]* noalias "orig.arg.no"="0" %dst, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.0" %src_0, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.1" %src_1, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.2" %src_2, i66* noalias readonly align 512 "orig.arg.no"="1" "unpacked"="1.3" %src_3) #1 {
entry:
  %0 = icmp eq [4 x %struct.HeadCtx]* %dst, null
  %1 = icmp eq i66* %src_0, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a4struct.HeadCtx.19.20([4 x %struct.HeadCtx]* nonnull %dst, i66* nonnull %src_0, i66* %src_1, i66* %src_2, i66* %src_3, i64 4)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_out(i32* noalias "orig.arg.no"="0", i32* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i32* noalias "orig.arg.no"="12", i32* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="18", i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.2" %_2, i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.3" %_3, i1* noalias "orig.arg.no"="20", i1* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i1* noalias "orig.arg.no"="24", i1* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i1* noalias "orig.arg.no"="28", i1* noalias readonly align 512 "orig.arg.no"="29", i1* noalias "orig.arg.no"="30", i1* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* %0, i32* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %12, i32* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.18.21([4 x %struct.HeadCtx]* %18, i66* align 512 %_0, i66* align 512 %_1, i66* align 512 %_2, i66* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %19, i1* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %21, i32* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %23, i1* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %25, i32* align 512 %26)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %27, i1* align 512 %28)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %29, i1* align 512 %30)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %31, i32* align 512 %32)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %33, i32* align 512 %34)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @apatb_scheduler_hls_hw(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i32*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i66*, i66*, i66*, i66*, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*, i32*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal void @copy_back(i32* noalias "orig.arg.no"="0", i32* noalias readonly align 512 "orig.arg.no"="1", i1* noalias "orig.arg.no"="2", i1* noalias readonly align 512 "orig.arg.no"="3", i1* noalias "orig.arg.no"="4", i1* noalias readonly align 512 "orig.arg.no"="5", i1* noalias "orig.arg.no"="6", i1* noalias readonly align 512 "orig.arg.no"="7", i1* noalias "orig.arg.no"="8", i1* noalias readonly align 512 "orig.arg.no"="9", i32* noalias "orig.arg.no"="10", i32* noalias readonly align 512 "orig.arg.no"="11", i32* noalias "orig.arg.no"="12", i32* noalias readonly align 512 "orig.arg.no"="13", i32* noalias "orig.arg.no"="14", i32* noalias readonly align 512 "orig.arg.no"="15", i32* noalias "orig.arg.no"="16", i32* noalias readonly align 512 "orig.arg.no"="17", [4 x %struct.HeadCtx]* noalias "orig.arg.no"="18", i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.0" %_0, i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.1" %_1, i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.2" %_2, i66* noalias readonly align 512 "orig.arg.no"="19" "unpacked"="19.3" %_3, i1* noalias "orig.arg.no"="20", i1* noalias readonly align 512 "orig.arg.no"="21", i32* noalias "orig.arg.no"="22", i32* noalias readonly align 512 "orig.arg.no"="23", i1* noalias "orig.arg.no"="24", i1* noalias readonly align 512 "orig.arg.no"="25", i32* noalias "orig.arg.no"="26", i32* noalias readonly align 512 "orig.arg.no"="27", i1* noalias "orig.arg.no"="28", i1* noalias readonly align 512 "orig.arg.no"="29", i1* noalias "orig.arg.no"="30", i1* noalias readonly align 512 "orig.arg.no"="31", i32* noalias "orig.arg.no"="32", i32* noalias readonly align 512 "orig.arg.no"="33", i32* noalias "orig.arg.no"="34", i32* noalias readonly align 512 "orig.arg.no"="35") #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0i32(i32* %0, i32* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %10, i32* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %12, i32* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %14, i32* align 512 %15)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %16, i32* align 512 %17)
  call void @onebyonecpy_hls.p0a4struct.HeadCtx.18.21([4 x %struct.HeadCtx]* %18, i66* align 512 %_0, i66* align 512 %_1, i66* align 512 %_2, i66* align 512 %_3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %19, i1* align 512 %20)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %21, i32* align 512 %22)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %23, i1* align 512 %24)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %25, i32* align 512 %26)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %27, i1* align 512 %28)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %29, i1* align 512 %30)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %31, i32* align 512 %32)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %33, i32* align 512 %34)
  ret void
}

declare void @scheduler_hls_hw_stub(i1 zeroext, i1 zeroext, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, [4 x %struct.HeadCtx]* noalias nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull)

define void @scheduler_hls_hw_stub_wrapper(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i32*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i66*, i66*, i66*, i66*, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*, i32*) #5 {
entry:
  %33 = call i8* @malloc(i64 96)
  %34 = bitcast i8* %33 to [4 x %struct.HeadCtx]*
  call void @copy_out(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i32* null, i32* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %34, i66* %19, i66* %20, i66* %21, i66* %22, i1* null, i1* %23, i32* null, i32* %24, i1* null, i1* %25, i32* null, i32* %26, i1* null, i1* %28, i1* null, i1* %30, i32* null, i32* %31, i32* null, i32* %32)
  call void @scheduler_hls_hw_stub(i1 %0, i1 %1, i32* %2, i1* %3, i1* %4, i1 %5, i1 %6, i1* %7, i1 %8, i1* %9, i32* %10, i32* %11, i32* %12, i32* %13, i1 %14, i1 %15, i1 %16, i1 %17, i1 %18, [4 x %struct.HeadCtx]* %34, i1* %23, i32* %24, i1* %25, i32* %26, i1 %27, i1* %28, i1 %29, i1* %30, i32* %31, i32* %32)
  call void @copy_in(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i32* null, i32* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, [4 x %struct.HeadCtx]* %34, i66* %19, i66* %20, i66* %21, i66* %22, i1* null, i1* %23, i32* null, i32* %24, i1* null, i1* %25, i32* null, i32* %26, i1* null, i1* %28, i1* null, i1* %30, i32* null, i32* %31, i32* null, i32* %32)
  call void @free(i8* %33)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
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
!7 = !{!"19", [4 x %struct.HeadCtx]* null}
!8 = !{!9}
!9 = !{!"array_partition", !"type=Complete", !"dim=1"}
!10 = !{!11, !12, !13, !14}
!11 = !{!"19.0", %struct.HeadCtx* null}
!12 = !{!"19.1", %struct.HeadCtx* null}
!13 = !{!"19.2", %struct.HeadCtx* null}
!14 = !{!"19.3", %struct.HeadCtx* null}
