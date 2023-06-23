/// @description Insert description here
// You can write your code in this editor
draw_self(); //Draw box above HUD.

//Setting text formatting
draw_set_font(shovelFont);
draw_set_colour(c_white);

//Drawing the text
draw_text(7, 8, "equip the armor?");
draw_text(130, 30, "yes");
draw_text(270, 30, "no");

//Drawing the selection box
if (selection == 0) //yes
{
	draw_sprite(sSelectionBoxLeft, selectionAnimCounter div 30 % 2, 122, 26);
	draw_sprite(sSelectionBoxRight, selectionAnimCounter div 30 % 2, 122 + string_width("yes"), 26);
}
else //no
{
	draw_sprite(sSelectionBoxLeft, selectionAnimCounter div 30 % 2, 261, 26);
	draw_sprite(sSelectionBoxRight, selectionAnimCounter div 30 % 2, 261 + string_width("no"), 26);
}