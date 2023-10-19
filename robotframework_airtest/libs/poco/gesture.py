from time import sleep
from airtest.core.win.win import Windows
from poco.gesture import PendingGestureAction


class WindowsPendingGestureAction(PendingGestureAction):
    def up(self):
        device: Windows = self.pocoobj.device

        events = self.track.discretize()

        for event in events:
            action_type = event[0]

            if action_type == "d":
                x, y = event[1]
                x, y = self._normalized2window((x, y))
                pos = device._action_pos((x, y))
                device.mouse.press("left", pos)
            elif action_type == "m":
                x, y = event[1]
                x, y = self._normalized2window((x, y))
                pos = device._action_pos((x, y))
                device.mouse.move(pos)
            elif action_type == "u":
                pos = self._normalized2window(self.track.last_point)
                pos = device._action_pos((x, y))
                device.mouse.release("left", pos)
            elif action_type == "s":
                how_long = event[1]
                sleep(how_long)
            else:
                raise ValueError("Unknown event type {}".format(repr(type)))

    def _normalized2window(self, pos: tuple) -> tuple:
        size = self.pocoobj.device.get_current_resolution()
        return int(pos[0] * size[0]), int(pos[1] * size[1])
