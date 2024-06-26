<?php
// Permitir solicitudes desde cualquier origen
header("Access-Control-Allow-Origin: *");
// Permitir métodos GET, POST, PUT, DELETE y opciones preflights
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
// Permitir ciertos encabezados en las solicitudes
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, api-key");

//Importamos la clase Response y la clase User
require_once 'classes/Response.inc.php';
require_once 'classes/User.inc.php';
require_once 'classes/Authentication.inc.php';

//Creamos el objeto de la clase User para manejar el endpoint
$user = new User();

//Comprobamos de qué tipo es la petición al endpoint
switch ($_SERVER['REQUEST_METHOD']) {
	//Método get
	case 'GET':
		$auth = new Authentication();
	$auth->verify();
		//Recogemos los parámetros de la petición get
		$params = $_GET;

		//Llamamos al método get de la clase User, le pasamos los 
		//parámetros get y comprobamos:
		//1º) si recibimos parámetros
		//2º) si los parámetros están permitidos
		$users = $user->get($params);
		//Creamos la respuesta en caso de realizar una petición correcta
		$response = array(
			'result' => 'ok',
			'users' => $users
		);

		Response::result(200, $response); //devolvemos la respuesta a la petición correcta

		break;
	//Método post
	case 'POST':
		//Recogemos los  parámetros pasados por la petición post
		//decodificamos el json para convertirlo en array asociativo
		//php://input equivale a $_POST para leer datos raw del cuerpo de la petición
		$params = json_decode(file_get_contents('php://input'), true);

		//si no recibimos parámtros...
		if(!isset($params)){
			//creamos el array de error y devolvemos la respuesta
			$response = array(
				'result' => 'error',
				'details' => 'Error en la solicitud'
			);

			Response::result(400, $response);
			exit;
		}

		//realizamos la inserción en BD de la petición
		$insert_id = $user->insert($params);

		//creamos el array de ok y devolvemos la respuesta junto al nuevo id
		$response = array(
			'result' => 'ok',
			'insert_id' => $insert_id
		);

		Response::result(201, $response);


		break;
	//Método put
	case 'PUT':
		$auth = new Authentication();
	$auth->verify();
		//Recogemos los  parámetros pasados por la petición post
		//decodificamos el json para convertirlo en array asociativo
		//php://input equivale a $_POST para leer datos raw del cuerpo de la petición
		$params = json_decode(file_get_contents('php://input'), true);

		//Si no recibimos parámetros, no recibimos el parámetro id o id está vacío
		if(!isset($params) || !isset($_GET['id']) || empty($_GET['id'])){
			//creamos el array de error 
			$response = array(
				'result' => 'error',
				'details' => 'Error en la solicitud'
			);
			//y lo devolvemos como respuesta
			Response::result(400, $response);
			exit;
		}
		//si recibimos el parámtro id y es correcto, realizamos la actualización
		$user->update($_GET['id'], $params);
		//creamos el array de respuesta correcta
		$response = array(
			'result' => 'ok'
		);
		//y devolvemos
		Response::result(200, $response);
		
		break;
	//Método delete
	case 'DELETE':
		$auth = new Authentication();
		$auth->verify();
		//Si no existe el parámetro id o está vacío
		if(!isset($_GET['id']) || empty($_GET['id'])){
			//creamos el array de error y devolvemos la respuesta	
			$response = array(
				'result' => 'error',
				'details' => 'Error en la solicitud'
			);

			Response::result(400, $response);
			exit;
		}
		//eliminamos el id de la base de datos
		$user->delete($_GET['id']);
		//creamos el array de respuesta correcta
		$response = array(
			'result' => 'ok'
		);
		//devolvemos la respuesta
		Response::result(200, $response);
		break;

}
?>