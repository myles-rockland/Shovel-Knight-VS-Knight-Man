/// @description Insert description here
// You can write your code in this editor
if (sprite_index == sEnemyDying)
{
	image_index = 3;
}
else if (sprite_index = sEnemyTeleportIn)
{
	audio_play_sound(sfxKmTeleportIn, 0, false);
	if (!playerMoved)
	{
		newDialogue(["\\0knight man: halt! have you seen a short, blue man pass through this area?", "\\0shovel knight: well met, but no, sorry.", "\\0knight man: very well, i shall be on my way, then."]);
	}
	else
	{
		newDialogue(["\\0knight man: \\shold it right there\\0!", "\\0knight man: you are short... and blue... could it be...?!", "\\0knight man: conniving scoundrel! it's \\syou\\0!", "\\0shovel knight: i'm not sure who you are, but i'm no scoundrel!", "\\0knight man: we will have a fair and square fight, and for that, i will offer you this armor."]);
	}
	currentState = "idle";
}
else if (currentHealth == 20 && sprite_index == sEnemyReplenish)
{
	replenishCounter = 0;
	replenishedNum++;
	if (replenishedNum == 2)
	{
		replenished = true;
	}
	currentState = "idle";
}
else if (sprite_index == sEnemyThrow)
{
	throwingCounter = 0;
	audio_stop_sound(sfxKmPull);
	currentState = choose("jumping", "running");
}