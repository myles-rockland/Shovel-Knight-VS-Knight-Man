/// @description Insert description here
// You can write your code in this editor
choices = ["resume", "controls", "back to title screen", "quit to desktop"];
selection = 0;
cursorAnimCounter = 0;
cursorPosChange = 0;
titleSelected = false;
resumed = false;

//Setting text formatting
shovelFont = font_add("shovel-knight-extended.ttf", 6, false, false, 32, 128);

//save speed before pause
var enemy = instance_nearest(x, y, oEnemy);
var player = instance_nearest(x, y, oPlayer1);
playerPrevXSpd = player.xspd;
playerPrevYSpd = player.yspd;
enemyPrevXSpd = enemy.xspd;
enemyPrevYSpd = enemy.yspd;

//Pause music
audio_pause_sound(musFight);

//Play pause sound
audio_play_sound(sfxPause, 0, false);