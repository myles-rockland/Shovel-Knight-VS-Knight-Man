/// @description Insert description here
// You can write your code in this editor
//draw_text(floor(x), floor(y - 60), (image_index)); //Debugging thing

var numBubbles = (maxHealth div 2) + (maxHealth % 2);
var numFullBubbles = currentHealth div 2;
var numHalfBubbles = currentHealth % 2;
for (var i = 0; i < numBubbles; i++)
{
	var xpos = 305 + (i * 9);
	if (numFullBubbles > 0)
	{
		//Draw full bubble
		draw_sprite(sEnemyHealthBubble, 0, xpos, 8);
		numFullBubbles--;
	}
	else if (numHalfBubbles > 0)
	{
		//Draw half bubble
		draw_sprite(sEnemyHealthBubble, 1, xpos, 8);
		numHalfBubbles--;
	}
	else
	{
		//Draw empty bubbles
		draw_sprite(sEnemyHealthBubble, 2, xpos, 8);
	}
}
