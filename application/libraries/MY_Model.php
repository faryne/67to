<?php

class MY_Model extends CI_Model
{
	
	public function __construct ()
	{
		parent::__construct();
	}

	public function get_by_id ($table, $id, $fields = array())
	{
		$sql 	=	sprintf(
						"SELECT %s FROM %s WHERE id = ?",
						empty($fields) ? '*' : implode(',', $fields),
						$table 
					);
		$query	=	$this->db->query($sql, array($id));
		$row 	=	$query->row_array();
		$query->free_result();

		return $row;

	}
}