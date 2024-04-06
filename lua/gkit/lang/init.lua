
local run = require("gkit/safe").run


local function setup()
  run(require("gkit/lang/md").setup)
end



return {
  setup = setup
}
