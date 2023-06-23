/// @description Insert description here
// You can write your code in this editor
switch (currentState)
{
	case "idle":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerIdleAlt;
		}
		else sprite_index = sPlayerIdle;
	break;
	case "crouching":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerCrouchAlt;
		}
		else sprite_index = sPlayerCrouch;
	break;
	case "running":
		if (abs(xspd) == runningInitSpeed)
		{
			if (global.armourType == 1)
			{
				sprite_index = sPlayerRunStartAlt;
			}
			else sprite_index = sPlayerRunStart;
		}
		else
		{
			if (global.armourType == 1)
			{
				sprite_index = sPlayerRunAlt;
			}
			else sprite_index = sPlayerRun;
		}
	break;
	case "turning":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerTurnAlt;
		}
		else sprite_index = sPlayerTurn;
		if (turningCounter == 8)
		{
			image_xscale *= -1;
		}
	break;
	case "jumping":
		if (yspd <= 2)
		{
			if (global.armourType == 1)
			{
				sprite_index = sPlayerJumpAlt;
			}
			else sprite_index = sPlayerJump;
		}
		else
		{
			if (global.armourType == 1)
			{
				sprite_index = sPlayerFallAlt;
			}
			else sprite_index = sPlayerFall;
		}
	break;
	case "attacking":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerAttackAlt;
		}
		else sprite_index = sPlayerAttack;
	break;
	case "pogoing":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerPogoAlt;
		}
		else sprite_index = sPlayerPogo;
	break;
	case "stunned":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerStunnedAlt;
		}
		else sprite_index = sPlayerStunned;
	break;
	case "dying":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerDyingAlt;
		}
		else sprite_index = sPlayerDying;
	break;
	case "dead":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerDeadAlt;
		}
		else sprite_index = sPlayerDead;
	break;
	case "victory":
		if (global.armourType == 1)
		{
			sprite_index = sPlayerVictoryAlt;
		}
		else sprite_index = sPlayerVictory;
	break;
	case "armorGet":
		sprite_index = sPlayerGetArmor;
	break;
}
if (xspd != 0 && currentState != "stunned" && currentState != "crouching")
{
	image_xscale = xspd * (1/abs(xspd));
}
image_alpha = int64(invulnerableCounter % 3 == 0);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);