local map = vim.keymap.set
-- jq -R 'try fromjson catch .'
-- -- map("n", "Q", "<cmd>%!jq .<CR>", { buffer = true, noremap = true })
-- map("n", "Q", "<cmd>%!jq -R \"fromjson? | . \" -c | jq .<CR>", { buffer = true, noremap = true })
map(
	"n",
	"Q",
	'<cmd>%!jq -R "fromjson? | ." | jq -s . | jq "sort_by(.messageNumber) | .[]"<CR>',
	{ buffer = true, noremap = true }
)
