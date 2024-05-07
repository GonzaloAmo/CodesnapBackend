<?php
require_once 'classes/Response.inc.php';
require_once 'classes/Scripts.inc.php';

//Creamos el objeto de la clase User para manejar el endpoint
$script = new Script();

switch ($_SERVER['REQUEST_METHOD']) {
	//Método get
	/**
	 * Probar:
	 *  http://localhost/DWES/API/api/user
	 *  http://localhost/DWES/API/api/user?id=1
	 *  http://localhost/DWES/API/api/user?nombre=Nacho
	 *  http://localhost/DWES/API/api/user?disponible=1
	 *  http://localhost/DWES/API/api/user?page=3
	 *  Cualquier combinación válida de los anteriores.
	 *  En caso de recibir un parámetro distinto dará error.
	 */
	case 'GET':
		$params = $_GET;
		$scripts = $script->get($params);
		$response = array(
			'result' => 'ok',
			'scripts' => $scripts
		);

		Response::result(200, $response);

		break;
	//Método post
	/**
	 * Probar:
	 *  http://localhost/DWES/API/api/user
	 *  body -> raw (radio)
	 *  {
	 *     "nombre": "prueba",
	 *     "disponible": "1"
	 *  }
	 */
	case 'POST':
		$params = json_decode(file_get_contents('php://input'), true);
		if(!isset($params)){
			$response = array(
				'result' => 'error',
				'details' => 'Error en la solicitud'
			);
			Response::result(400, $response);
			exit;
		}
		$insert_id = $script->insert($params);
		$response = array(
			'result' => 'ok',
			'insert_id' => $insert_id
		);
		Response::result(201, $response);

		break;
	//Método put
	/**
	 * Probar:
	 *  http://localhost/DWES/API/api/user?id=1093
	 *  body -> raw (radio)
	 *  {
	 *     "nombre": "nueva prueba",
	 *     "disponible": "1"
	 *  }
	 */
	case 'PUT':
		$params = json_decode(file_get_contents('php://input'), true);
		//Si no recibimos parámetros, no recibimos el parámetro id o id está vacío
		if(!isset($params) || !isset($_GET['id']) || empty($_GET['id'])){
			$response = array(
				'result' => 'error',
				'details' => 'Error en la solicitud'
			);
			Response::result(400, $response);
			exit;
		}
		$script->update($_GET['id'], $params);
		$response = array(
			'result' => 'ok'
		);
		Response::result(200, $response);

		break;
	//Método delete
	/**
	 * Probar:
	 *  http://localhost/DWES/API/api/user?id=1092
	 */
	case 'DELETE':
		if(!isset($_GET['id']) || empty($_GET['id'])){
			$response = array(
				'result' => 'error',
				'details' => 'Error en la solicitud'
			);

			Response::result(400, $response);
			exit;
		}
		$script->delete($_GET['id']);
		$response = array(
			'result' => 'ok'
		);
		Response::result(200, $response);
		break;
	default:
		$response = array(
			'result' => 'error'
		);
		Response::result(404, $response);

		break;
}