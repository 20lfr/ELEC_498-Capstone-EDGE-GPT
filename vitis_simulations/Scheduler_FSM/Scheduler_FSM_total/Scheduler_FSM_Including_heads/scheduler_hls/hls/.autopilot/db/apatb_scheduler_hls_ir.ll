; ModuleID = '/home/luka/Scripting/ELEC_498-Capstone-LiteLM/vitis_simulations/Scheduler_FSM/Scheduler_FSM_total/Scheduler_FSM_Including_heads/scheduler_hls/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline willreturn
define void @apatb_scheduler_hls_ir(i1 zeroext %cntrl_start, i1 zeroext %cntrl_reset_n, i32* noalias nocapture nonnull dereferenceable(4) %cntrl_layer_idx, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_busy, i1* noalias nocapture nonnull dereferenceable(1) %cntrl_start_out, i1 zeroext %axis_in_valid, i1 zeroext %axis_in_last, i1* noalias nocapture nonnull dereferenceable(1) %axis_in_ready, i1 zeroext %wl_ready, i1* noalias nocapture nonnull dereferenceable(1) %wl_start, i32* noalias nocapture nonnull dereferenceable(4) %wl_addr_sel, i32* noalias nocapture nonnull dereferenceable(4) %wl_layer, i32* noalias nocapture nonnull dereferenceable(4) %wl_head, i32* noalias nocapture nonnull dereferenceable(4) %wl_tile, i1 zeroext %dma_done, i1 zeroext %compute_ready, i1 zeroext %compute_done, i1 zeroext %requant_ready, i1 zeroext %requant_done, i1* noalias nocapture nonnull dereferenceable(1) %compute_start, i32* noalias nocapture nonnull dereferenceable(4) %compute_op, i1* noalias nocapture nonnull dereferenceable(1) %requant_start, i32* noalias nocapture nonnull dereferenceable(4) %requant_op, i1 zeroext %stream_ready, i1* noalias nocapture nonnull dereferenceable(1) %stream_start, i1 zeroext %stream_done, i1* noalias nocapture nonnull dereferenceable(1) %done, i32* noalias nocapture nonnull dereferenceable(4) %STATE) local_unnamed_addr #0 {
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
  %compute_start_copy = alloca i1, align 512
  %compute_op_copy = alloca i32, align 512
  %requant_start_copy = alloca i1, align 512
  %requant_op_copy = alloca i32, align 512
  %stream_start_copy = alloca i1, align 512
  %done_copy = alloca i1, align 512
  %STATE_copy = alloca i32, align 512
  call fastcc void @copy_in(i32* nonnull %cntrl_layer_idx, i32* nonnull align 512 %cntrl_layer_idx_copy, i1* nonnull %cntrl_busy, i1* nonnull align 512 %cntrl_busy_copy, i1* nonnull %cntrl_start_out, i1* nonnull align 512 %cntrl_start_out_copy, i1* nonnull %axis_in_ready, i1* nonnull align 512 %axis_in_ready_copy, i1* nonnull %wl_start, i1* nonnull align 512 %wl_start_copy, i32* nonnull %wl_addr_sel, i32* nonnull align 512 %wl_addr_sel_copy, i32* nonnull %wl_layer, i32* nonnull align 512 %wl_layer_copy, i32* nonnull %wl_head, i32* nonnull align 512 %wl_head_copy, i32* nonnull %wl_tile, i32* nonnull align 512 %wl_tile_copy, i1* nonnull %compute_start, i1* nonnull align 512 %compute_start_copy, i32* nonnull %compute_op, i32* nonnull align 512 %compute_op_copy, i1* nonnull %requant_start, i1* nonnull align 512 %requant_start_copy, i32* nonnull %requant_op, i32* nonnull align 512 %requant_op_copy, i1* nonnull %stream_start, i1* nonnull align 512 %stream_start_copy, i1* nonnull %done, i1* nonnull align 512 %done_copy, i32* nonnull %STATE, i32* nonnull align 512 %STATE_copy)
  call void @apatb_scheduler_hls_hw(i1 %cntrl_start, i1 %cntrl_reset_n, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy_copy, i1* %cntrl_start_out_copy, i1 %axis_in_valid, i1 %axis_in_last, i1* %axis_in_ready_copy, i1 %wl_ready, i1* %wl_start_copy, i32* %wl_addr_sel_copy, i32* %wl_layer_copy, i32* %wl_head_copy, i32* %wl_tile_copy, i1 %dma_done, i1 %compute_ready, i1 %compute_done, i1 %requant_ready, i1 %requant_done, i1* %compute_start_copy, i32* %compute_op_copy, i1* %requant_start_copy, i32* %requant_op_copy, i1 %stream_ready, i1* %stream_start_copy, i1 %stream_done, i1* %done_copy, i32* %STATE_copy)
  call void @copy_back(i32* %cntrl_layer_idx, i32* %cntrl_layer_idx_copy, i1* %cntrl_busy, i1* %cntrl_busy_copy, i1* %cntrl_start_out, i1* %cntrl_start_out_copy, i1* %axis_in_ready, i1* %axis_in_ready_copy, i1* %wl_start, i1* %wl_start_copy, i32* %wl_addr_sel, i32* %wl_addr_sel_copy, i32* %wl_layer, i32* %wl_layer_copy, i32* %wl_head, i32* %wl_head_copy, i32* %wl_tile, i32* %wl_tile_copy, i1* %compute_start, i1* %compute_start_copy, i32* %compute_op, i32* %compute_op_copy, i1* %requant_start, i1* %requant_start_copy, i32* %requant_op, i32* %requant_op_copy, i1* %stream_start, i1* %stream_start_copy, i1* %done, i1* %done_copy, i32* %STATE, i32* %STATE_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(i32* noalias readonly, i32* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512, i32* noalias readonly, i32* noalias align 512, i32* noalias readonly, i32* noalias align 512, i32* noalias readonly, i32* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i32* noalias readonly, i32* noalias align 512) unnamed_addr #1 {
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %19, i1* %18)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %21, i32* %20)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %23, i1* %22)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %25, i32* %24)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %27, i1* %26)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %29, i1* %28)
  call fastcc void @onebyonecpy_hls.p0i32(i32* align 512 %31, i32* %30)
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
define internal fastcc void @copy_out(i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512) unnamed_addr #3 {
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* %18, i1* align 512 %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %20, i32* align 512 %21)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %22, i1* align 512 %23)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %24, i32* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %26, i1* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %28, i1* align 512 %29)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %30, i32* align 512 %31)
  ret void
}

