package com.examples.youtubeapi.view.mediator
{
	import com.examples.youtubeapi.signals.CommentsFeedSignal;
	import com.examples.youtubeapi.view.components.CommentsArea;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * 
	 * @author Jonathan Torres
	 * Displays comments from a video
	 * CommentsArea.mxml
	 */
	
	public class CommentsAreaMediator extends Mediator
	{
		[Inject]
		public var view:CommentsArea;
		
		[Inject]
		public var commentsFeedSignal:CommentsFeedSignal;
		
		public function CommentsAreaMediator()
		{
			super();
		}
		
		/**
		 * When the comments are received...
		 * 
		 */		
		override public function onRegister():void
		{
			commentsFeedSignal.add(onCommentsReady);
		}
		
		/**
		 * Display the comments in the List
		 * 
		 */		
		private function onCommentsReady(comments:ArrayCollection):void
		{
			view.commentsList.dataProvider = comments;
		}
	}
}