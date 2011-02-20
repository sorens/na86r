#!/usr/bin/env ruby
require 'curses'

STATUS_LINE = 10

def write(line, column, text)
  Curses.setpos(line, column)
  Curses.addstr(text);
end

def init_screen
  Curses.noecho # do not show typed keys
  Curses.init_screen
  Curses.stdscr.keypad(true) # enable arrow keys
  begin
    yield
  ensure
    Curses.close_screen
  end
end

def display(message)
  write 0,0,message
end


init_screen do
  write(STATUS_LINE+1, 0, "q=Quit r=Reset a=AI-move")

  loop do

    case Curses.getch
    when Curses::Key::UP then display "UP"
    when Curses::Key::DOWN then display "DOWN"
    when Curses::Key::RIGHT then display "RIGHT"
    when Curses::Key::LEFT then display "LEFT"
    when ?q then break
    end
  end
end