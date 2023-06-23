/// @description Insert description here
// You can write your code in this editor
selectionAnimCounter++;

var player = instance_nearest(x, y, oPlayer1);
var enemy = instance_nearest(x, y, oEnemy);
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
enemy.currentState = (enemy.currentState == "crouching") ? "crouching" : "idle";

//Check for input
rightKeyPressed = keyboard_check_pressed(ord("D"));
leftKeyPressed = keyboard_check_pressed(ord("A"));
confirmKeyPressed = (keyboard_check_pressed(ord("K")) || keyboard_check_pressed(vk_space));

if (rightKeyPressed)
{
	selection++;
	if (selection > 1)
	{
		selection = 0;
	}
}
else if (leftKeyPressed)
{
	selection--;
	if (selection < 0)
	{
		selection = 1;
	}
}
else if (confirmKeyPressed)
{
	io_clear();
	if (selection == 0) //Player selected yes
	{
		global.armourType = 1;
		//Display crouching tooltip
		instance_create_layer(112, 72, "Instances", oArmorGetBox);
		instance_destroy();
	}
	else //player selected no
	{
		player.armourType = 0;
		newDialogue(["\\0knight man: no, no, terrible! no honor! no \\schivalry\\0! no matter!", "\\0knight man: it is time to decide with this fight which of us is a \\strue warrior\\0!"]);
		instance_destroy();
	}
}