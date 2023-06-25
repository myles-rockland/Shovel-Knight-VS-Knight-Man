/// @description Insert description here
// You can write your code in this editor
confirmKeyPressed = (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(vk_space)) || (gamepad_button_check_pressed(0,gp_face1));
var player = instance_nearest(x, y, oPlayer1);
var enemy = instance_nearest(x, y, oEnemy);
player.currentState = "armorGet"; //Be still
player.xspd = 0;
player.yspd = 0;
enemy.currentState = (enemy.currentState == "crouching") ? "crouching" : "idle";

if (!confirmed && image_index > 3 && image_index < 4)
{
	image_speed = 0;
	if (confirmKeyPressed)
	{	
		confirmed = true;
		audio_play_sound(sfxArmourGetBoxClose, 0, false);
		image_speed = 1;
	}
}