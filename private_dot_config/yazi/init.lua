---@diagnostic disable: undefined-global


-- Show user and hostname in top bar
function Header:host()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Line { ui.Span(ya.user_name() .. "@" .. ya.host_name()):fg("lightgreen"):bold(true), ui.Span(":") }
end

function Header:render(area)
	self.area = area

	local right = ui.Line { self:count(), self:tabs() }
	local left = ui.Line {
    self:host(),
    self:cwd(math.max(0, area.w - right:width())):fg("blue"),
    ui.Span("/"):fg("blue"):bold(true),
    ui.Span(tostring(cx.active.current.hovered.name)):fg("white"):bold(true),
  }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
	}
end

-- Show symlink path in status bar
function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end

 	local linked = ""
 	if h.link_to ~= nil then
 		linked = " -> " .. tostring(h.link_to)
 	end
 	return ui.Span(" " .. h.name .. linked)
end

-- Remove file size from status bar
function Status:render(area)
	self.area = area

	local left = ui.Line { self:mode(), self:name() }
	local right = ui.Line { self:permissions(), self:position() }
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end

