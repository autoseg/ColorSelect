require 'gtk2'

class Color
  attr_accessor :color, :alpha

  def initialize(color_selector)
    @color = color_selector.current_color
      @alpha = color_selector.current_alpha
  end

  def get_color(type)
    case type
    when :hex
      "##{round_hex(@color.red)}#{round_hex(@color.green)}#{round_hex(@color.blue)}"
    when :rgb
      "rgb(#{rgb_value})"
    when :rgba
      "rgba(#{rgb_value}, #{"%.2f" % (lowbase(@alpha).to_f/255.to_f)})"
    end
  end

  private
  def rgb_value
    "#{lowbase(@color.red)}, #{lowbase(@color.green)}, #{lowbase(@color.blue)}"
  end

  def lowbase(value)
    value * 256 / 65536
  end

  def round_hex(value)
    lowbase(value).to_s(16).ljust(2,'0')
  end

end

window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
window.set_title  "VIM Color Selector"
window.border_width = 10
window.set_size_request(-1,-1)

window.signal_connect('delete_event') { Gtk.main_quit }

vbox = Gtk::VBox.new false, 0 

color_selector = Gtk::ColorSelection.new
color_selector.has_opacity_control = true

notebook = Gtk::Notebook.new
notebook.show_tabs = false

notebook.append_page color_selector

vbox.pack_start notebook, true, false, 0 

radio = {}
radio[:hex] = Gtk::RadioButton.new "Hexadecimal"
radio[:rgb] = Gtk::RadioButton.new radio[:hex], "rgb"
radio[:rgba] = Gtk::RadioButton.new radio[:rgb], "rgba"

button_ok = Gtk::Button.new 'Ok'
button_cancel = Gtk::Button.new 'Cancel'


radios_box = Gtk::HBox.new false, 0 
radios_box.pack_start radio[:hex], true, false, 0
radios_box.pack_start radio[:rgb], true, false, 0
radios_box.pack_start radio[:rgba], true, false, 0

actions_box = Gtk::HBox.new false, 0
actions_box.pack_start button_ok, true, false, 15
actions_box.pack_start button_cancel, true, false, 15

vbox.pack_start radios_box, true, false, 0
vbox.pack_start actions_box, true, false, 0

hbox = Gtk::HBox.new false, 0 
hbox.pack_start vbox, false, false, 0

if ARGV.first
  if %w(hex rgb rgba).include?( ARGV.first.downcase || 'hex' )
    radio[ARGV.first.downcase.to_sym].set_active true
  end
end

button_ok.signal_connect 'clicked' do

  radio.select! { |key, radio_button| radio_button.active? } 

  color_object = Color.new(color_selector)

  print color = color_object.get_color(radio.keys.first).send(ARGV.last || 'downcase')

  Gtk.main_quit

end

button_cancel.signal_connect 'clicked' do
  Gtk.main_quit
end

window.add(hbox)
window.show_all
Gtk.main
