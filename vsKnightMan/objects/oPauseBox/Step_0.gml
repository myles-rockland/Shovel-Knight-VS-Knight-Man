/// @description Insert description here
// You can write your code in this editor
downKeyPressed = keyboard_check_pressed(ord("S"));
upKeyPressed = keyboard_check_pressed(ord("W"));
confirmKeyPressed = (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(vk_space));

var enemy = instance_nearest(x, y, oEnemy);
var player = instance_nearest(x, y, oPlayer1);
player.xspd = 0;
player.yspd = 0;
enemy.yspd = 0;
enemy.xspd = 0;
enemy.grav = 0;
enemy.idleCounter = 0;
enemy.runningCounter = 0;
enemy.swingingCounter = 0;
enemy.throwingCounter = 0;
enemy.blockingCounter = 0;
enemy.bashReadyCounter = 0;
enemy.replenishCounter = 0;
enemy.image_speed = 0;

cursorAnimCounter++; //Keep animating the cursor until a choice is made

if (titleSelected)
{
	image_alpha = 0;
	downKeyPressed = false;
	upKeyPressed = false;
	confirmKeyPressed = false;
	if (!instance_exists(oCurtainTransitionOutro))
	{
		room_goto(titleScreen);
	}
}
else if (instance_exists(oControlsBox))
{
	downKeyPressed = false;
	upKeyPressed = false;
	confirmKeyPressed = false;
}

//Change selection based on inputs
if (downKeyPressed)
{
	selection++;
	if (selection == array_length(choices))
	{
		selection = 0;
	}
}
else if (upKeyPressed)
{
	selection--;
	if (selection == -1)
	{
		selection = array_length(choices) - 1;
	}
}
else if (confirmKeyPressed)
{
	switch(choices[selection])
	{
		case "resume":
			enemy.image_speed = 1;
			player.paused = false;
			player.image_speed = 1;
			player.grav = 0.3;
			enemy.grav = 0.3;
			player.xspd = playerPrevXSpd;
			player.yspd = playerPrevYSpd;
			enemy.xspd = enemyPrevXSpd;
			enemy.yspd = enemyPrevYSpd;
			instance_destroy();
		break;
		case "controls":
			if (!instance_exists(oControlsBox))
			{
				instance_create_layer(112, 72, "Instances", oControlsBox);
			}
		break;
		case "back to title screen":
			instance_create_layer(0, 0, "Instances", oCurtainTransitionOutro);
			titleSelected = true;
		break;
		case "quit to desktop":
			game_end();
		break;
	}
}