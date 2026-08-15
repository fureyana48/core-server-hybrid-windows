# Recovery Procedure

## Status

**PENDING physical verification**

This document defines the intended recovery order without claiming that every step has already been tested.

## Recovery order

1. Confirm the target ThinkPad.
2. Confirm Windows 10 or Windows 11.
3. Confirm target disk and partition topology.
4. Restore the verified system image when available.
5. Verify UEFI/GPT/EFI layout.
6. Verify BCD/boot entries.
7. Verify storage volumes.
8. Verify power configuration.
9. Verify required services.
10. Verify network adapters and routing.
11. Compare the restored machine against its baseline.
12. Record deviations.

## Boot recovery

The repository contains references for BCD and EFI state.

A boot repair command set should only be published as an authoritative procedure after testing on the relevant machine.

## Image restoration

The actual image restoration process is intentionally pending until an imaging solution is selected and a restore test is completed.
