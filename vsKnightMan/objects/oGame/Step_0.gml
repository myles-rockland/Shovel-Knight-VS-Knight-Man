/// @description Insert description here
// You can write your code in this editor
if (keyboard_check_pressed(vk_f11))
{
	window_set_fullscreen(!window_get_fullscreen());
}
cutsceneActive = instance_exists(oCutscene);
dialogueActive = instance_exists(oDialogueBox);