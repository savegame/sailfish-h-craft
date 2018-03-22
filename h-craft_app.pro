TEMPLATE = app

CONFIG += warn_off
sailfish: CONFIG += sailfishapp
CONFIG += link_pkgconfig

sailfish: PKGCONFIG += wayland-client wayland-egl dbus-1
PKGCONFIG += zlib libpng egl
!sailfish: PKGCONFIG += bzip2
x11: PKGCONFIG += x11 xrandr gl glesv2 xxf86vm sdl
sailfish: PKGCONFIG += vorbis vorbisenc vorbisfile ogg openal
sailfish: LIBS += -lbz2

sailfish: DEFINES += SAILFISH
!sailfish: DEFINES += _IRR_COMPILE_WITH_OPENGL_
!sailfish: DEFINES += NO_IRR_COMPILE_WITH_OGLES1_
x11: DEFINES += _IRR_LINUX_X11_RANDR_
x11: DEFINES += _IRR_COMPILE_WITH_OGLES2_

x11 {
	DEFINES -= _IRR_COMPILE_WITH_SAILFISH_DEVICE_
	DEFINES += _IRR_COMPILE_WITH_X11_
	DEFINES += _IRR_COMPILE_WITH_OGLES2_
	DEFINES += NO_IRR_COMPILE_WITH_OGLES1_
	DEFINES += _IRR_COMPILE_WITH_EGL_MANAGER_
}

sailfish || x11 {
	INCLUDEPATH += libs/irrlicht/include
	INCLUDEPATH += libs/irrlicht/source/Irrlicht
	INCLUDEPATH += libs/irrlicht/source/Irrlicht/libjpeg
	LIBS += -lirrlicht -L$$OUT_PWD/lib
	QMAKE_CXXFLAGS += $$system('freetype-config --cflags')
	LIBS += -lfreetype
	PKGCONFIG += openal ogg
}

sailfish || x11: DEFINES += HC1_OGLES HAVE_STDINT_H HAVE_STAT HAVE_NANOSLEEP HAVE_TIME_H

INCLUDEPATH += libs/freealut/freealut-1.1.0/include

TARGET = h-craft

include(libs/tremor/tremor-1.0.2/tremor.pri)
include(libs/freealut/freealut-1.1.0/freealut.pri)
#include(libs/freealut/freealut-1.1.0/freeault.pri)


