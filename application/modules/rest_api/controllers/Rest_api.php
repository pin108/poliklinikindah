<?php
Header('Access-Control-Allow-Origin: *'); //for allow any domain, insecure

class Rest_api extends CI_Controller
{
    public function __construct() {
               parent::__construct();
               $this->load->model('restAPI_model');
               $this->load->model('contact/contact_model');
               $this->load->model('patient/patient_model');
               $this->load->model('settings/settings_model');
               $this->load->model('admin/admin_model');
               $this->load->model('doctor/doctor_model');
               $this->load->model('appointment/appointment_model');
               $this->load->model('module/module_model');
               $this->load->model('bill/bill_model');
               $this->load->model('payment/payment_model');
               $this->load->model('menu_model');
			   $this->load->model('login/login_model');
			   //$this->load->model('prescription/prescription_model');
			   //$this->load->model('menu_access/menu_access_model');
			   //$this->load->model('history/history_model');
			   //$this->load->model('sessions/sessions_model');
			   //$this->load->model('treatment/treatment_model');
               $this->lang->load('main','english');

			   $this->load->library('session');
			   $this->load->library('form_validation'); 
			   $this->load->helper('currency');
			   $this->load->helper('date');
			   $this->load->helper('currency_helper');
    } 

	/** Fetch session data */
	public  function get_sessions()
	{
		$sessions = $this->sessions_model->get_sessions();
		$session_dates = $this->sessions_model->get_session_date_id('session_date_id');
		$def_dateformate = $this->settings_model->get_date_formate();
		$doctor_name = $this->doctor_model->get_doctor_name();
		$doctor_id = $this->doctor_model->get_doctor_details('id');
		$doctors = $this->doctor_model->get_doctor_fees();
		$patients = $this->patient_model->get_patient();
		$patient_name = $this->patient_model->get_patient_name();
		$patient_id = $this->patient_model->get_patient_detail('patient_id');
		//$bill = $this->bill_model->get_bill($bill_id);
		//$bill_id = $this->bill_model->get_bill_detail('bill_id');
		$bill_id = $this->bill_model->create_bill_for_patient($patient_id,0,$doctor_id);

		$session_data = array();
		$i=1;
		foreach($sessions as $session){
			$row['sr_no'] = $i;
			$row['session_id'] = $session['session_id'];
			$row['bill_id'] = $session['bill_id'];
			$patients = explode(",",$session['patient_id']); 
				$row['patient_name'] = "";
				foreach ($patients as $patient_id){
					if($row['patient_name'] != ""){
						$row['patient_name'] .=  ",";
					}
					$row['patient_name'] = $patient_name[$patient_id];
				}
			$row['patient_id'] = $session['patient_id'];
			$doctors = explode(",",$session['doctor_id']);
				$row['doctor_name'] = "";
				foreach ($doctors as $doctor_id){
					if($row['doctor_name'] != ""){
						$row['doctor_name'] .=  ",";
					}
					$row['doctor_name'] = $doctor_name[$doctor_id];
				}
			$row['doctor_id'] = $session['doctor_id'];
			$row['start_date'] = date($def_dateformate,strtotime($session['start_date']));
			$row['total_appointments'] = $session['total_appointments'];
			$row['pending_appointments'] = $session['pending_appointments'];
			$row['frequency'] = $session['frequency'];
			$row['charges'] = $session['charges'];
			$row['frequency'] = $session['frequency'];
			$row['pending_payment'] = $session['charges'] - $session['paid_amount'];
			$i++;
			$session_data[] = $row;	
		}
		echo json_encode($session_data);
		
	}

	/** Fetch history */
	public  function get_section_data()
	{
		$get_sections = $this->history_model->get_section_data();
	
		echo json_encode($get_sections);
	}

	/**
    *Fetch payment method  
    */  
	public function get_payment_method()
	{
		$pay = array();
		$payment_methods= $this->settings_model->get_payment_methods();
		
		$i=1;
		foreach($payment_methods as $payment_method)
		{
			$row['sr_no'] = $i;
			$row['payment_method_id'] = $payment_method['payment_method_id'];
			$row['payment_method_name'] = $payment_method['payment_method_name'];
			$i++;
			$pay[] = $row;
		}
		echo json_encode($pay);
	}
	
	/** Fetch all Users */
	public  function get_users(){
		$users = $this->admin_model->get_users();

		$all_users = array();
		foreach($users as $user){
			if($user['is_active'] == 1){
				$user['is_active'] = "Yes";
			}else{
				$user['is_active'] = "No";
			}
			$all_users[] = $user;
		}
		echo json_encode($all_users);
	}

	/**
	 * fetch the menu_access detail
	 */
	public function get_categories_access(){
		$categories_access = array();
		
		$level = $this->session->userdata('category');
		$categories = $this->menu_access_model->find_category();
		$mymenus = $this->menu_access_model->get_mymenu();	
		$menu_accesss = $this->menu_access_model->get_menu_access();

		foreach ($categories as $category){
			// Show System Administrator access only to System Administrator
			if ($category['category_name']!="System Administrator" || $level == "System Administrator"){
				$row['id'] = $category['id'];
				$row['name'] = $category['category_name'];
				$row['allow_menu'] = "";
				foreach ($menu_accesss as $menu_access){
					if(($category['category_name'] == $menu_access['category_name']) && ($menu_access['allow']==1))
					{ 										 						
						foreach ($mymenus as $mymenu){
							if($menu_access['menu_text']==$mymenu['menu_text']){
								$row['allow_menu'] .= $this->lang->line($mymenu['menu_text']);
								$row['allow_menu'] .= ", ";
							}
						}
					}
				}
				$categories_access[] = $row;
			}
		}
		echo json_encode($categories_access);
	} 

	/** Fetch Exceptional Days */
	public  function get_exceptional_days(){
		$get_exceptional_days = $this->settings_model->get_exceptional_days();
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();

		$exceptional_days = array();
		$i=1;
		foreach($get_exceptional_days as $exceptional_day){
			$row['sr_no'] = $i;
			$row['uid'] = $exceptional_day['uid'];
			$row['working_date'] = date($def_dateformate,strtotime($exceptional_day['working_date']));
			$row['end_date'] = date($def_dateformate,strtotime($exceptional_day['end_date']));
			$row['start_time'] = date($def_timeformate,strtotime($exceptional_day['start_time']));
			$row['end_time'] = date($def_timeformate,strtotime($exceptional_day['end_time']));
			$row['working_status'] = $exceptional_day['working_status'];
			$row['working_reason'] = $exceptional_day['working_reason'];
			$i++;
			$exceptional_days[] = $row;
		}	
		echo json_encode($exceptional_days);
	}
	
	/* Fetch Doctor Unavailability*/

	public function get_dr_inavailability(){
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();
		$doctors= $this->doctor_model->find_doctor();
		$availability=$this->appointment_model->get_dr_inavailability();

		$inavailability = array();
		$i=1;
		foreach ($availability as $avi){
			$row['sr_no']=$i;
			$row['appointment_id'] = $avi['appointment_id'];
			$row['userid'].= $this->session->userdata('id');
			
		foreach ($doctors as $doctor){
			if ($avi['doctor_id'] == $doctor['doctor_id']) {
				$row['doctor_name']=$doctor['title'] . ' ' . $doctor['first_name'] . ' ' . $doctor['middle_name']. ' ' . $doctor['last_name'];

			}
		}
			$row['appointment_date'] = date($def_dateformate,strtotime($avi['appointment_date']));
			$row['end_date'] = date($def_dateformate,strtotime($avi['end_date']));
			$row['start_time'] = date($def_timeformate,strtotime($avi['start_time']));
			$row['end_time'] = date($def_timeformate,strtotime($avi['end_time']));
			$i++;
			$inavailability[] = $row;
		}

		echo json_encode($inavailability);
	}

