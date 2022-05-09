<?php
class RestAPI_model extends CI_Model
{
    function __construct() {
        parent::__construct();
		$this->load->database();
    }
    public function find_patient($clinic_code) {
		if($clinic_code){
			$this->db->where("clinic_code", $clinic_code);
		}
		$this->db->order_by("first_name", "asc");
        $this->db->group_by('patient_id');
        $query = $this->db->get('view_patient');
        return $query->result_array();
    }
    function get_all_contact_details(){
		$query = $this->db->get('contact_details');
		return $query->result_array();
	}
    public function get_date_formate(){
        $this->db->select('ck_value');
        $query=$this->db->get_where('data',array('ck_key'=>'default_dateformate'));
        $row=$query->row();
        return $row->ck_value;
     }
    public function ajax_all_patients($level) {
		$patients = $this->patient_model->find_patient();
		$contact_details = $this->contact_model->get_all_contact_details();
		$def_dateformate = $this->settings_model->get_date_formate();
		$ajax_data = array();
		foreach ($patients as $patient){
			$col = array();
			if(isset($patient['followup_date']) && $patient['followup_date'] != '0000-00-00'){
				$followup_date = date($def_dateformate,strtotime($patient['followup_date']));
			}else{
			//	$followup_date = "Set Next Follow Up";
        	$followup_date =$this->lang->line('set')." ". $this->lang->line('next_follow_date');
			}
			$col[$this->lang->line('id')] = $patient['display_id'];
			$col[$this->lang->line('ssn_id')] = $patient['ssn_id'];
			$col[$this->lang->line('name')] = "<a class='btn btn-info btn-sm square-btn-adjust' title='Edit' href='".site_url("patient/edit/" . $patient['patient_id']."/patient")."'>".$patient['first_name'] . " " . $patient['middle_name'] . " " . $patient['last_name'] ."</a>";
			$col[$this->lang->line("display")." ".$this->lang->line("name")] = $patient['display_name'];
			$contacts = "";
			foreach($contact_details as $contact_detail){
				if($contact_detail['contact_id'] == $patient['contact_id']){
					if($contacts == ""){
						$contacts .= $contact_detail['detail'];
					}else{
						$contacts .= ",".$contact_detail['detail'];
					}
				}
			}
			$col[$this->lang->line('phone_number')] = $contacts;
			$col[$this->lang->line("email")] = $patient['email'];
			$reference_by = $patient['reference_by'];
			if($patient['reference_by_detail'] != NULL || $patient['reference_by_detail']!= ""){
				$reference_by .= $patient['reference_by_detail'];
			}
			$col[$this->lang->line('reference_by')] = $reference_by;
			$col[$this->lang->line("added_date")] = date($def_dateformate,strtotime($patient['patient_since']));;
			if($level != "Receptionist") {
				$col[$this->lang->line("visit")] = "<a class='btn btn-primary btn-sm square-btn-adjust' title='Visit' href='".site_url("patient/visit/" . $patient['patient_id'])."'>". $this->lang->line("visit")."</a>";
			}
			$col[$this->lang->line("follow_up")] = "<a class='btn btn-success btn-sm square-btn-adjust' title='Follow Up' href='".site_url("patient/followup/" . $patient['patient_id'])."'>".$followup_date."</a>";
			if($level != "Receptionist") {
				$col[$this->lang->line('delete')]="<a class='btn btn-danger btn-sm square-btn-adjust confirmDelete deletePatient' data-patient_id='".$patient['patient_id']."' title='".$this->lang->line('delete')."' ><i class='fa fa-trash'>".$this->lang->line("delete")."</a>";
			}
			$ajax_data[] = $col;
		}
		echo '{ "data":'.json_encode($ajax_data).'}';
	}
    public function get_contacts($id){

        $query = $this->db->get_where('contacts', array('contact_id' => $id));
        echo $this->db->last_query();
        return $query->row_array();

	}
    function get_contact_id($patient_id) {
        $query = $this->db->get_where('patient', array('patient_id' => $patient_id));
        $row = $query->row();
		//print_r($row);
        if ($row)
            return $row->contact_id;
        else
            return 0;
    }
    function get_patient_detail($patient_id) {

        //$this->db->group_by('patient_id');

        $query = $this->db->get_where('view_patient', array('patient_id' => $patient_id));

		//echo $this->db->last_query()."<br/>";

        return $query->row_array();

    }
    public function insert_contact($data){
        $this->db->insert('contacts', $data);
        $contact_id = $this->db->insert_id();
        //echo $this->db->last_query();
        return $contact_id;
    }
    function insert_patient($contact_id,$patient_since,$display_id,$data,$last_name) {

        $data['contact_id'] = $contact_id;

        $data['patient_since'] = $patient_since;

        $data['display_id'] = $display_id;

		$data['sync_status'] = 0;

        $this->db->insert('patient', $data);

		//echo $this->db->last_query()."<br/>";

		$p_id = $this->db->insert_id();

		if($display_id == ""){

			$this->display_id($p_id,$last_name);

		}

        return $p_id;

    }
    function is_english($str){

		if (strlen($str) != strlen(utf8_decode($str))) {

			return false;

		} else {

			return true;

		}

	}
    function display_id($id,$last_name) {

		$str = "";

		if($this->is_english($last_name)){

			$str = $last_name[0];

			$str = strtoupper($str);

		}





        $p_id = $id;

        $n = 5;

        $num = str_pad((int) $p_id, $n, "0", STR_PAD_LEFT);

        $display_id = $str . $num;



        $this->db->set("display_id", $display_id);

		$this->db->set("sync_status", 0);

        $this->db->where("patient_id", $p_id);

        $this->db->update("patient");

		//echo $this->db->last_query()."<br/>";

    }
    function insert_contact_details_full($contact_id,$contact_type,$contact_detail,$is_default,$clinic_code){

		$data = array();

		$data['contact_id'] = $contact_id;

		$data['type'] = $contact_type;

		$data['detail'] = $contact_detail;

		$data['is_default'] = $is_default;

		$data['clinic_code'] = $clinic_code;



		$this->db->insert('contact_details', $data);

		//echo $this->db->last_query();

	}
    function insert_patient_full($contact_id,$display_id,$reference_by,$gender,$dob,$age=NULL){

		$data['contact_id'] = $contact_id;

        $data['patient_since'] = date("Y-m-d");

        $data['display_id'] = $display_id;

        $data['reference_by'] = $reference_by;

		$data['gender'] = $gender;

		$data['age'] = $age;

		$data['sync_status'] = 0;



		/*if($this->session->userdata('clinic_code')){

			$data['clinic_code'] = $this->session->userdata('clinic_code');

		}*/

		if($dob != NULL){

			$data['dob'] = date('Y-m-d',strtotime($dob));

		}



        $this->db->insert('patient', $data);

		//echo $this->db->last_query();

		$patient_id = $this->db->insert_id();

		if($display_id == ""){

			$this->display_id($patient_id);

		}

		//echo $this->db->last_query();

        return $patient_id;

	}
    /** Delete Patient */
    public function delete_patient($patient_id) {
        $this->db->select('contact_id');
        $query = $this->db->get_where('patient', array('patient_id' => $patient_id));
        //echo $this->db->last_query()."<br/>";
        $row = $query->row();
        if($row) {
            $c_id = $row->contact_id;
            /* Delete ck_contact_details data where Contact Id = $c_id */
            $this->db->delete('contact_details', array('contact_id' => $c_id));
            /* Delete ck_contacts data where Contact Id = $c_id */
            $this->db->delete('contacts', array('contact_id' => $c_id));
            /* Delete ck_patient data where Patient Id = $patient_id */
            $this->db->delete('patient', array('patient_id' => $patient_id));
        }
    }
    /** Update PAtient */
    function update_contact($data,$contact_id){
		$data['sync_status'] = 0;
		$this->db->update('contacts', $data, array('contact_id' =>  $contact_id));
		//echo $this->db->last_query();
	}
    function update_contact_details($contact_id,$types,$details,$is_default,$clinic_code){
		$i = 0;
		$this->db->delete('contact_details', array('contact_id' => $contact_id));
		if(!empty($types)){
			foreach($types as $type){
				$data = array();
				$data['contact_id'] = $contact_id;
				$data['type'] = $type;
				$data['detail'] = $details[$i];
				if(isset($is_default[$i]) && $is_default[$i]){
					$data['is_default'] = 1;
				}else{
					$data['is_default'] = 0;
				}
				$data['clinic_code'] = $clinic_code;
				$this->db->insert('contact_details', $data);
				//echo $this->db->last_query();
				$i++;
			}
		}
	}
    function update_address($data,$contact_id){
		$this->db->update('contacts', $data, array('contact_id' =>  $contact_id));
	}
    public function update_reference_by($patient_id,$reference_by,$reference_details){
		$data['reference_by'] = "";
		$data['sync_status'] = 0;
        if($reference_by){
			$data['reference_by'] = $reference_by;
			if($reference_by == "Self"){
				$data['reference_by_detail'] = " ";
			}
			if(reference_by == "Internet"){
				$data['reference_by_detail'] = " ";
			}
		}
		if($reference_details){
			$data['reference_by_detail'] = $reference_details;
		}
        $this->db->update('patient', $data, array('patient_id' => $patient_id));
		//echo $this->db->last_query();
    }
    public function update_patient_data($patient_id,$data,$clinic_code,$dob){
		if($clinic_code){
			$data['clinic_code'] = $clinic_code;
		}
		if($dob){
			$data['dob'] = date('Y-m-d',strtotime($dob));
		}
        $this->db->update('patient', $data, array('patient_id' => $patient_id));
		//echo $this->db->last_query();
    }
    public function update_display_id($patient_id,$display_id){
        $data['display_id'] = $display_id;
		$data['sync_status'] = 0;
        $this->db->update('patient', $data, array('patient_id' => $patient_id));
		//echo $this->db->last_query();
    }
	/**
	 * Add Token to rest api response table
	 */
	function add_response_data($data) {
        $this->db->insert('rest_api_response', $data);
       // echo $this->db->last_query();
    }
	/**
	 * Get Valid token data
	 */
    function get_token($token) {
        $this->db->where("token", $token);
        $query = $this->db->get("rest_api_response");
		//echo $this->db->last_query();
        if ($query->num_rows() > 0) {
			$result = $query->row_array();
			//return TRUE;
			return $result;
        }else{
            return FALSE;
        }
    }
	/**
	 * Check token is generated for perticulare user
	 */
	function check_token($username, $password) {
		$this->db->where("username", $username);
        $this->db->where("password", $password);
        $this->db->where("is_deleted",NULL);

        $query = $this->db->get("users");
		$result = $query->row();
		$userid=$result->userid;

        $this->db->where("user_id", $userid);
		$this->db->where("response_date", date('Y-m-d'));
        $query = $this->db->get("rest_api_response");
		//echo $this->db->last_query();
        if ($query->num_rows() > 0) {
			$result = $query->row_array();
			//return TRUE;
			return $result;
        }else{
            return FALSE;
        }
    }
}

?>
