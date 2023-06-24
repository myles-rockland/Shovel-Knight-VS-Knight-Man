/// @description Insert description here
// You can write your code in this editor
var _pos = audio_sound_get_track_position(bgm);
if (_pos > totalLength)
{
	audio_sound_set_track_position(bgm, _pos - loopLength);
}