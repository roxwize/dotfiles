#!/usr/bin/env python3

from datetime import datetime
from sys import argv
from time import sleep

months = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")

inception = 2024 # 30 nov 24 21:37
now = datetime.now().timetuple()
day = now.tm_yday

month = day // 14
if month >= 26:
	month = "+"
else:
	month = months[month]

out = str(now.tm_year - inception).zfill(2) + month + str(day % 14 - 1).zfill(2)
try:
	_ = argv.index("-y")
	print("date|string|" + out + "\n")
except ValueError:
	print(out)
