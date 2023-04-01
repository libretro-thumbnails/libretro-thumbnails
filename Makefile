# libretro-thumbnails: RetroArch Thumbnails
#
# Usage:
#
# make: Brings down the latest stable thumbnails
# make update: Bring down the latest unstable thumbnails
# make packs: Creates pack archives of the thumbnails
#

# The packs directory must be relative from this Makefile.
PACKSDIR ?= packs

# Download the latest thumbnails.
update: pull
	git submodule update --recursive --remote --init

# Retrieve the latest repository updates.
pull:
	git pull

# Tell the user how to install the thumbnails.
install: all
	@echo "Place libretro-thumbnails in RetroArch's config/thumbnails folder."

# Build thumbnails .zip packs for all systems.
packs: index packs-index | update
	git submodule foreach 'git archive HEAD --format zip --prefix="$$name/" -9 --output "../$(PACKSDIR)/$$name.zip"'
	git submodule foreach 'git ls-files | grep -E ".*\.(png)" > ../$(PACKSDIR)/$$name_tree.txt'

# Clean all the files.
clean: clean-index clean-packs clean-packs-index

# Construct the .index for the packs directory.
packs-index: clean-packs-index packs-dir
	git submodule foreach 'echo $$name.zip >> ../$(PACKSDIR)/.index'

# Ensure the packs directory exists.
packs-dir:
	mkdir -p $(PACKSDIR)

# Build the root .index file.
index: clean-index
	git submodule foreach 'echo $$name >> ../.index'

# Clean the .index file.
clean-index:
	rm -f .index

# Clean the packs directory.
clean-packs:
	rm -rf $(PACKSDIR)

# Clean the pack's .index file.
clean-packs-index:
	rm -f $(PACKSDIR)/.index
