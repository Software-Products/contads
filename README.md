# Continuous ADS

Continuous ADS (ContADS.exe) is an Windows executable utility that provides UI-driven approach to automate file telemetry re-play with the ATLAS Data Server. 

## Stack

Written in [AutoIt](https://www.autoitscript.com/site/autoit/downloads/) script, it is a simple, standalone program which can be used as the basis to create further automation steps if needed. 

## Usage

1. Download [AutoIt](https://www.autoitscript.com/site/autoit/downloads/) and compile the script `ContADS.au3`, this will create the exectuable `ContADS.exe` in the same directory; the copy the executable to the machine where `ATLAS Data Server` is installed.
2. Copy the raw telemetry files - both `.raw` and corresponding `.raw_tm` files into a local directory where the `ATLAS Data Server` is installed, e.g. `C:\raw\`
3. Create a `.txt` file which contains the list of telemetry files to be replayed, e.g. `day1.txt:`
   ```
   C:\raw\session 1.raw_tm
   C:\raw\session 2.raw_tm
   C:\raw\session 3.raw_tm
   C:\raw\session 4.raw_tm
   C:\raw\session 5.raw_tm
   ...
   ```
4. Run `ContADS.exe day1.txt`

## Notes
- `ATLAS Data Server` should already be configured to play telemetry files.
- If `ATLAS Data Server` is already running before `ContADS.exe` the script will wait until `ATLAS Data Server` is back in focus, this can be done by manually clicking so it is at the forefront.
- `ContADS.exe` runs as a seperate windows process until termination, in order to stop/kill it at any other point, end the process using `Process Explorer`.
