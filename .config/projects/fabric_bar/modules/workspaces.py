from fabric.hyprland.widgets import Workspaces, WorkspaceButton

# Basic usage with default button factory
workspaces = Workspaces(

)

# Custom button factory to match your Waybar config
def custom_button_factory(workspace_id: int):
    # Match your format-icons: "1", "2", ..., "9", "0" for workspace 10
    label = str(workspace_id) if workspace_id != 10 else "0"
    return WorkspaceButton(id=workspace_id, label=label)

workspaces = Workspaces(buttons_factory=custom_button_factory)
