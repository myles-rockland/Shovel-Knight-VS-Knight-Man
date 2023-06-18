/// @description Insert description here
// You can write your code in this editor
//draw_text(floor(x), floor(y - 40), (pogoDelay)); //debugging, comment in/out to view values

//Draw player health bubbles
var numBubbles = (maxHealth div 2) + (maxHealth % 2);
var numFullBubbles = currentHealth div 2;
var numHalfBubbles = currentHealth % 2;
for (var i = 0; i < numBubbles; i++)
{
	var xpos = 156 + (i * 9);
	if (numFullBubbles > 0)
	{
		//Draw full bubble
		draw_sprite(sPlayerHealthBubble, 0, xpos, 8);
		numFullBubbles--;
	}
	else if (numHalfBubbles > 0)
	{
		//Draw half bubble
		draw_sprite(sPlayerHealthBubble, 1, xpos, 8);
		numHalfBubbles--;
	}
	else
	{
		//Draw empty bubbles
		draw_sprite(sPlayerHealthBubble, 2, xpos, 8);
	}
}

//Drawing gold count
draw_set_halign(fa_left);
draw_text(12, 10, gold);

//Draw magic count
draw_text_colour(91, 10, magic, #38c0fc, #38c0fc, #38c0fc, #38c0fc, 1);