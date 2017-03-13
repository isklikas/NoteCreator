include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoteCreator
NoteCreator_FILES = NoteCreator.xm NoteAccountController.m NoteController.m LineCreator.m NoteContentController.m NoteFileManager.m NoteScreenContainer.m
NoteAccountController.m_CFLAGS = -fobjc-arc
NoteCreator.xm_CFLAGS = -fobjc-arc
NoteController.m_CFLAGS = -fobjc-arc
NoteContentController.m_CFLAGS = -fobjc-arc
NoteFileManager.m_CFLAGS = -fobjc-arc
NoteScreenContainer.m_CFLAGS = -fobjc-arc
LineCreator.m_CFLAGS = -fobjc-arc
NoteCreator_LIBRARIES = activator
NoteCreator_FRAMEWORKS = UIKit CoreGraphics
BUNDLE_NAME = com.isklikas.NoteCreator
com.isklikas.NoteCreator_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS)/makefiles/bundle.mk
include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	#PreferenceLoader plist
	$(ECHO_NOTHING)if [ -f Preferences.plist ]; then mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoteCreator; cp Preferences.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NoteCreator/; fi$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += notecreatorprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
