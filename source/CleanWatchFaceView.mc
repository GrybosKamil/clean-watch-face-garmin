using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

using Toybox.System;

class CleanWatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
        updateBatteryLabel();
        updateTimeLabel();
        updateDateLabel();

        View.onUpdate(dc);
    }

    function updateTimeLabel() {
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [
            clockTime.hour, 
            clockTime.min.format("%02d")
            ]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
    }

    function updateDateLabel() {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$ $3$", [
            today.day,
            today.month,
            today.year
            ]);
        var view = View.findDrawableById("DateLabel");
        view.setText(dateString);
    }

    function updateBatteryLabel() {
        var stats = System.getSystemStats();
        var pwr = stats.battery;
        var view = View.findDrawableById("BatteryLabel");
        view.setColor(getBatteryStatusColor(pwr));
        view.setText(formatBatteryStatusValue(pwr));
    }

    function formatBatteryStatusValue(pwr) {
        if (pwr >= 100.0) {
            return "100%";
        } else {
            return Lang.format("$1$%", [ pwr.format("%2.1f") ] );
        }
    }

    function getBatteryStatusColor(pwr) {
        if (pwr >= 50.0) {
            return Graphics.COLOR_GREEN;
        }
        if (pwr >= 20.0) {
            return Graphics.COLOR_BLUE;
        }
        if (pwr >= 10.0) {
            return Graphics.COLOR_YELLOW;
        }
        if (pwr >= 5.0) {
            return Graphics.COLOR_ORANGE;
        }
        return Graphics.COLOR_RED;
    }

    function getBatteryStatusFont(pwr) {
        if (pwr >= 20.0) {
            return Graphics.FONT_SMALL;
        }
        if (pwr >= 10.0) {
            return Graphics.FONT_MEDIUM;
        }
        return Graphics.FONT_LARGE;
    }

    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }

}