   /** 
	* Fetch department 
		*/
	public  function get_all_departments()
	{	
		$all_department = array();	
		$departments = $this->doctor_model->get_all_departments();

		$i=1;
		foreach ($departments as $department){
			$row['sr_no']=$i;
			$row['department_id']=$department['department_id'];
			$row['department_name']=$department['department_name'];
			$i++;
			$all_department[] = $row;
		}
		echo json_encode($all_department);
			
	}

	/**
    *Fetch Fees detail   
    */  
	public function get_fees()
	{	
		$data = array();

		$fees = $this->doctor_model->find_fees();
		$doctor_name = $this->doctor_model->get_doctor_name();
		$doctor_id = $this->doctor_model->get_doctor_details('id');
		$doctors = $this->doctor_model->get_doctor_fees();	
		
		$i=1;
		foreach($fees as $fee)
		{
			$row['sr_no'] = $i;
			$row['id'] = $fee['id'];
			$doctors = explode(",",$fee['doctor_id']);
					$row['doctor_name'] = "";
					foreach ($doctors as $doctor_id){
						if($row['doctor_name'] != ""){
							$row['doctor_name'] .=  ",";
						}
						$row['doctor_name'] = $doctor_name[$doctor_id];
					}
			$row['doctor_id'] = $fee['doctor_id'];
			$row['detail'] = $fee['detail'];
			$row['fees'] = $fee['fees'];
			$i++;
		
		$data[] = $row;
		}
		echo json_encode($data);
	}


	/** Fetch Doctor */	
	public function find_doctor()
	{
		$all_doctor = array();	
		$category = $this->session->userdata('category');
		$doctors= $this->doctor_model->find_doctor();
		
		$departments = $this->doctor_model->get_all_departments();

		$department_name = array();
		$i=1;
		foreach($departments as $department){
			$department_name[$department['department_id']] = $department['department_name'];
		}

		$all_doctor = array();
		if(isset($doctors)){ 
			foreach ($doctors as $doctor){
				
				$display = TRUE;
				$user_id = $this->session->userdata('id'); 
				if ($this->doctor_model->is_doctor($user_id)) {
					if($doctor['userid'] != $this->session->userdata('id')) {
						$display = FALSE;
					}
				}
				if($display) {
					$row['sr_no']=$i;
					$row['doctor_id'] = $doctor['doctor_id'];
					$row['doctor_name']= $doctor['title'] . " " .$doctor['first_name'] . " " . $doctor['middle_name'] . " " . $doctor['last_name'];
					$doctor_departments = explode(",",$doctor['department_id']); 
					$row['departments'] = "";
					foreach ($doctor_departments as $department_id){
						if($row['departments'] != ""){
							$row['departments'] .=  ",";
						}
						$row['departments'] .= $department_name[$department_id];
					}
					$row['email'] = $doctor['email'];
					$row['phone_number'] = $doctor['phone_number'];

				}$i++;
				$all_doctor[] = $row;

			}
		}

		echo json_encode($all_doctor);	
	}
	/** Fetch nurse */	
	public function get_nurse()
	{
		$all_nurse = array();	
		$category = $this->session->userdata('category');
		$nurses= $this->doctor_model->get_nurse();
		
		$departments = $this->doctor_model->get_all_departments();

		$department_name = array();
		$i=1;
		foreach($departments as $department){
			$department_name[$department['department_id']] = $department['department_name'];
		}

		$all_nurse = array();
		if(isset($nurses)){ 
			foreach ($nurses as $nurse){
				
				$display = TRUE;
				if($category == 'nurse'){
					if($nurse['userid'] != $this->session->userdata('id')) {
						$display = FALSE;
					}
				}
				if($display) {
					$row['sr_no']=$i;
					$row['nurse_id'] = $nurse['nurse_id'];
					$row['nurse_name']= $nurse['title'] . " " .$nurse['first_name'] . " " . $nurse['middle_name'] . " " . $nurse['last_name'];
					$nurse_departments = explode(",",$nurse['department_id']); 
					$row['departments'] = "";
					foreach ($nurse_departments as $department_id){
						if($row['departments'] != ""){
							$row['departments'] .=  ",";
						}
						$row['departments'] .= $department_name[$department_id];
					}
					$row['email'] = $nurse['email'];
					$row['phone_number'] = $nurse['phone_number'];

				}$i++;
				$all_nurse[] = $row;

			}
		}

		echo json_encode($all_nurse);	
	}
	/**
    *Fetch All Patient Reports
    */ 
	public function get_patient_report()
	{
		$patient_report = $this->patient_model->get_patient_report();
		$email = $this->contact_model->get_contact_email($contact_id);
		$reference_by= $this->settings_model->get_reference_by();
		$def_dateformate = $this->settings_model->get_date_formate();

		$report = array();
		$i=1;
		foreach($patient_report as $patient){

			$row['sr_no'] = $i;
			$row['display_id'] = $patient['display_id'];
			$row['patient_name'] = $patient['patient_name'];
			$row['phone_number'] = $patient['phone_number'];
			$row['email'] = $patient['email'];
			$row['reference_by'] = $patient['reference_by'];
			$reference_by = $patient['reference_by'];
				if($patient['reference_by_detail'] != NULL || $patient['reference_by_detail']!= ""){
					$reference_by .= $patient['reference_by_detail'];
				}

			if($patient['followup_date'] != '0000-00-00' && $patient['followup_date'] != NULL){

				$row['follow_up'] = date($def_dateformate,strtotime($patient['followup_date']));
			}
			$i++;
			$report[] = $row;
		}
		echo json_encode($report);
	}

/** Fetch Bill details */
	public function get_bills()
	{
		
		$bills = $this->bill_model->get_bills();
		$bill_details = $this->bill_model->get_bill_details();
		$doctor = $this->doctor_model->get_doctors();
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();
		$tax_type = $this->settings_model->get_data_value('tax_type');
		//$tax_rates = $this->settings_model->get_tax_rates();
		$patients = $this->patient_model->get_patient();
		
		$total_amount = 0;
		$pay_amount = 0;
		$due_amount = 0;
		$i=1;
		$bill_recipt = array();
		foreach($bills as $bill){

			$row['sr_no'] = $i;
			$row['bill_id'] = $bill['bill_id'];
			$row['bill_date'] = date($def_dateformate,strtotime($bill['bill_date']));
			$row['patient_name'] = $bill['first_name'] . ' ' . $bill['middle_name'] . ' ' . $bill['last_name'];
			$row['doctor_name'] = $bill['doctor_name'];
			$row['total_amount'] = $bill['total_amount'] + $bill[$tax_type.'tax_amount'];
			$row['pay_amount'] = $bill['pay_amount'];
			$row['due_amount'] = $bill['due_amount'];
			$row['patient_id'] = $bill['patient_id'];
			$row['tax_amount'] = $bill['tax_amount'];

			$i++;

			$total_amount = $total_amount+$bill['total_amount']+$bill[$tax_type.'tax_amount'];
			$due_amount = $due_amount+$bill['due_amount'];
			$pay_amount = $pay_amount+$bill['pay_amount'];
			
			$bill_recipt[] = $row;
		}
		echo json_encode($bill_recipt);
	}

