<?php
require_once 'Response.inc.php';
require_once 'Database.inc.php';

class ForumApp extends Database
{
	private $table = 'forumsApp';
	private $allowedConditions_get = array(
		'name',
		'imagen',
		'link'
	);

	/**
	 * @param array $params
	 * @return
	 */
	public function get($params){
		foreach ($params as $key => $param) {
			if(!in_array($key, $this->allowedConditions_get)){
				unset($params[$key]);
				$response = array(
					'result' => 'error',
					'details' => 'Error en la solicitud'
				);
				Response::result(400, $response);
				exit;
			}
		}
		//llamamos 
		$users = parent::getDB($this->table, $params);

		return $users;
	}

}