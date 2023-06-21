/// @description Insert description here
// You can write your code in this editor
switch (currentState)
{
	case "idle":
		sprite_index = sPlayerIdle;
	break;
	case "crouching":
		sprite_index = sPlayerCrouch;
	break;
	case "running":
		if (abs(xspd) == runningInitSpeed)
		{
			sprite_index = sPlayerRunStart;
		}
		else
		{
			sprite_index = sPlayerRun;
		}
	break;
	case "turning":
		sprite_index = sPlayerTurn;
		if (turningCounter == 8)
		{
			image_xscale *= -1;
		}
	break;
	case "jumping":
		if (yspd <= 2)
		{
			sprite_index = sPlayerJump;
		}
		else
		{
			sprite_index = sPlayerFall;
		}
	break;
	case "attacking":
		sprite_index = sPlayerAttack;
	break;
	case "pogoing":
		sprite_index = sPlayerPogo;
	break;
	case "stunned":
		sprite_index = sPlayerStunned;
	break;
	case "dying":
		sprite_index = sPlayerDying;
	break;
	case "dead":
		sprite_index = sPlayerDead;
	break;
	case "victory":
		sprite_index = sPlayerVictory;
	break;
}
if (xspd != 0 && currentState != "stunned")
{
	image_xscale = xspd * (1/abs(xspd));
}
image_alpha = int64(invulnerableCounter % 3 == 0);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);