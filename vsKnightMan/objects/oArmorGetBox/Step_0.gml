/// @description Insert description here
// You can write your code in this editor
confirmKeyPressed = keyboard_check_pressed(ord("K"));
var player = instance_nearest(x, y, oPlayer1);
var enemy = instance_nearest(x, y, oEnemy);
player.currentState = "armorGet"; //Be still
player.xspd = 0;
player.yspd = 0;
enemy.currentState = (enemy.currentState == "crouching") ? "crouching" : "idle";


if (confirmKeyPressed)
{
	newDialogue(["\\0knight man: Your chivalry is honorable. now...", "\\0knight man: it is time to decide with this fight which of us is a \\strue warrior\\0!"]);
	audio_play_sound(sfxArmourGetBoxClose, 0, false);
	audio_play_sound(sfxArmourEquip, 0, false);
	instance_destroy();
}