#!/usr/bin/python
#
# change-background.py
#
# A script to change to a random background image
#
# (c) 2004, Davyd Madeley <davyd@madeley.id.au>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2, or (at your option)
#   any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

backgrounds = "/home/ben/Photos/backgrounds"

import gconf
import os
import sys
import random
import mimetypes

class GConfClient:
        def __init__ (self):
                self.__client__ = gconf.client_get_default ()
        def get_background (self):
                return self.__client__.get_string ("/desktop/gnome/background/picture_filename")
        def set_background (self, background):
                self.__client__.set_string ("/desktop/gnome/background/picture_filename", background)


client = GConfClient ()

dir_items = os.listdir (os.path.join (os.environ["HOME"], backgrounds))
items = []


if len(sys.argv) > 1:
  print sys.argv[1]
  client.set_background (os.path.join (os.environ["HOME"], backgrounds, sys.argv[1] ))
  exit()

print "random now"
for item in dir_items:
        mimetype = mimetypes.guess_type (item)[0]
        if mimetype and mimetype.split ('/')[0] == "image":
                items.append (item)

item = random.randint (0, len (items) - 1)
current_bg = client.get_background ()

while (items[item] == current_bg):
        item = random.randint (0, len (items) - 1)

client.set_background (os.path.join (os.environ["HOME"], backgrounds, items[item]))
