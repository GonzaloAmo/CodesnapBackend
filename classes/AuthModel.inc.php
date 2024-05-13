<?php

class AuthModel
{
	private $connection;//atributo que se guarda la conexión
	/**
     * Constructor que se encarga de realizar la conexión
     */
	public function __construct(){
		$this->connection = new mysqli('127.0.0.1', 'root', '', 'codesnap');

		if($this->connection->connect_errno){
			echo 'Error de conexión a la base de datos';
			exit;
		}
	}
    /**
     * Método login: realiza la llamada a BD con el usuario y contraseña y comprueba si existe en BD
     *
     * @param string $username Usuario en BD
     * @param string $password Contraseña en BD
     * @return array Array asociativo con la información del usuario
     */
    public function login($username, $password)
	{
		$query = "SELECT id, email, username FROM users WHERE username = '$username' AND password = '$password'";

		$results = $this->connection->query($query);

		$resultArray = array();

		if($results != false){
			foreach ($results as $value) {
				$resultArray[] = $value;
			}
		}

		return $resultArray;
	}
    /**
     * Método update: actualiza el token del usuario pasado por parámetro
     *
     * @param int $id id del usuario en BD
     * @param string $token El token generado para el usuario
     * @return int
     */
	public function update($id, $token)
	{
		$query = "UPDATE users SET token = '$token' WHERE id = $id";

		$this->connection->query($query);
		
		if(!$this->connection->affected_rows){
			return 0;
		}

		return $this->connection->affected_rows;
	}

	public function getById($id)
	{
		$query = "SELECT token FROM users WHERE id = $id";

		$results = $this->connection->query($query);

		$resultArray = array();

		if($results != false){
			foreach ($results as $value) {
				$resultArray[] = $value;
			}
		}

		return $resultArray;
	}
}
