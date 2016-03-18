<?php

class users extends MY_Model 
{
	public function __construct ()
	{
		parent::__construct();
	}

	/** 
	 * 檢查傳入的 username 是否存在（不管該 username 是否已被刪除
	 * @param 	$username 		使用者帳號
	 * @output 	boolean 		若該username已被使用時傳回 TRUE ，反之傳回 FALSE
	 */
	public function is_exist_username ($username)
	{
		$row 	=	$this->get_user($username, array('id'));

		return empty($row) ? FALSE : TRUE;
	}

	/**
	 * 檢查傳入的 username 是否為有效帳號 
	 * @param 	$username 		使用者帳號
	 * @output 	boolean 		TRUE 為有效帳號  FALSE 為無效帳號
	 */
	public function is_valid_user ($username)
	{
		$row 	=	$this->get_user($username, array('id', 'status'));
		if (empty($row))
		{
			return FALSE;
		}
		if (intval($row['status']) !== 1)
		{
			return FALSE;
		}
		return TRUE;
	}

	/** 
	 * 取得使用者資料
	 *
	 */
	public function get_user ($username, array $fields = array())
	{
		$query 	=	$this->db->select(empty($fields) ? '*' : $fields)
		 					 ->from(__CLASS__)
		 					 ->where('username', $username)
		 					 ->get();
		$row 	=	$query->row_array($username);
		$query->free_result();

		return $row;
	}


}