HEADERS += \
    src/gui_dialogs/gui_ai.h \
    src/gui_dialogs/gui_controller_display.h \
    src/gui_dialogs/gui_developer_settings.h \
    src/gui_dialogs/gui_dlg_okcancel.h \
    src/gui_dialogs/gui_editor.h \
    src/gui_dialogs/gui_game.h \
    src/gui_dialogs/gui_helper.h \
    src/gui_dialogs/gui_hud.h \
    src/gui_dialogs/gui_intro.h \
    src/gui_dialogs/gui_levelmanager.h \
    src/gui_dialogs/gui_menu_analog.h \
    src/gui_dialogs/gui_menu_arcade.h \
    src/gui_dialogs/gui_menu_championship.h \
    src/gui_dialogs/gui_menu_championship_progress.h \
    src/gui_dialogs/gui_menu_championship_winner.h \
    src/gui_dialogs/gui_menu_controls.h \
    src/gui_dialogs/gui_menu_credits.h \
    src/gui_dialogs/gui_menu_gameend.h \
    src/gui_dialogs/gui_menu_gameend_champ.h \
    src/gui_dialogs/gui_menu_gameend_rivals.h \
    src/gui_dialogs/gui_menu_graphics.h \
    src/gui_dialogs/gui_menu_highscores.h \
    src/gui_dialogs/gui_menu_hover_unlocked.h \
    src/gui_dialogs/gui_menu_keyboard.h \
    src/gui_dialogs/gui_menu_licenses.h \
    src/gui_dialogs/gui_menu_loadingscreen.h \
    src/gui_dialogs/gui_menu_main.h \
    src/gui_dialogs/gui_menu_nagscreen.h \
    src/gui_dialogs/gui_menu_newprofile.h \
    src/gui_dialogs/gui_menu_options.h \
    src/gui_dialogs/gui_menu_pause.h \
    src/gui_dialogs/gui_menu_profiles.h \
    src/gui_dialogs/gui_menu_replaytheatre.h \
    src/gui_dialogs/gui_menu_rivals.h \
    src/gui_dialogs/gui_menu_rivals_score.h \
    src/gui_dialogs/gui_menu_selecthover.h \
    src/gui_dialogs/gui_menu_timeattack.h \
    src/gui_dialogs/gui_menu_tutorial3.h \
    src/gui_dialogs/gui_modellist.h \
    src/gui_dialogs/gui_nodemanager.h \
    src/gui_dialogs/gui_touch.h \
    src/gui_dialogs/gui_user_controls.h \
    src/mobile/advert.h \
    src/mobile/advert_admob.h \
    src/mobile/android_tools.h \
    src/mobile/app_restrictions.h \
    src/mobile/billing.h \
    src/mobile/billing_googleplay.h \
    src/tinyxml/tinystr.h \
    src/tinyxml/tinyxml.h \
    src/ai_track.h \
    src/app_tester.h \
    src/camera.h \
    src/CGUIDialogRoot.h \
    src/CGUITextSlider.h \
    src/CGUITTFont.h \
    src/championship.h \
    src/CLMOMeshFileLoader.h \
    src/compile_config.h \
    src/config.h \
    src/config_enums.h \
    src/controller.h \
    src/convert_utf.h \
    src/device_joystick.h \
    src/device_joystick_settings.h \
    src/device_keyboard.h \
    src/device_mouse.h \
    src/device_touch.h \
    src/device_touch_settings.h \
    src/editor.h \
    src/EGUIElementTypesHC.h \
    src/EGUIEventTypesHC.h \
    src/event_receiver_base.h \
    src/font_manager.h \
    src/game.h \
    src/game_enums.h \
    src/globals.h \
    src/grid_triangle_selector.h \
    src/gui.h \
    src/gui_dialog.h \
    src/gui_freetype_font.h \
    src/gui_ids.h \
    src/helper_file.h \
    src/helper_irr.h \
    src/helper_math.h \
    src/helper_str.h \
    src/helper_xml.h \
    src/highscores.h \
    src/hover.h \
    src/IGUITextSlider.h \
    src/input_device.h \
    src/input_device_manager.h \
    src/irrlicht_manager.h \
    src/keycode_strings.h \
    src/level.h \
    src/level_manager.h \
    src/logging.h \
    src/logging_priorities.h \
    src/main.h \
    src/mesh_texture_loader.h \
    src/music_manager.h \
    src/nn.h \
    src/node_manager.h \
    src/ogg_stream.h \
    src/ogles2_materials.h \
    src/ov_callbacks.h \
    src/physics.h \
    src/player.h \
    src/profiles.h \
    src/random.h \
    src/recorder.h \
    src/rivalsmode.h \
    src/sound.h \
    src/sound_openal.h \
    src/sound_settings.h \
    src/start_browser.h \
    src/streaming.h \
    src/string_table.h \
    src/timer.h \
    src/track_marker.h

