/// @description Insert description here
// You can write your code in this editor
if (sprite_index == sPlayerAttack || sprite_index == sPlayerAttackAlt)
{
	enemyHitFromAttack = false;
	if (attackBuffered)
	{
		attackBuffered = false;
		state = attackState;
	}
	else
	{
		state = idleState;
	}
}
if (sprite_index == sPlayerDying || sprite_index == sPlayerDyingAlt)
{
	deathTransCounter++;
	image_speed = 0;
}
if (sprite_index == sPlayerGetArmor)
{
	image_index = 1;
}
