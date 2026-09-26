pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property string artist: ""
    property string song: ""
    property string artUrlPath: ""
    property bool musicPlaying: false
    property int songLength: 1
    property double position: 0
    property double newPos: 0

    Process {
        id: titleProc
        command: ["playerctl", "--player=spotify", "metadata", "title"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: song = this.text.trim()
        }
    }

    Process {
        id: artistProc
        command: ["playerctl", "--player=spotify", "metadata", "artist"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: artist = this.text.trim()
        }
    }

    Process {
        id: songLen
        command: ["playerctl", "--player=spotify", "metadata", "mpris:length"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                songLength = this.text / 1000000;
            }
        }
    }

    Process {
        id: songPos
        command: ["playerctl", "--player=spotify", "position"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                position = this.text;
            }
        }
    }

    Process {
        id: updatePos
        command: ["playerctl", "--player=spotify", "position", newPos]
        running: false
    }

    function updateSongPos(newPosition) {
      newPos = newPosition
      updatePos.running = true
    }

    Process {
        id: arturl
        command: ["playerctl", "--player=spotify", "metadata", "mpris:artUrl"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                artUrlPath = this.text.trim();
            }
        }
    }

    Process {
        id: playStatus
        command: ["playerctl", "--player=spotify", "status"]
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.trim() == "Playing") {
                    musicPlaying = true;
                    //console.log("playing: " + musicPlaying)
                } else if (this.text.trim() == "Paused") {
                    musicPlaying = false;
                    //console.log("paused: " + musicPlaying)
                }
            }
        }
    }

    Process {
        id: playNext
        command: ["playerctl", "--player=spotify", "next"]
        running: false
    }
    function nextSong() {
        playNext.running = true;
        metadataBuffer.running = true;
    }

    Process {
        id: playPrevious
        command: ["playerctl", "--player=spotify", "previous"]
        running: false
    }
    function lastSong() {
        playPrevious.running = true;
        metadataBuffer.running = true;
    }

    Timer {
        id: playBuffer
        interval: 100
        running: true
        repeat: false

        onTriggered: {
            playStatus.running = true;
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true

        onTriggered: {
            metadataBuffer.running = true;
            playStatus.running = true;
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            songPos.running = true;
        }
    }

    Process {
        id: playPauseMusic
        command: ["playerctl", "--player=spotify", "play-pause"]

        onExited: {
            updateMusicStatus();
        }
    }

    function playMusic() {
        playPauseMusic.running = true;
    }

    function updateMusicStatus() {
        playBuffer.running = true;
    }

    function updateMetadata() {
        arturl.running = true;
        artistProc.running = true;
        titleProc.running = true;
        songLen.running = true;
    }
    Timer {
        id: metadataBuffer
        interval: 100
        running: true
        repeat: false

        onTriggered: {
            updateMetadata();
        }
    }
}
