
require 'rubygems'
require 'gosu'

WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 480
TRACKS = []
LOCATIONS = []

module ZOrder
  BACKGROUND, IMAGE, IMAGES, TEXT = *0..3
end

class GUIMP < (Gosu::Window)
    
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = "GUI Music Player"
    @album1 = Gosu::Image.new("Images/Maggot_Brain.jpg")
    @album2 = Gosu::Image.new("Images/Electric_Ladyland.JPG")
    @album3 = Gosu::Image.new("Images/Madvillainy.JPG")
    @album4 = Gosu::Image.new("Images/reign_in_blood.jpg")
    @song = Gosu::Song.new("Funkadelic/Track_01.flac")
    @album_font = Gosu::Font.new(20)
    @prompt = "Please select an album to view songs!"
    @album_placeholder = ""
    @artist_placeholder = ""
    @track_count = 0
    @csong = -1
    read_file
  end

  def read_file
    @music_file = File.open("albums.txt", "r")
    @album_count = @music_file.gets.to_i
    @music_file.close
  end

  def read_album(choice)
    @prompt = ""
    case choice
    when 1
      album = File.open("album1.txt","r")
    when 2
      album = File.open("album2.txt","r")
    when 3
      album = File.open("album3.txt","r")
    when 4
      album = File.open("album4.txt","r")
    end
    album_name = album.gets
    @album_placeholder = album_name
    album_artist = album.gets
    @artist_placeholder = album_artist
    @album_art_location = album.gets
    @track_count = album.gets.to_i
    read_tracks(album)
    album.close
  end

  def read_tracks(album)
    index = 0
    while index < @track_count
      TRACKS[index] = album.gets
      location = album.gets.chomp
      LOCATIONS[index] = location
      index += 1
    end
    while index < 15
      TRACKS[index] = ""
      LOCATIONS[index] = ""
      index += 1
    end
  end

  def current_song(track)
    @song.stop
    @prompt = "Now Playing: " + TRACKS[track].to_s
    @csong = track
    @currentsong = LOCATIONS[track]
    @currentsong = @currentsong.chomp
    @currentsong = @currentsong.to_s
    @song = Gosu::Song.new(@currentsong)
    @song.play
  end

  def needs_cursor?
    true
  end

  def update
    if (@track_count != 0)
      if @song.playing? == false
        @csong += 1
        @prompt = "Now Playing: " + TRACKS[@csong].to_s
        currentsong = LOCATIONS[@csong]
        currentsong = currentsong.chomp
        currentsong = currentsong.to_s
        @song = Gosu::Song.new(currentsong)
        @song.play
      end
    end
  end

  def draw
    Gosu.draw_rect(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, Gosu::Color::WHITE, ZOrder::BACKGROUND, mode=:default) #Background
    @album1.draw(0, 0, ZOrder::IMAGE, scale_x = 1, scale_y = 1)           #Album 1
    @album2.draw(240, 0, ZOrder::IMAGE, scale_x = 1, scale_y = 1)         #Album 2
    @album3.draw(0, 240, ZOrder::IMAGES, scale_x = 1, scale_y = 1)        #Album 3
    @album4.draw(236, 240, ZOrder::IMAGE, scale_x = 1, scale_y = 1)       #Album 4
    Gosu.draw_rect(480, 5, 510, 100, Gosu::Color::BLACK, ZOrder::IMAGES)  #Top Panel
    Gosu.draw_rect(480, 110, 510, 2, Gosu::Color::BLACK, ZOrder::IMAGES)  #Divider Line
    Gosu.draw_rect(480, 119, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 1
    Gosu.draw_rect(480, 141, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 2
    Gosu.draw_rect(480, 163, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 3
    Gosu.draw_rect(480, 185, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 4
    Gosu.draw_rect(480, 207, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 5
    Gosu.draw_rect(480, 229, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 6
    Gosu.draw_rect(480, 251, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 7
    Gosu.draw_rect(480, 273, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 8
    Gosu.draw_rect(480, 295, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 9
    Gosu.draw_rect(480, 317, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 10
    Gosu.draw_rect(480, 339, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 11
    Gosu.draw_rect(480, 361, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 12
    Gosu.draw_rect(480, 383, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 13
    Gosu.draw_rect(480, 405, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 14
    Gosu.draw_rect(480, 427, 510, 20, Gosu::Color::BLACK, ZOrder::IMAGES) #Placeholder 15
    Gosu.draw_rect(480, 460, 510, 2, Gosu::Color::BLACK, ZOrder::IMAGES)  #Bottom Line
    @album_font.draw_text(@prompt, 490, 20, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text("Album: ", 490, 40, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text("Artist: ", 490, 60, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(@album_placeholder, 570, 40, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(@artist_placeholder, 570, 60, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[0], 570, 119, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[1], 570, 141, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[2], 570, 163, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[3], 570, 185, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[4], 570, 207, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[5], 570, 229, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[6], 570, 251, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[7], 570, 273, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[8], 570, 295, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[9], 570, 317, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[10], 570, 339, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[11], 570, 361, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[12], 570, 383, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[13], 570, 405, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
    @album_font.draw_text(TRACKS[14], 570, 427, ZOrder::TEXT, 1.0, 1.0, Gosu::Color::WHITE)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
    if id == Gosu::MsLeft
      if (mouse_x > 0 and mouse_x < 240) and (mouse_y > 0 and mouse_y < 240) #Album 1 Coordinates
        read_album(1)
      end
      if (mouse_x > 240 and mouse_x < 480) and (mouse_y > 0 and mouse_y < 240) #Album 2 Coordinates
        read_album(2)
      end
      if (mouse_x > 0 and mouse_x < 240) and (mouse_y > 240 and mouse_y < 480) #Album 3 Coordinates
        read_album(3)
      end
      if (mouse_x > 240 and mouse_x < 480) and (mouse_y > 240 and mouse_y < 480) #Album 4 Coordinates
        read_album(4)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 119 and mouse_y < 139 ) and (@track_count > 0) #Track 1 Coordinates
        current_song(0)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 141 and mouse_y < 161 ) and (@track_count > 0) #Track 2 Coordinates
        current_song(1)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 163 and mouse_y < 183 ) and (@track_count > 0) #Track 3 Coordinates
        current_song(2)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 185 and mouse_y < 205 ) and (@track_count > 0) #Track 4 Coordinates
        current_song(3)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 207 and mouse_y < 227) and (@track_count > 0) #Track 5 Coordinates
        current_song(4)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 229 and mouse_y < 249) and (@track_count > 0) #Track 6 Coordinates
        current_song(5)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 251 and mouse_y < 271 ) and (@track_count > 0) #Track 7 Coordinates
        current_song(6)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 273 and mouse_y < 293) and (@track_count > 0) #Track 8 Coordinates
        current_song(7)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 295 and mouse_y < 315 ) and (@track_count > 0) #Track 9 Coordinates
        current_song(8)
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 317 and mouse_y < 337 ) and (@track_count > 0) #Track 10 Coordinates
        if @track_count >= 10
          current_song(9)
        end
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 339 and mouse_y < 359 ) and (@track_count > 0) #Track 11 Coordinates
        if @track_count >= 11
          current_song(10)
        end
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 361 and mouse_y < 381 ) and (@track_count > 0) #Track 12 Coordinates
        if @track_count >= 12
          current_song(11)
        end
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 383 and mouse_y < 403 ) and (@track_count > 0) #Track 13 Coordinates
        if @track_count >= 13
          current_song(12)
        end
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 405 and mouse_y < 425 ) and (@track_count > 0) #Track 14 Coordinates
        if @track_count >= 14
          current_song(13)
        end
      end
      if (mouse_x > 480 and mouse_x < 990 ) and (mouse_y > 427 and mouse_y < 447 ) and (@track_count > 0) #Track 15 Coordinates
        if @track_count >= 15
          current_song(14)
        end
      end
    end
  end
end

GUIMP.new.show