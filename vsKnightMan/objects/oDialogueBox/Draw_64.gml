/// @description Insert description here
// You can write your code in this editor
draw_self(); //Draw box above HUD

//Setting text formatting
draw_set_font(shovelFont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

//Drawing text
var _len = string_length(text[text_current]);
if (char_current < _len)
{
	char_current += char_speed;
}
var _str = string_copy(text[text_current], 1, char_current);
draw_text(text_x, text_y,  _str);

//Drawing dialogue boxes
if (string_starts_with(text[text_current], "knight man"))
{
	draw_sprite(sEnemyDialogue, 0, 0, 0);
}
else
{
	draw_sprite(sPlayerDialogue, 0, 0, 0);
}