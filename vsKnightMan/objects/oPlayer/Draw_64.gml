/// @description Insert description here
// You can write your code in this editor
//Draw player health bubbles
numBubbles = (maxHealth div 2) + (maxHealth % 2);
numFullBubbles = currentHealth div 2;
numHalfBubbles = currentHealth % 2;
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
draw_text(12, 10, gold);