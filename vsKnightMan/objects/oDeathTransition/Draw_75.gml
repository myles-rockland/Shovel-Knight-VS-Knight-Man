/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (deathTallyCounter >= 60 && deathTallyCounter < 240)
{
	var player = instance_nearest(x, y, oPlayer1);
	draw_sprite(sDeathTallySpot, 0, 200, 100);
	draw_sprite(sDeathTallySkull, 0, 200, 93);
	draw_sprite(sSkMapMarker, deathTallyCounter div 30 % 2, 200, 91);
	draw_set_halign(fa_center);
	draw_text(200, 10, "player");
	draw_text(200, 20, player.gold);
}