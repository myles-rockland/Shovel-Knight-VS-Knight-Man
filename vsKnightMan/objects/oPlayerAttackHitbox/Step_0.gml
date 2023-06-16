/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer);
if (player.pogoing)
{
	x = player.x;
	y = player.y + player.yspd - 8;
}
else
{
	x = player.x + (player.image_xscale * 25);
	y = player.y - 16;
}
if (place_meeting(x, y, oEnemy))
{
	var enemy = instance_place(x, y, oEnemy);
	enemy.currentHealth--;
	instance_destroy();
}