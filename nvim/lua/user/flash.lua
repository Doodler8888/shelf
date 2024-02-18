require('flash').setup {
    highlight_matches_on_search_start = false,  -- Disable highlighting immediately
    only_search = true,                        -- Activate only for searches
    keys = {                                   -- Assign only '/' and '?'
        search_activate = { '/', '?' },
    },
    modes = {
	char = {
	    enabled = false
	}
    }
}
