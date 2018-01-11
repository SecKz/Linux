<?php

class TestController extends Controller {

	#public $layout = 'column1';
	public $layout = '';

	public function actions() {
		#header('Content-Type:text/html;charset=UTF-8');
		#return true;

	}

	public function beforeAction($action) {
		header('Content-Type:text/html;charset=UTF-8');
		echo '-------------------this is the action start----------------','<br />';
		return true;
	}


	# 参考 http://hudeyong926.iteye.com/blog/1396317
	public function afterAction($action) {
		echo '-------------------this is the action ending----------------','<br />';
		var_dump(Yii::app()->user->isGuest);
		var_dump($action->getId());
		return true;

	}

	public function actionIndex() {
		echo '这是一个测试类','<br />';
		echo __FUNCTION__ ,'<br />';
		echo $this->id, '<br />';
		echo $this->action->id,'<br />';
		$this->renderPartial('index',array('data'=>'nnnnnnnnn'));

	}

	public function actionSelf() {
		echo __FUNCTION__,'<br />';

	}

	public function actionView() {

	#	$this->renderPartial('view',array('model'=>$model));

	}

}

?>