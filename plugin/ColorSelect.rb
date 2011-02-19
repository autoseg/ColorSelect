require 'gtk2'

def lowbase(value)
  lowbase = value * 256 / 65536
end

def round_hex(value)
  lowbase(value).to_s(16).ljust(2,'0')
end

def color_to_hex(color)
  "##{round_hex(color.red)}#{round_hex(color.green)}#{round_hex(color.blue)}"
end

def color_to_rgba(color, alfaObj)
  "rgba(#{lowbase(color.red)}, #{lowbase(color.green)}, #{lowbase(color.blue)}, #{"%.2f" % (lowbase(alfaObj).to_f/255.to_f)})"
end

colorSelection = Gtk::ColorSelectionDialog.new("VIM Color Selector")
colorsel = colorSelection.colorsel
colorsel.has_opacity_control = true

response = colorSelection.run

if response == Gtk::Dialog::RESPONSE_OK
  colorObj = colorsel.current_color
  alfaObj = colorsel.current_alpha
  if ARGV.first == 'rgba'
    print color_to_rgba(colorObj, alfaObj)
  else
    color = color_to_hex(colorObj)
    print color.send(ARGV.last || 'downcase')
  end
end
