# Maps for Counter-Strike 1.6

Self-made Counter-Strike 1.6 map sources and compile scripts/tools for ***linux***.

Probably only useful to myself.

## Installation
1. Install QuArK (6.6)
2. Install Steam and Counter-Strike 1.6 
3. Init for QuArK (`setup.sh` expects QuArK 6.6)
```
cd quark
./setup.sh
```
4. Start QuArK
    * `Edit -> Configuration -> Games/Half-Life`
        * `Directory of Half-Life` to `quark/Half-Life` under this folder
        * `Add-ons...` add `duges.qrk`

## Compile
```sh
./compile.sh <map> <fast|final|leak> [run]
```
