VERSION = 1.1

QT += quick
CONFIG += c++17
CONFIG += Release

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

RESOURCES += qml.qrc

HEADERS += \
    gameplaycontroller.h \
    bubblestate.h \
    main.h

SOURCES += \
    gameplaycontroller.cpp \
    bubblestate.cpp \
	main.cpp

Release:DESTDIR = release
Release:OBJECTS_DIR = release/obj
Release:MOC_DIR = release/moc
Release:RCC_DIR = release/rcc
Release:UI_DIR = release/ui

unix {
	# If it is unix* OS -> define flag 'no-pie' to build executable (see: https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html)
	QMAKE_LFLAGS += -no-pie
}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
