#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <stdint.h>

// ==========================================
// ADDRESS DEFINITIONS (Check your Vivado Address Editor!)
// ==========================================
#define DMA_BASE_ADDR       0x80000000  // Base Address of AXI DMA
#define DDR_BASE_ADDR       0x10000000  // A safe place in DDR for data
#define TX_BUFFER_OFFSET    0x00100000
#define RX_BUFFER_OFFSET    0x00200000

// AXI DMA Register Offsets
#define MM2S_DMACR          0x00  // MM2S Control
#define MM2S_DMASR          0x04  // MM2S Status
#define MM2S_SA             0x18  // MM2S Source Address
#define MM2S_LENGTH         0x28  // MM2S Transfer Length

#define S2MM_DMACR          0x30  // S2MM Control
#define S2MM_DMASR          0x34  // S2MM Status
#define S2MM_DA             0x48  // S2MM Dest Address
#define S2MM_LENGTH         0x58  // S2MM Buffer Length

#define MAP_SIZE            0x10000 // 64KB map size

// Helper to write to a register
void reg_write(void *base, int offset, uint32_t value) {
    *((volatile uint32_t *)(base + offset)) = value;
}

// Helper to read a register
uint32_t reg_read(void *base, int offset) {
    return *((volatile uint32_t *)(base + offset));
}

int main() {
    int mem_fd;
    void *dma_vptr;
    void *ddr_vptr;

    printf("--- Linux Userspace DMA Loopback Test ---\n");

    // 1. Open /dev/mem
    if ((mem_fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
        perror("Can't open /dev/mem");
        return -1;
    }

    // 2. Map the DMA Registers
    dma_vptr = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, DMA_BASE_ADDR);
    if (dma_vptr == MAP_FAILED) {
        perror("Can't map DMA registers");
        return -1;
    }

    // 3. Map the DDR Memory (for Data Buffers)
    // Note: In a real production system, you should use CMA (Contiguous Memory Allocator) 
    // or a UIO driver, but for a quick test on Kria/Ubuntu, this usually works if the RAM is reserved.
    // If this fails, try a higher address or use 'udmabuf'.
    ddr_vptr = mmap(0, 0x400000, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, DDR_BASE_ADDR);
    if (ddr_vptr == MAP_FAILED) {
        perror("Can't map DDR memory");
        return -1;
    }

    // Create pointers for our buffers in Virtual Space
    uint32_t *tx_buffer = (uint32_t *)(ddr_vptr + TX_BUFFER_OFFSET);
    uint32_t *rx_buffer = (uint32_t *)(ddr_vptr + RX_BUFFER_OFFSET);
    
    // Physical addresses to give to the DMA
    uint32_t tx_phys = DDR_BASE_ADDR + TX_BUFFER_OFFSET;
    uint32_t rx_phys = DDR_BASE_ADDR + RX_BUFFER_OFFSET;

    // 4. Reset DMA
    reg_write(dma_vptr, MM2S_DMACR, 0x4); // Reset MM2S
    reg_write(dma_vptr, S2MM_DMACR, 0x4); // Reset S2MM
    usleep(1000); // Wait for reset

    // 5. Start DMA Channels (Set Run/Stop bit to 1)
    reg_write(dma_vptr, MM2S_DMACR, 0x1); // Start MM2S
    reg_write(dma_vptr, S2MM_DMACR, 0x1); // Start S2MM

    // 6. Prepare Data
    for (int i = 0; i < 32; i++) {
        tx_buffer[i] = 0xDEAD0000 + i;
        rx_buffer[i] = 0x00000000;
    }

    // 7. Start Transfer
    // Important: Setup S2MM (Receive) FIRST
    printf("Starting S2MM (Receive)...\n");
    reg_write(dma_vptr, S2MM_DA, rx_phys);     // Dest Address
    reg_write(dma_vptr, S2MM_LENGTH, 128);     // Length (bytes) - Kicks off S2MM

    printf("Starting MM2S (Send)...\n");
    reg_write(dma_vptr, MM2S_SA, tx_phys);     // Source Address
    reg_write(dma_vptr, MM2S_LENGTH, 128);     // Length (bytes) - Kicks off MM2S

    // 8. Poll for Completion
    printf("Waiting for completion...\n");
    while (!(reg_read(dma_vptr, MM2S_DMASR) & 0x1000)); // Wait for IOC_Irq (Idle)
    while (!(reg_read(dma_vptr, S2MM_DMASR) & 0x1000)); // Wait for IOC_Irq (Idle)

    // 9. Verify
    int errors = 0;
    for (int i = 0; i < 32; i++) {
        if (rx_buffer[i] != tx_buffer[i]) {
            printf("Error at %d: Got %x, Expected %x\n", i, rx_buffer[i], tx_buffer[i]);
            errors++;
        }
    }

    if (errors == 0) printf("Test PASSED!\n");
    else printf("Test FAILED with %d errors.\n", errors);

    // Cleanup
    munmap(dma_vptr, MAP_SIZE);
    munmap(ddr_vptr, 0x400000);
    close(mem_fd);

    return 0;
}