declare void @apatb_scheduler_hls_hw(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i32*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i32* noalias, i32* noalias readonly align 512) unnamed_addr #3 {
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
  call fastcc void @onebyonecpy_hls.p0i1(i1* %18, i1* align 512 %19)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %20, i32* align 512 %21)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %22, i1* align 512 %23)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %24, i32* align 512 %25)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %26, i1* align 512 %27)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %28, i1* align 512 %29)
  call fastcc void @onebyonecpy_hls.p0i32(i32* %30, i32* align 512 %31)
  ret void
}

declare void @scheduler_hls_hw_stub(i1 zeroext, i1 zeroext, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i1 zeroext, i1* noalias nocapture nonnull, i32* noalias nocapture nonnull)

define void @scheduler_hls_hw_stub_wrapper(i1, i1, i32*, i1*, i1*, i1, i1, i1*, i1, i1*, i32*, i32*, i32*, i32*, i1, i1, i1, i1, i1, i1*, i32*, i1*, i32*, i1, i1*, i1, i1*, i32*) #4 {
entry:
  call void @copy_out(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i32* null, i32* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, i1* null, i1* %19, i32* null, i32* %20, i1* null, i1* %21, i32* null, i32* %22, i1* null, i1* %24, i1* null, i1* %26, i32* null, i32* %27)
  call void @scheduler_hls_hw_stub(i1 %0, i1 %1, i32* %2, i1* %3, i1* %4, i1 %5, i1 %6, i1* %7, i1 %8, i1* %9, i32* %10, i32* %11, i32* %12, i32* %13, i1 %14, i1 %15, i1 %16, i1 %17, i1 %18, i1* %19, i32* %20, i1* %21, i32* %22, i1 %23, i1* %24, i1 %25, i1* %26, i32* %27)
  call void @copy_in(i32* null, i32* %2, i1* null, i1* %3, i1* null, i1* %4, i1* null, i1* %7, i1* null, i1* %9, i32* null, i32* %10, i32* null, i32* %11, i32* null, i32* %12, i32* null, i32* %13, i1* null, i1* %19, i32* null, i32* %20, i1* null, i1* %21, i32* null, i32* %22, i1* null, i1* %24, i1* null, i1* %26, i32* null, i32* %27)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #4 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
