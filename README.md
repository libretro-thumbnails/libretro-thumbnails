# libretro-thumbnails

Thumbnails for [RetroArch](http://retroarch.com), organized into separate repositories by system/console to ease maintenance.

This readme focusses on use of the libretro github thumbnail __repository__ _not_ on use of the Retroarch app. For user-guide details about how thumbnail files function within RetroArch, the file and subfolder requirements for using thumbnail images, the flexible name matching algorithm that assigns image files to playlisted games, and troubleshooting thumbnails and playlists, see our [documentation](https://docs.libretro.com/guides/roms-playlists-thumbnails/#thumbnails).

### Overview of RetroArch Thumbnails

- Thumbnails are installed into RetroArch config's `thumbnails` directory
- There are three types of thumbnails:
  - `Named_Snaps` are in-game snapshots, aka gameplay screenshots
  - `Named_Titles` are images of the introductory title screen in-game
  - `Named_Boxarts` are scans of the boxes or covers of games
- Thumbnails must follow this naming and pathing convention:
    ```
    thumbnails/Playlist Name/Named Type/Game Name.png
    ```
RetroArch can display both [automatic server-provided thumbnails](https://docs.libretro.com/guides/roms-playlists-thumbnails/#thumbnails) and [custom thumbnails set by the user](https://docs.libretro.com/guides/roms-playlists-thumbnails/#custom-thumbnails) 
    
    
# Technical Usage of this Repository

### Install

Check out the repository, with all submodules, into RetroArch's thumbnails directory:

```
cd ~/.config/retroarch
git clone --recursive --depth=1 http://github.com/libretro-thumbnails/libretro-thumbnails.git thumbnails
```

### Update

To bring in the latest thumbnails across all systems, use:

```
git pull
git submodule update --recursive --remote --init --force
```

If you have [`make`](https://www.gnu.org/software/make/) available, you can run the above by simply running:

```
make
```

Alternatively, the script below will maintain shallow clones (depth=1) and checkout master:

```
sh update_modules.sh
```

### Testing for Restricted Characters

To check for files with invalid file names, use the following command....

``` bash
find . -name '*[&\*:`<>?\\|"*]*'
```

### .index Files

The .index files allow RetroArch to list the files available in the given directory. To build the .index files, run...

```
make index
make
```

## Thumbnail Server

The libretro-thumbnail server receives updates from the repository about once every two days on a cronjob. If you don't see updated files, append `?nocaches=CURRENTDATE` to have CloudFlare serve new content.

After a thumbnail contribution is accepted via a github pull request, the image will not be visible in RetroArch until the periodic export from the github repository to the thumbnail server occurs. Depending on maintenance, the delay may potentially be 1-2 weeks.


# Contributions

For a step-by-step guide on how any user can contribute new or improved thumbnail images to RetroArch via github.com, see our [detailed guide](https://docs.libretro.com/guides/roms-playlists-thumbnails/#contributing-thumbnails-how-to).  Note you may use [libretro-thumbnails-check](https://github.com/RobLoach/libretro-thumbnails-check) to check for missing thumbnails

## Rules for Images & Contributions

### File & Naming Guidelines

- __Format__. Images must be `.png` format. _In RetroArch versions later than 1.19.1, image formats other than PNG can be enabled including jpg, bmp, tga_.
- __Filenames__
  - _Invalid characters._  If the characters ``&*/:`<>?\|"`` appear in a game name displayed in a playlist, they must be replaced with `_` in the corresponding thumbnail filename.
  - Over-writes. If replacing an existing image in the repository, name your new image file exactly as the previous one to guarantee that it will be matched to the relevant game name in RetroArch. (Unless your contribution is to correct an erroneous filename that doesn't match the game name database.)
  - New additions. If uploading a new thumbnail that has no prior existing version in the repository, research the naming conventions of libretro and how the game is named in databases. Name the image file according to the game name that RetroArch assigns in the playlist.
- __Subfolder & Repository Locations.__ Ensure you have used the correct console system folder and thumbnail type folder in the repository before submitting a Pull Request.

### Image Guidelines

# Resolution
  - Images with native width larger than 512px should be scaled down to 512px wide
  - Images with native width of 512px or less should be added as-is

# Screenshot Composition & Aesthetics
For snaps (in-game screenshots), choose a good clear artful image that shows the art, spirit, or action of the game in normal or ideal gameplay. For examples of well-chosen well-composed in-game screenshots, see the back-of-box images printed on officially published games.

In order for the thumbnail repository to contain "archival quality" snaps (in-game screenshots) for each game:
  - Snaps should ideally represent characteristic art/sprites, environment, and/or action from the game.
  - Contributors should think of what screenshot a museum curator would pick for a museum exhibit about the game.
  - Contributors should think of what kind of picture the game's designers and artists would pick for the back of the game's box.

_Examples for thinking about the elements of a good screenshot composition._

  - Racing game:
    - A good screenshot often will show the vehicle following the road and with visible competitors/co-racers if they exist. A worse screenshot would be crashed off the track with the camera aiming away from the upcoming road.
  - Fighting game:
    - A good snap screenshot will show the character sprites and at least one animation key frame, not a situation when the characters are off-screen or invisible.
  - Scrolling shooter:
    - Some combination of clear player ship + clear background + enemies + some of the bullet style or explosions.
  - 3rd person action game
    - A good snap thumbnail will include some balance between the character and the environmental setting or style of the game.  A less ideal snap thumbnail might be mostly filled by a single wall texture with the camera directly facing a bland wall.

__Substitutions__.
- Promotional material is acceptable when no official boxart is available.


# Credits

The art provided has many different sources. Thank you to many of the contributors and sites who have made this possible...

- [Screenshot(s) via MobyGames](https://mobygames.com)
- [Fandom](https://www.fandom.com)
- Volunteer user contributions, [submission history here](https://github.com/libretro-thumbnails/libretro-thumbnails/pulls?q=is%3Apr+is%3Aclosed) (and for [previous archive here](https://github.com/libretro/libretro-thumbnails/pulls?q=is%3Apr+is%3Aclosed))
