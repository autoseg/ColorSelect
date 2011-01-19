require 'gtk2'

def round_hex(value)
  lowbase = value * 256 / 65536
  lowbase.to_s(16).ljust(2,'0')
end

def color_to_hex(color)
	"##{round_hex(color.red)}#{round_hex(color.green)}#{round_hex(color.blue)}"
end

colorSelection = Gtk::ColorSelectionDialog.new("VIM Color Selector")

response = colorSelection.run

if response == Gtk::Dialog::RESPONSE_OK
	colorObj = colorSelection.colorsel.current_color
	puts colorObj.to_s
	color = color_to_hex(colorObj)
	print color.send(ARGV.first || 'downcase')
end
