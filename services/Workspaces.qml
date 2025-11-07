pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
    property var workspaces: Hyprland.workspaces
    property var focusedWorkspaceId: Hyprland.focusedWorkspace

    function dispatch(id: int): void {
        Hyprland.dispatch("workspace " + id);
    }
}
