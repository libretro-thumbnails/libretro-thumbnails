# libretro-thumbnails

Thumbnails for [RetroArch](http://retroarch.com), split into individual repositories to ease maintenance.

## Install

Check out the repository, with all submodules, into RetroArch's thumbnails directory:

```
cd ~/.config/retroarch
git clone --recursive --depth=1 http://github.com/libretro-thumbnails/libretro-thumbnails.git thumbnails
```

## Update

To bring in the latest thumbnails across all systems, use:

```
git pull
git submodule update --init
```

You can also bring the latest changes from all submodules down by using:

```
make update
```

## Usage

- Thumbnails are installed into RetroArch config's `thumbnails` directory
- There are three types of thumbnails:
  - `Named_Snaps` are in game snapshots
  - `Named_Titles` are title screen snapshots
  - `Named_Boxarts` are the boxes or covers for games
- Thumbnails follow the following naming convention:
    ```
    thumbnails/Playlist Name/Named Type/Game Name.png
    ```
- The following characters in playlist titles must be replaced with _ in the corresponding thumbnail filename:
    ```
    &*/:`<>?\|
    ```
- Images must be `.png` format
- Images should be no wider than 512px
- Substitute promotional flyers are acceptable when no boxart is available for a game
- Use [libretro-thumbnails-check](https://github.com/RobLoach/libretro-thumbnails-check) to check for missing thumbnails
