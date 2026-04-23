This is our project for CS 3110.

Team Members:
Aayan Hussain (ah2425)
Bryan Shao (bs887)
Nhat Minh (Kevin) (nt428)

## Setup

### macOS

1. Install XQuartz (required for the graphics library):
   - Download and run the `.pkg` from https://www.xquartz.org
   - Log out and back in after installing
2. Install the graphics library:
   ```
   opam install graphics
   ```
3. Build and run:
   ```
   dune exec bin/main.exe
   ```

### Windows (WSL)

1. Enable WSLg (Windows 11) or install VcXsrv (Windows 10):
   - **Windows 11**: WSLg is built in, no extra steps needed
   - **Windows 10**: Download and run [VcXsrv](https://sourceforge.net/projects/vcxsrv/), then add this to your `~/.bashrc`:
     ```
     export DISPLAY=:0
     ```
2. Install the graphics library inside WSL:
   ```
   sudo apt install libx11-dev
   opam install graphics
   ```
3. Build and run:
   ```
   dune exec bin/main.exe
   ```
