return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = {
    idle = {
      timeout = 120000, -- 2 minutes
    }
  }
}
