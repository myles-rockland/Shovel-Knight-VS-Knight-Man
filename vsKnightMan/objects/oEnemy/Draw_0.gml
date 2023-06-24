/// @description Insert description here
// You can write your code in this editor
switch (currentState)
{
	case "idle":
		sprite_index = sEnemyIdle;
	break;
	case "running":
		sprite_index = sEnemyRun;
	break;
	case "blockingUp":
		sprite_index = sEnemyBlockUp;
	break;
	case "blockingSide":
		sprite_index = sEnemyBlockSide;
	break;
	case "jumping":
		if (yspd <= 0)
		{
			sprite_index = sEnemyJump;
		}
		else
		{
			sprite_index = sEnemyFall;
		}
	break;
	case "swinging":
		sprite_index = sEnemySwing;
	break;
	case "throwing":
		sprite_index = sEnemyThrow;
	break;
	case "bashReady":
		sprite_index = sEnemyBashReady;
	break;
	case "bashing":
		sprite_index = sEnemyBash;
	break;
	case "replenishing":
		sprite_index = sEnemyReplenish;
		if (replenishedNum == 0)
		{
			sprite_index = sEnemyIdle;
		}
		if (currentHealth == 20 && sprite_index != sEnemyReplenish)
		{
			replenishCounter = 0;
			replenishedNum++;
			if (replenishedNum == 2)
			{
				replenished = true;
			}
			currentState = "idle";
		}
	break;
	case "dying":
		sprite_index = sEnemyDying;
		image_xscale = -sign(xspd);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
	break;
	case "crouching":
		sprite_index = sEnemyCrouch;
	break;
	case "teleportingIn":
		sprite_index = sEnemyTeleportIn;
		if (!grounded)
		{
			image_speed = 0;
			image_index = 0;
		}
		else
		{
			image_speed = 1;
		}
	break;
	case "teleportingOut":
		sprite_index = sEnemyTeleportOut;
		if (image_index > 2)
		{
			if (grounded)
			{
				audio_play_sound(sfxKmTeleportOut, 0, false);
			}
			yspd = -4;
			image_speed = 0;
		}
	break;
}
if (xspd != 0 && currentState != "dying")
{
	image_xscale = xspd * (1/abs(xspd));
}
var colours = [c_aqua, c_blue, c_red]
if (hitCounter > 0)
{
	image_blend = colours[hitCounter div 3 % 3]; //Felt like a genius figuring out this divmod counter
}
else
{
	image_blend = c_white;
}
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);