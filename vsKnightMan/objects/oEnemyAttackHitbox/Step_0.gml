/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer1); //change player object as needed
var enemy = instance_nearest(x, y, oEnemy);
x = enemy.x + (enemy.image_xscale * 40);
y = enemy.y;
if (place_meeting(x, y, player) && player.currentState != "dead" && player.currentState != "dying" && player.currentState != "stunned" && player.invulnerableCounter == 0)
{
	player.currentState = "stunned";
	player.yspd = -3;
	player.currentHealth--;
	if (player.currentHealth == 0)
	{
		player.yspd = -5;
	}
}
//Destroy self
if (enemy.throwingCounter == 10)
{
	instance_destroy();
}