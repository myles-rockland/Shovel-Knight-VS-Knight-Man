// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function newDialogue(messageArray){
	var dialogueBox = instance_create_layer(0, 0, "Instances", oDialogueBox);
	for (var i = 0; i < array_length(messageArray); i++)
	{
		dialogueBox.text[i] = messageArray[i];
	}
}