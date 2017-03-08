include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NoteCreatorPrefs
NoteCreatorPrefs_FILES = prefsRootListController.m
NoteCreatorPrefs_INSTALL_PATH = /Library/PreferenceBundles
NoteCreatorPrefs_FRAMEWORKS = UIKit
NoteCreatorPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoteCreatorPrefs.plist$(ECHO_END)
