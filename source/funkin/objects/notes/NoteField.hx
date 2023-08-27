package funkin.objects.notes;

import flixel.group.FlxGroup.FlxTypedGroup;
import forever.ForeverSprite;

class Strum extends ForeverSprite {
	public function new(x:Float, y:Float, skin:String = "default", id:Int):Void {
		super(x, y);

		frames = AssetHelper.getAsset('images/notes/${NoteConfig.config.strumImage}', ATLAS_SPARROW);
		this.ID = id;

		if (NoteConfig.config.strumAnims.length > 0)
			for (i in NoteConfig.config.strumAnims) {
				var dir:String = Utils.noteDirections[id];
				var color:String = Utils.noteColors[id];

				addAtlasAnim(i.name, i.prefix.replace("${dir}", dir).replace("${color}", color), i.fps, i.looped);
			}

		animation.play("static");
	}
}

class NoteField extends FlxTypedGroup<Strum> {
	public var skin:String = "default";

	// READ ONLY VARIABLES
	public var size(get, never):Float;
	public var spacing(get, never):Int;
	public var fieldWidth(get, never):Float;

	public function new(x:Float, y:Float, skin:String = "default"):Void {
		super();

		this.skin = skin;
		regenStrums(x, y);
	}

	public function regenStrums(x:Float = 0, y:Float = 0):Void {
		for (i in 0...4) {
			var strum:Strum = new Strum(x, y, skin, i);
			strum.x += i * fieldWidth;
			strum.scale.set(size, size);
			strum.updateHitbox();
			add(strum);
		}
	}

	@:dox(hide) @:noCompletion function get_spacing():Int {
		if (NoteConfig.config.strumSpacing >= 30) // minimum spacing is 30
			return NoteConfig.config.strumSpacing;
		return NoteConfig.getDummyConfig().strumSpacing;
	}

	@:dox(hide) @:noCompletion function get_size():Float {
		if (NoteConfig.config.strumSize > 0)
			return NoteConfig.config.strumSize;
		return NoteConfig.getDummyConfig().strumSize;
	}

	@:dox(hide) @:noCompletion function get_fieldWidth():Float
		return spacing * size;
}
