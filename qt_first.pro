TEMPLATE = app

QT += qml quick widgets 3dquick 3d

SOURCES += main.cpp

RESOURCES += qml.qrc \
    images.qrc \
    models.qrc \

# CONFIG += release

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \

QML_MESHES_FILES = models/SnowTerrain.obj
#include(pkg.pri)
