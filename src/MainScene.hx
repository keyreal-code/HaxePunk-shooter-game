package ;

import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class MainScene extends Scene
{
	private var player:PlayerShip;
	private var spawnInterval:Int;
	private var powerupInterval:Int;
	private var enemyGraphic:Image;
	private var powerupGraphic:Image;
	private var explosion:Explosion;
	private var score:Score;
	private var paused:Bool;
	private var pausedText:PausedText;
	private var lifeCounter:LifeCounter;
	private var playing:Bool;
	private var gameOverScreen:GameOverScreen;
	
	public function new()
	{
		super();
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		
		var atlas:TextureAtlas = TextureAtlas.loadTexturePacker("atlas/atlas.xml");
		enemyGraphic = new Image(atlas.getRegion("enemyShip"));
		powerupGraphic = new Image(atlas.getRegion("powerup"));
		
		player = new PlayerShip(atlas);
		add(player);
		spawnInterval = Math.round(Math.random() * 50) + 50;
		powerupInterval = Math.round(Math.random() * 200) + 150;
		
		explosion = new Explosion(atlas);
		add(explosion);
		
		score = new Score();
		add(score);
		
		paused = false;
		pausedText = new PausedText();
		add(pausedText);
		pausedText.visible = false;
		
		lifeCounter = new LifeCounter(new Image(atlas.getRegion("heart")));
		add(lifeCounter);
		lifeCounter.moveTo(10, 10);
		
		playing = true;
		gameOverScreen = new GameOverScreen();
		add(gameOverScreen);
		gameOverScreen.visible = false;
	}
	
	override public function update() {	
		if (Input.pressed(Key.P)) {
			togglePause();
		}
		
		if (paused) return;
		
		super.update();
		
		if (!playing && Input.pressed(Key.ENTER)) {
			restart();
		}
		
		if (!playing) return;
		
		spawnInterval--;
		if (spawnInterval == 0) {
			var enemy = new EnemyShip(enemyGraphic, explosion, score, lifeCounter);
			add(enemy);
			enemy.x = Math.round(Math.random() * (HXP.width-64));
			enemy.y = -50;
			spawnInterval = Math.round(Math.random() * 20)+30;
		}
		powerupInterval--;
		if (powerupInterval == 0) {
			var powerup = new PowerUp(powerupGraphic, lifeCounter);
			add(powerup);
			powerup.x = Math.round(Math.random() * (HXP.width-64));
			powerup.y = -50;
			powerupInterval = Math.round(Math.random() * 200) + 150;
		}
	}
	
	public function togglePause() {
		paused = !paused;
		pausedText.visible = !pausedText.visible;
	}
	
	public function gameOver() {
		playing = false;
		var i:Int;
		for(i in 0...30){
			explosion.explode(player.x, player.y);
		}
		player.active = false;
		player.collidable = false;
		player.visible = false;
		gameOverScreen.visible = true;
	}
	
	public function restart() {
		playing = true;
		player.active = true;
		player.collidable = true;
		player.visible = true;
		lifeCounter.updateLives(3);
		player.x = HXP.width/2 - player.width/2;
		player.y = HXP.height - 80;
		gameOverScreen.visible = false;
		score.reset();
	}
	
 }