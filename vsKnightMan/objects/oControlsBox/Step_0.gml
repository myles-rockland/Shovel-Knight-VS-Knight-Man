/// @description Insert description here
// You can write your code in this editor
confirmKeyPressed = (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(vk_space));

if (confirmKeyPressed)
{
	audio_play_sound(sfxBack, 0, false);
	instance_destroy();
}