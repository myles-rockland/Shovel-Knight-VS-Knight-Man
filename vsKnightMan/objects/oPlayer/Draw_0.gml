/// @description Insert description here
// You can write your code in this editor
if (xspd != 0 && currentState != "stunned" && currentState != "crouching")
{
	image_xscale = xspd * (1/abs(xspd));
}
image_alpha = int64(invulnerableCounter % 3 == 0);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);