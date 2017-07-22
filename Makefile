all:
	git submodule update --init

install: all
	@echo "Nothing to install for libretro-thumbnails."

update: all
	git submodule foreach git pull origin master
