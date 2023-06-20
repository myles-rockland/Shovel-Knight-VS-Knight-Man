/// @description Insert description here
// You can write your code in this editor
if (sprite_index == sEnemyReplenish && image_index < 12)
{
	if (currentHealth == 20)
	{
		replenishCounter = 0;
		replenishedNum++;
	}
	if (replenishedNum == 2)
	{
		replenished = true;
	}
	currentState = "idle";
}
else if (sprite_index == sEnemyThrow)
{
	throwingCounter = 0;
	currentState = choose("jumping", "running");
}