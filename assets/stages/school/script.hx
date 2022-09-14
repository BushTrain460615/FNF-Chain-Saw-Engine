var bgGirls:FlxSprite;

function create()
{
	var bgSky = new FlxSprite().loadGraphic(Paths.returnGraphic('stages/school/images/weebSky'));
	bgSky.scrollFactor.set(0.1, 0.1);
	PlayState.instance.add(bgSky);

	var bgSchool:FlxSprite = new FlxSprite(-200, 0).loadGraphic(Paths.returnGraphic('stages/school/images/weebSchool'));
	bgSchool.scrollFactor.set(0.6, 0.90);
	bgSchool.scale.set(6, 6);
	PlayState.instance.add(bgSchool);

	var bgStreet:FlxSprite = new FlxSprite(-200, 0).loadGraphic(Paths.returnGraphic('stages/school/images/weebSchool'));
	bgStreet.scrollFactor.set(0.95, 0.95);
	bgStreet.scale.set(6, 6);
	PlayState.instance.add(bgStreet);

	var fgTrees:FlxSprite = new FlxSprite(-50, 130).loadGraphic(Paths.returnGraphic('stages/school/images/weebTreesBack'));
	fgTrees.scrollFactor.set(0.9, 0.9);
	fgTrees.scale.set(6 * 0.8, 6 * 0.8);
	PlayState.instance.add(fgTrees);

	var bgTrees:FlxSprite = new FlxSprite(-580, -800);
	bgTrees.frames = FlxAtlasFrames.fromSparrow(Paths.returnGraphic('stages/school/images/weebTrees'),
		Paths.xml('stages/school/images/weebTrees'));
	bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
	bgTrees.animation.play('treeLoop');
	bgTrees.scrollFactor.set(0.85, 0.85);
	bgTrees.scale.set(6 * 1.4, 6 * 1.4);
	PlayState.instance.add(bgTrees);

	var treeLeaves:FlxSprite = new FlxSprite(-200, -40);
	treeLeaves.frames = FlxAtlasFrames.fromSparrow(Paths.returnGraphic('stages/school/images/petals'),
		Paths.xml('stages/school/images/petals'));
	treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
	treeLeaves.animation.play('leaves');
	treeLeaves.scrollFactor.set(0.85, 0.85);
	treeLeaves.scale.set(6, 6);
	PlayState.instance.add(treeLeaves);

	bgGirls = new FlxSprite(-100, 190);
	bgGirls.frames = FlxAtlasFrames.fromSparrow(Paths.returnGraphic('stages/school/images/bgFreaks'),
		Paths.xml('stages/school/images/bgFreaks'));

	if (PlayState.instance.SONG.song.toLowerCase() == 'roses')
	{
		bgGirls.animation.addByIndices('danceLeft', 'BG fangirls dissuaded', CoolUtil.numberArray(14), "", 24, false);
		bgGirls.animation.addByIndices('danceRight', 'BG fangirls dissuaded', CoolUtil.numberArray(30, 15), "", 24, false);
	}
	else
	{
		bgGirls.animation.addByIndices('danceLeft', 'BG girls group', CoolUtil.numberArray(14), "", 24, false);
		bgGirls.animation.addByIndices('danceRight', 'BG girls group', CoolUtil.numberArray(30, 15), "", 24, false);
	}

	bgGirls.scrollFactor.set(0.9, 0.9);
	bg.scale.set(6, 6);
	PlayState.instance.add(bgGirls);
}

var danceDir:Bool = false;

function beatHit(curBeat:Int)
{
	danceDir = !danceDir;

	if (danceDir)
		bgGirls.animation.play('danceRight', true);
	else
		bgGirls.animation.play('danceLeft', true);
}
