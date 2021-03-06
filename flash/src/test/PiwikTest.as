package test 
{
	import data.modules.DataSet;
	import data.modules.piwik.Piwik;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.vis4.utils.DelayedTask;
	import viz.SparkLine;
	import viz.VizModule;
	/**
	 * ...
	 * @author gka
	 */
	public class PiwikTest extends TestCase 
	{
		protected var piwik:Piwik;
		protected var _stage:Sprite;
		
		public function PiwikTest(stage:Sprite) 
		{
			_stage = stage;
			
		}
		
		override public function run():void 
		{
			piwik = new Piwik({
				'piwik-url': 'http://piwik.vis4.net/',
				'piwik-token-auth': 'anonymous',
				'piwik-site-id': 1
			});
			piwik.addEventListener(Event.INIT, initialized);
			piwik.initialize();
		}
		
		public function initialized(e:Event):void 
		{
			trace('site-name = ', piwik.siteInfo);
			next();
		}
		
		public function next():void
		{
			var ds:DataSet = piwik.randomDataSet;
			ds.addEventListener(Event.COMPLETE, dataLoaded);
			ds.load();
			
		}
		
		public function dataLoaded(e:Event):void 
		{
			var ds:DataSet = e.target as DataSet;
			
			//var viz:VizModule = new ds.viz(_stage, ds.config);
			var vis:VizModule = new ds.viz(_stage, ds.config);//
			
			vis.setData(ds.getData());
			vis.fadeIn();
			
			var slideTime:Number = 6;
			
			new DelayedTask(slideTime*1000, vis, vis.fadeOut);
			new DelayedTask(slideTime*1000+2000, this, next);
			/*viz.foo();
			viz.setData(ds.getData());
			viz.fadeIn();
			*/
			//viz.setData(ds.getData());
			//viz.fadeIn();
		}
		
	}

}