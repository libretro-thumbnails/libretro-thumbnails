# libretro-thumbnails

Thumbnails for [RetroArch](http://retroarch.com), organized into separate repositories by system/console to ease maintenance.

This readme focusses on use of the libretro github thumbnail __repository__ _not_ on use of the Retroarch app. For user-guide details about how thumbnail files function within RetroArch, the file and subfolder requirements for using thumbnail images, the flexible name matching algorithm that assigns image files to playlisted games, and troubleshooting thumbnails and playlists, see our [documentation](https://docs.libretro.com/guides/roms-playlists-thumbnails/#thumbnails).

#### Contents
- [Overview of RetroArch Thumbnails](#overview-of-retroarch-thumbnails)
- [Technical Usage of this Repository](#technical-usage-of-this-repository)
- [Contributions and Image Guidelines](#contributions)
- [Credits](#credits)

### Overview of RetroArch Thumbnails

- Thumbnails are installed into RetroArch config's `thumbnails` directory
- There are three types of thumbnails:
  - `Named_Snaps` are in-game snapshots, aka gameplay screenshots
  - `Named_Titles` are images of the game's introductory title screen
  - `Named_Boxarts` are scans of the boxes or covers of games
- Thumbnails must follow this naming and pathing convention:
    ```
    thumbnails/Playlist Name/Named_Type/Game Name.png
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

For a step-by-step guide on how any user can contribute new or improved thumbnail images to RetroArch via github.com on the web, see our [detailed guide](https://docs.libretro.com/guides/roms-playlists-thumbnails/#contributing-thumbnails-how-to).  The entire process can be done on the web, you do not need to use or understand any of the technical processes described earlier in this readme.  Note you may use [libretro-thumbnails-check](https://github.com/RobLoach/libretro-thumbnails-check) to check for missing thumbnails, but be aware that list may be deprecated and unmaintained.

## Rules for Images

### File & Naming Guidelines

- __Format__. Images must be `.png` format. (_RetroArch versions later than 1.19.1 can use image formats other than PNG including jpg, bmp, tga, but we currently do not support those in the repository or thumbnail server._)
- __Filenames__
  - _Invalid characters._  If the characters ``&*/:`<>?\|"`` appear in a game name displayed in a playlist, they must be replaced with `_` in the corresponding thumbnail filename.
  - Over-writes. If replacing an existing image in the repository, name your new image file exactly as the previous one to guarantee that it will be matched to the relevant game name in RetroArch. (Unless your contribution is to correct an erroneous filename in accordance with the game name database.)
  - New additions. If uploading a new thumbnail that has no prior existing version in the repository, research the naming conventions of libretro and how the game is named in databases. Name the image file according to the game name that RetroArch assigns in the playlist.
- __Subfolder & Repository Locations.__ Ensure you have used the correct console system directory and thumbnail type folder in the repository before submitting a Pull Request.

### Image Guidelines

#### Resolution
  - Images with native width larger than 512px should be scaled down to 512px wide
  - Images with native width of 512px or less should be added as-is

#### Rules for Settings
When taking in-game screenshots for thumbnails (snaps), ensure that your various settings/processes that would affect the thumbnail are set according to these guidelines:

- __Shaders/filters OFF__
  - Because the thumbnail  max resolution (512px width) is too low to accurately represent scanlines/sub-pixel effects created by CRT shaders (for example), shaders should be turned OFF when working on creating an in-game screenshot for a thumbnail.
  - See RetroArch menu > Settings > Video > GPU Screenshot ON | OFF to toggle whether a saved screenshot will include slang shader effects.
- __Bilinear Filtering OFF__ (unless native)
  - Bilinear filtering should be off, _unless_ native to the original game/console.
  - Warning: many image apps on PC (including defailt Microsoft Photos, and some web browsers) may misleadingly apply bilinear or other filtering temporarily while you view the screenshot file, even though the file itself is raw pixels. To accurately review your screenshot image file contents, ensure that your app's settings for filtering are turned OFF.
- __Color Correction (e.g. GBA) ON__ (where appropriate)
  - Just as a movie box wouldn't contain thumbnails that had a wrongly calibrated set of colors for the film, GBA thumbnail and title screen snaps should have color correction ON where appropriate.
  - Color Correction core options are acceptable and preferable in cases when the option corrects the visuals to the original game's/designers' intention. Usually this situation only applies to GBA or cases when the original hardware/display caused the developers to encode colors in a way that pre-compensated for the original display's output and which would be wrong if viewed without appropriate filtering. 
  - You may need to research the game's promotional materials or the history of the game/console to determine whether color correction is correct for the game in question.

__Substitutions__. Promotional material are acceptable when no official boxart is available.

#### Screenshot Composition & Aesthetics

- For snaps (in-game screenshots), choose a good clear artful image that shows the art, spirit, environment, and action of the game in normal or ideal gameplay.
- For examples of well-chosen well-composed in-game screenshots, see the back-of-box images printed on officially published games and the guidelines below.
- __Goals.__
  - __Quality.__ We want to build a library of archival quality snaps (in-game screenshots) for each game.  Contributors should think about and ask themselves:
    - _What screenshot would a museum director create and pick for a museum exhibit about the game?_
    - _What kind of screenshot would the game's designers and artists pick for their work portfolio or on the back of the game's box?_
    - _What screenshot connects to fond feelings and memories of the game's particular feel and experience?_
  - __Visual identification while browsing__.
    - A good screenshot should help to quickly and clearly distinguish a game from other similar games, and from other installments within its own series.
    - A particular screenshot is not a good choice if it can easily be mistaken for the game's sequel, for example.

#### FAQ

- Question. "Are interface/HUD elements an obstruction, or a distinct and important part of an in-game snap?"
  - Answer. Usually the in-game interface (HUD) is a fundamental and carefully designed part of the game and the game's art/aesthetics, and which can also help distinguish similar games. In most cases, you should include the normal gameplay HUD, and not go out of your way to capture a screenshot faded away for a transition.  Though as with other guidelines, it may vary case by case. 

__Table 1. Examples of good and bad screenshot composition.__
_These are example and discussions for guidance. Keep in mind that it is the unique character of each game that should determine what picture is appropriate to represent it._

| __Game Type Example__ | __Good Screenshot Example__ | __Worse Screenshot Example__ |
| :---: | -- | --| 
|       Racing game       |    Shows the vehicle following the road, with environmental style visible, and with visible competitors/co-racers if they exist         |  The player vehicle/character is crashed off the track or stuck against a wall, and/or the camera is aiming away from the upcoming road (unless perhaps that screenshot represents the particular spirit of the given game. A freecam picture that doesn't convey the normal perspective/action of the game.)      |      
| Fighting game | Clear character sprites with at least one character showing an animation key frame, in a background that portrays the mood of the game | A situation when one or both characters are off-screen or invisible. A transitional/interface screen that doesn't show fighting. |
| Scrolling shooter | Some combination of clear player ship + stage background + enemies (and/or a climactic boss) + bullet style or explosions. | An empty screen with few-to-no enemies and no action happening. | 
| 3rd person action game | Includes a balance between the character and the environmental setting or style of the game |  A picture mostly filled by a single wall texture where the camera directly facing a wall | 
| RPG / JRPG | Shows a distinct scenic setting and characters, e.g. an iconic area from early scenes. Textbox dialog within a picture is fine or even ideal if it helps characterize the game. |  An image taken up by a textbox or menu that makes it unclear which game, or which game in a series, it is.  Any screen that is very similar between different entries in the same series (e.g. some menu screens, or some random-battle scenes) |



# Credits

The art provided has many different sources. Thank you to many of the contributors and sites who have made this possible...

- [Screenshot(s) via MobyGames](https://mobygames.com)
- [Fandom](https://www.fandom.com)
- Volunteer user contributions, [submission history here](https://github.com/libretro-thumbnails/libretro-thumbnails/pulls?q=is%3Apr+is%3Aclosed) (and for [previous archive here](https://github.com/libretro/libretro-thumbnails/pulls?q=is%3Apr+is%3Aclosed))
