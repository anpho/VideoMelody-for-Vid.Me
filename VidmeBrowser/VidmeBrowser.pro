APP_NAME = VidmeBrowser

RESOURCES += assets.qrc
CONFIG += qt warn_on cascades10
LIBS += -lbbdata -lbb
LIBS += -lbbsystem -lbbplatform  -lbbdevice 
LIBS += -lbbcascadespickers
QT += network
include(config.pri)
