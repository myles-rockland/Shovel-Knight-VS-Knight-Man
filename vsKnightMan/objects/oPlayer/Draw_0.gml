/// @description Insert description here
// You can write your code in this editor
if (sprite_index != sPlayerGetArmor && (instance_nearest(x, y, oGame)).armourType == 1)
{
	sprite_index = asset_get_index(sprite_get_name(sprite_index) + "Alt");
}
if (xspd != 0 && state != stunState && state != attackState && state != dyingState)
{
	image_xscale = sign(xspd);
}
image_alpha = int64(invulnerableCounter % 3 == 0);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);