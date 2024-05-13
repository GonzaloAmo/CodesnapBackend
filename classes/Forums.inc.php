<?php
require_once 'Response.inc.php';
require_once 'Database.inc.php';

class Forum extends Database
{
	private $table = 'forums';
	private $allowedConditions_get = array(
		'id',
		'idUser',
		'title',
        'question',
        'creation_date',
        'response_number',

	);

	private $allowedConditions_insert_update = array(
		'id',
		'idUser',
		'title',
        'question',
        'creation_date',
        'response_number',
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
		if(!isset($data['title']) || empty($data['title'])){
			//... genera la respuesta de error
			$response = array(
				'result' => 'error',
				'details' => 'El campo code es obligatorio'
			);

			Response::result(400, $response);
			exit;
		}
        if(!isset($data['question']) || empty($data['question'])){
			//... genera la respuesta de error
			$response = array(
				'result' => 'error',
				'details' => 'El campo question es obligatorio'
			);

			Response::result(400, $response);
			exit;
		}
        // ACTIVAR ESTO CUANDO SE AÑADA EL RECUPERAR LA FECHA EN EL MOMENTO QUE SE CREA
        // if(!isset($data['creation_date']) || empty($data['creation_date'])){
		// 	//... genera la respuesta de error
		// 	$response = array(
		// 		'result' => 'error',
		// 		'details' => 'El campo creation_date es obligatorio'
		// 	);

		// 	Response::result(400, $response);
		// 	exit;
		// }
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
     * probar con: {"idUser":"2","title":"Titulo del foro","question":"Alguien sabe como realizar...? "}
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
//probar con: {"id":"2","username":"usuario2","email":"usuario2@example.com","password":"1234","fechanacimiento":"2000-01-01","sexo":"1","telefono":"628742007","fecha_ingreso":"2024-04-24","nombrecompleto":"Usuario Dos","descripcion":"Descripci del usuario dos","ubicacion":"Ciudad Dos"} 	/**

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