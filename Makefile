# libretro-thumbnails: RetroArch Thumbnails
#
# Usage:
#
# make: Brings down the latest stable thumbnails
# make update: Bring down the latest unstable thumbnails
#

# Download the latest thumbnails.
update: pull
	git submodule update --recursive --remote --init --force
	git submodule foreach 'git ls-files | grep -E ".*\.(png)" > ".index"'

# Retrieve the latest repository updates.
pull:
	git pull

# Tell the user how to install the thumbnails.
install: all
	@echo "Place libretro-thumbnails in RetroArch's config/thumbnails folder."

# Clean all the files.
clean: clean-index

# Build the root .index file.
index: clean-index
	git submodule foreach 'echo $$name >> ../.index'

# Clean the .index file.
clean-index:
	rm -f .index
