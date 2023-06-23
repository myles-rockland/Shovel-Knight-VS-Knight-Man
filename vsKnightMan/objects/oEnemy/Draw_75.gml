/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer1);
var bgColours = [c_maroon, c_teal, c_orange, c_red, c_lime, c_green, c_fuchsia];

if (currentState == "dying")
{
	game_set_speed(20, gamespeed_fps); //Slow the game down and draw crazy colours
	dyingCounter++;
	if (dyingCounter % 5 == 0)
	{
		draw_set_colour(bgColours[round(random_range(0, array_length(bgColours) - 1))]);
	}
	draw_rectangle(0, 0, 400, 240, false);
	draw_sprite_ext(player.sprite_index, player.image_index, floor(player.x), floor(player.y), player.image_xscale, player.image_yscale, player.image_angle, c_white, player.image_alpha);
	draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, c_white, image_alpha);
}
else if (currentState == "crouching")
{
	game_set_speed(60, gamespeed_fps);
}