/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer1); //change player object as needed
var enemy = instance_nearest(x, y, oEnemy);
x = player.x + (player.image_xscale * 25);
y = player.y - 16;
if (place_meeting(x, y, enemy))
{
	player.xspd -=  7 * player.image_xscale;
	if (!(enemy.currentState == "teleporting" || enemy.currentState == "crouching" || enemy.currentState == "dying" || enemy.currentState == "replenishing" || (enemy.currentState == "blockingSide" && player.image_xscale != enemy.image_xscale)))
	{
		enemy.currentHealth--;
		enemy.hitCounter = 1;
	}
	instance_destroy();
}
//Destroy self
if (player.attackCounter == 13 || player.landed || player.grounded && player.jumpKeyPressed || player.currentState == "stunned")
{
	instance_destroy();
}