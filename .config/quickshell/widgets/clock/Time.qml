pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
  id: root

  readonly property string time: {
    // The passed format string matches the default output of
    // the `date` command
    Qt.formatDateTime(clock.date, "hh\nmm\nss ")

  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
