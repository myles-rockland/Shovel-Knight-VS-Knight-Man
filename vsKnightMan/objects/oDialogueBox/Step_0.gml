/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer1);
//Force the player to be still
if (player.currentState == "jumping" && !player.jumpKeyPressed)
{
	player.currentState = "jumping"; //Let the player fall if they are still in the air
}
else if (player.currentState == "pogoing")
{
	player.currentState = "pogoing"; //Let the player fall if they are still in the air
}
else if (player.currentState == "crouching")
{
	player.currentState = "crouching"; //Allow crouching
	player.xspd = 0;
	player.yspd = 0;
}
else
{
	player.currentState = "idle"; //Be still
	player.xspd = 0;
	player.yspd = 0;
}