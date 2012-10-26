import sys
import os
import win32gui
import time

class Spotify(object):

  APPCOMMAND      = 0x0319

  # Command IDs
  CMD_NONE        = 0
  CMD_PLAYPAUSE   = 917504
  CMD_MUTE        = 524288
  CMD_VOLUMEDOWN  = 589824
  CMD_VOLUMEUP    = 655360
  CMD_STOP        = 851968
  CMD_PREVIOUS    = 786432
  CMD_NEXT        = 720896

  _hwnd            = None
  muted            = False
  adverts=[]
  prev         = ''

  def __init__(self):
    self._hwnd = win32gui.FindWindow("SpotifyMainWindow", None)
    reader=open('/home/ben/.scripts/.adverts','r')
    self.adverts=reader.read().split('\n')
    reader.close()

  def daemon(self):
    while True:
      time.sleep(1)
      if self.isPlaying() and not self.prev == self.__str__():
        self.prev = self.__str__()
        if self.isAdvert():
          self.mute()
        else:
          sys.stdout.write('playing: ' + self.__str__() + '\n')
          self.unmute()

  def isAdvert(self):
    return self.getCurrentArtist() == 'Spotify' or self.__str__() in self.adverts

  def setAdvert(self):
    if not self.isPlaying():
      self.playpause() #now muted and playing again

    self.adverts.append(self.__str__())
    writer=open('/home/ben/.scripts/.adverts','w')
    writer.write('\n'.join(self.adverts))
    writer.close()
    self.muted=True
      
    self.daemon()

  def playpause(self):
    self._sendCommand(self.CMD_PLAYPAUSE)

  def mute(self):
    if not self.muted:
      sys.stdout.write('\033[31;5;75mMUTING\033[0m (advert: ' + self.__str__() + ')\n')
      os.system('/usr/bin/notify-send -i /home/ben/Photos/angry_face.png "Muted Spotify advert"')
      self.playpause()
      time.sleep(1)
      os.system('/bin/bash -c "amixer sset Master off" > /dev/null')
      time.sleep(1)
      self.playpause()
    self.muted=True

  def unmute(self):
    if self.muted:
      sys.stdout.write('\033[38;5;75mUNMUTING\033[0m\n')
      os.system('/usr/bin/notify-send -i /home/ben/Photos/awesome_face.png "Spotify advert finished"')
      os.system('/bin/bash -c "amixer sset Master on" > /dev/null')
    self.muted=False

  def getCurrentTrack(self):
    return self._parseWindowTitle()['track']

  def getCurrentArtist(self):
    return self._parseWindowTitle()['artist']

  def isPlaying(self):
    return self.getCurrentArtist() != None

  def _sendCommand(self, id):
    win32gui.SendMessage(self._hwnd, self.APPCOMMAND, 0, id)

  def _parseWindowTitle(self):
    trackinfo = win32gui.GetWindowText(self._hwnd).split(" - ")

    if len(trackinfo) == 1:
      return {'artist': None, 'track': None}

    artist, track = trackinfo[1].split(" \x96 ")
    return {'artist': artist, 'track': track}

  def __str__(self):
    return self.getCurrentArtist()+ " - "+self.getCurrentTrack()

# Dict of spotify commands available from command line
COMMANDLINE_COMMANDS = {
    'currenttrack': Spotify.getCurrentTrack,
    'currentartist': Spotify.getCurrentArtist,
    'status': Spotify.__str__,
    'daemon': Spotify.daemon,
    'setAdvert': Spotify.setAdvert
}

if __name__ == "__main__":
  def fail():
    print "Usage: pytify.py "+"|".join(COMMANDLINE_COMMANDS.keys())
    sys.exit(0)

  if len(sys.argv) < 2: fail()

  cmd_name = sys.argv[1]
  if not COMMANDLINE_COMMANDS.has_key(cmd_name): fail()

  cmd = COMMANDLINE_COMMANDS[cmd_name]

  spotify = Spotify()

  res = cmd(spotify)
  if res: print res
