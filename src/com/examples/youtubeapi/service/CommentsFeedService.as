package com.examples.youtubeapi.service
{
	import com.examples.youtubeapi.signals.CommentsFeedSignal;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.utils.ObjectProxy;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Parse the comments of a Video
	 * Turn each comment taken from the feed, into an usable Object for display
	 */
	
	public class CommentsFeedService extends Actor
	{
		[Inject]
		public var commentFeedSignal:CommentsFeedSignal;
		
		[Bindable]
		private var _commentProxy:ObjectProxy;
		
		private var _comments:ArrayCollection;
		private var _comment:Object;
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader;
		private var _xmlFeed:XML;
		private var _xmlList:XMLList;
		
		public function CommentsFeedService()
		{
			super();
		}
		
		/**
		 * 
		 * Load the feed URL
		 * 
		 */	
		public function parseCommentsFeed(url:String):void
		{
			_urlRequest = new URLRequest(url);
			_urlLoader = new URLLoader(_urlRequest);
			
			var loadCompleteSignal:NativeSignal = new NativeSignal(_urlLoader, Event.COMPLETE, Event);
			loadCompleteSignal.add(onLoadComplete);
		}
		
		/**
		 * 
		 * Parse the feed
		 * Each comment data is in an Object. All comments are inside an ArrayCollection
		 */	
		private function onLoadComplete(event:Event):void
		{
			var atom:Namespace = new Namespace('http://www.w3.org/2005/Atom');
			var schemas:Namespace = new Namespace('http://schemas.google.com/g/2005');
			var gdata:Namespace = new Namespace('http://gdata.youtube.com/schemas/2007');
			
			default xml namespace = atom;
			
			_xmlFeed = XML(_urlLoader.data);
			_xmlList = _xmlFeed.entry;
			
			var commentsSource:Array = new Array();
			
			for (var i:int = 0; i < _xmlList.length(); i++)
			{
				_comment = new Object();
				_comment.content = _xmlList[i].content;
				_comment.author = _xmlList[i].author.name;
				
				_commentProxy = new ObjectProxy(_comment);
				commentsSource.push(_commentProxy);
			}
			
			_comments = new ArrayCollection(commentsSource);
			commentFeedSignal.dispatch(_comments);
		}
	}
}