# libretro-thumbnails

Thumbnails for [RetroArch](http://retroarch.com), organized into separate repositories by system/console to ease maintenance.

This readme focusses on use of the libretro github thumbnail __repository__ _not_ on use of the Retroarch app. For user-guide details about how thumbnail files function within RetroArch, the file and subfolder requirements for using thumbnail images, the flexible name matching algorithm that assigns image files to playlisted games, and troubleshooting thumbnails and playlists, see our [documentation](https://docs.libretro.com/guides/roms-playlists-thumbnails/#thumbnails).

#### Contents
- [Overview of RetroArch Thumbnails](#overview-of-retroarch-thumbnails)
- [Technical Usage of this Repository](#technical-usage-and-maintenance-of-this-repository)
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
    
    
# Technical Usage and Maintenance of this Repository

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

For contributors: After a thumbnail contribution is accepted via a github pull request, the image will not be visible in RetroArch until the periodic export from the github repository to the thumbnail server occurs. Depending on maintenance, the delay may potentially be 1-2 weeks. (Users may also need to activate a [thumbnails update in RetroArch](https://docs.libretro.com/guides/roms-playlists-thumbnails/#thumbnails) if a contribution replaced a previous image.)


# Contributions

For a step-by-step guide on how any user can contribute new or improved thumbnail images to RetroArch via github.com on the web, see our [detailed guide](https://docs.libretro.com/guides/roms-playlists-thumbnails/#contributing-thumbnails-how-to).  The entire process can be done on the web, you do not need to use or understand any of the technical processes described earlier in this readme.  Note you may use [libretro-thumbnails-check](https://github.com/RobLoach/libretro-thumbnails-check) to check for missing thumbnails, but be aware that list may be deprecated and unmaintained.

Contributions must follow all guidelines below.

- [File & Naming](#file-&-naming-guidelines)
- [Image Guidelines](#image-guidelines)
- [Rules for Settings](#rules-for-settings)
- [Screenshot Composition](#screenshot-composition-&-aesthetics)

## File & Naming Guidelines

- __Format__. Images must be `.png` format. (_RetroArch versions later than 1.19.1 can use image formats other than PNG including jpg, bmp, tga, but we currently do not support those in the repository or thumbnail server._)
- __Filenames__
  - _Invalid characters._  If the characters ``&*/:`<>?\|"`` appear in a game name displayed in a playlist, they must be replaced with `_` in the corresponding thumbnail filename.
  - Over-writes. If replacing an existing image in the repository, name your new image file exactly as the previous one to guarantee that it will be matched to the relevant game name in RetroArch. (Unless your contribution is to correct an erroneous filename in accordance with the game name database.)
  - New additions. If uploading a new thumbnail that has no prior existing version in the repository, research the naming conventions of libretro and how the game is named in databases. Name the image file according to the game name that RetroArch assigns in the playlist.
- __Subfolder & Repository Locations.__ Ensure you have used the correct console system directory and thumbnail type folder in the repository before submitting a Pull Request.

## Image Guidelines

### Goals

- __Quality.__ The goal is to have a library of archival quality snaps (in-game screenshots) that represents the look and spirit of each game, for the benefit and pleasure of all users.  
- __Visual identification while browsing__.
    - A good screenshot should help to quickly distinguish a game from other similar games, and from other installments within its own series.
    - A particular screenshot is not a good choice if it can easily be mistaken for the game's sequel or prequel, for example.

### Resolution
  - Images with native width larger than 512px should be scaled down to 512px wide
  - Images with native width of 512px or less should be added as-is

### Rules for Settings
When taking in-game screenshots for thumbnails, ensure that your various settings/processes that would affect the thumbnail are set according to these guidelines:

- __Shaders/filters OFF__
  - Because the thumbnail  max resolution (512px width) is too low to accurately represent scanlines/sub-pixel effects created by CRT shaders (for example), shaders should be turned OFF when working on creating an in-game screenshot for a thumbnail.
  - See RetroArch menu > Settings > Video > GPU Screenshot ON | OFF to toggle whether a saved screenshot will include slang shader effects.
- __Bilinear Filtering OFF__ (unless native)
  - Bilinear filtering should be off, _unless_ native to the original game/console.
  - Warning: many image apps on PC (including default Microsoft Photos, and some web browsers) may misleadingly apply bilinear or other filtering temporarily while you view the screenshot file, even though the file itself is raw pixels. To accurately review your screenshot image file contents, ensure that your app's settings for filtering are turned OFF.
- __Color Correction (e.g. GBA and GBC) ON__ (where appropriate)
  - Just as a movie box wouldn't contain thumbnails that showed a wrongly calibrated set of colors for the film, GBA/GBC thumbnail and title screen snaps should have color correction ON where appropriate.
  - Color Correction core options are acceptable and preferable in cases when the option corrects the visuals to the original game's/designers' intention. Usually this situation only applies to GBA & GBC or cases when the original hardware/display caused the developers to encode colors in a way that pre-compensated for the original display's output and which would be wrong if viewed without appropriate filtering. 
  - You may need to research the game's promotional materials or the history of the game/console to determine whether color correction is correct for the game in question.
- __In-game HUD and Interface Elements ON__
  - Usually a game's in-game interface/HUD is a fundamental and carefully designed part of the game and the game's identity, and which can also help distinguish between similar games. In most cases, you should include the normal gameplay HUD, and should usually not capture a screenshot where the HUD has faded away for a transition.
  - If you are a player who turns HUDs off as a personal preference, you should usually turn it ON when taking an in-game screenshot for a thumbnail contribution.

__Substitutions__. Promotional material are acceptable when no official boxart is available.

### Screenshot Composition & Aesthetics

- For snaps (in-game screenshots), choose a good clear artful image that shows the art, spirit, environment, and action of the game in normal or ideal gameplay.
- For examples of well-chosen well-composed in-game screenshots, see the back-of-box images printed on officially published games and the guidelines below.
- Contributors should think about and ask themselves:
    - _What screenshot would a museum director create and pick for a museum exhibit about the game?_
    - _What kind of screenshot would the game's designers and artists pick for their work portfolio or if they were choosing pictures for the back of the box?_
    - _What screenshot connects to fond feelings and memories of the game's particular feel and experience?_

#### Example Patterns of Good vs Worse Screenshot Composition
Below are _example qualities_ intended to provide some guidance about good/bad thumbnail snaps. The "Worse" examples describe some common patterns of non-ideal screenshots. These are not necessarily hard rules: the overall principle is that the character of each individual game should determine what picture is appropriate to represent it.

| __Game Genre/Format__ | __Good Screenshot Example__ | __Worse Screenshot Example(s)__ |
| :---: | -- | --| 
|       Racing Game      |    Shows the vehicle following the road, with environmental style visible, and with visible competitors/co-racers if they exist. (Often a turn will look more 'dynamic' than a straight, in the sprite/model of the player vehicle and the framed path of the road).         |  The player vehicle/character is stuck against a wall, is slowing down after wrongly going off-track, or is crashed off the track (unless that situation well-represents the particular spirit or reputation of the given game). The player's position makes it difficult to understand the feel of normal ideal gameplay. Or the camera is aiming away from the upcoming road. A freecam picture that doesn't convey the normal perspective of action in gameplay.      |      
| Fighting Game | Clear character sprites with both competitors, and at least one character showing an animation key frame, in a background that portrays the mood of the game. | A situation when one or both characters are off-screen or invisible. A transitional menu screen that doesn't show fighting or the artistic spirit of the game. A bland background/moment if a more radiant one is available. |
| Scrolling Shooter | Some combination of clear player ship + visible stage background art + enemies (and/or a climactic boss) + bullet style or explosions. | An empty screen with few-to-no enemies and no action happening. A moment when an empty background is showing (unless the game only has empty backgrounds). | 
| 3rd Person Action Game | Includes a balance between the character(s) and the environmental setting or style of the game. Emphasizes a situation of interest to both the player and character. E.g. shows the line-of-sight of the main character or player from a key position in the level. |  A picture mostly filled by a single wall texture instead of the larger playspace.  Or where the camera is too close to an object/wall and blocks view of the typical scenery or characters. | 
| RPG / JRPG | Shows a distinct scenic setting and characters, e.g. an iconic area from early scenes. Textbox dialog within a snap is fine or even preferable if it helps characterize the game either visually or in writing style. |  An image taken up by a textbox or menu that makes it unclear which game, or which game in a series, it is.  Any screen that is very similar between different entries in the same series (e.g. some menu screens, or some random-battle scenes). A small room that is significantly smaller than the normal size of the game view (unless the particular image helps rather than hinders identification of the game). |


# Credits

The files in the repository have many different sources. Thank you to the many contributors, in-game photographers, scanners, collectors, sites, and site managers, who have made this possible...

- [Screenshot(s) via MobyGames](https://mobygames.com)
- [Fandom](https://www.fandom.com)
- Volunteer user contributions. View the [submission history here](https://github.com/libretro-thumbnails/libretro-thumbnails/pulls?q=is%3Apr+is%3Aclosed) and [here](https://github.com/libretro/libretro-thumbnails/pulls?q=is%3Apr+is%3Aclosed)

*The game art itself and promotional art originates from the work of each respective game's developers and publishers.*
