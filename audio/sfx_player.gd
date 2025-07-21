extends AudioStreamPlayer

@export var music_player: AudioStreamPlayer
@export var songs: Array[AudioStream] = []

func play_random_song():
	var random_index = randi() % songs.size()
	music_player.stream = songs[random_index]
	music_player.play()
	music_player.connect("finished", Callable(self, "_on_music_finished"))

func _on_music_finished():
	music_player.disconnect("finished", Callable(self, "_on_music_finished"))
	play_random_song()

func stop_music():
	music_player.stop()
	music_player.disconnect("finished", Callable(self, "_on_music_finished"))

func playDialogueClick():
	$dialogueClick.play()

func playDialogueTalk():
	$dialogueTalk.play()

func playStairs():
	$stairs.play()

func playStairs2():
	$stairs2.play()

func stopIntro():
	$musicIntro.stop()
