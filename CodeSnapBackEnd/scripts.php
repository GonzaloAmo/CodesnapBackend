<?php
// Permitir solicitudes desde cualquier origen
header("Access-Control-Allow-Origin: *");
// Permitir métodos GET, POST, PUT, DELETE y opciones preflights
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
// Permitir ciertos encabezados en las solicitudes
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, api-key");

require_once 'classes/Response.inc.php';
require_once 'classes/Scripts.inc.php';
require_once 'classes/Authentication.inc.php';

//Creamos el objeto de la clase User para manejar el endpoint
$script = new Script();

switch ($_SERVER['REQUEST_METHOD']) {
	//Método get
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
	case 'POST':
		$auth = new Authentication();
		$auth->verify();
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
}