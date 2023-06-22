/// @description Insert description here
// You can write your code in this editor
var player = instance_nearest(x, y, oPlayer1);

//Apply gravity
yspd += grav;

//Collision checking
if (place_meeting(x + xspd, y, oSolid))
{
	x = round(x);
	var _pixelCheck = sign(xspd);
	while !place_meeting(x + _pixelCheck, y, oSolid)
	{
		x += _pixelCheck;
	}
	xspd = 0;
	walled = true;
}
else
{
	walled = false;
}

if (place_meeting(x + xspd, y + yspd, oSolid))
{
	y = round(y);
	var _pixelCheck = sign(yspd) * abs(grav);
	while !place_meeting(x + xspd, y + _pixelCheck, oSolid)
	{
		y += _pixelCheck;
	}
	if (place_meeting(x, y + 1, oSolid))
	{
		grounded = true;
	}
	yspd = 0;
}
else
{
	grounded = false;
}

//Apply movement
x += xspd;
y += yspd;

//Player collision checking
if (player.currentState == "pogoing" && place_meeting(x, y - 1, oPlayer1) && currentState != "swinging" && currentState != "dying" && currentState != "teleportingOut" && currentState != "crouching")
{
	player.yspd = player.jumpSpd;
	if (currentState != "replenishing" && currentState != "blockingUp" && player.pogoDelay == 0)
	{
		currentHealth--;
		hitCounter = 1;
		player.pogoDelay++;
	}
}
else if (currentState != "dying" && currentState != "teleportingOut" && currentState != "crouching" && player.currentState != "dead" && player.currentState != "dying" && player.currentState != "stunned" && player.invulnerableCounter == 0 && (place_meeting(x + xspd, y, oPlayer1) || place_meeting(x + xspd, y + yspd, oPlayer1)))
{
	player.currentState = "stunned";
	player.yspd = -3;
	player.currentHealth--;
	if (player.currentHealth == 0)
	{
		player.yspd = -5;
	}
}
if (hitCounter > 0 && hitCounter < 30)
{
	hitCounter++;
}
else
{
	hitCounter = 0;
}

