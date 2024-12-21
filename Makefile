# libretro-thumbnails: RetroArch Thumbnails
#
# Usage:
#
# make: Brings down the latest thumbnails, and updates the index files
#

# Download the latest thumbnails, and update the index files.
update: pull update-submodules indexes
	@echo "Thumbnail update complete"

# Retrieve the latest repository updates.
pull:
	git pull

# Update all the submodules to their latest commits upstream.
update-submodules:
	git submodule update --recursive --remote --init --force

# There is not install script, so inform the user how to install the thumbs.
install:
	@echo "Place libretro-thumbnails in RetroArch's config/thumbnails folder."

# Clean all the files.
clean: clean-index

# Build the root .index file.
index: clean-index
	git submodule foreach 'echo $$name >> ../.index'

# Clean the .index file.
clean-index:
	rm -f .index

# Update all the .index files.
indexes: index
	git submodule foreach 'git ls-files | grep -E ".*\.(png)" > ".index"'
