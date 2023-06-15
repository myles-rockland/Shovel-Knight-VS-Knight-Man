/// @description Insert description here
// You can write your code in this editor
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
draw_text(12, 10, gold);

//Drawing death transition
if (sprite_index == sPlayerDead && image_speed = 0 && deathCounter == 0 && resetCounter == 0)
{
	deathCounter++;
}
else if (deathCounter > 0 && deathCounter < 60)
{
	deathCounter++;
}
if (deathCounter == 60)
{
	deathTransitionXPos -= 400/60;
	if (deathTransitionXPos < 0)
	{
		deathTransitionXPos = 0;
		deathCounter = 0;
		resetCounter++;
		currentHealth = maxHealth;
		x = 48;
		y = 224;
	}
	draw_sprite(sDeathTransition, 0, deathTransitionXPos, 0);
}
if (resetCounter > 0 && resetCounter < 180)
{
	draw_sprite(sDeathTransition, 0, deathTransitionXPos, 0);
	resetCounter++;
	x = 48;
	y = 224;
}
if (resetCounter == 180)
{
	x = 48;
	y = 224;
	deathTransitionXPos -= 400/60;
	if (deathTransitionXPos < -400)
	{
		resetCounter = 0;
	}
	draw_sprite(sDeathTransition, 0, deathTransitionXPos, 0);
}