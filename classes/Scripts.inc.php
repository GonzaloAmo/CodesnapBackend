<?php
require_once 'Response.inc.php';
require_once 'Database.inc.php';

class Script extends Database
{
	private $table = 'scripts';
	private $allowedConditions_get = array(
		'id',
		'idUser',
		'code',
		'title',
		'dateCreated'
	);

	private $allowedConditions_insert_update = array(
		'idUser',
		'code',
		'title'
	);

	/**
	 * @param
	 * @return
	 */
	private function validate($data){
		if(!isset($data['idUser']) || empty($data['idUser'])){
			//... genera la respuesta de error
			$response = array(
				'result' => 'error',
				'details' => 'El campo idUser es obligatorio'
			);

			Response::result(400, $response);
			exit;
		}
		if(!isset($data['code']) || empty($data['code'])){
			//... genera la respuesta de error
			$response = array(
				'result' => 'error',
				'details' => 'El campo code es obligatorio'
			);

			Response::result(400, $response);
			exit;
		}
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