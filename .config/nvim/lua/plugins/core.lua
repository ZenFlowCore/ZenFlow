return {
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.dashboard"

      -- Set your custom header
      dashboard.section.header.val = require("dashboard-images").zen
      -- Custom buttons/options
      dashboard.section.buttons.val = {}
      -- Optional: Add a footer
      dashboard.section.footer.val = {
        "Made in Heaven",
      }
      dashboard.config.layout = {
        { type = "padding", val = 6 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }
      alpha.setup(dashboard.config)
    end,
  },
}
