import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

Window {
    visible: true
    width: 320
    height: 480
    title: qsTr("FRAXION")

    property int elapsed: 0
    property int minSec: 10
    property int maxSec: 300
    property string colorTranquille: "#166ab7"
    property string colorSoutenu: "#f44e42"

    function setElapsed(e)
    {
        elapsed = e;
        var min = Math.floor(elapsed / 60);
        var sec = elapsed % 60;
        lcd.text = (min < 10 ? "0" : "") + min + ":" + (sec < 10 ? "0" : "") + sec;
    }

    function ringtone()
    {
        FraxionActivity.ringtone();
    }

    function vibrate()
    {
        FraxionActivity.vibrate(1000);
    }

    Timer {
        id: timer
        interval: 1000
        repeat: true
        onTriggered: {
            setElapsed(elapsed+1);

            var tranquille = dialTranquille.value;
            var soutenu = dialSoutenu.value;

            var modulo = tranquille + soutenu;
            var reste = elapsed % modulo;

            var calcul = (reste - tranquille);

            if(calcul + 1 < 0)
            {
                lcd.color = colorTranquille;
            }

            if(calcul + 1 > 0)
            {
                lcd.color = colorSoutenu;
            }

            if(reste == 0 || calcul == 0)
            {
                if(switchSon.checked)
                    ringtone();

                if(switchVibreur.checked)
                    vibrate();
            }
        }
    }

    Column {
        id: lines
        anchors.fill: parent

        Row {
            id: gridView
            y: 0
            height: 240
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            Column {
                id: rythmes
                width: 200
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10

                SpinBox {
                    id: spinBoxTranquille
                    from: minSec
                    value: 10
                    anchors.top: labelTranquille.bottom
                    anchors.topMargin: 20
                    to: maxSec
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    onValueModified: {
                        dialTranquille.value = value;
                    }
                }

                Label {
                    id: labelTranquille
                    width: 140
                    height: 40
                    text: qsTr("Durée tranquille")
                    font.bold: true
                    font.pointSize: 12
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: colorTranquille
                }

                SpinBox {
                    id: spinBoxSoutenu
                    from: minSec
                    value: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    to: maxSec
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    onValueModified: {
                        dialSoutenu.value = value;
                    }
                }

                Label {
                    id: labelSoutenu
                    width: 140
                    height: 40
                    text: qsTr("Durée soutenue")
                    font.bold: true
                    font.pointSize: 12
                    anchors.bottom: spinBoxSoutenu.top
                    anchors.bottomMargin: 20
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: colorSoutenu
                }
            }

            Column {
                id: dials
                width: 100
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10

                Dial {
                    id: dialTranquille
                    width: 100
                    height: 100
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    from: minSec
                    to: maxSec
                    onValueChanged: {
                        spinBoxTranquille.value = value;
                    }
                }

                Dial {
                    id: dialSoutenu
                    width: 100
                    height: 100
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    from: minSec
                    to: maxSec
                    onValueChanged: {
                        spinBoxSoutenu.value = value;
                    }
                }
            }
        }

        Label {
            id: lcd
            color: colorTranquille
            text: qsTr("00:00")
            font.bold: true
            anchors.top: gridView.bottom
            anchors.topMargin: 0
            anchors.bottom: controls.top
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pointSize: 38
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            id: controls
            y: 0
            height: 110
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Column {
                id: switchs
                width: 200
                height: 100
                anchors.left: parent.left
                anchors.leftMargin: 10

                Switch {
                    id: switchVibreur
                    width: 140
                    height: 40
                    text: qsTr("Vibreur")
                    anchors.top: parent.top
                    anchors.topMargin: 10
                }

                Switch {
                    id: switchSon
                    width: 140
                    height: 40
                    text: qsTr("Son")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                }
            }

            Button {
                id: buttonAction
                width: 100
                height: 100
                text: qsTr("Start/Stop")
                anchors.right: parent.right
                anchors.rightMargin: 10
                onClicked: {
                    if(timer.running)
                    {
                        dialTranquille.enabled = true;
                        dialSoutenu.enabled = true;
                        spinBoxTranquille.enabled = true;
                        spinBoxSoutenu.enabled = true;

                        timer.stop();
                    }
                    else
                    {
                        elapsed = 0;
                        lcd.color = colorTranquille;

                        dialTranquille.enabled = false;
                        dialSoutenu.enabled = false;
                        spinBoxTranquille.enabled = false;
                        spinBoxSoutenu.enabled = false;

                        timer.start();
                    }
                }
            }
        }
    }
}
