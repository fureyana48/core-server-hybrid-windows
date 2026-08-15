# Backup Strategy

## 1. Configuration baseline

The PowerShell workflow captures the machine's current state into a structured directory.

Current pattern:

```text
<BACKUP-DRIVE>:\SERVER-BACKUP\<DEVICE>\<WIN10|WIN11>\MASTER-BACKUP
```

This keeps Windows 10 and Windows 11 independent.

## 2. System image

A full restoration requires a disk/system image or clone.

The `wbAdmin` experiment for T540p Windows 11 was not accepted as the final image workflow because the selected destination was rejected as an unsupported backup location.

That workflow is therefore **PENDING / NOT THE AUTHORITATIVE METHOD**.

## 3. Imaging tool

Macrium Reflect is an acceptable candidate for the full-image layer.

The exact imaging workflow is intentionally left pending until it is tested and verified.

## 4. Recovery principle

Never assume that a text baseline can restore an operating system by itself.

Baseline = reconstruction reference.

System image = restoration mechanism.
