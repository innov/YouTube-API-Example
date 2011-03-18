package com.examples.youtubeapi.service
{
	import com.examples.youtubeapi.signals.VideosFeedSignal;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Parse the feed of all the videos received.
	 * Turn each video taken from the feed, into an usable Object for display
	 */
	
	public class VideosFeedService extends Actor
	{
		[Inject]
		public var videosFeedSignal:VideosFeedSignal;
		
		[Bindable]
		private var _videoProxy:ObjectProxy;
		
		private var _videos:ArrayCollection;
		private var _aVideo:Object;
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		private var _xmlFeed:XML;
		private var _xmlList:XMLList;
		
		public function VideosFeedService()
		{
			super();
		}
		
		/**
		 * 
		 * Load the feed URL
		 * 
		 */		
		public function parseVideoFeed(url:String):void
		{
			_urlRequest = new URLRequest(url);
			_urlLoader = new URLLoader(_urlRequest);
			
			var loadCompleteSignal:NativeSignal = new NativeSignal(_urlLoader, Event.COMPLETE, Event);
			loadCompleteSignal.add(onLoadComplete);
		}

		/**
		 * 
		 * Parse the feed
		 * Each video data is in an Object. All videos are inside an ArrayCollection
		 */		
		private function onLoadComplete(event:Event):void
		{
			var atom:Namespace = new Namespace('http://www.w3.org/2005/Atom');
			var media:Namespace = new Namespace('http://search.yahoo.com/mrss/');
			var yt:Namespace = new Namespace('http://gdata.youtube.com/schemas/2007');
			
			default xml namespace = atom;
			
			_xmlFeed = XML(_urlLoader.data);
			_xmlList = _xmlFeed.entry;
			
			var videosSource:Array = new Array();
			
			for (var i:int = 0; i < _xmlList.length(); i++)
			{
				_aVideo = new Object();
				_aVideo.id = _xmlList[i].id;
				_aVideo.title = _xmlList[i].title;
				_aVideo.author = _xmlList[i].author.name;
				_aVideo.thumbnail = _xmlList[i].media::group.media::thumbnail[1].@url;
				_aVideo.hits = _xmlList[i].yt::statistics.@viewCount;
				
				_videoProxy = new ObjectProxy(_aVideo);
				videosSource.push(_videoProxy);
			}
			
			_videos = new ArrayCollection(videosSource);
			videosFeedSignal.dispatch(_videos);
		}
	}
}