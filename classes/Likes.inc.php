<?php
require_once 'Response.inc.php';
require_once 'Database.inc.php';

class Like extends Database
{
	private $table = 'likes';
	private $allowedConditions_get = array(
		'id',
		'idUser',
		'idPhoto',
	);

	private $allowedConditions_insert_update = array(
		'id',
		'idUser',
		'idPhoto',
	);

	/**
	 * @param
	 * @return
	 */
	private function validate($data){
		return true;
	}

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

	/**
	 * @param array $params
	 * @return
	 */
	public function insert($params)
	{
		foreach ($params as $key => $param) {
			if(!in_array($key, $this->allowedConditions_insert_update)){
				unset($params[$key]);
				$response = array(
					'result' => 'error',
					'details' => 'Error en la solicitud'+ var_dump($params)
				);
	
				Response::result(400, $response);
				exit;
			}
		}
		if($this->validate($params)){
			return parent::insertDB($this->table, $params);
		}
	}
	/**
	 * @param int $id
	 * @param array $params
	 * @return void
	 */
	public function update($id, $params)
	{
		foreach ($params as $key => $parm) {
			if(!in_array($key, $this->allowedConditions_insert_update)){
				unset($params[$key]);
				$response = array(
					'result' => 'error',
					'details' => 'Error en la solicitud'
				);
	
				Response::result(400, $response);
				exit;
			}
		}
		if($this->validate($params)){
			$affected_rows = parent::updateDB($this->table, $id, $params);
			if($affected_rows==0){
				$response = array(
					'result' => 'error',
					'details' => 'No hubo cambios'
				);

				Response::result(200, $response);
				exit;
			}
		}
	}

	/**
	 * @param int $id
	 */
	public function delete($id)	
	{
		$affected_rows = parent::deleteDB($this->table, $id);
		if($affected_rows==0){
			$response = array(
				'result' => 'error',
				'details' => 'No hubo cambios'
			);
			Response::result(200, $response);
			exit;
		}
	}
}