local status_ok, colorizer = pcall(require, "colorizer")

if not status_ok then
  return
end

colorizer.setup({
  filetypes = { "*" },
  {
    RGB      = true,  -- #RGB hex codes #111
    RRGGBB   = true,  -- #RRGGBB hex codes #111111
    names    = false, -- "Name" codes like Blue
    RRGGBBAA = true,  -- #RRGGBBAA hex codes
    rgb_fn   = true,  -- CSS rgb() and rgba() functions
    hsl_fn   = true,  -- CSS hsl() and hsla() functions
    css      = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  },
  buftypes = {},
})
