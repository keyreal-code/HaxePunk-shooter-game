package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;
/**
 * Explosion emitter.
 * @author Kirill Poletaev
 */
class Explosion extends Entity
{
	private var particles:Emitter;

	public function new(atlas:TextureAtlas) 
	{
		super();
		particles = new Emitter(atlas.getRegion("explosion"), 22, 24);
		particles.newType("explosion", [0]);
		particles.setMotion("explosion", 0, 10, 1, 360, 50, 1, Ease.quadOut);
		graphic = particles;
		layer = -1;
	}
	
	public function explode(x:Float, y:Float) {
		particles.emitInRectangle("explosion", x, y, 64, 48);
	}
	
}