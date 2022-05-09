ALTER TABLE %dbprefix%bill ADD due_amount decimal(11,2) DEFAULT '0.00';
CREATE TABLE IF NOT EXISTS %dbprefix%todos ( id_num int(11) NOT NULL AUTO_INCREMENT, userid int(11) DEFAULT '0', todo varchar(250) DEFAULT NULL, done int(11) DEFAULT '0', add_date datetime DEFAULT NULL, done_date datetime DEFAULT NULL, PRIMARY KEY (id_num));
CREATE OR REPLACE VIEW %dbprefix%view_patient AS SELECT patient.patient_id,patient.patient_since, patient.display_id, patient.reference_by, patient.followup_date,contacts.display_name,contacts.contact_id,contacts.first_name,contacts.middle_name,contacts.last_name,contacts.phone_number,contacts.email FROM %dbprefix%patient as patient LEFT JOIN %dbprefix%contacts as contacts ON patient.contact_id = contacts.contact_id;
CREATE OR REPLACE VIEW %dbprefix%view_visit_treatments AS SELECT visit.visit_id,bill_detail.particular,bill_detail.type FROM %dbprefix%visit AS visit LEFT JOIN %dbprefix%bill AS bill ON bill.visit_id = visit.visit_id LEFT JOIN %dbprefix%bill_detail AS bill_detail ON bill_detail.bill_id = bill.bill_id;		
UPDATE %dbprefix%version SET current_version='0.0.6';