	public function get_payments()
	{
		
		$payments = $this->payment_model->get_payments();
		$patients = $this->patient_model->get_patient();
		$patient_name = $this->patient_model->get_patient_name();
		$patient_id = $this->patient_model->get_patient_detail($patient_id);

		$i=1;
		$payment_list = array();
		foreach($payments as $payment)
		{
			$row['sr_no'] = $i;
			$row['payment_id'] = $payment['payment_id'];
			$row['pay_date'] = $payment['pay_date'];
			$patient_detail = explode(",",$payment['patient_id']); 
					$row['patient_name'] = "";
					foreach ($patient_detail as $patient_id){
						if($row['patient_name'] != ""){
							$row['patient_name'] .=  ",";
						}
						$row['patient_name'] = $patient_name[$patient_id];
					}
			$row['patient_id'] = $payment['patient_id'];		
			$row['pay_amount'] = $payment['pay_amount'];
			$row['pay_mode'] = $payment['pay_mode'];
			$row['payment_status'] = $payment['payment_status']; 
			if (in_array("snaap", $active_modules)) {	
				$row['cases'] = $payment['cases'];
			}
			$row['action'] = $payment['action'];
			$i++;
			$payment_list[] = $row;
		}
		echo json_encode($payment_list);
	}

	/**Fetch Issue Refund detail */
	public function get_refunds()
	{
		
		$refunds = $this->payment_model->get_refunds();
		$def_dateformate = $this->settings_model->get_date_formate();
		$patients = $this->patient_model->get_patient();
		$patient_name = $this->patient_model->get_patient_name();
		$patient_id = $this->patient_model->get_patient_detail($patient_id);
		
		$i=1;
		$issue_refund = array();
		foreach ($refunds as $refund)
		{
			$row['sr_no'] = $i;
			$row['refund_id'] = $refund['refund_id'];
			$row['refund_date'] = date($def_dateformate,strtotime($refund['refund_date']));
			$patient_detail = explode(",",$refund['patient_id']); 
					$row['patient_name'] = "";
					foreach ($patient_detail as $patient_id){
						if($row['patient_name'] != ""){
							$row['patient_name'] .=  ",";
						}
						$row['patient_name'] = $patient_name[$patient_id];
					}
			$row['patient_id'] = $refund['patient_id'];
			$row['refund_amount'] = $refund['refund_amount'];
		
			$i++;
			$issue_refund[] = $row;
		}
		echo json_encode($issue_refund);
	}

	/**
	 * Fetch bill report
	 */	
	public function get_bill_report()
	{	
		//$reports = $this->patient_model->get_bill_report($from_date,$to_date);
		//$report = $this->patient_model->get_bill_detail_amount();
		$bill_from_date = date('Y-m-d');
		$bill_to_date = date('Y-m-d');
		$clinics =$this->settings_model->get_all_clinics();
		$clinic_id =$this->session->userdata('clinic_id');
		$report = $this->bill_model->get_bill_detail('bill_id');
		$reports = $this->bill_model->get_bill_report($bill_from_date,$bill_to_date,$clinic_id);
		$bills = $this->bill_model->get_bills();
		$bill_details = $this->bill_model->get_bill_details();
		$patients = $this->patient_model->get_patient();
		$doctor = $this->doctor_model->get_doctors();
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();
		$tax_type = $this->settings_model->get_data_value('tax_type');
		$active_modules = $this->module_model->get_active_modules();
	
		$i=1;
		$report = array();

		$bill_amt=0; 
		$pay_amt=0; 
		$due_amt=0;

		foreach($bills as $bill)
		{
			$row['sr_no'] = $i;
			$row['bill_id'] = $bill['bill_id'];
			$row['bill_date'] = date($def_dateformate,strtotime($bill['bill_date']));
			$row['patient_id'] = $bill['patient_id'];
			$row['patient_name'] = $bill['first_name'] . ' ' .$bill['middle_name'] . ' ' . $bill['last_name'];
			$row['doctor_id'] = $bill['doctor_id'];
			$row['doctor_name'] = $bill['doctor_name'];
			$row['amount'] = $bill['total_amount'];
			$row['pay_amount'] = $bill['pay_amount'];
			$row['due_amount'] = $bill['due_amount'];
			//$row['tax_amount'] = $bill['tax_amount'];
			
			/*$row['bill_amt'] = $bill_amt+ $bill['total_amount']+ $bill[$tax_type.'_tax_amount'];
			$pay_amt = $pay_amt+ $bill['pay_amount'];
			$due_amt = $due_amt+ $bill['total_amount'] + $bill[$tax_type.'_tax_amount'] - $bill['pay_amount'];
			*/
			$i++;
			$report[] = $row;
		}
		echo json_encode($report);
	}

	/**
	 * Fetch Tax Report
	 */
	public function get_tax_report()
	{
		$tax_report = $this->bill_model->get_tax_report($from_date,$to_date);
		$bill_details = $this->bill_model->get_bill_details();
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();

		$grand_total = 0;
		$tax_total = 0;
		$tax_data = array();
		$i=1;
		foreach ($tax_report as $tax)
		{

			$row['sr_no'] = $i;
			$row['bill_id'] = $tax['bill_id'];
			$row['bill_date'] = date($def_dateformate,strtotime($tax['bill_date']));
			$row['patient_id'] = $tax['display_id'];
			$row['patient_name'] = $tax['first_name'] . ' ' .$tax['middle_name'] . ' ' . $tax['last_name'];
			$row['tax_amount'] = $tax['taxable_amount'];
			$row['total_amount'] = $tax['total_amount'];
			$row['bill_amount'] = $row['tax_amount'] + $row['total_amount'];
			$row['item_tax_amount'] = $tax['item_tax_amount'];
			$grand_total = $grand_total + $row['total_amount'];
			$tax_total = $tax_total + $row['tax_amount'];

			$i++;
			$tax_data[] = $row;
		}
		echo json_encode($tax_data);
	}

	/**
	 * Fetch Treatment Report
	 */
	public function get_treatment_report()
	{
		$from_date = date('Y-m-d');
		$to_date = date('Y-m-d');
		$selected_doctors = array();
		$selected_treatments = array();

		$treatment_reports = $this->treatment_model->get_treatments();
		$treatmentss = $this->treatment_model->get_treatment('id');
		$doctor_name = $this->doctor_model->get_doctor_name();
		$doctor_id = $this->doctor_model->get_doctor_details('id');
		$doctor = $this->doctor_model->get_doctor_doctor_id($doctor_id);
		$timezone = $this->settings_model->get_time_zone();
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();
		$patient_id = $this->patient_model->get_patient();
		$patient_name = $this->patient_model->get_patient_name();
		$treatment_report = $this->treatment_model->get_treatment_report($from_date,$to_date,$selected_doctors,$selected_treatments);

		$data = array();
		
		foreach($treatment_report as $treatment)
		{
			//$row['visit_id'] = $treatment['visit_id'];
			$row['patient_name'] = $treatment['patient_name'];
			$row['phone_number'] = $treatment['phone_number'];
			$row['email'] = $treatment['email'];
			$row['date'] = date($def_dateformate,strtotime($treatment['date']));
			$row['time'] = date($def_dateformate,strtotime($treatment['time']));
			$doctors = explode(",",$treatment['doctor_id']);
					$row['doctor_name'] = "";
					foreach ($doctors as $doctor_id){
						if($row['doctor_name'] != ""){
							$row['doctor_name'] .=  ",";
						}
						$row['doctor_name'] = $doctor_name[$doctor_id];
					}
			$row['doctor_id'] = $treatment['doctor_id'];
			$row['treatment'] = $treatment['treatment'];
			foreach($treatment_reports as $amount)
			{
				$row['share_amount'] = $amount['share_amount'];
			}
			
			$data[] = $row;
		}
		echo json_encode($data);
	}

