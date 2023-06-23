/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer1); //change player object as needed
var enemy = instance_nearest(x, y, oEnemy);
x = enemy.x + (enemy.image_xscale * 40);
y = enemy.y;
if (place_meeting(x, y, player) && player.currentState != "dead" && player.currentState != "dying" && player.currentState != "stunned" && player.invulnerableCounter == 0)
{
	if (player.currentState == "crouching" && global.armourType == 1 && player.image_xscale != enemy.image_xscale) // && player.image_xscale != enemy.image_xscale
	{
			player.xspd +=  7 * enemy.image_xscale;
			if (enemy.throwingCounter % 5 == 0)
			{
				audio_play_sound(sfxSkBlock, 0, false);
			}
	}
	else
	{
		player.currentState = "stunned";
		player.yspd = -3;
		player.currentHealth--;
		if (player.currentHealth == 0)
		{
			player.yspd = -5;
		}
		audio_play_sound(sfxSkHurt, 0, false);
	}
}
//Destroy self
if (enemy.throwingCounter == 10)
{
	instance_destroy();
}