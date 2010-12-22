require 'gtk2'

def round_hex(value)
	if  value[2].to_s.hex > '9'.hex and value[0..1].hex < 255
		value[0..1].hex.next.to_s(16) 
	else
		value[0..1].hex.to_s(16)
	end
end

def color_to_hex(color)
	"##{round_hex(color[1,4])}#{round_hex(color[5,4])}#{round_hex(color[9,4])}"
end

colorSelection = Gtk::ColorSelectionDialog.new("VIM Color Selector")

response = colorSelection.run

if response == Gtk::Dialog::RESPONSE_OK
	colorObj = colorSelection.colorsel.current_color
	color = color_to_hex(colorObj.to_s)
	print color.send(ARGV.first || 'downcase')
end
