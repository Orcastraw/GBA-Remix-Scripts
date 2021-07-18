import simpleaudio as sa

import subprocess
subprocess.Popen([r"D:/Remix/play/EmuHawk.exe"])

while True:
	result = open("toPlay.txt").readline().rstrip()
	if result == "menu":
		wave_obj = sa.WaveObject.from_wave_file("D:/Audio Work/Full Muffled Hanyuu Song.wav")
		play_obj = wave_obj.play()
		f = open("toPlay.txt", "w")
		f.write("menuActive\n")
		f.write(" ")
		f.close()
	if result == "menuClose":
		play_obj.stop()


	if result == "select":
		wave_obj = sa.WaveObject.from_wave_file("select.wav")
		play_obj = wave_obj.play()
		play_obj.wait_done()

	if result == "confirm":
		wave_obj = sa.WaveObject.from_wave_file("confirm.wav")
		play_obj = wave_obj.play()
		play_obj.wait_done()

	if result == "success":
		wave_obj = sa.WaveObject.from_wave_file("success.wav")
		play_obj = wave_obj.play()
		play_obj.wait_done()

	if result == "failure":
		wave_obj = sa.WaveObject.from_wave_file("failure.wav")
		play_obj = wave_obj.play()
		play_obj.wait_done()


