local M = {}

local yapf = {
	formatCommand = 'yapf --quiet',
	formatStdin = true
}

local prettier = {
	formatCommand = "prettier --stdin-filepath=${INPUT} --tab-width=4",
	formatStdin = true,
}

local goimports = {
	formatCommand = "goimports",
	formatStdin = true,
}

local rustfmt = {
	formatCommand = "rustfmt",
	formatStdin = true,
}

local shellcheck = {
	lintCommand = 'shellcheck -f gcc -x',
	lintSource = 'shellcheck',
	lintFormats = {
		'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m',
		'%f:%l:%c: %tote: %m'
	}
}

M.languages = {
	python = {yapf},
	javascript = {prettier},
	html = {prettier},
	go = {goimports},
	sh = {shellcheck},
	rust = {rustfmt}
}

M.filetypes = {}
for k, _ in pairs(M.languages) do
	M.filetypes[#M.filetypes + 1] = k
end

return M