SOURCES += \
    src/gui_dialogs/gui_ai.cpp \
    src/gui_dialogs/gui_controller_display.cpp \
    src/gui_dialogs/gui_developer_settings.cpp \
    src/gui_dialogs/gui_dlg_okcancel.cpp \
    src/gui_dialogs/gui_editor.cpp \
    src/gui_dialogs/gui_game.cpp \
    src/gui_dialogs/gui_helper.cpp \
    src/gui_dialogs/gui_hud.cpp \
    src/gui_dialogs/gui_intro.cpp \
    src/gui_dialogs/gui_levelmanager.cpp \
    src/gui_dialogs/gui_menu_analog.cpp \
    src/gui_dialogs/gui_menu_arcade.cpp \
    src/gui_dialogs/gui_menu_championship.cpp \
    src/gui_dialogs/gui_menu_championship_progress.cpp \
    src/gui_dialogs/gui_menu_championship_winner.cpp \
    src/gui_dialogs/gui_menu_controls.cpp \
    src/gui_dialogs/gui_menu_credits.cpp \
    src/gui_dialogs/gui_menu_gameend.cpp \
    src/gui_dialogs/gui_menu_gameend_champ.cpp \
    src/gui_dialogs/gui_menu_gameend_rivals.cpp \
    src/gui_dialogs/gui_menu_graphics.cpp \
    src/gui_dialogs/gui_menu_highscores.cpp \
    src/gui_dialogs/gui_menu_hover_unlocked.cpp \
    src/gui_dialogs/gui_menu_keyboard.cpp \
    src/gui_dialogs/gui_menu_licenses.cpp \
    src/gui_dialogs/gui_menu_loadingscreen.cpp \
    src/gui_dialogs/gui_menu_main.cpp \
    src/gui_dialogs/gui_menu_nagscreen.cpp \
    src/gui_dialogs/gui_menu_newprofile.cpp \
    src/gui_dialogs/gui_menu_options.cpp \
    src/gui_dialogs/gui_menu_pause.cpp \
    src/gui_dialogs/gui_menu_profiles.cpp \
    src/gui_dialogs/gui_menu_replaytheatre.cpp \
    src/gui_dialogs/gui_menu_rivals.cpp \
    src/gui_dialogs/gui_menu_rivals_score.cpp \
    src/gui_dialogs/gui_menu_selecthover.cpp \
    src/gui_dialogs/gui_menu_timeattack.cpp \
    src/gui_dialogs/gui_menu_tutorial3.cpp \
    src/gui_dialogs/gui_modellist.cpp \
    src/gui_dialogs/gui_nodemanager.cpp \
    src/gui_dialogs/gui_touch.cpp \
    src/gui_dialogs/gui_user_controls.cpp \
    src/mobile/advert_admob.cpp \
    src/mobile/android_tools.cpp \
    src/mobile/app_restrictions.cpp \
    src/mobile/billing_googleplay.cpp \
    src/tinyxml/tinystr.cpp \
    src/tinyxml/tinyxml.cpp \
    src/tinyxml/tinyxmlerror.cpp \
    src/tinyxml/tinyxmlparser.cpp \
    src/ai_track.cpp \
    src/app_tester.cpp \
    src/camera.cpp \
    src/CGUITextSlider.cpp \
    src/CGUITTFont.cpp \
    src/championship.cpp \
    src/CLMOMeshFileLoader.cpp \
    src/config.cpp \
    src/controller.cpp \
    src/device_joystick.cpp \
    src/device_joystick_settings.cpp \
    src/device_keyboard.cpp \
    src/device_mouse.cpp \
    src/device_touch.cpp \
    src/device_touch_settings.cpp \
    src/editor.cpp \
    src/event_receiver_base.cpp \
    src/font_manager.cpp \
    src/game.cpp \
    src/grid_triangle_selector.cpp \
    src/gui.cpp \
    src/gui_dialog.cpp \
    src/gui_freetype_font.cpp \
    src/helper_file.cpp \
    src/helper_irr.cpp \
    src/helper_math.cpp \
    src/helper_str.cpp \
    src/helper_xml.cpp \
    src/highscores.cpp \
    src/hover.cpp \
    src/input_device.cpp \
    src/input_device_manager.cpp \
    src/irrlicht_manager.cpp \
    src/keycode_strings.cpp \
    src/level.cpp \
    src/level_manager.cpp \
    src/logging.cpp \
    src/main.cpp \
    src/mesh_texture_loader.cpp \
    src/music_manager.cpp \
    src/nn.cpp \
    src/node_manager.cpp \
    src/ogg_stream.cpp \
    src/ogles2_materials.cpp \
    src/ov_callbacks.cpp \
    src/physics.cpp \
    src/player.cpp \
    src/profiles.cpp \
    src/random.cpp \
    src/recorder.cpp \
    src/rivalsmode.cpp \
    src/sound_openal.cpp \
    src/sound_settings.cpp \
    src/start_browser.cpp \
    src/streaming.cpp \
    src/string_table.cpp \
    src/timer.cpp \
    src/track_marker.cpp \
    src/convert_utf.c

DISTFILES += \
    h-craft.desktop \
    rpm/h-craft.yaml \
    h-craft.png