//Do stuff based on current state
switch (currentState)
{
	case "idle":
		image_xscale = sign(player.x - x)
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		idleCounter++;
		xspd = 0;
		if (player.x > x - 32 && player.x < x + 32 && player.y < y)
		{
			idleCounter = 0;
			currentState = "blockingUp"
		}
		else if (player.grounded && grounded && ((player.x > x - 80 && player.x < x) || (player.x < x + 80 && player.x > x)))
		{
			idleCounter = 0;
			currentState = "blockingSide"
		}
		else if (idleCounter == 60)
		{
			idleCounter = 0;
			currentState = "running";
		}
	break;
	case "running":
		runningCounter++;
		if (instance_exists(oPlayerAttackHitbox) && place_meeting(x, y, oPlayerAttackHitbox))
		{
			runningCounter = 0;
			currentState = "bashReady";
		}
		else if ((player.currentState == "pogoing" && place_meeting(x, y - 1, oPlayer1)) || player.x > x - 8 && player.x < x + 8)
		{
			runningCounter = 0;
			currentState = "swinging";
		}
		else if (runningCounter == 120)
		{
			runningCounter = 0;
			currentState = "throwing";
		}
		else if (player.jumpKeyPressed)
		{
			runningCounter = 0;
			currentState = choose("jumping", "bashReady");
		}
		else
		{
			xspd = 2 * sign(player.x - x);
		}
	break;
	case "jumping":
		if (grounded && !hasJumped)
		{
			hasJumped = true;
			yspd = -8;
			xspd = (player.x - x)/48; //1.5 * sign(player.x - x)
		}
		else if (grounded && hasJumped)
		{
			hasJumped = false;
			currentState = "idle";
		}
	break;
	case "swinging":
		swingingCounter++;
		xspd = 0;
		if (player.currentState != "stunned" && player.invulnerableCounter == 0 && (place_meeting(x + xspd, y, oPlayer1) || place_meeting(x + xspd, y + yspd, oPlayer1)))
		{
			swingingCounter = 0;
			currentState = "idle";
		}
		else if (swingingCounter == 60)
		{
			swingingCounter = 0;
			currentState = "throwing";
		}
	break;
	case "throwing":
		throwingCounter++;
		if (throwingCounter == 4)
		{
			instance_create_layer(x + (image_xscale * 40), y, "Instances", oEnemyAttackHitbox);
		}
		xspd = 0;
	break;
	case "bashReady":
		image_xscale = sign(player.x - x);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		xspd = 0;
		bashReadyCounter++;
		if (bashReadyCounter == 30)
		{
			bashReadyCounter = 0;
			instance_create_layer(x - (16 * image_xscale), y, "Instances", oEnemyDashEffect);
			currentState = "bashing";
		}
	break;
	case "bashing":
		if (!bashStarted)
		{
			bashStarted = true;
			xspd = 6 * sign(player.x - x);
		}
		else if (walled && bashStarted)
		{
			bashStarted = false;
			currentState = "idle";
		}
	break;
	case "blockingUp":
		blockingCounter++;
		if (player.currentState == "pogoing" && place_meeting(x, y - 1, oPlayer1))
		{
			blockingCounter = 0;
			currentState = "swinging";
		}
		else if ((instance_exists(oPlayerAttackHitbox) && place_meeting(x, y, oPlayerAttackHitbox)) || blockingCounter == 120)
		{
			blockingCounter = 0;
			currentState = "jumping";
		}
	break;
	case "blockingSide":
		blockingCounter++;
		image_xscale = sign(player.x - x);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		if (player.attackCounter == 5)
		{
			blockingCounter = 0;
			currentState = "bashReady";
		}
		else if (player.currentState == "pogoing" && place_meeting(x, y, oPlayer1))
		{
			blockingCounter = 0;
			currentState = "swinging";
		}
		else if (blockingCounter == 120)
		{
			blockingCounter = 0;
			currentState = "jumping";
		}
	break;
	case "replenishing":
		xspd = 0;
		replenishCounter++;
		image_xscale = sign(player.x - x);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		if (currentHealth < 20 && replenishCounter == 3)
		{
			currentHealth++;
			replenishCounter = 0;
		}
		if (replenishedNum == 0)
		{			
			player.xspd = 0;
			player.yspd = 0;
			player.currentState = (player.currentState == "crouching") ? "crouching" : "idle";
		}
	break;
	case "dying":
		if (!deathLaunched)
		{
			deathLaunched = true;
			xspd = 2 * image_xscale; //image_xscale gets set in previous step, negativity depends on placement of check for death
			yspd = -5;
		}
		else if (grounded && deathLaunched)
		{
			xspd = 0;
			currentState = "crouching";
			newDialogue(["\\0knight man: \\wgaaah... \\0i am ashamed. i never thought i'd lose in this way.", "\\0shovel knight: you fought well, but i am not the one you seek!", "\\0shovel knight: i am shovel knight, on my quest to defeat the enchantress.", "\\0knight man: ...forgive me, shovel knight. i am knight man, on my quest to find a \\scerulean coward\\0!", "\\0shovel knight: all is forgiven, as a knight of the code of shovelry! i wish you well in your search, fellow knight.", "\\0knight man: likewise. for chivalry!", "\\0shovel knight: for shovelry!"]);
		}
		
	break;
	case "crouching":
		image_xscale = sign(player.x - x)
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		if (!instance_exists(oDialogueBox))
		{
			currentState = "teleportingOut";
		}
	break;
	case "teleportingIn":
		if (!grounded)
		{
			yspd = 4;
		}
		else
		{
			yspd = 0;
		}
		//Force the player to be still
		if (player.currentState == "jumping" && !player.jumpKeyPressed)
		{
			player.currentState = "jumping"; //Let the player fall if they are still in the air
		}
		else if (player.currentState == "pogoing")
		{
			player.currentState = "pogoing"; //Let the player fall if they are still in the air
		}
		else if (player.currentState == "crouching")
		{
			player.currentState = "crouching"; //Allow crouching
			player.xspd = 0;
			player.yspd = 0;
		}
		else
		{
			player.currentState = "idle"; //Be still
			player.xspd = 0;
			player.yspd = 0;
		}
	break;
	case "teleportingOut":
		yspd = 0;
		if (replenished)
		{
			player.currentState = "victory";
		}
		else if (y > 0)
		{
			//Force the player to be still
			if (player.currentState == "jumping" && !player.jumpKeyPressed && !player.grounded)
			{
				player.currentState = "jumping"; //Let the player fall if they are still in the air
			}
			else if (player.currentState == "pogoing" && !player.grounded)
			{
				player.currentState = "pogoing"; //Let the player fall if they are still in the air
			}
			else if (player.currentState == "crouching")
			{
				player.currentState = "crouching"; //Allow crouching
				player.xspd = 0;
				player.yspd = 0;
			}
			else
			{
				player.currentState = "idle"; //Be still
				player.xspd = 0;
				player.yspd = 0;
			}
		}
		else if (y <= 0 && player.currentState != "idle" && !replenished)
		{
			playerMoved = true;
			currentState = "teleportingIn";
		}
	break;
}
if (currentHealth == 0 && !deathLaunched && replenished)
{
	currentState = "dying";
}
if (currentHealth <= 6 && grounded && !replenished && currentState != "bashing" && currentState != "bashReady" && currentState != "jumping" && currentState != "teleportingIn" && currentState != "teleportingOut" && !instance_exists(oDialogueBox))
{
	idleCounter = 0;
	runningCounter = 0;
	swingingCounter = 0;
	throwingCounter = 0;
	blockingCounter = 0;
	bashReadyCounter = 0;
	hasJumped = false;
	bashStarted = false;
	currentState = "replenishing";
	image_index = 0;
}