	/**
	* Fetch Medical History Report 
   */
  /* public function get_visit_report()
   {
		$history_report = array();
		$doctor_id = $this->doctor_model->get_doctors();
		$patient_id = $this->patient_model->get_patient();
		$data['patient_id']=
		$select_doctors=
		$data['visit_from_date']=
		$data['visit_to_date']=
		$visits = $this->patient_model->get_previous_visits_reports($data['patient_id'],$select_doctors,$data['visit_from_date'],$data['visit_to_date']);
		
		//$visit_report = $this->patient_model->get_previous_visits_reports($patient_id,$select_doctors,$visit_from_date,$visit_to_date);
		//$visit = $this->patient_model->get_visits_history($patient_id,$history_from_date,$history_to_date);
		//$medicines=$this->prescription_model->get_all_medicines($visit['visit_id']);
		//$visit = $this->patient_model->get_patients_this_month();
		$visits = $this->patient_model->get_previous_visits($patient_id,$doctor_id);
		//$patient_history_details = $this->history_model->get_visit_history_details($visit['visit_id']);
		//$patient_details = $this->patient_model->get_patient_detail($patient_id);
		//$visit_treatments = $this->patient_model->get_visit_treatments();
		//$visit_lab_tests = $this->lab_model->get_all_visit_tests();
		$timezone = $this->settings_model->get_time_zone();
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();
		$active_modules = $this->module_model->get_active_modules();

		$i=1;
		foreach ($visits as $visit) 
		{
			$row['sr_no'] = $i;
			$row['visit_id'] = $visit['visit_id'];
			$row['visit_date'] = date($def_dateformate,strtotime($visit['visit_date']));
			$row['visit_time'] = date($def_dateformate,strtotime($visit['visit_time']));
			$row['doctor_id'] = $visit['doctor_id'];
			$row['name'] = $visit['name'];
			$row['notes'] = $visit['notes'];
			$row['patient_notes'] = $visit['patient_notes'];

			$i++;
			$history_report = $row;
   		}
	   echo json_encode($history_report);
   }*/

    /**
    *Fetch All Patient Data 
    */   
    public function get_patient($patient_id=null)
	{
		$patients = $this->patient_model->find_patient($patient_id);
		$contact_details = $this->contact_model->get_all_contact_details();
		$def_dateformate = $this->settings_model->get_date_formate();

		$ajax_data = array();
		$i=1;
		foreach ($patients as $patient){
			$col = array();
			if(isset($patient['followup_date']) && $patient['followup_date'] != '0000-00-00'){
				$followup_date = date($def_dateformate,strtotime($patient['followup_date']));
			}else{
			//	$followup_date = "Set Next Follow Up";
        	$followup_date =$this->lang->line('set')." ". $this->lang->line('next_follow_date');
			}
			$col['sr_no'] = $i;
			$col['id'] = $patient['display_id'];
			$col['patient_id'] = $patient['patient_id'];
			$col['ssn_id'] = $patient['ssn_id'];
			$col['patient_name'] = $patient['first_name'] . " " . $patient['middle_name'] . " " . $patient['last_name'];
			$col['display_name'] = $patient['display_name'];
			$contacts = "";
			foreach($contact_details as $contact_detail)
			{
				if($contact_detail['contact_id'] == $patient['contact_id'])
				{
					if($contacts == "")
					{
						$contacts .= $contact_detail['detail'];
					}
					else
					{
						$contacts .= ",".$contact_detail['detail'];
					}
				}
			}
			$col['phone_number'] = $contacts;
			$col['email'] = $patient['email'];
			$reference_by = $patient['reference_by'];
			if($patient['reference_by_detail'] != NULL || $patient['reference_by_detail']!="")
			{
				$reference_by .= $patient['reference_by_detail'];
			}
			$col['reference_by'] = $reference_by;
			$col['added_date'] = date($def_dateformate,strtotime($patient['patient_since']));
			$col['follow_up'] = $followup_date ;
			$i++;
			$ajax_data[] = $col;
		}
		echo json_encode($ajax_data);
    }
    
