/// @description Insert description here
// You can write your code in this editor
draw_self();

//Draw menu choices
for (var i = 0; i < array_length(choices); i++)
{
	draw_set_alpha(1);
	if (selection == i)
	{
		if (startGameCounter > 0)
		{
			draw_set_alpha(startGameCounter div 10 % 2);
		}
		else if (exitGameCounter > 0)
		{
			draw_set_alpha(exitGameCounter div 10 % 2);
		}
	}
	draw_text(floor(160), floor(140 + (12 * i)), choices[i]);
}
draw_set_alpha(1);

//Draw cursor shovel
draw_sprite(sCursor, cursorAnimCounter div 30 % 2, 120 + cursorPosChange, 140 + (12 * selection));