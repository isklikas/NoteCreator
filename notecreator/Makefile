include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoteCreator
NoteCreator_FILES = Event.xm
NoteCreator_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	#PreferenceLoader plist
	$(ECHO_NOTHING)if [ -f Preferences.plist ]; then mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoteCreator; cp Preferences.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoteCreator/; fi$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"
