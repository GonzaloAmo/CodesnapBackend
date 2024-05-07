<?php
require_once 'classes/Response.inc.php';
require_once 'classes/Likes.inc.php';

//Creamos el objeto de la clase User para manejar el endpoint
$like= new Like ();

switch ($_SERVER['REQUEST_METHOD']) {
	case 'GET':
		$params = $_GET;
		$likes = $like->get($params);
		$response = array(
			'result' => 'ok',
			'foros' => $likes
		);

		Response::result(200, $response);

		break;
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
		$insert_id = $like->insert($params);
		$response = array(
			'result' => 'ok',
			'insert_id' => $insert_id
		);
		Response::result(201, $response);

		break;
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
		$like->update($_GET['id'], $params);
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
		$like->delete($_GET['id']);
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