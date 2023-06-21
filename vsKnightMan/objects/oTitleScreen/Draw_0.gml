/// @description Insert description here
// You can write your code in this editor
draw_self();

for (var i = 0; i < array_length(choices); i++)
{
	draw_text(floor(160), floor(140 + (12 * i)), choices[i]);
}

//Draw selection shovel