# Core Server Hybrid Windows

**Version:** 1.0.0  
**Release target:** 17 August 2026  
**Status:** Initial portfolio release / baseline documentation

A practical documentation and recovery-oriented configuration repository for a hybrid Windows environment built around older Lenovo ThinkPad hardware.

The project focuses on **repeatability, configuration visibility, backup discipline, and recovery readiness** rather than on blindly applying tweaks.

## Scope

Current documented hardware:

- Lenovo ThinkPad T540p
- Lenovo ThinkPad A475
- Lenovo ThinkPad W530

Windows installations are treated as **independent baselines**:

```text
T540p
├── Windows 10
└── Windows 11

A475
├── Windows 10
└── Windows 11

W530
├── Windows 10
└── Windows 11
```

Windows 10 and Windows 11 must never share the same backup destination or baseline directory.

## Design principles

1. **Separate machine identity from OS identity.**
2. **Separate Windows 10 from Windows 11.**
3. **Capture before changing.**
4. **Prefer reversible configuration changes.**
5. **Keep the core stable; defer non-essential work.**
6. **Use configuration baselines for rebuild/recovery guidance.**
7. **Use a real disk/image backup for full-system restoration.**

## Important backup distinction

The PowerShell baseline captures in this project are **configuration records**, not complete system images.

Examples:

- disk and partition inventory
- volume inventory
- EFI/boot information
- BCD configuration
- power configuration
- services
- network adapters/profiles/IP configuration
- routing

A configuration baseline can help reconstruct a system, but it does **not** replace a full disk/system image.

For full restoration, use an appropriate imaging/cloning solution such as Macrium Reflect or another verified imaging workflow.

## Current backup destinations

### T540p

```text
E:\SERVER-BACKUP\T540P\WIN10
E:\SERVER-BACKUP\T540P\WIN11
```

### A475

```text
D:\SERVER-BACKUP\A475\WIN10
D:\SERVER-BACKUP\A475\WIN11
```

### W530

Windows 10 and Windows 11 backups are maintained separately.

The exact W530 destination details remain a pending documentation item if they are not yet recorded in this repository.

## Repository layout

```text
core-server-hybrid-windows/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── docs/
│   ├── architecture/
│   ├── backup/
│   ├── recovery/
│   ├── hardware/
│   └── windows/
│       ├── win10/
│       └── win11/
├── configs/
│   ├── a475/
│   │   ├── win10/
│   │   └── win11/
│   ├── t540p/
│   │   ├── win10/
│   │   └── win11/
│   └── w530/
│       ├── win10/
│       └── win11/
└── scripts/
    ├── backup/
    ├── inventory/
    ├── network/
    ├── power/
    └── recovery/
```

## v1.0 boundary

v1.0 intentionally documents what is already captured and leaves incomplete work explicitly marked as **PENDING** rather than inventing values.

Planned later work includes:

- verified full-disk image/restore procedures
- complete W530 baseline transcription
- more Windows service/network documentation
- automated validation
- restore drills
- release automation
- screenshots and architecture diagrams
