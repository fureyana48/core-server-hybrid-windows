# Windows Baseline Model

Every Windows installation is a separate baseline.

## Required identity

```text
Device
OS
Version / Build
System Drive
Boot Mode
Partition Style
Backup Root
```

## Required baseline categories

```text
00-IDENTITY
01-STORAGE
02-PARTITION
03-VOLUME
04-BOOT-EFI
05-POWER
06-SERVICES
07-NETWORK
08-ROUTING
```

Not every machine must have every category populated at v1.0.

Missing categories are recorded as pending instead of being guessed.
