# Architecture Overview

## Core concept

The environment is organized around physical ThinkPad nodes, with each Windows installation treated as an independent configuration baseline.

```text
                    CORE SERVER / HYBRID WINDOWS
                              |
        +---------------------+---------------------+
        |                     |                     |
      T540p                  A475                  W530
        |                     |                     |
   +----+----+           +----+----+           +----+----+
   |         |           |         |           |         |
 Win10     Win11       Win10     Win11       Win10     Win11
```

The repository records **state and procedure**, not private machine data.

## Baseline layers

### Layer 1 — Identity

- manufacturer/model
- Windows edition/version/build
- BIOS/UEFI information

### Layer 2 — Storage

- physical disks
- partition layout
- volumes
- EFI/recovery information

### Layer 3 — Core operating behavior

- boot/BCD
- power plans
- sleep/lid behavior
- services

### Layer 4 — Network

- adapters
- network profiles
- IP configuration
- interface metrics
- routing

### Layer 5 — Recovery

- configuration reconstruction
- boot recovery
- verified image restoration

## Rule

A configuration capture is evidence of system state. It is not automatically a restore point or a disk image.
