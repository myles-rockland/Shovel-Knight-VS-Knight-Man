/// @description Insert description here
// You can write your code in this editor
//draw_text(50, 50, choices[selection]);
if (!titleSelected)
{
	draw_self();
	
	if (image_index > 3 && image_index < 4)
	{
		draw_set_font(shovelFont);
		draw_set_colour(c_white);

		//Draw menu choices
		for (var i = 0; i < array_length(choices); i++)
		{
			draw_text(floor(119), floor(100 + (12 * i)), choices[i]);
		}

		//Draw selection box
		draw_sprite(sSelectionBoxLeft, cursorAnimCounter div 30 % 2, 115, 96 + (12 * selection));
		draw_sprite(sSelectionBoxRight, cursorAnimCounter div 30 % 2, 106 + string_width(choices[selection]), 96 + (12 * selection));
	}
}