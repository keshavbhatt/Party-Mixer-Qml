TEMPLATE = aux
TARGET = kpm

RESOURCES += kpm.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  kpm.apparmor \
               kpm.desktop \
               kpm.png

AP_TEST_FILES += tests/autopilot/run \
                 $$files(tests/*.py,true)

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
    MediaPlayer1.qml \
    MediaPlayer2.qml \
    PlayList.qml \
    Screen1.qml \
    Screen2.qml \
    ScrollBar.qml

#specify where the qml/js files are installed to
qml_files.path = /kpm
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /kpm
config_files.files += $${CONF_FILES}

INSTALLS+=config_files qml_files

