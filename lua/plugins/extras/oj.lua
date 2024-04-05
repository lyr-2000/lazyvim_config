return {
  {
    'xeluxee/competitest.nvim', -- see: https://github.com/xeluxee/competitest.nvim
    dependencies = 'MunifTanjim/nui.nvim',
    config = function() 
      require('competitest').setup() 


    end,
  }
}
