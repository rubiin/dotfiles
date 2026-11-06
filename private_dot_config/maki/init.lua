-- ~/.config/maki/init.lua

maki.setup({
	-- UI
	ui = {
		theme = "tokyonight",
		splash_animation = false,
		scrollbar = true,
		inline_images = true,
		notifications = "auto",
		mouse_scroll_lines = 5,
		max_input_lines = 20,
		thinking_lines = 3,

		-- Keep tool output readable without flooding the terminal.
		tool_output_lines = {
			bash = 5,
			code_execution = 3,
			grep = 3,
			web = 5,
			other = 3,
		},
	},

	-- Agent behavior
	agent = {
		max_output_lines = 3000,
		max_continuation_turns = 3,
		stale_read_check = true,
		rtk = true,
	},

	-- Provider
	provider = {
		connect_timeout_secs = 15,
		stream_timeout_secs = 300,
		max_retries = 3,
	},

	-- Storage
	storage = {
		max_log_files = 10,
		input_history_size = 200,
	},

	-- Plugins
	plugins = {
		bash = {
			timeout_secs = 180,
		},

		code_execution = {
			timeout_secs = 30,
			max_memory_mb = 100,
		},

		glob = {
			search_result_limit = 100,
		},

		grep = {
			search_result_limit = 100,
		},

		index = {
			max_file_size_mb = 4,
		},

		task = {
			allow_background = true,
			max_concurrent = 4,
		},

		edit = {
			edit_lines = true,
			insert_lines = true,
			multiedit = true,
		},

		webfetch = {
			max_response_bytes = 5242880,
		},

		websearch = {
			provider = "exa",
		},
	},
})
