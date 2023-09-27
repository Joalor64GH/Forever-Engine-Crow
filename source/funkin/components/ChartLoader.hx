package funkin.components;

import funkin.objects.notes.Note.NoteData;

class ChartLoader {}

typedef ChartFormat = {
	var notes:Array<NoteData>;
	var events:Array<ChartEvent<ForeverEvents>>;
}

typedef ChartEvent<T> = {
	var event:T;
	var step:Int;
	// meta info, used to tell which bar/section this has been triggered
	var ?bar:Int;
}

enum ForeverEvents {
	BPMChange(step:Int, nextBPM:Float);
	PlayAnimation(who:Int, animation:String);
	ChangeCharacter(who:Int, toCharacter:String);
	FocusCamera(who:Int, noEasing:Bool);
	PlaySound(soundName:String, volume:Float);
	NoteFieldChange(who:Int, event:NoteFieldEvents);
}

enum NoteFieldEvents {
	VelocityChange(newSpeed:Float, duration:Float);
	NoteRotation(newRotation:Int, duration:Float);
	NoteVibration(intensity:Int, duration:Float);
}
