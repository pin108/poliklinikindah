<?php
/*
	This file is part of Chikitsa.

    Chikitsa is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Chikitsa is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Chikitsa.  If not, see <https://www.gnu.org/licenses/>.
*/
class Bill extends CI_Controller {
    function __construct() {
        parent::__construct();

		$this->config->load('version');
		
		$this->load->model('settings/settings_model');
		$this->load->model('doctor/doctor_model');
		$this->load->model('admin/admin_model');
		$this->load->model('patient/patient_model');
		$this->load->model('contact/contact_model');
		//$this->load->model('package/package_model');
		$this->load->model('module/module_model');
		$this->load->model('payment/payment_model');
		$this->load->model('menu_model');
		$this->load->model('bill_model');

		$this->load->helper('form');
		$this->load->helper('currency_helper');
		//$this->load->helper('mainpage');

        $this->load->library('session');
		$this->load->library('form_validation');
		$this->load->library('export');
		$this->load->helper('header');

		$this->lang->load('main',$this->session->userdata('prefered_language'));
    }
	public function index() {
		// Check If user has logged in or not
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
		 	redirect('login/index');
        }else if (!$this->menu_model->can_access("bill",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		}else{
			$data['tax_type']=$this->settings_model->get_data_value('tax_type');
		  	$data['def_dateformate'] = $this->settings_model->get_date_formate();

			$data['bills'] = $this->bill_model->get_bills();
		    $data['doctors']=$this->doctor_model->get_doctors();
			if($this->input->post('from_date')){
				$data['from_date'] = $this->input->post('from_date');
			}else{
				//$data['from_date'] = date('Y-m-d');
				$data['from_date'] = date('01-m-Y');
			}
			
			if($this->input->post('to_date')){
				$data['to_date'] = $this->input->post('to_date');
			}else{
				$data['to_date'] = date('Y-m-d');
			}
			if($this->input->post('doctor_id')){
				$data['doctor_id'] = $this->input->post('doctor_id');
			}else{
				$data['doctor_id'] = NULL;
			}

			$data['doctors']=$this->doctor_model->get_doctors();
			$user_id = $this->session->userdata('user_id');
			$clinic_id = $this->session->userdata('clinic_id');
			$header_data = get_header_data();

			$this->load->view('templates/header',$header_data);
			$this->load->view('templates/menu');
		 	$this->load->view('browse',$data);
			$this->load->view('templates/footer');
       }
    }
	public function insert($patient_id = NULL, $doctor_id = NULL,$appointment_id = NULL){
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
            redirect('login/index/');
        }else if (!$this->menu_model->can_access("bill",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		} else {
			$timezone = $this->settings_model->get_time_zone();
			if (function_exists('date_default_timezone_set'))
				date_default_timezone_set($timezone);

			$active_modules = $this->module_model->get_active_modules();
			$data['active_modules'] = $active_modules;

			$data['def_dateformate'] = $this->settings_model->get_date_formate();
			$data['def_timeformate'] = $this->settings_model->get_time_formate();
			$data['time_interval'] = $this->settings_model->get_time_interval();

			if (in_array("treatment", $active_modules)) {
				$this->load->model('treatment/treatment_model');
				$data['treatments'] = $this->treatment_model->get_treatments();
			}
			if (in_array("lab", $active_modules)) {
				$this->load->model('lab/lab_model');
				$data['lab_tests'] = $this->lab_model->get_tests();
			}
			$data['clinic_start_time'] = $this->settings_model->get_clinic_start_time();
			$data['clinic_end_time'] = $this->settings_model->get_clinic_end_time();

			$data['patients'] = $this->patient_model->get_patient();
            //$data['package'] = $this->package_model->get_packages();
			$data['edit_bill'] = TRUE;
			$data['patient_id'] = $patient_id;
			$data['patient'] = $this->patient_model->get_patient_detail($patient_id);
			$data['doctor_id'] = $doctor_id;
			$data['appointment_id'] = $appointment_id;
			$data['doctor'] = $this->doctor_model->get_doctor_doctor_id($doctor_id);
			$data['doctors'] = $this->doctor_model->get_doctors();
			$data['fees'] = array();
			if (in_array("doctor", $active_modules)) {
				$data['fees'] = $this->doctor_model->get_doctor_fees();
			}
			if (in_array("stock", $active_modules)) {
				$this->load->model('stock/stock_model');
				$data['items'] = $this->stock_model->get_items();
			}
			$data['bill_id'] = 0;
			$data['discount'] = 0;
			$data['fees_total'] = 0;
			$data['particular_total'] = 0;
			$data['vat_tax_total'] = 0;
			$data['session_total'] = 0;
			$data['treatment_total'] = 0;
			$data['lab_test_total'] = 0;
			$data['item_total'] = 0;
			$data['room_total'] = 0;
			$data['bill_details'] = array();
			$data['tax_type']=$this->settings_model->get_data_value('tax_type');
			$data['tax_rates'] = $this->settings_model->get_tax_rates();
			$data['tax_rate_name'] = $this->settings_model->get_tax_rate_name();
			$data['tax_rate_array'] = $this->settings_model->get_tax_rate_array();

			$user_id  = $this->session->userdata('user_id');
			$clinic_id = $this->session->userdata('clinic_id');
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
			$this->load->view('templates/menu');
			$this->load->view('bill_form', $data);
			$this->load->view('templates/footer');
        }
    }
	public function check_available_stock($required_stock, $item_id) {
		$this->load->model('stock/stock_model');
		$item_detail = $this->stock_model->get_item($item_id);

		$available_quantity = $item_detail['available_quantity'];
		if ($available_quantity < $required_stock) {
			$this->form_validation->set_message('check_available_stock', 'Required Quantity ' . $required_stock . ' exceeds Available Stock (' . $available_quantity . ') for Item ' . $item_detail['item_name']);
			return FALSE;
		} else {
			return TRUE;
		}
	}
	public function delete_bill($bill_id){
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
            redirect('login/index/');
        } else {
			 $this->bill_model->delete_bill($bill_id);
			$this->index();
		}
	}
	public function edit($bill_id){
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
            redirect('login/index/');
        }else if (!$this->menu_model->can_access("bill",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		} else {
			$timezone = $this->settings_model->get_time_zone();
			if (function_exists('date_default_timezone_set'))
				date_default_timezone_set($timezone);

			$active_modules = $this->module_model->get_active_modules();
			$data['active_modules'] = $active_modules;
			$data['tax_type'] = $this->settings_model->get_data_value('tax_type');
			$data['tax_rates'] = $this->settings_model->get_tax_rates();
			$data['called_from'] = "bill_edit_".$bill_id;
			$this->form_validation->set_rules('patient_id', $this->lang->line("patient_id"), 'required');
			$this->form_validation->set_rules('bill_date', $this->lang->line("bill_date"), 'required');
			$this->form_validation->set_rules('bill_time', $this->lang->line("bill_time"), 'required');
			if ($this->form_validation->run() === FALSE) {
			}else{
				$patient_id = $this->input->post('patient_id');
				$doctor_id = $this->input->post('doctor_id');
				if($bill_id == 0){ 
					$bill_id = $this->bill_model->create_bill_for_patient($patient_id,0,$doctor_id);
				}
				$data['patient_id'] = $patient_id;
				$action = $this->input->post('submit');

				if ($action == 'item') {
					$item_id = $this->input->post('item_id');
					$this->form_validation->set_rules('item_name', $this->lang->line("item_name"), 'required');
					$this->form_validation->set_rules('item_amount', $this->lang->line("item_amount"), 'required|numeric');
					$this->form_validation->set_rules('item_quantity', $this->lang->line("item_quantity"), 'required|callback_check_available_stock['.$item_id.']');
					if ($this->form_validation->run() === FALSE) {
					}else {
						$item = $this->input->post('item_name');

						$amount = $this->input->post('item_amount');
						$quantity = $this->input->post('item_quantity');

						$tax_id = $this->input->post('item_tax_id');

						$tax_rate = $this->input->post('item_tax_rate');

						$tax_amount = $tax_rate * $amount / 100;
 
						$this->bill_model->add_bill_item($action, $bill_id, $item, $quantity, $amount*$quantity, $amount,$item_id,$tax_amount,$tax_id);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}elseif ($action == 'lab_test') {
					$this->form_validation->set_rules('lab_test', $this->lang->line('lab_test'), 'required');
					$this->form_validation->set_rules('test_price', $this->lang->line('amount'), 'required|numeric');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$lab_test = $this->input->post('lab_test');
						$lab_test_id = $this->input->post('lab_test_id');
						$test_price = $this->input->post('test_price');

						$tax_rate = $this->input->post('lab_rate');
						$tax_amount = $tax_rate*$test_price/100;
						$tax_id = $this->input->post('lab_rate_name_value');

						$this->bill_model->add_bill_item($action, $bill_id, $lab_test, 1, $test_price,$test_price,NULL,$tax_amount);
            			$this->load->model('lab/lab_model');
            			$this->lab_model->add_test_visit_r($lab_test_id,'pending',NULL,$bill_id);
						$this->bill_model->recalculate_tax($bill_id);
					}

					$data['bill_id'] = $bill_id;

					$data['bill'] = $this->bill_model->get_bill($bill_id);
					$data['bill_details'] = $this->bill_model->get_bill_detail($bill_id);

					$data['balance'] = $this->patient_model->get_balance_amount($bill_id,$patient_id);
				}elseif ($action == 'session') {
					$this->form_validation->set_rules('session_charges', $this->lang->line('charges'), 'required');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$session_charges = $this->input->post('session_charges');

						$this->patient_model->add_bill_item($action, $bill_id, 'Session', 1, $session_charges,$session_charges,NULL,0);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}elseif ($action == 'package') {
					$this->form_validation->set_rules('package', $this->lang->line("package"), 'required');
					$this->form_validation->set_rules('package_price', $this->lang->line("package_price"), 'required|numeric');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$package = $this->input->post('package');
						$package_price = $this->input->post('package_price');
						$this->patient_model->add_bill_item($action, $bill_id, $package, 1, $package_price);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}elseif ($action == 'treatment') {
					$this->form_validation->set_rules('treatment', $this->lang->line("treatment"), 'required');
					$this->form_validation->set_rules('treatment_price', $this->lang->line("treatment_price"), 'required|numeric');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$treatment = $this->input->post('treatment');
						$treatment_price = $this->input->post('treatment_price');
						//$tax_amount = $this->input->post('treatment_rate');

						$tax_rate = $this->input->post('treatment_rate');
						$tax_amount = $tax_rate*$treatment_price/100;
						$tax_id = $this->input->post('treatment_rate_name');

						$this->bill_model->add_bill_item($action, $bill_id, $treatment, 1,$treatment_price,$treatment_price,NULL,$tax_amount);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}elseif ($action == 'fees') {
					$this->form_validation->set_rules('fees_detail','fees detail' , 'required');
					$this->form_validation->set_rules('fees_amount','fees amount', 'required|numeric');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$fees = $this->input->post('fees_detail');
						$fees_amount = $this->input->post('fees_amount');
						$tax_rate = $this->input->post('tax_amount');
						$tax_amount = $tax_rate*$fees_amount/100;
						$tax_id = $this->input->post('tax_id');
						
						$this->bill_model->add_bill_item($action, $bill_id,$fees ,1, $fees_amount,$fees_amount,NULL,$tax_amount,$tax_id);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}elseif ($action == 'particular') {

					$this->form_validation->set_rules('particular', $this->lang->line("particular"), 'required');
					$this->form_validation->set_rules('particular_amount', $this->lang->line("particular_amount"), 'required|numeric');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$particular = $this->input->post('particular');
						$particular_amount = $this->input->post('particular_amount');
						$tax_rate = $this->input->post('tax_amount');
						$tax_amount = $tax_rate*$particular_amount/100;
						$tax_id = $this->input->post('tax_id');
						
						$this->bill_model->add_bill_item($action, $bill_id, $particular, 1, $particular_amount,$particular_amount,NULL,	$tax_amount,$tax_id);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}elseif ($action == 'tax') {
					$bill_amount = $this->bill_model->get_bill_amount($bill_id);
					$discount = $this->patient_model->get_discount_amount($bill_id);
					$taxable_amount = $bill_amount - $discount;

					$this->form_validation->set_rules('bill_tax_rate', $this->lang->line("tax"), 'required');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$tax_id = $this->input->post('bill_tax_rate');
						$tax_rate = $this->settings_model->get_tax_rate($tax_id);
						$tax_rate_percent = $tax_rate['tax_rate'];
						$tax_rate_name = $tax_rate['tax_rate_name']." ( ".$tax_rate_percent."% )";
						$tax_amount = $taxable_amount * $tax_rate_percent /100;

						$this->bill_model->add_bill_item($action, $bill_id, $tax_rate_name, 1, $tax_amount,$tax_amount,NULL,NULL,$tax_id);
						$this->bill_model->recalculate_tax($bill_id);


					
						
					}
				}elseif ($action == 'discount') {
					//echo $bill_id."<br/>";
					$bill_amount = $this->bill_model->get_bill_amount($bill_id);
					//echo $bill_amount."<br/>";
					$discount = $this->bill_model->get_discount_amount($bill_id);
					$bill_amount = $bill_amount + 1;
					$this->form_validation->set_rules('discount', $this->lang->line('discount'), 'required|less_than['.$bill_amount.']|numeric');
					if ($this->form_validation->run() === FALSE) {

					} else {
						$discount_amount = $this->input->post('discount');
						$this->bill_model->update_discount($bill_id,$discount_amount);
						$this->bill_model->recalculate_tax($bill_id);
					}
				}else{

				}

				//get bill payment data
				$payment_bill_data=$this->bill_model->get_bill_payment_data($bill_id);
				$payment_amount=0;
				foreach($payment_bill_data as $payment){
					$payment_amount=$payment_amount+$payment['adjust_amount'];
				}
				//Update Due Amount of Bill 
				//get payment amount 
					$due_amount=$this->bill_model->calculate_bill_due_amount($bill_id,$data['tax_type'],$payment_amount);				
				 
			}
			$data['tax_rate_name'] = $this->settings_model->get_tax_rate_name();
			$data['tax_rate_array'] = $this->settings_model->get_tax_rate_array();
			if (in_array("treatment", $active_modules)) {
				$this->load->model('treatment/treatment_model');
				$data['treatments'] = $this->treatment_model->get_treatments();

			}
			if (in_array("lab", $active_modules)) {
				$this->load->model('lab/lab_model');
				$data['lab_tests'] = $this->lab_model->get_tests();
				$data['lab_test_total'] = $this->bill_model->get_total("lab_test",$bill_id);
			}else{
				$data['lab_test_total'] = 0;
			}
			if (in_array("stock", $active_modules)) {
				$this->load->model('stock/stock_model');
				$data['items'] = $this->stock_model->get_items();
				$data['item_total'] = $this->bill_model->get_item_total($bill_id);

			}else{
				$data['item_total'] = 0;
			}

			//Fetch Patient id from Bill
            $data['clinic_start_time'] = $this->settings_model->get_clinic_start_time();
			$data['clinic_end_time'] = $this->settings_model->get_clinic_end_time();
			$data['def_dateformate'] = $this->settings_model->get_date_formate();
			$data['def_timeformate'] = $this->settings_model->get_time_formate();
			$data['time_interval'] = $this->settings_model->get_time_interval();

			$data['patients'] = $this->patient_model->get_patient();
			$data['doctors'] = $this->doctor_model->get_doctors();
            //$data['package'] = $this->package_model->get_packages();
			$data['bill_id'] = $bill_id;
			$bill = $this->bill_model->get_bill($bill_id);
			if($bill['visit_id']  != NULL){
				$data['visit_id'] = $bill['visit_id'];
			}else{
				$data['visit_id'] = 0;
			}

			$data['bill'] = $this->bill_model->get_bill($bill_id);
			$data['bill_details'] = $this->bill_model->get_bill_detail($bill_id);
			$patient_id = $data['bill']['patient_id'];
			$data['patient_id'] = $patient_id;
			$data['patient'] = $this->patient_model->get_patient_detail($patient_id);
			$data['balance'] = $this->patient_model->get_balance_amount($bill_id);

			$data['vat_tax_total']=0;
			if($data['tax_type']=='bill' ){
				$data['vat_tax_total'] = $this->bill_model->get_vat_tax_total($bill_id);
			}
			$data['particular_total'] = $this->bill_model->get_particular_total($bill_id);
			$data['fees_total'] = $this->bill_model->get_total("fees",$bill_id);
			$data['treatment_total'] = 0;
			if (in_array("treatment", $active_modules)) {
				$data['treatment_total'] = $this->bill_model->get_total("treatment",$bill_id);
			}
			$data['room_total'] = 0;
			if (in_array("rooms", $active_modules)) {
				$data['room_total'] = $this->bill_model->get_total("room",$bill_id);
			}

			$data['package_total'] = 0;
			if (in_array("package", $active_modules)) {
				$data['package_total'] = $this->bill_model->get_package_total($bill_id);
			}

			$data['particular_tax_total'] = $this->bill_model->get_tax_total("particular",$bill_id);
			$data['treatment_tax_total'] = $this->bill_model->get_tax_total("treatment",$bill_id);
			$data['lab_test_tax_total'] = $this->bill_model->get_tax_total("lab",$bill_id);
			$data['session_tax_total'] = $this->bill_model->get_tax_total("session",$bill_id);

			$data['session_total'] = $this->bill_model->get_total("session",$bill_id);
			$data['edit_bill'] = TRUE;

			$data['paid_amount'] = $this->payment_model->get_paid_amount($bill_id);
			$data['discount'] = $this->bill_model->get_discount_amount($bill_id);
			$user_id = $this->session->userdata('user_id');
			$clinic_id = $this->session->userdata('clinic_id');
			$header_data = get_header_data();

			$doctor_id=$data['bill']['doctor_id'];
			$data['doctor']=$this->doctor_model->get_doctor_doctor_id($doctor_id);

			$data['fees'] = array();
			if (in_array("doctor", $active_modules)) {
				$data['fees'] = $this->doctor_model->get_doctor_fees($doctor_id);
			}

			$this->load->view('templates/header',$header_data);
			$this->load->view('templates/menu');
			$this->load->view('bill_form', $data);
			$this->load->view('templates/footer');
		}
	}
	public function delete_bill_detail($bill_detail_id, $bill_id, $patient_id,$called_from) {
        //Check if user has logged in
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
            redirect('login/index/');
        }else if (!$this->menu_model->can_access("bill",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		} else {
            $this->patient_model->delete_bill_detail($bill_detail_id, $bill_id);

			$data['tax_type'] = $this->settings_model->get_data_value('tax_type');
			//get bill payment data
			$payment_bill_data=$this->bill_model->get_bill_payment_data($bill_id);
			$payment_amount=0;
			foreach($payment_bill_data as $payment){
				$payment_amount=$payment_amount+$payment['adjust_amount'];
			}
			//Update Due Amount of Bill 
			//get payment amount 
				$due_amount=$this->bill_model->calculate_bill_due_amount($bill_id,$data['tax_type'],$payment_amount);

			$called_from = str_replace("_","/",$called_from);
            redirect($called_from);
        }
    }
	public function tax_report(){
		//Check if user has logged in
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
            redirect('login/index/');
        }else if (!$this->menu_model->can_access("tax_report",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		} else {
			$data['def_dateformate'] = $this->settings_model->get_date_formate();

			$from_date = date('Y-m-d');
			$to_date = date('Y-m-d');
			if($this->input->post('from_date')){
				$from_date = date('Y-m-d', strtotime($this->input->post('from_date')));
			}
			if($this->input->post('to_date')){
				$to_date = date('Y-m-d', strtotime($this->input->post('to_date')));
			}
			$data['from_date'] = $from_date;
			$data['to_date'] = $to_date;
			$data['bill_details'] = $this->bill_model->get_bill_details();

			$tax_type = $this->settings_model->get_data_value('tax_type');
			$data['tax_type'] = $tax_type;
			$user_id = $this->session->userdata('user_id');
			$clinic_id = $this->session->userdata('clinic_id');
			$header_data = get_header_data();

			if($tax_type == "item"){
				$data['tax_report'] = $this->bill_model->get_tax_report($from_date,$to_date);
			}elseif($tax_type == "bill"){
				$data['tax_report'] = $this->bill_model->get_bill_tax_report($from_date,$to_date);
			}

			if($this->input->post('export_to_excel')!== NULL){
				if($tax_type == "item"){
					$this->tax_report_excel_export($data['tax_report']);
				}else{
					$this->bill_tax_report_excel_export($data['tax_report']);
				}
			}elseif($this->input->post('print_report')!== NULL){
				$this->print_tax_report($data['tax_report']);
			}else{
				$this->load->view('templates/header',$header_data);
				$this->load->view('templates/menu');
				if($tax_type == "item"){
					$this->load->view('tax_report', $data);
				}elseif($tax_type == "bill"){
					$this->load->view('bill_tax_report', $data);
				}
				$this->load->view('templates/footer');
			}
		}
	}
	public function print_tax_report($result){
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
            redirect('login/index');
        }else if (!$this->menu_model->can_access("tax_report",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		} else {
			$data['tax_report'] = $result;
			$data['def_dateformate'] = $this->settings_model->get_date_formate();
			$data['bill_details'] = $this->bill_model->get_bill_details();

			$tax_type = $this->settings_model->get_data_value('tax_type');
			$data['tax_type'] = $tax_type;

			if($tax_type == "item"){
				$this->load->view('bill/print_tax_report', $data);
			}elseif($tax_type == "bill"){
				$this->load->view('bill/print_bill_tax_report', $data);
			}
		}
	}
	public function tax_report_excel_export($result){
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();

		$tax_report = array();
		$i = 0;
		$grand_invoice_total = 0;
		$discount_total = 0;
		$discount_total = 0;
		$tax_revenue_total = 0;
		$grand_total = 0;
		$non_taxable_revenue_total = 0;
		$taxable_revenue_total = 0;
		foreach($result as $row){

			$tax_report[$i]['patient_id'] = $row['display_id'];
			$tax_report[$i]['patient_name'] = $row['first_name']." ".$row['middle_name']." ".$row['last_name'];
			$tax_report[$i]['invoice_id'] = $row['bill_id'];
			$tax_report[$i]['invoice_date'] = date($def_dateformate,strtotime($row['bill_date']));
			$tax_report[$i]['taxable_revenue'] = $row['taxable_amount'];
			$tax_report[$i]['non_taxable_revenue'] = $row['non_taxable_amount'];
			$tax_report[$i]['total'] = $row['taxable_amount'] + $row['non_taxable_amount'];
			$tax_report[$i]['tax_revenue'] = $row['item_tax_amount'];
			$tax_report[$i]['discount'] = $row['discount'];
			$tax_report[$i]['invoice_total'] = $row['total_amount'] + $row['item_tax_amount'];

			$non_taxable_revenue_total = $non_taxable_revenue_total + $tax_report[$i]['non_taxable_revenue'];
			$taxable_revenue_total = $taxable_revenue_total + $tax_report[$i]['taxable_revenue'];
			$grand_total = $grand_total + $tax_report[$i]['total'];
			$grand_invoice_total = $grand_invoice_total + $tax_report[$i]['invoice_total'];
			$discount_total = $discount_total + $tax_report[$i]['discount'];
			$tax_revenue_total = $tax_revenue_total + $tax_report[$i]['tax_revenue'];

			$i++;

		}
		$tax_report[$i]['patient_id'] = "Total";
		$tax_report[$i]['patient_name'] = "";
		$tax_report[$i]['invoice_id'] = "";
		$tax_report[$i]['invoice_date'] = "";
		$tax_report[$i]['taxable_revenue'] = $taxable_revenue_total;
		$tax_report[$i]['non_taxable_revenue'] = $non_taxable_revenue_total;
		$tax_report[$i]['total'] = $grand_total;
		$tax_report[$i]['tax_revenue'] = $tax_revenue_total;
		$tax_report[$i]['discount'] = $discount_total;
		$tax_report[$i]['invoice_total'] = $grand_invoice_total;
		$this->export->to_excel($tax_report, 'tax_report');
	}
	public function bill_tax_report_excel_export($result){
		$def_dateformate = $this->settings_model->get_date_formate();
		$def_timeformate = $this->settings_model->get_time_formate();

		$tax_report = array();
		$i = 0;
		$grand_total = 0;
		$grand_tax = 0;
		foreach($result as $row){
			$tax_report[$i]['patient_id'] = $row['display_id'];
			$tax_report[$i]['patient_name'] = $row['first_name']." ".$row['middle_name']." ".$row['last_name'];
			$tax_report[$i]['invoice_id'] = $row['bill_id'];
			$tax_report[$i]['invoice_date'] = date($def_dateformate,strtotime($row['bill_date']));
			$tax_report[$i]['total_amount'] = $row['total_amount'];
			$tax_report[$i]['tax_amount'] = $row['tax_amount'];
			$tax_report[$i]['invoice_total'] = $row['total_amount'] + $row['tax_amount'];
			$grand_total = $grand_total +  $row['total_amount'];
			$grand_tax = $grand_tax +  $row['tax_amount'];
			$i++;
		}
		$tax_report[$i]['patient_id'] = "Total";
		$tax_report[$i]['patient_name'] = "";
		$tax_report[$i]['invoice_id'] = "";
		$tax_report[$i]['invoice_date'] = "";
		$tax_report[$i]['total_amount'] = $grand_total;
		$tax_report[$i]['tax_amount'] = $grand_tax;
		$tax_report[$i]['invoice_total'] = $grand_total + $grand_tax;
		$this->export->to_excel($tax_report, 'tax_report');
	}
	/*public function print_receipt($bill_id) {
		  //Check if user has logged in
		  if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
           redirect('login/index/');
      } else {
           $def_dateformate = $this->settings_model->get_date_formate();
           $def_timeformate = $this->settings_model->get_time_formate();

           $clinic = $this->settings_model->get_clinic_settings();

           $invoice = $this->settings_model->get_invoice_settings();
           $receipt_template = $this->patient_model->get_template();
           $template = $receipt_template['template'];

           $active_modules = $this->module_model->get_active_modules();
			     $data['active_modules'] = $active_modules;

           $data['particular_total'] = $this->bill_model->get_particular_total($bill_id);
           $data['treatment_total'] = $this->bill_model->get_treatment_total($bill_id);
			     $data['item_total'] = $this->bill_model->get_item_total($bill_id);
           $data['fees_total'] = $this->bill_model->get_fee_total($bill_id);

           $data['paid_amount'] = $this->payment_model->get_paid_amount($bill_id);

			     //Clinic Details
			     $clinic_array = array('clinic_name','tag_line','clinic_address','landline','mobile','email');
			     foreach($clinic_array as $clinic_detail){
				         $template = str_replace("[$clinic_detail]", $clinic[$clinic_detail], $template);
			     }
			     $clinic_logo = "<img src='".base_url()."/".$clinic['clinic_logo']."'/>";
			     $template = str_replace("[clinic_logo]", $clinic_logo, $template);


			     //Bill Details
			     $bill_array = array('bill_date','bill_id','bill_time');
			     $bill = $this->bill_model->get_bill($bill_id);
			     $patient_id = $bill['patient_id'];

			     $doctor_id = $bill['doctor_id'];
			     if($doctor_id == NULL || $doctor_id ==''){
				       $visit_id =  $bill['visit_id'];
				       $visit = $this->patient_model->get_visit_data($visit_id);
				       $doctor_id = $visit['doctor_id'];
			     }
			     $doctor = $this->doctor_model->get_doctor_doctor_id($doctor_id);
			     $doctor_name = $doctor['title']." ".$doctor['first_name']." ".$doctor['middle_name']." ".$doctor['last_name'];
			     $template = str_replace("[doctor_name]", $doctor_name, $template);
			     $template = str_replace("[reference_by]", $doctor_name, $template);

      		 $bill_details = $this->bill_model->get_bill_detail($bill_id);
      		 foreach($bill_array as $bill_detail){
      				if($bill_detail == 'bill_date'){
      					$bill_date = date($def_dateformate, strtotime($bill['bill_date']));
      					$template = str_replace("[bill_date]", $bill_date, $template);
      				}elseif($bill_detail == 'bill_time'){
      					$bill_time = date($def_timeformate, strtotime($bill['bill_time']));
      					$template = str_replace("[bill_time]", $bill_time, $template);
      				}elseif($bill_detail == 'bill_id'){
      					$bill_id = $invoice['static_prefix'] . sprintf("%0" . $invoice['left_pad'] . "d", $bill['bill_id']);
      					$template = str_replace("[bill_id]", $bill_id, $template);
      				}else{
      					$template = str_replace("[$bill_detail]", $bill[$bill_detail], $template);
      				}
      		 }

           //Patient Details
      			$patient = $this->patient_model->get_patient_detail($patient_id);
      			$addresses = $this->contact_model->get_contacts($patient['contact_id']);
      			$patient_array = array('patient_name','age','sex','patient_address');
      			foreach($patient_array as $patient_detail){
      				if($patient_detail == 'patient_name'){
      					$patient_name = $patient['first_name']." ".$patient['middle_name']." ".$patient['last_name'];
      					$template = str_replace("[patient_name]",$patient_name, $template);
      					$template = str_replace("[patient_id]",$patient_id, $template);
      				}elseif($patient_detail == 'patient_address'){
      					$patient_address = "<strong>(".$addresses['type'].")</strong><br/>".$addresses['address_line_1']."<br/>".$addresses['address_line_2']."<br/>".$addresses['area']."<br/>".$addresses['city'] . "," . $addresses['state'] . " " . $addresses['postal_code'] . "<br/>" . $addresses['country'];
      					$template = str_replace("[$patient_detail]", $patient_address, $template);
      				}elseif($patient_detail == 'sex'){
      					$template = str_replace("[$patient_detail]", $patient['gender'], $template);
      				}else{
      					$template = str_replace("[$patient_detail]", $patient[$patient_detail], $template);
      				}
      			}

            //Bill Table
            $tax_type=$this->settings_model->get_data_value('tax_type');
            if($tax_type == "item"){
      				$tax_column_header = "</td><td style='width: 100px; text-align: right; padding: 5px; border: 1px solid black;'><strong>Tax</strong>";
      			}else{
      				$tax_column_header = "";
      			}
            $template = str_replace("[tax_column_header]", $tax_column_header, $template);

            $particular_table = "";
      			$sessions_table = "";
      			$item_table = "";
      			$treatment_table = "";
      			$room_table = "";
      			$fees_table = "";
      			$col_string = "";

            $start_pos = strpos($template, '[col:');
			      if ($start_pos !== false) {
              $end_pos= strpos($template, ']',$start_pos);
              $length = abs($end_pos - $start_pos);
      				$col_string = substr($template, $start_pos, $length+1);
      				$columns = str_replace("[col:", "", $col_string);
      				$columns = str_replace("]", "", $columns);
      				$cols = explode("|",$columns);
            }

            $particular_array = $this->generate_bill_table('particular',$bill_details,$cols,$tax_type);
            $particular_table = $particular_array['bill_table'];
            $particular_amount = $particular_array['total_mrp'];
            $particular_tax_amount = $particular_array['total_tax'];

            $item_array = $this->generate_bill_table('item',$bill_details,$cols,$tax_type);
            $item_table = $item_array['bill_table'];
            $item_amount = $item_array['total_mrp'];
            $item_tax_amount = $item_array['total_tax'];

            $treatment_array = $this->generate_bill_table('treatment',$bill_details,$cols,$tax_type);
            $treatment_table = $treatment_array['bill_table'];
            $treatment_amount = $treatment_array['total_mrp'];
            $treatment_tax_amount = $treatment_array['total_tax'];

            $fees_array = $this->generate_bill_table('fees',$bill_details,$cols,$tax_type);
            $fees_table = $fees_array['bill_table'];
            $fees_amount = $fees_array['total_mrp'];
            $fees_tax_amount = $fees_array['total_mrp'];

            $session_array = $this->generate_bill_table('session',$bill_details,$cols,$tax_type);
            $session_table = $session_array['bill_table'];
            $session_amount = $session_array['total_mrp'];
            $session_tax_amount = $session_array['total_tax'];

            $room_array = $this->generate_bill_table('room',$bill_details,$cols,$tax_type);
            $room_table = $room_array['bill_table'];
            $room_amount = $room_array['total_mrp'];
            $room_tax_amount = $room_array['total_mrp'];

            $table = $particular_table . $item_table . $treatment_table.$fees_table.$sessions_table.$room_table;
			      $template = str_replace("$col_string",$table, $template);

            $discount_amount = $this->bill_model->get_discount_amount($bill['bill_id']);
			      $discount = currency_format($discount_amount);
          	if($tax_type == "item"){
				        $discount = "<td style='text-align: right; padding: 5px; border: 1px solid black;'>"."(".$discount.")"."</td>";
			      }
			      $template = str_replace("[discount]",$discount, $template);

            $tax_amount = 0;
            if($tax_type == "bill"){
    				  $tax_details = "</td>";
    				  foreach($bill_details as $bill_detail){
      					if($bill_detail['type']=='tax'){
      						$tax_details .= "<td colspan='2' style='padding:5px;border:1px solid black;'>".$bill_detail['particular']."</td>";
      						$tax_details .= "<td style='padding:5px;border:1px solid black;text-align:right;'><strong>".currency_format($bill_detail['amount'])."</strong></td>";
      						$tax_amount = $tax_amount + $bill_detail['amount'];
      						$tax_details .= "</tr><tr><td>";
      					}
      				}
      			}else{
      				$tax_details = "</td><td></td><td></td><td>";
      			}
      			$template = str_replace("[tax_details]", $tax_details, $template);

            $total_amount = $particular_amount + $item_amount + $treatment_amount + $fees_amount + $session_amount + $room_amount;
            $total_amount = $total_amount - $discount_amount;
            $total_amount = $total_amount + $particular_tax_amount + $item_tax_amount + $treatment_tax_amount + $fees_tax_amount + $session_tax_amount + $room_tax_amount;

            $total_amount = $total_amount + $tax_amount;
            $total_amount = currency_format($total_amount);
      			if($tax_type == "item"){
      				$total_amount = "</td><td style='text-align: right; padding: 5px; border: 1px solid black;'>".$total_amount;
      			}
            $template = str_replace("[total]",$total_amount, $template);


            $paid_amount = $this->payment_model->get_paid_amount($bill['bill_id']);
   			    $paid_amount = currency_format($paid_amount);
       			if($tax_type == "item"){
				       $paid_amount = "</td><td style='text-align: right; padding: 5px; border: 1px solid black;'>".$paid_amount;
			      }
		 	      $template = str_replace("[paid_amount]",$paid_amount, $template);

            echo $template;
        }
    }
    function generate_bill_table($bill_type,$bill_details,$cols,$tax_type){
      $bill_table = "";
      $total_amount = 0;
      $tax_amount = 0;
      $total_mrp = 0;
      foreach($bill_details as $bill_detail){

        if($bill_detail['type']==$bill_type){
          $bill_table .= "<tr>";
          foreach($cols as $col){

            if($col == 'mrp'){
              $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
							$bill_table .= currency_format($bill_detail[$col])."</td>";
              $total_mrp = $total_mrp + $bill_detail[$col];
            }elseif($col == 'tax_amount'){
              $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
							$bill_table .= currency_format($bill_detail[$col])."</td>";
              $tax_amount = $tax_amount + $bill_detail['tax_amount'];
            }elseif($col == 'amount'){
              $amount = $bill_detail[$col];
              if($tax_type == "item"){
                $amount = $amount + $bill_detail['tax_amount'];
              }
              $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
							$bill_table .= currency_format($amount)."</td>";
              $total_amount = $total_amount + $amount;

            }elseif($col == 'particular'){
              $bill_table .= "<td style='text-align:left;padding:5px;border:1px solid black;'>";
							$bill_table .= $bill_detail[$col]."here</td>";
            }elseif($col == 'quantity'){
              $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
              $bill_table .= $bill_detail[$col]."</td>";
            }else{
              $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
							$bill_table .= $col."</td>";
            }
          }
          $bill_table .= "</tr>";
        }
      }
      if($bill_table != ""){
        $bill_table .= "<tr>";
        foreach($cols as $col){
          if($col == 'mrp'){
            $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'><strong>";
            $bill_table .= currency_format($total_mrp)."</strong></td>";
          }elseif($col == 'tax_amount'){
            $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'><strong>";
            $bill_table .= currency_format($tax_amount)."</strong></td>";
          }elseif($col == 'particular'){
            $bill_table .= "<td style='text-align:left;padding:5px;border:1px solid black;'>";
            $bill_table .= "<strong>Sub Total - ".ucfirst($bill_type)."</strong></td>";
          }elseif($col == 'quantity'){
            $bill_table .= "<td style='text-align:left;padding:5px;border:1px solid black;'></td>";
          }elseif($col == 'amount'){
            $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'><strong>";
            $bill_table .= currency_format($total_amount)."</strong></td>";
          }else{
            $bill_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
            $bill_table .= $col."</td>";
          }
        }
          $bill_table .= "</tr>";
			}

      $bill_array = array('bill_table' => $bill_table,
                          'total_mrp' => $total_mrp,
                          'total_tax' => $tax_amount,
                          'total_amount' => $total_amount);
      return $bill_array;
    }*/

    public function print_receipt($bill_id) {
		//Check if user has logged in
		if (!$this->session->userdata('user_name') || $this->session->userdata('user_name') == '') {
			redirect('login/index/');
		}else if (!$this->menu_model->can_access("bill",$this->session->userdata('category'))){
			$header_data = get_header_data();
			$this->load->view('templates/header',$header_data);
		 	$this->load->view('templates/menu');
			$this->load->view('templates/access_forbidden');
			$this->load->view('templates/footer');
		} else {
			$vat_tax_bill_id=$bill_id;
			$active_modules = $this->module_model->get_active_modules();
			$data['active_modules'] = $active_modules;

			if (in_array("treatment", $active_modules)) {
				$data['treatment_total'] = $this->bill_model->get_treatment_total($bill_id);
			}
			$data['item_total'] = $this->bill_model->get_item_total($bill_id);

			$data['paid_amount'] = $this->payment_model->get_paid_amount($bill_id);
			$data['particular_total'] = $this->bill_model->get_particular_total($bill_id);
			if (in_array("doctor", $active_modules)) {
				$data['fees_total'] = $this->bill_model->get_fee_total($bill_id);
			}
			$currency_postfix = $this->settings_model->get_currency_postfix();

			$def_dateformate = $this->settings_model->get_date_formate();
			$def_timeformate = $this->settings_model->get_time_formate();
			$invoice = $this->settings_model->get_invoice_settings();
			$receipt_template = $this->patient_model->get_template();
			$template = $receipt_template['template'];
			//echo $template;
			$clinic = $this->settings_model->get_clinic_settings();

			//Clinic Details
			$clinic_array = array('clinic_name','tag_line','clinic_address','landline','mobile','email');
			foreach($clinic_array as $clinic_detail){
				$template = str_replace("[$clinic_detail]", $clinic[$clinic_detail], $template);
			}
			$clinic_logo = "<img src='".base_url()."/".$clinic['clinic_logo']."'/>";
			$template = str_replace("[clinic_logo]", $clinic_logo, $template);


			//Bill Details
			$bill_array = array('bill_date','bill_id','bill_time');
			$bill = $this->bill_model->get_bill($bill_id);
			$template = str_replace("[created_by]", $bill['created_by'], $template);
			$patient_id = $bill['patient_id'];

			$doctor_id = $bill['doctor_id'];
			if($doctor_id == NULL || $doctor_id ==''){

				$visit_id =  $bill['visit_id'];
				$visit = $this->patient_model->get_visit_data($visit_id);
				$doctor_id = $visit['doctor_id'];
			}
			$doctor = $this->doctor_model->get_doctor_doctor_id($doctor_id);
			$doctor_name = $doctor['title']." ".$doctor['first_name']." ".$doctor['middle_name']." ".$doctor['last_name'];
			$template = str_replace("[doctor_name]", $doctor_name, $template);
			$template = str_replace("[reference_by]", $doctor_name, $template);

			//Bill Details
			$bill_details = $this->bill_model->get_bill_detail($bill_id);
			foreach($bill_array as $bill_detail){
				if($bill_detail == 'bill_date'){
					$bill_date = date($def_dateformate, strtotime($bill['bill_date']));
					$template = str_replace("[bill_date]", $bill_date, $template);
				}elseif($bill_detail == 'bill_time'){
					$bill_time = date($def_timeformate, strtotime($bill['bill_time']));
					$template = str_replace("[bill_time]", $bill_time, $template);
				}elseif($bill_detail == 'bill_id'){
					$bill_id = $invoice['static_prefix'] . sprintf("%0" . $invoice['left_pad'] . "d", $bill['bill_id']);
					$template = str_replace("[bill_id]", $bill_id, $template);
				}else{
					$template = str_replace("[$bill_detail]", $bill[$bill_detail], $template);
				}
			}
			
			//
			//Tax Details for Bill type
			$tax_amount = 0;
			$data['tax_type']=$this->settings_model->get_data_value('tax_type');

			if($data['tax_type'] == "item"){
				$tax_column='<td style="width: 100px; text-align: right; padding: 5px; border: 1px solid black;"><strong>Tax</strong></td>';
			}else{
				$tax_column="";
			}
			$template = str_replace("[tax_column]", $tax_column, $template);

			if($data['tax_type'] == "bill"){
				$tax_details = "Tax</td>";
				foreach($bill_details as $bill_detail){

					if($bill_detail['type']=='tax'){
						//$tax_details .="<td colspan='2' style='padding:5px;border:1px solid black;'>Tax</td>";
						$tax_details .= "<td colspan='2' style='padding:5px;border:1px solid black;'>".$bill_detail['particular']."</td>";
						$tax_details .= "<td style='padding:5px;border:1px solid black;text-align:right;'><strong>".currency_format($bill_detail['amount'])."</strong></td>";
						$tax_amount = $tax_amount + $bill_detail['amount'];
						$tax_details .= "</tr><tr><td>";
					}
				}

			}else{
				$tax_details = "</td><td></td><td></td><td>";
			}
			$template = str_replace("[tax_details]", $tax_details, $template);
			//Patient Details
			$patient = $this->patient_model->get_patient_detail($patient_id);
			$addresses = $this->contact_model->get_contacts($patient['contact_id']);
			$patient_array = array('patient_name','age','sex','patient_address');
			foreach($patient_array as $patient_detail){
				if($patient_detail == 'patient_name'){
					$patient_name = $patient['first_name']." ".$patient['middle_name']." ".$patient['last_name'];
					$template = str_replace("[patient_name]",$patient_name, $template);
					$template = str_replace("[patient_id]",$patient_id, $template);
				}elseif($patient_detail == 'patient_address'){
					$patient_address = "<strong>(".$addresses['type'].")</strong><br/>".$addresses['address_line_1']."<br/>".$addresses['address_line_2']."<br/>".$addresses['area']."<br/>".$addresses['city'] . "," . $addresses['state'] . " " . $addresses['postal_code'] . "<br/>" . $addresses['country'];
					$template = str_replace("[$patient_detail]", $patient_address, $template);
				}elseif($patient_detail == 'sex'){
					$template = str_replace("[$patient_detail]", $patient['gender'], $template);
				}else{
					$template = str_replace("[$patient_detail]", $patient[$patient_detail], $template);
				}
			}
			$particular_table = "";
			$sessions_table = "";
			$item_table = "";
			$treatment_table = "";
			$room_table = "";
			$fees_table = "";
			$col_string = "";
			$particular_amount = 0;
			$particular_tax_amount = 0;
			$sessions_amount = 0;
			$session_tax_amount = 0;
			$item_amount = 0;
			$treatment_amount = 0;
			$fees_amount = 0;
			$room_amount = 0;
			$vat_tax_table = "";
			$vat_tax_amount = 0;
			//Bill Columns
			$start_pos = strpos($template, '[col:');
			if ($start_pos !== false) {
				$end_pos= strpos($template, ']',$start_pos);
				$length = abs($end_pos - $start_pos);
				$col_string = substr($template, $start_pos, $length+1);
				$columns = str_replace("[col:", "", $col_string);
				$columns = str_replace("]", "", $columns);
				$cols = explode("|",$columns);


				foreach($bill_details as $bill_detail){
					if($bill_detail['type']=='particular'){
						$particular_table .= "<tr>";
						foreach($cols as $col){
							if($col =='mrp' || $col =='amount' ){
								$particular_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
								$particular_table .= currency_format($bill_detail[$col])."</td>";
							}elseif($col=='tax_amount'){
								if($data['tax_type'] == "item"){
									$particular_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
									$particular_table .= currency_format($bill_detail[$col])."</td>";
								}
							}else{
								$particular_table .= "<td style='padding:5px;border:1px solid black;'>";
								$particular_table .= $bill_detail[$col]."</td>";
							}
						}
						$particular_table .= "</tr>";
						$particular_tax_amount=$bill_detail['tax_amount'];
						$particular_amount = $particular_amount + $bill_detail['amount'];
					}elseif($bill_detail['type']=='Vat Tax'){
						$data['vat_tax_total']=0;
						if($data['tax_type']=='bill' ){
							$vat_tax_amount = $this->bill_model->get_vat_tax_total($vat_tax_bill_id);
							$vat_tax_total = currency_format($vat_tax_amount);
							//$vat="<td style='text-align: right; padding: 5px; border: 1px solid black;'>$vat_tax_total</td>";
							$template = str_replace("[vat_tax]",$vat_tax_total, $template);
			
						}
					}elseif($bill_detail['type']=='room'){
						$room_table .= "<tr>";
						foreach($cols as $col){
							if($col =='mrp' || $col =='amount'){
								$room_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
								$room_table .= currency_format($bill_detail[$col])."</td>";
							}elseif($col=='tax_amount'){
								if($data['tax_type'] == "item"){
									$particular_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
									$particular_table .= currency_format($bill_detail[$col])."</td>";
								}
							}else{
								$room_table .= "<td style='padding:5px;border:1px solid black;'>";
								$room_table .= $bill_detail[$col]."</td>";
							}
						}
						$room_table .= "</tr>";
						$room_amount = $room_amount + $bill_detail['amount'];
					}elseif($bill_detail['type']=='item'){
						$item_table .= "<tr>";
						foreach($cols as $col){
							if($col =='mrp' || $col =='amount'){
								$item_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
								$item_table .= currency_format($bill_detail[$col])."</td>";
							}else{
								$item_table .= "<td style='padding:5px;border:1px solid black;'>";
								$item_table .= $bill_detail[$col]."</td>";
							}

						}
						$item_table .= "</tr>";
						$item_amount = $item_amount + $bill_detail['amount'];
					}elseif($bill_detail['type']=='treatment'){
						$treatment_table .= "<tr>";
						foreach($cols as $col){
							if($col =='mrp' || $col =='amount'){
								$treatment_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
								$treatment_table .= currency_format($bill_detail[$col])."</td>";
							}else if($col=='tax_amount'){
								if($data['tax_type'] == "item"){
									$treatment_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
									$treatment_table .= currency_format($bill_detail[$col])."</td>";
								}
							}else{
								$treatment_table .= "<td style='padding:5px;border:1px solid black;'>";
								$treatment_table .= $bill_detail[$col]."</td>";
							}

						}
						$treatment_table .= "</tr>";
						$tax_rate = $bill_detail['tax_amount'];
						$treatment_amount = $treatment_amount + $bill_detail['amount'];
					}elseif($bill_detail['type']=='fees'){
						$fees_table .= "<tr>";
						foreach($cols as $col){
							if($col =='mrp' || $col =='amount'){
								$fees_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
								$fees_table .= currency_format($bill_detail[$col])."</td>";
							}else{
								$fees_table .= "<td style='padding:5px;border:1px solid black;'>";
								$fees_table .= $bill_detail[$col]."</td>";
							}

						}
						$fees_table .= "</tr>";
						$fees_amount = $fees_amount + $bill_detail['amount'];
					}elseif($bill_detail['type']=='session'){
						$sessions_table .= "<tr>";
						foreach($cols as $col){
							if($col =='mrp' || $col =='amount' ){
								$sessions_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
								$sessions_table .= currency_format($bill_detail[$col])."</td>";
							}elseif($col=='tax_amount'){
								if($data['tax_type'] == "item"){
									$sessions_table .= "<td style='text-align:right;padding:5px;border:1px solid black;'>";
									$sessions_table .= currency_format($bill_detail[$col])."</td>";
								}
							}else{
								$sessions_table .= "<td style='padding:5px;border:1px solid black;'>";
								$sessions_table .= $bill_detail[$col]."</td>";
							}

						}
						$sessions_table .= "</tr>";
						$session_tax_amount = $bill_detail['tax_amount'];
						$sessions_amount = $sessions_amount + $bill_detail['amount'];
					}elseif($bill_detail['type']=='tax'){
						//$tax_rate2 = $bill_detail['tax_amount'];
						//$tax_amount = $bill_detail['tax_amount'] + $bill_detail['amount'];
					}
				}
				if($particular_table != ""){
					if($data['tax_type'] == "bill"){
						$particular_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Particular</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($particular_amount)."</strong></td></tr>";
					}else{
						$particular_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Particular</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($particular_amount)."</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($particular_tax_amount)."</strong></td></tr>";
					}
				}
				if($room_table != ""){
					if($data['tax_type'] == "bill"){
						$room_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Rooms</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($room_amount)."</strong></td></tr>";
					}else{
						$room_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Rooms</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($room_amount)."</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($particular_tax_amount)."</strong></td></tr>";
					}
				}
				if($item_table != ""){
					if($data['tax_type'] == "bill"){
						$room_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Items</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($item_amount)."</strong></td></tr>";
					}else{
						$room_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Items</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($item_amount)."</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($particular_tax_amount)."</strong></td></tr>";
					}
				}
				if($treatment_table != ""){
					if($data['tax_type'] == "bill"){
						$treatment_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Treatment</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($treatment_amount)."</strong></td></tr>";
					}else{
						$treatment_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Treatment</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($treatment_amount)."</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($tax_rate)."</strong></td></tr>";
					}
				}
				if($fees_table != ""){
					$fees_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Fees</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($fees_amount)."</strong></td></tr>";
				}
				if($sessions_table != ""){
					if($data['tax_type'] == "bill"){
						$sessions_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Sessions</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($sessions_amount)."</strong></td></tr>";
					}else{
						$sessions_table .= "<tr><td colspan='3' style='padding:5px;border:1px solid black;'><strong>Sub Total - Sessions</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($sessions_amount)."</strong></td><td style='text-align:right;padding:5px;border:1px solid black;'><strong>".currency_format($session_tax_amount)."</strong></td></tr>";
					}
				}
			}
			$table = $particular_table . $item_table . $treatment_table.$fees_table.$sessions_table.$room_table;
			$template = str_replace("$col_string",$table, $template);

			if($data['tax_type'] == "item"){
				$tax_column_header = "</td><td style='width: 100px; text-align: right; padding: 5px; border: 1px solid black;'><strong>Tax</strong>";
			}else{
				$tax_column_header = "";
			}
			$template = str_replace("[tax_column_header]", $tax_column_header, $template);


			$balance = $this->bill_model->get_balance_amount($bill['bill_id']);
			$balance = currency_format($balance);
			$template = str_replace("[previous_due]",$balance, $template);

			$paid_amount = $this->payment_model->get_paid_amount($bill['bill_id']);
			$paid_amount = currency_format($paid_amount);
			if($data['tax_type'] == "item"){
				$paid_amount = "</td><td style='text-align: right; padding: 5px; border: 1px solid black;'>".$paid_amount;
			}
			$template = str_replace("[paid_amount]",$paid_amount, $template);


			$discount_amount = $this->bill_model->get_discount_amount($bill['bill_id']);
			$discount = currency_format($discount_amount);
			if($data['tax_type'] == "item"){
				$discount = "(".$discount.")"."<td style='text-align: right; padding: 5px; border: 1px solid black;'></td>";
			}
			$template = str_replace("[discount]",$discount, $template);

			$total_amount = $vat_tax_amount+$particular_amount + $item_amount + $treatment_amount + $fees_amount +$sessions_amount + $room_amount - $discount_amount + @$tax_rate + $particular_tax_amount + $session_tax_amount;

			$total_amount = $total_amount + $tax_amount;
			$total_amount_value=$total_amount;
			$total_amount = currency_format($total_amount);
			if($data['tax_type'] == "item"){
				$total_amount = "</td><td style='text-align: right; padding: 5px; border: 1px solid black;'>".$total_amount;
			}
			$template = str_replace("[total]",$total_amount, $template);
			

			//Get Payent Methods
				$payments_details =  $this->payment_model->get_payments_detail_from_bill($bill['bill_id']);
				
				$col_string = substr($template, $start_pos, $length+1);
				$columns = str_replace("[paycol:", "", $col_string);
				$columns = str_replace("]", "", $columns);
			
				$columns= 'payment_mode|collected_by|payment_amount';
			
				$pay_cols = explode("|",$columns);
				
				$payment_table="";
				$paid_amount_value=0;
				foreach($payments_details as $paymnet){
					$paid_amount_value=$paid_amount_value+$paymnet['pay_amount'];
					$payment_table .= "<tr>";
							foreach($pay_cols as $col){
								
								if($col=='payment_mode'){
									$payment_table .= "<td colspan='2' style='text-align: left; padding: 5px; border: 1px solid black;'>";
									$payment_table .= $paymnet['pay_mode']."</td>";
							
								}
								if($col=='payment_amount'){
									$payment_table .= "<td style='text-align: right; padding: 5px; border: 1px solid black;'>";
									$payment_table .= currency_format($paymnet['pay_amount']).$currency_postfix."</td>";
								}
								if($col=='collected_by'){
									$payment_table .= "<td style='text-align: left; padding: 5px; border: 1px solid black;'>";
									$payment_table .= $paymnet['collected_by']."</td>";
								}
								
							}
						$payment_table .= "</tr>";
				}
				$template = str_replace("[paycol:payment_mode|collected_by|payment_amount]",$payment_table, $template);

				$due_amount=$total_amount_value -$paid_amount_value;
				$due_amount = currency_format($due_amount).$currency_postfix;
				$template = str_replace("[due_amount]",$due_amount, $template);
				
			$template .="<input type='button' value='Print' id='print_button' onclick='window.print()'>
			<style>
				@media print{
					#print_button{
						display:none;
					}

				}
			</style>";
			echo $template;
		}
	}


}
?>