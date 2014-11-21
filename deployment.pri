android-no-sdk {
    target.path = /data/user/qt
    export(target.path)
    INSTALLS += target
} else:android {
    x86 {
        target.path = /libs/x86
    } else: armeabi-v7a {
        target.path = /libs/armeabi-v7a
    } else {
        target.path = /libs/armeabi
    }
    export(target.path)
    INSTALLS += target
} else:unix {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

#!isEmpty(QML_MESHES_FILES) {

#    # rules to copy files from the *base level* of $$PWD/qml/meshes into the right place
#    copyqmlmeshes_install.files = $$QML_MESHES_FILES
#    copyqmlmeshes_install.path = $$target.path/$$resource_dir/qml/meshes
#    INSTALLS += copyqmlmeshes_install

#    target_dir = $$DESTDIR/$$resource_dir/qml/meshes
#    copyqmlmeshes.input = QML_MESHES_FILES
#    copyqmlmeshes.output = $$target_dir/${QMAKE_FILE_IN_BASE}${QMAKE_FILE_EXT}
#    copyqmlmeshes.commands = $$QMAKE_COPY ${QMAKE_FILE_IN} ${QMAKE_FILE_OUT}
#    copyqmlmeshes.CONFIG += no_link no_clean
#    copyqmlmeshes.variable_out = POST_TARGETDEPS
#    QMAKE_EXTRA_COMPILERS += copyqmlmeshes
#}

export(INSTALLS)