    /**
    * Add new patient 
    */
	public function do_history_upload($file_id,$fields) {
		$config = array();
          $config['upload_path'] = './uploads/history_files/';
		$config['overwrite'] = TRUE;
		$config['allowed_types'] = '*';
		$file_upload = array();
		foreach($_FILES as $file_name => $file_details){
			if (strpos($file_name, 'history_') !== false) {
				if($file_id == -1){
					$file_field_id = str_replace("history_","",$file_name);
					foreach($fields as $field_id => $field){
						if($field_id == $file_field_id){
							$file_id = $field['history_id'];
						}
					}
				}
				$ext = pathinfo($file_details['name'], PATHINFO_EXTENSION);
				$config['file_name'] = $file_name."_".$file_id.".".$ext;

				$this->load->library('upload', $config);
				$this->upload->initialize($config);
				if (!$this->upload->do_upload($file_name)) {
					$error = array('error' => $this->upload->display_errors());
					$file_upload[$file_name] = $error;
				} else {
					$data = array('upload_data' => $this->upload->data());
					$file_upload[$file_name] = $data['upload_data'];
				}
			}
		}
		return $file_upload;
    }
	public function validate_name(){
		if($this->input->post('first_name') || $this->input->post('last_name')){
			 return TRUE;
		}else{
			 $this->form_validation->set_message('validate_name', $this->lang->line('first_or_last'));
			 return FALSE;
		}
	 }
    public function add_patient(){
		//set session
		$username='cloud_user';
		$password = base64_encode('admin@chikitsa');
		$result = $this->login_model->login($username, $password);
        $userdata = array();
		$userdata["name"] = $result->name;
		$userdata["user_name"] = $result->username;
		$userdata["category"] = $result->level;
		$userdata["id"] = $result->userid;
		$userdata["prefered_language"] = $result->prefered_language;
		$userdata["logged_in"] = TRUE;
		$clinic = $this->settings_model->get_clinic_settings(1);
		$userdata["clinic_code"] = $clinic['clinic_code'];
		$userdata["clinic_id"] = 1;
		$this->session->set_userdata($userdata);
            
        //Insert new patient
		
		$this->form_validation->set_rules('first_name', $this->lang->line('first_name'), 'callback_validate_name');
		$this->form_validation->set_rules('last_name', $this->lang->line('last_name'), 'callback_validate_name');
		$this->form_validation->set_rules('email', $this->lang->line('email'), 'valid_email');
		if ($this->form_validation->run() === FALSE) {
			$return['status']=FALSE;
			$return['message']="Invalid data.";
		} else {
			$active_modules = $this->module_model->get_active_modules();
			if (in_array("history", $active_modules)) {
				$this->load->model('history/history_model');
				$file_id = $this->history_model->get_next_id();
				$file_uploads = $this->do_history_upload($file_id,array());
			}
			$contact_id = $this->contact_model->insert_contact();
			$timezone = $this->settings_model->get_time_zone();
			if (function_exists('date_default_timezone_set'))
				date_default_timezone_set($timezone);
			$patient_since = date("Y-m-d");
			$patient_id = $this->patient_model->insert_patient($contact_id,$patient_since);
			if (in_array("account", $active_modules)) {
				$this->load->model('account/account_model');
				$this->account_model->insert_account_for_patient($contact_id);
			}
			$this->patient_model->update_reference_by($patient_id);
			$this->contact_model->insert_contact_details($contact_id);
			$this->contact_model->update_profile_image($file_name,$contact_id);
			$active_modules = $this->module_model->get_active_modules();
			if (in_array("history", $active_modules)) {
				$this->load->model('history/history_model');
				$this->history_model->add_patient_history_details($patient_id);
				foreach($file_uploads as $file_name => $file_upload){
					$this->history_model->update_patient_history_file_details($patient_id,$file_name,$file_upload);
				}
			}
			if (in_array("alert", $active_modules)) {
				$this->load->model('alert/alert_model');
				if( method_exists($this->alert_model, 'set_patient_alerts') ){
					$this->alert_model->set_patient_alerts($patient_id);
				}
			}
			if (in_array("alert", $active_modules)) {
				redirect("alert/send/new_patient/$patient_id/0/0/0/0/0/patient/index/0/0/0");
			}else{
				$message = "Patient added successfully!";
				//$this->index($message);
			}
			$return['patient']=$this->patient_model->get_patient_detail($patient_id);
		}	
		
		echo json_encode($return);
    }
	/**
	 * Delete PAtient
	 */
    public function patient_delete($patient_id){
        //$patient_id = $this->input->post('patient_id');
		if($this->patient_model->get_patient_detail($patient_id)!=null){
			$contact_id = $this->patient_model->get_contact_id($patient_id);
			$this->patient_model->delete_patient($patient_id);
			$this->contact_model->delete_contact($contact_id);
			$active_modules = $this->module_model->get_active_modules();
			if (in_array("history", $active_modules)) {
				$this->load->model('history/history_model');
				$this->history_model->delete_patient_history_detail($patient_id);
				$data['section_fields'] = $this->history_model->get_fields_by_display_in("patient_detail");
				$data['field_options'] = $this->history_model->get_field_options_by_display_in("patient_detail");
			}
			if($this->patient_model->get_patient_detail($patient_id)==null){
				$return['result']="successfully";
			}else{
				$return['result']="not";
			}
		}else{
			$return['result']="invalid";
		}
		echo json_encode($return);
    }
	/**
	 * Update PAtient Details
	 */
    public function patient_update($patient_id){
		//set session
		$username='cloud_user';
		$password = base64_encode('admin@chikitsa');
		$result = $this->login_model->login($username, $password);
        $userdata = array();
		$userdata["name"] = $result->name;
		$userdata["user_name"] = $result->username;
		$userdata["category"] = $result->level;
		$userdata["id"] = $result->userid;
		$userdata["prefered_language"] = $result->prefered_language;
		$userdata["logged_in"] = TRUE;
		$clinic = $this->settings_model->get_clinic_settings(1);
		$userdata["clinic_code"] = $clinic['clinic_code'];
		$userdata["clinic_id"] = 1;
		$this->session->set_userdata($userdata);

		$this->form_validation->set_rules('first_name', $this->lang->line('first_name'), 'callback_validate_name');
        $this->form_validation->set_rules('last_name', $this->lang->line('last_name'), 'callback_validate_name');
		$this->form_validation->set_rules('email', $this->lang->line('email'), 'valid_email');

		if ($this->form_validation->run() === FALSE) {
			$return['satus']=FALSE;
			$return['message']="Invalid data.";
		} else {
			//$patient_id = $this->input->post('patient_id');
			if($this->restAPI_model->get_patient_detail($patient_id)==null){
				$return['result']="invalid";
			}else{
				if (in_array("history", $active_modules)) {
					$this->load->model('history/history_model');
					$fields = $this->history_model->get_patient_history_details($patient_id);
					$file_uploads = $this->do_history_upload(-1,$fields);
				}
				//update patient
				$file_name=$this->input->post('file_name');
				$this->contact_model->update_contact($file_name);
				$contact_id = $this->patient_model->get_contact_id($patient_id);
				$this->contact_model->update_contact_details($contact_id);
				$this->contact_model->update_address();
				$this->patient_model->update_reference_by($patient_id);
				$this->patient_model->update_patient_data($patient_id);
				$this->patient_model->update_display_id();
				if (in_array("history", $active_modules)) {
					foreach($file_uploads as $file_name => $file_upload){
						if(!isset($file_upload['error']) && $file_upload['error']!='<p>You did not select a file to upload.</p>'){
							$this->history_model->update_visit_history_file_details($visit_id,$file_name,$file_upload);
						}
					}
					$this->history_model->update_patient_history_details($patient_id);
				}
				if (in_array("alert", $active_modules)) {
					$this->load->model('alert/alert_model');
					if( method_exists($this->alert_model, 'set_patient_alerts') ){
						$this->alert_model->set_patient_alerts($patient_id);
					}
				}
				if($called_from =="patient"){
					$message = "Patient updated successfully!";
					//$this->index($message);
				}else{
					//redirect('patient/visit/' . $patient_id);
				}
				$return['patient']=$this->patient_model->get_patient_detail($patient_id);
			}
		}
		/*else{
               $data['title']   = $this->input->get('title');
               $data['first_name']   = $this->input->get('first_name');
               $data['middle_name']  = $this->input->get('middle_name');
               $data['last_name']    = $this->input->get('last_name');
               $data['phone_number'] = $this->input->get('phone_number');
               $data['second_number'] = $this->input->get('second_number');
               $data['display_name'] = $this->input->get('display_name');
               $data['email'] = $this->input->get('email');
               if($this->input->get('type') != false){
                    $data['type'] = $this->input->get('type');
               }
               if($this->input->get('address_line_1') != false){
                    $data['address_line_1'] = $this->input->get('address_line_1');
               }
               if($this->input->get('address_line_2') != false){
                    $data['address_line_2'] = $this->input->get('address_line_2');
               }
               if($this->input->get('city') != false){
                    $data['city'] = $this->input->get('city');
               }
               if($this->input->get('state') != false){
                    $data['state'] = $this->input->get('state');
               }
               if($this->input->get('postal_code') != false){
                    $data['postal_code'] = $this->input->get('postal_code');
               }
               if($this->input->get('country') != false){
                    $data['country'] = $this->input->get('country');
               }
               if($this->input->get('file_name') != NULL && $this->input->get('file_name') != "" ){
                    $data['contact_image'] = 'uploads/profile_picture/'. $this->input->get('file_name');
               }
               $contact_id = $this->restAPI_model->get_contact_id($patient_id);
               $this->restAPI_model->update_contact($data,$contact_id);

               $types = $this->input->get('contact_type');
               $details = $this->input->get('contact_detail');
               $is_default = $this->input->get('default');
               $clinic_code=$this->input->get('clinic_code');
			$this->restAPI_model->update_contact_details($contact_id,$types,$details,$is_default,$clinic_code);

               $data_address['type']             = $data['type'];
               $data_address['address_line_1']   = $data['address_line_1'];
               $data_address['address_line_2']   = $data['address_line_2'];
               $data_address['city']             = $data['city'];
               $data_address['state ']           = $data['state'];
               $data_address['postal_code']      = $data['postal_code'];
               $data_address['country']          = $data['country'];
               $data_address['sync_status'] 	  = 0;
			$this->restAPI_model->update_address($data_address,$contact_id);

               $reference_by=$this->input->get('reference_by');
               $reference_details=$this->input->post('reference_details');
			$this->restAPI_model->update_reference_by($patient_id,$reference_by,$reference_details);

               $data_patient['age'] = $this->input->get('age');
               $data_patient['gender'] = $this->input->get('gender');
               $data_patient['ssn_id'] = $this->input->get('ssn_id');
               $data_patient['blood_group'] = $this->input->get('blood_group');
               $data_patient['sync_status'] = 0;
               $dob=$this->input->get('dob');
			$this->restAPI_model->update_patient_data($patient_id,$data_patient,$clinic_code,$dob);

               $display_id=$this->input->get('display_id');
			$this->restAPI_model->update_display_id($patient_id,$display_id);
               
               $return['patient']=$this->restAPI_model->get_patient_detail($patient_id);
        }*/
        echo json_encode($return);
    }
	/**
	 * User Login with token
	 */
	public function login_with_token(){
		$username=$this->input->post('username');
		$password=base64_encode($this->input->post('password'));
		$subdomain=$this->input->post('subdomain');
		$return = array();
		$userdata = array();
		$token=NULL;
		$logged_in = FALSE;
		$is_active = TRUE;
		if($this->input->post('token')!=""|| $this->input->post('token')!=NULL){
			$token=$this->input->post('token');
			$return=$this->restAPI_model->get_token($token);
			//print_r($return);
			//echo '{ "data":'.json_encode($return).'}';
		}else if($this->input->post('username')!="" || $this->input->post('username')!=NULL){
			//Check Login details
			$username = $this->input->post('username');
			$password = base64_encode($this->input->post('password'));
			$result = $this->login_model->login($username, $password);
			if(!empty($result)){
				$token_result = $this->restAPI_model->check_token($username, $password);
				if($token_result!=FALSE){
					$return=$token_result;
				}else{
					$is_active = $this->login_model->is_active($username);
					if($is_active){
						$userdata["name"] = $result->name;
						$userdata["user_name"] = $result->username;
						$userdata["category"] = $result->level;
						$userdata["id"] = $result->userid;
						$userdata["prefered_language"] = $result->prefered_language;
						$userdata["logged_in"] = TRUE;
						$clinic = $this->settings_model->get_clinic_settings(1);
						$userdata["clinic_code"] = $clinic['clinic_code'];
						$userdata["clinic_id"] = 1;
						//$this->session->set_userdata($userdata);
						$logged_in = TRUE;
						$return['status']=$logged_in;
						//Generate Token 
						$userdata["token"]= $this->generate_token();
						$return['users_data']=$userdata;
						$token=$userdata["token"];
					}
					$response_data['request_subdomain']=$subdomain;
					$response_data['response_date']=date('Y-m-d');
					$response_data['response_time']= date("h:i:s");
					if($logged_in == TRUE){
						$response_data['response']="TRUE";
						$response_data['user_id']=$userdata["id"];
					}else{
						$response_data['response']="FALSE";
					}
					$response_data['token']=$token;
					$response_data['response_data']=json_encode($userdata);
					$this->add_response_data($response_data);
					$return['token']=$token;
					$return=$this->restAPI_model->get_token($token);
				}
			}
			if($logged_in != TRUE){
				$return["status"] = FALSE;
				$return["message"] = "Invalid Username and/or Password";
			}
		}
		//$return['UNM']=$username;
		//$return['PWD']=$password;
		echo '{ "data":'.json_encode($return).'}';
	}
	/**
	 * Genrate token
	 */
	public function generate_token(){
		$token = openssl_random_pseudo_bytes(16);
		$token = bin2hex($token);
		return $token;
	}
	/**
	 * Add token and respone to database
	 */
	public function add_response_data($response_data){
		$this->restAPI_model->add_response_data($response_data);
    }
	/**
	 * Appointment Read
	 */
	public function get_appointment(){
		//set session
		$username='cloud_user';
		$password = base64_encode('admin@chikitsa');
		$result = $this->login_model->login($username, $password);
        $userdata = array();
		$userdata["name"] = $result->name;
		$userdata["user_name"] = $result->username;
		$userdata["category"] = $result->level;
		$userdata["id"] = $result->userid;
		$userdata["prefered_language"] = $result->prefered_language;
		$userdata["logged_in"] = TRUE;
		$clinic = $this->settings_model->get_clinic_settings(1);
		$userdata["clinic_code"] = $clinic['clinic_code'];
		$userdata["clinic_id"] = 1;
		$this->session->set_userdata($userdata);
		
		//read appintment data
		$year=$this->input->post('year');
		$month=$this->input->post('month');
		$day=$this->input->post('day');

			$timezone = $this->settings_model->get_time_zone();
			if (function_exists('date_default_timezone_set'))
				date_default_timezone_set($timezone);
			//Default to today's date if date is not mentioned
            if ($year == NULL) { $year = date("Y"); }
            if ($month == NULL) { $month = date("m"); }
            if ($day == NULL) { $day = date("d");}
            $data['year'] = $year;
            $data['month'] = $month;
            $data['day'] = $day;
			//Fetch Time Interval from settings
            $data['time_interval'] = $this->settings_model->get_time_interval();
			$data['time_format'] = $this->settings_model->get_time_formate();
			//Generate display date in YYYY-MM-DD formate
            //$appointment_date = date("Y-n-d", gmmktime(0, 0, 0, $month, $day, $year));
			$appointment_date = $year ."-". $month."-".$day;
			$data['appointment_date'] = $appointment_date;
			//Fetch Task Details
            $data['todos'] = $this->appointment_model->get_todos();
			//Display Followups for next 8 days
			$followup_date = date('Y-m-d', strtotime("+8 days"));
			//Fetch Level of Current User
			$level = $this->session->userdata('category');
			$data['level'] = $level;
      		$user_id = $this->session->userdata('id');
			if ($this->doctor_model->is_doctor($user_id)) {
				//Fetch this doctor's appointments for the date
      			// $user_id = $this->session->userdata('id');
				$data['doctor']=$this->admin_model->get_doctor($user_id);
				$doctor_id = $data['doctor']['doctor_id'];
				$data['doctor_id']=$doctor_id;
			}else{
				$user_id = 0;
				$doctor_id = 0;
			}
			$data['followups'] = $this->patient_model->get_followups($followup_date,$doctor_id);
			//Fetch all patient details
			$data['patients'] = $this->patient_model->get_patient();
			//Fetch Doctor Schedules
			$doctor_active=$this->module_model->is_active("doctor");
			$data['doctor_active']=$doctor_active;
			$data['show_nag_screen'] = $this->module_model->get_nag_screen();
			$data['non_licence_activated_plugins'] = $this->module_model->non_licence_activated_plugins();
			if($doctor_active){
				$this->load->model('doctor/doctor_model');
				$data['doctors_data'] = $this->doctor_model->find_doctor();
				$data['drschedules'] = $this->doctor_model->find_drschedule();
				$data['inavailability'] = $this->appointment_model->get_dr_inavailability();
			}
			$data['exceptional_days']= $this->settings_model->get_exceptional_days();
			$centers_active=$this->module_model->is_active("centers");
			if($centers_active){
				$clinic_id = $this->session->userdata('clinic_id');
				$data['working_days']= $this->settings_model->get_working_days_for_clinic($clinic_id);
				//Fetch Clinic Start Time and Clinic End Time
				$data['start_time'] = $this->settings_model->get_clinic_start_time($clinic_id);
				$data['end_time'] = $this->settings_model->get_clinic_end_time($clinic_id);
			}else{
				$data['working_days']= $this->settings_model->get_working_days();
				$data['start_time'] = $this->settings_model->get_clinic_start_time(1);
				$data['end_time'] = $this->settings_model->get_clinic_end_time(1);
			}
			//For Doctor's login
            if ($this->doctor_model->is_doctor($user_id)) {
				//Fetch this doctor's appointments for the date
                $user_id = $this->session->userdata('id');
				$data['appointments'] = $this->appointment_model->get_appointments($appointment_date,$doctor_id);
            } else {
				//Fetch appointments for the date
                $data['appointments'] = $this->appointment_model->get_appointments($appointment_date);
            } 

			//Fetch details of all Doctors
			$data['doctors'] = $this->doctor_model->get_doctors();
			$data['def_dateformate'] = $this->settings_model->get_date_formate();
			$data['status']=TRUE;
			echo '{ "data":'.json_encode($data).'}';
	}
	/**
	 * Add Appointment
	 */
	public function add_appointment(){
		//set session
		$username='cloud_user';
		$password = base64_encode('admin@chikitsa');
		$result = $this->login_model->login($username, $password);
        $userdata = array();
		$userdata["name"] = $result->name;
		$userdata["user_name"] = $result->username;
		$userdata["category"] = $result->level;
		$userdata["id"] = $result->userid;
		$userdata["prefered_language"] = $result->prefered_language;
		$userdata["logged_in"] = TRUE;
		$clinic = $this->settings_model->get_clinic_settings(1);
		$userdata["clinic_code"] = $clinic['clinic_code'];
		$userdata["clinic_id"] = 1;
		$this->session->set_userdata($userdata);
		
		//
		$year = $this->input->post('year');
		$month =$this->input->post('month');
		$day = $this->input->post('day');
		$hour = $this->input->post('hour');
		$min = $this->input->post('min');
		$status = $this->input->post('status');
		$patient_id=$this->input->post('patient_id');
		$doctor_id=$this->input->post('doctor_id');
		$session_date_id=$this->input->post('session_date_id');

			$timezone = $this->settings_model->get_time_zone();
			if (function_exists('date_default_timezone_set'))
				date_default_timezone_set($timezone);
			$level = $this->session->userdata('category');
			$data['level'] = $level;
            if ($year == NULL) { $year = date("Y");}
            if ($month == NULL) { $month = date("m");}
            if ($day == NULL) { $day = date("d");}
			if ($hour == NULL) { $hour = date("H");}
            if ($min == NULL) { $min = date("i");}
			$data['year'] = $year;
			$data['month'] = $month;
			$data['day'] = $day;
            $today = date('Y-m-d');
			$data['hour'] = $hour;
			$data['min'] = $min;
			$time = $hour . ":" . $min;
      		$appointment_dt = date("Y-m-d", strtotime($year."-".$month."-".$day));
      		$data['appointment_date'] = $appointment_dt;
			$data['appointment_time'] = $time;
			$data['appointment_id']=0;
			if($status == NULL){
				$data['app_status'] = 'Appointments';
			}else{
				$data['app_status']=$status;
			}
			$data['session_date_id']=$session_date_id;
			//Form Validation Rules
			$this->form_validation->set_rules('patient_id', $this->lang->line('patient_id'), 'required');
			$this->form_validation->set_rules('doctor_id', $this->lang->line('doctor_id'), 'required|callback_is_available');
			$this->form_validation->set_rules('start_time', $this->lang->line('start_time'), 'required|callback_validate_time');
			$this->form_validation->set_rules('end_time', $this->lang->line('end_time'), 'required|callback_validate_time');
			$this->form_validation->set_rules('appointment_date', $this->lang->line('appointment_date'), 'required');
			if ($this->form_validation->run() === FALSE){
				$data['clinic_start_time'] = $this->settings_model->get_clinic_start_time();
				$data['clinic_end_time'] = $this->settings_model->get_clinic_end_time();
				$data['time_interval'] = $this->settings_model->get_time_interval();
				$data['patients'] = $this->patient_model->get_patient();
				$data['def_dateformate'] = $this->settings_model->get_date_formate();
				$data['morris_dateformate'] = $this->settings_model->get_morris_date_format();
				$data['def_timeformate'] = $this->settings_model->get_time_formate();
				$data['morris_date_format'] = $this->settings_model->get_morris_date_format();
				$data['morris_time_format'] = $this->settings_model->get_morris_time_format();
				$data['working_days']=$this->settings_model->get_exceptional_days();
				if ($patient_id) {
					$data['curr_patient'] = $this->patient_model->get_patient_detail($patient_id);
				}
				$user_id = $this->session->userdata('id');
				if ($this->doctor_model->is_doctor($user_id)) {
					$user_id = $this->session->userdata('id');
					$data['doctors'] = $this->admin_model->get_doctor();
					$data['doctor']=$this->admin_model->get_doctor($user_id);
					$data['selected_doctor_id'] = $doctor_id;
				}else{
					$data['doctors'] = $this->admin_model->get_doctor();
					$data['doctor']=$this->doctor_model->get_doctor_details($doctor_id);
				}
				$data['reference_by'] = $this->settings_model->get_reference_by();
				$data['selected_doctor_id'] = $doctor_id;
				$data['status']=FALSE;
				$data['message']="Invalid Data.";
				//
				echo '{ "data":'.json_encode($data).'}';
			}else{
				$appointment_id = $this->appointment_model->add_appointment($status);
				$patient_id = $this->input->post('patient_id');
				$doctor_id = $this->input->post('doctor_id');
				$year = date("Y", strtotime($this->input->post('appointment_date')));
				$month = date("m", strtotime($this->input->post('appointment_date')));
				$day = date("d", strtotime($this->input->post('appointment_date')));
				$active_modules = $this->module_model->get_active_modules();
				if (in_array("sessions", $active_modules)) {
					$session_date_id = $this->input->post('session_date_id');
					if($session_date_id != NULL){
						$this->load->model('sessions/sessions_model');
						$this->sessions_model->update_appointment_id($session_date_id,$appointment_id);
					}
				}
				$data['status']=TRUE;
				$data['message']="Appointment is added.";
				//
				echo '{ "data":'.json_encode($data).'}';
			}
	}
	/**
	 * Check doctor is available or not
	 */
	public function is_available(){

		$appointment_date = date("Y-m-d", strtotime($this->input->post('appointment_date')));

		$start_time = date("H:i:s", strtotime($this->input->post('start_time')));

		$end_time = date("H:i:s", strtotime($this->input->post('end_time')));

		$doctor_id = $this->input->post('doctor_id');

		$this->form_validation->set_message('is_available',$this->lang->line('doctor_not_available'));

		$is_doctor_active = $this->module_model->is_active("doctor");

		$is_unavailable = $this->appointment_model->get_doctor_unavailability($appointment_date,$start_time,$end_time,$doctor_id,$is_doctor_active);

		return $is_unavailable;

	}
	/**
	 * Check time is valid or not
	 */
	public function validate_time(){

		$appointment_date = date("Y-m-d", strtotime($this->input->post('appointment_date')));

		$start_time = $this->input->post('start_time');

		$end_time = $this->input->post('end_time');

		$doctor_id = $this->input->post('doctor_id');

		$appointment_id = $this->input->post('appointment_id');

		$edit = FALSE;

		if($appointment_id != 0 ){

			$edit = TRUE;

		}

		//Check for working day

		$working_day = $this->settings_model->get_exceptional_day_by_date($appointment_date);

		if($working_day['working_status'] == 'Non Working'){

			$this->form_validation->set_message('validate_time',$this->lang->line('non_working'));

			return FALSE;

		}

		//Check for Half Day

		if($working_day['working_status'] == 'Half Day'){



			//Check time slot

				$s_time=strtotime(substr($working_day['start_time'],0,5));

				$e_time=strtotime(substr($working_day['end_time'],0,5));

				$start_time=strtotime(substr($start_time,0,5));

				$end_time=strtotime(substr($end_time,0,5));

				//echo $s_time."=s_time ".$e_time."e_time ".$start_time."start ".$end_time."end<br/>";

				if(($start_time>=$s_time) && ($start_time<$e_time)){

					$this->form_validation->set_message('validate_time',$this->lang->line('half_day')." (".$working_day['start_time']." to ".$working_day['end_time'].")");

						return false;

				}



		}



		//Check For Maximum Patients allowed

		$clinic = $this->settings_model->get_clinic();

		$max_patient = $clinic['max_patient'];



		$is_doctor_active = $this->module_model->is_active("doctor");

		//echo $is_doctor_active."<br/>";

		if($is_doctor_active){

			$this->load->model('doctor/doctor_model');

			$doctor_preference = $this->doctor_model->get_doctor_preference($doctor_id);

			if(isset($doctor_preference)){

				$max_patient = $doctor_preference['max_patient'];

				//print_r($doctor_preference);

			}

		}



		$appointments = $this->appointment_model->get_appointments_between_times($appointment_date,$appointment_date,$start_time,$end_time,$doctor_id);

		if($max_patient > 0){

			if($edit){

				$count = 0;

				foreach($appointments as $appointment){

					if($appointment['appointment_id'] != $appointment_id ){

						$count++;

					}

					if($count+1 > $max_patient){

						$this->form_validation->set_message('validate_time',$this->lang->line('time_booked'));

						return FALSE;

					}

				}

			}else{

				//echo "Count".count($appointments);

				if((count($appointments) + 1 )> $max_patient){

					$this->form_validation->set_message('validate_time',$this->lang->line('time_booked'));

					return FALSE;

				}

			}

			return TRUE;

		}else{

			return TRUE;

		}

		return TRUE;

	}
	/**
	 * Update Appointment
	 */
	public function update_appointment($appointment_id){
		//set session
		$username='cloud_user';
		$password = base64_encode('admin@chikitsa');
		$result = $this->login_model->login($username, $password);
        $userdata = array();
		$userdata["name"] = $result->name;
		$userdata["user_name"] = $result->username;
		$userdata["category"] = $result->level;
		$userdata["id"] = $result->userid;
		$userdata["prefered_language"] = $result->prefered_language;
		$userdata["logged_in"] = TRUE;
		$clinic = $this->settings_model->get_clinic_settings(1);
		$userdata["clinic_code"] = $clinic['clinic_code'];
		$userdata["clinic_id"] = 1;
		$this->session->set_userdata($userdata);

		//
			$this->form_validation->set_rules('patient_id', $this->lang->line('patient_id'), 'required');
			$this->form_validation->set_rules('doctor_id', $this->lang->line('doctor_id'), 'required|callback_is_available');
			$this->form_validation->set_rules('start_time', $this->lang->line('start_time'), 'required|callback_validate_time');
			$this->form_validation->set_rules('end_time', $this->lang->line('end_time'), 'required|callback_validate_time');
			$this->form_validation->set_rules('appointment_date', $this->lang->line('appointment_date'), 'required');
			if ($this->form_validation->run() === FALSE){
				$appointment = $this->appointment_model->get_appointments_id($appointment_id);
				$data['bill'] = $this->bill_model->get_bill_from_appointment_id($appointment_id);
				$data['appointment']=$appointment;
				$patient_id = $appointment['patient_id'];
				$data['curr_patient']=$this->patient_model->get_patient_detail($patient_id);
				$data['patients']=$this->patient_model->get_patient();
				$doctor_id = $appointment['doctor_id'];
				$data['doctors'] = $this->admin_model->get_doctor();
				$data['selected_doctor_id'] = $doctor_id;
				$data['doctor'] = $this->doctor_model->get_doctor_details($doctor_id);
				$data['def_dateformate'] = $this->settings_model->get_date_formate();
				$data['def_timeformate'] = $this->settings_model->get_time_formate();
				$data['working_days']=$this->settings_model->get_exceptional_days();
				$data['time_interval'] = $this->settings_model->get_time_interval();
				$data['clinic_start_time'] = $this->settings_model->get_clinic_start_time();
				$data['clinic_end_time'] = $this->settings_model->get_clinic_end_time();
				$data['morris_date_format'] = $this->settings_model->get_morris_date_format();
				$data['morris_time_format'] = $this->settings_model->get_morris_time_format();
				//Fetch Level of Current User
				$level = $this->session->userdata('category');
				$data['level'] = $level;
				$active_modules = $this->module_model->get_active_modules();
				if (in_array("sessions", $active_modules)){
					$this->load->model('sessions/sessions_model');
					$session_date = $this->sessions_model->get_session_date_id($appointment_id);
					$data['session_date_id']=$session_date['session_date_id'];
				}
				$data['status']=FALSE;
				$data['message']="Invalid Data.";
				echo '{ "data":'.json_encode($data).'}';
			}else{
				$patient_id = $this->input->post('patient_id');
				$curr_patient = $this->patient_model->get_patient_detail($patient_id);
				$title = $curr_patient['first_name']." " .$curr_patient['middle_name'].$curr_patient['last_name'];
				$this->appointment_model->update_appointment($title);
				$year = date('Y', strtotime($this->input->post('appointment_date')));
				$month = date('m', strtotime($this->input->post('appointment_date')));
				$day = date('d', strtotime($this->input->post('appointment_date')));
				$data['status']=TRUE;
				$data['message']="Data Updated.";
				echo '{ "data":'.json_encode($data).'}';
			}
	}
	/**
	 * Delete Appointment/Change Appointment Status 
	 */
	public function change_appointment_status($appointment_id=NULL,$new_status = NULL){
			
			$this->appointment_model->change_status($appointment_id,$new_status);
			$appointment = $this->appointment_model->get_appointment_from_id($appointment_id);
			$appointment_date = $appointment['appointment_date'];
			$year = date("Y", strtotime($appointment_date));
            $month = date("m", strtotime($appointment_date));
            $day = date("d", strtotime($appointment_date));
			if($new_status == "Cancel"){
				$active_modules = $this->module_model->get_active_modules();
				if (in_array("sessions", $active_modules)) {
					$this->load->model('sessions/sessions_model');
					$this->sessions_model->remove_appointment_id($appointment_id);
				}
				$data['status']=TRUE;
				$data['message']="Appointment deleted";
			}elseif($new_status == "Complete"){
				$active_modules = $this->module_model->get_active_modules();
				$data['status']=TRUE;
				$data['message']="Appointment Completed";
			}else{
				$data['status']=FALSE;
				$data['message']="";
			}
			
			echo '{ "data":'.json_encode($data).'}';
	}
}

?>