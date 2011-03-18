package com.examples.youtubeapi.view.mediator
{
	import com.examples.youtubeapi.signals.VideoThumbnailClickSignal;
	import com.examples.youtubeapi.view.itemrenderer.VideoThumbnailRenderer;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Display a thumbnail of a video
	 * 
	 */
	
	public class VideoThumbnailRendererMediator extends Mediator
	{
		[Inject]
		public var view:VideoThumbnailRenderer;
		
		[Inject]
		public var videoClickSignal:VideoThumbnailClickSignal;
		
		private var clickSignal:NativeSignal;
		
		public function VideoThumbnailRendererMediator()
		{
			super();
		}
		
		/**
		 * Signal when clicked
		 * 
		 */		
		override public function onRegister():void
		{
			clickSignal = new NativeSignal(view, MouseEvent.CLICK, MouseEvent);
			clickSignal.add(onVideoThumbnailClicked);
		}

		/**
		 * 
		 * Dispatch a Signal when clicked. With the id of the video clicked
		 * 
		 */		
		private function onVideoThumbnailClicked(event:MouseEvent):void
		{
			videoClickSignal.dispatch(String(view.data.id));
		}
	}
}