# wiiu-wudump-cemu-keygen
Generate Cemu-compatible keys.txt files from Wii U WUDump game.key files.  This tool recursively scans Wii U WUD dump folders, finds matching game.key and .wud files, creates a per-game keys.txt beside each dump, and also builds one master keys.txt for use with Cemu.


# WUDump Cemu Keygen

Generate Cemu-compatible `keys.txt` files from Wii U WUDump `game.key` files.

This is a small Windows helper script for people who have dumped their own Wii U discs as WUD files and want to create the matching Cemu `keys.txt` entries.

## Platform

This tool is for **Windows**.

It uses:

- Windows batch (`.bat`)
- Windows PowerShell (`.ps1`)

Tested/intended for Windows 10/11.

## What it does

The script recursively scans a root folder for Wii U WUD dump folders containing:

game.key
*.wud

For each valid folder, it creates:

keys.txt

inside that same folder.

It also creates one master:

keys.txt

in the root folder where the script is run.

Expected folder structure

Place these two script files in the root folder above your Wii U WUD dumps:

make_all_cemu_keys.bat
make_all_cemu_keys.ps1

Example:

```text
Wii U WUD Dumps/
├── make_all_cemu_keys.bat
├── make_all_cemu_keys.ps1
│
├── Mario Kart 8/
│   └── WUP-P-AMKP/
│       ├── game.key
│       └── Mario Kart 8 (Europe) (En,Fr,De,Es,It,Nl,Pt,Ru).wud
│
└── Super Mario 3D World/
    └── WUP-P-ARDP/
        ├── game.key
        └── Super Mario 3D World (Europe) (En,Fr,De,Es,It,Nl,Pt,Ru) (Rev 1).wud
```

The script looks for game.key, then checks whether there is exactly one .wud file in the same folder.

The .wud filename is used as the comment after #.

## Output example

If a folder contains:
```text
game.key
Mario Kart 8 (Europe) (En,Fr,De,Es,It,Nl,Pt,Ru).wud
```
The generated keys.txt line will look like:
```text
0123456789abcdef0123456789abcdef # Mario Kart 8 (Europe) (En,Fr,De,Es,It,Nl,Pt,Ru)
```
The first part is the 32-character key generated from game.key.

The part after # comes from the .wud filename.

## Generated files

After running the script, your folder may look like this:
```text
Wii U WUD Dumps/
├── keys.txt
├── cemu_key_generator_log.txt
├── make_all_cemu_keys.bat
├── make_all_cemu_keys.ps1
│
├── Mario Kart 8/
│   └── WUP-P-AMKP/
│       ├── game.key
│       ├── Mario Kart 8 (Europe) (En,Fr,De,Es,It,Nl,Pt,Ru).wud
│       └── keys.txt
│
└── Super Mario 3D World/
    └── WUP-P-ARDP/
        ├── game.key
        ├── Super Mario 3D World (Europe) (En,Fr,De,Es,It,Nl,Pt,Ru) (Rev 1).wud
        └── keys.txt
```
The root keys.txt is the master file containing all generated key lines.

## How to use
Put make_all_cemu_keys.bat and make_all_cemu_keys.ps1 in the root folder above your WUD dump folders.

Make sure each game dump folder contains:
```text
game.key
one .wud file
```
1) Double-click:
```text
make_all_cemu_keys.bat
```
The script will scan all subfolders.

2) Copy the root keys.txt into your Cemu folder, or copy its contents into your existing Cemu keys.txt.

## Important notes
* This is for WUD/WUX-style Cemu key entries.
* game.key must be exactly 16 bytes.
* Each folder must contain exactly one .wud file beside game.key.
* If no .wud file is found beside game.key, that folder is skipped.
* If more than one .wud file is found in the same folder, that folder is skipped.
* Folder names are ignored.
* The .wud filename is used for the comment after #.
* The root keys.txt is overwritten each time the script runs.
* Per-game keys.txt files are also overwritten.
* The script does not modify, delete, rename, or edit any .wud files.

A log file is written to:

cemu_key_generator_log.txt

## Legal note

This tool is intended only for use with Wii U discs and keys that you have dumped from your own console and games.

It does not include, download, generate, or provide Wii U common keys, title keys, game keys, game data, or copyrighted content.
