-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2022 at 07:32 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `poliklinikindah`
--

-- --------------------------------------------------------

--
-- Table structure for table `pid_appointments`
--

CREATE TABLE `pid_appointments` (
  `appointment_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `title` varchar(150) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `visit_id` int(11) NOT NULL DEFAULT 0,
  `appointment_reason` varchar(100) DEFAULT NULL,
  `clinic_id` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_appointment_log`
--

CREATE TABLE `pid_appointment_log` (
  `appointment_log_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `change_date_time` varchar(255) NOT NULL,
  `start_time` time NOT NULL,
  `from_time` time NOT NULL,
  `to_time` time NOT NULL,
  `old_status` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `appointment_reason` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_bill`
--

CREATE TABLE `pid_bill` (
  `bill_id` int(11) NOT NULL,
  `clinic_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `bill_date` date NOT NULL,
  `bill_time` time DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `due_amount` decimal(11,2) NOT NULL DEFAULT 0.00,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `appointment_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_bill_detail`
--

CREATE TABLE `pid_bill_detail` (
  `bill_detail_id` int(11) NOT NULL,
  `clinic_code` varchar(6) DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `bill_id` int(11) NOT NULL,
  `particular` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `mrp` decimal(10,2) DEFAULT NULL,
  `type` varchar(25) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_bill_payment_r`
--

CREATE TABLE `pid_bill_payment_r` (
  `bill_payment_id` int(11) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `adjust_amount` decimal(11,0) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_chikitsa_xml_check`
--

CREATE TABLE `pid_chikitsa_xml_check` (
  `id` int(11) NOT NULL,
  `last_checked_date` date DEFAULT NULL,
  `xml_content` text DEFAULT NULL,
  `module_name` varchar(50) DEFAULT NULL,
  `xml_version` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_chikitsa_xml_check`
--

INSERT INTO `pid_chikitsa_xml_check` (`id`, `last_checked_date`, `xml_content`, `module_name`, `xml_version`) VALUES
(1, '2022-01-31', '{\"last_modified_date\":\"2022-01-31\",\"version\":\"2.0.7\",\"link\":\"https:__sourceforge.net_projects_chikitsa_files_latest_download\"}', 'chikitsa', '2.0.7'),
(2, '2022-02-03', '{\"download_id\":1037,\"module\":\"alert\",\"title\":\"Send Alerts\",\"version\":\"0.2.1\",\"last_updated\":\"2022-02-03\",\"chikitsa_version\":\"2.0.7\",\"usd_price\":10,\"description\":\"Send Email and SMS Alerts to Patient and\\/or Doctors\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/send-alerts\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/transactional-bulk-sms-500x500-475x350-1.png\",\"change_log\":{\"changed\":[\"Send Alert for Item Goes Out OF \\tStock\"]}}', 'alert', '0.2.1'),
(3, '2022-01-29', '{\"download_id\":1047,\"module\":\"doctor\",\"title\":\"Doctors\",\"version\":\"0.2.0\",\"last_updated\":\"2022-01-29\",\"chikitsa_version\":\"2.0.6\",\"usd_price\":14,\"description\":\"Add Departments., Maintain Doctor\'s Profile.Indivdual Fees ,Flexible Schedule and Doctor Inavailability\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/doctor\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/bigstock-Medical-doctors-group-Isolate-27388721-1024x597-1.jpg\",\"change_log\":{\"changed\":[\"Minor Fixes\"]}}', 'doctor', '0.2.0'),
(4, '2021-09-18', '{\"download_id\":1024,\"module\":\"frontend\",\"title\":\"Frontend\",\"version\":\"0.0.4\",\"last_updated\":\"2021-09-18\",\"chikitsa_version\":\"2.0.1\",\"usd_price\":20,\"description\":\"Complete Website with Customizable options. Allow patients to book Appointments and view their records\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/front-end\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/edd\\/2019\\/11\\/shot-20191109-3179-1av046z.jpeg\",\"change_log\":{\"changed\":[\"Complete Frontend Website with customizable sections\",\"Allow Patients to book online appointments\",\"My account Page for your patients to see their visits and bills\"]}}', 'frontend', '0.0.4'),
(5, '2021-11-22', '{\"download_id\":1049,\"module\":\"gallery\",\"title\":\"Gallery\",\"version\":\"0.0.9\",\"last_updated\":\"2021-11-22\",\"chikitsa_version\":\"2.0.4\",\"usd_price\":9.99,\"description\":\"Upload and Maintain pictures of patient progress date wise. Compare before and after pictures of patient.\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/gallery\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/beforeafter-768x683-1.jpg\"}', 'gallery', '0.0.9'),
(6, '2021-08-09', '{\"download_id\":1018,\"module\":\"history\",\"title\":\"Custom Details\",\"version\":\"0.0.8\",\"last_updated\":\"2021-08-09\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":20,\"description\":\"Add Custom Fields for Patient Detail and Visit\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/medical-history\\/\",\"image_link\":\"https:\\/\\/i2.wp.com\\/sanskruti.net\\/chikitsa\\/wp-content\\/uploads\\/edd\\/2018\\/06\\/medical-information.jpg\",\"change_log\":{\"changed\":[\"Minor Fixes\"]}}', 'history', '0.0.8'),
(7, '2021-12-03', '{\"download_id\":1039,\"module\":\"import\",\"title\":\"Import CSV\",\"version\":\"0.0.8\",\"last_updated\":\"2021-12-03\",\"chikitsa_version\":\"2.0.5\",\"usd_price\":10,\"description\":\"Import CSV Data from your old Software\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/import-csv\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/banner-570x350-1.png\"}', 'import', '0.0.8'),
(8, '2021-09-13', '{\"download_id\":1035,\"module\":\"marking\",\"title\":\"Marking\",\"version\":\"0.0.8\",\"last_updated\":\"2021-09-13\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":15,\"description\":\"Very useful extension for Skin Specialists and Dentist.Mark the treatment Areas on Female \\/ Male Face ,Front \\/ Back Body images to keep record\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/marking\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/53eb531a079bb1729bc477f7b098b508c1e99269c74a1-1.jpg\",\"change_log\":{\"changed\":[\"Upload your own images to mark\",\"Department wise image backgrounds (Doctor Extension required)\",\"Add Marking before saving Visit\"]}}', 'marking', '0.0.8'),
(9, '2021-08-18', '{\"download_id\":1029,\"module\":\"menu_access\",\"title\":\"Menu Access\",\"version\":\"0.0.9\",\"last_updated\":\"2021-08-18\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":7,\"description\":\"Give or Revoke access to user categories on Navigation Menu.Create Additional User Categories.\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/menu-access\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/unnamed-1.png\"}', 'menu_access', '0.0.9'),
(10, '2021-08-17', '{\"download_id\":1041,\"module\":\"prescription\",\"title\":\"Prescription\",\"version\":\"0.0.7\",\"last_updated\":\"2021-08-17\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":\"7\",\"description\":\"Maintain and Print Prescription\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/prescription\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/Drugs1-570x350-1.jpg\",\"change_log\":{\"changed\":[\"Minor Changes\"]}}', 'prescription', '0.0.7'),
(11, '2021-09-16', '{\"download_id\":1014,\"module\":\"rooms\",\"title\":\"Rooms and Beds\",\"version\":\"0.0.3\",\"last_updated\":\"2021-09-16\",\"chikitsa_version\":\"2.0.1\",\"usd_price\":\"14\",\"description\":\"Allow Indoor Patients - Create Room Categories, Rooms and Allocate them to Patients\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/rooms-beds\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2019\\/06\\/photo-1519494080410-f9aa76cb4283-1.jpg\"}', 'rooms', '0.0.3'),
(12, '2020-01-03', '{\"download_id\":1027,\"module\":\"stock\",\"title\":\"Medicine Store\",\"version\":\"0.1.7\",\"last_updated\":\"2020-01-03\",\"chikitsa_version\":\"0.8.8\",\"usd_price\":\"14\",\"description\":\"Maintain Medicine Stock and Purchase Register. Sell to Patients in Visit. Separate Sell of Medicine is included too.\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/medicine-store\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/uncategorized-charming-unique-ideas-for-shelving-unique-wall-shelving-units-unique-shelving-units-unique-wall-shelving-units-unique-shelving-material-unique-1-1.jpg\"}', 'stock', '0.1.7'),
(13, '2021-08-20', '{\"download_id\":1020,\"module\":\"sessions\",\"title\":\"Sessions\",\"version\":\"0.0.6\",\"last_updated\":\"2021-08-20\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":\"10\",\"description\":\"Create Sessions of Appointments with different frequencies for your patients. Charge for Sessions. Track progress of Sessions\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/sessions\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2018\\/05\\/woman-on-therapist-couch-1.jpg\",\"change_log\":{\"changed\":[\"Minor Changes\"]}}', 'sessions', '0.0.6'),
(14, '2021-08-06', '{\"download_id\":1031,\"module\":\"template\",\"title\":\"Receipt Template\",\"version\":\"0.1.0\",\"last_updated\":\"2021-08-06\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":\"4.2\",\"description\":\"Option to add and modify the Receipt Template. Requires little HTML knowledge for perfect formatting.\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/receipt-template\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/Medical-Invoice-Template-in-Microsoft-Word-1.png\"}', 'template', '0.1.0'),
(15, '2021-08-14', '{\"download_id\":1033,\"module\":\"treatment\",\"title\":\"Treatment\",\"version\":\"0.1.1\",\"last_updated\":\"2021-08-14\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":\"0\",\"description\":\"Manage Treatment List and their Prices\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/treatment\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2017\\/11\\/Treatment_shutterstock_115857928-1.jpg\"}', 'treatment', '0.1.1'),
(16, '2021-08-25', '{\"download_id\":1016,\"module\":\"lab\",\"title\":\"Lab\",\"version\":\"0.0.5\",\"last_updated\":\"2021-08-25\",\"chikitsa_version\":\"2.0.0\",\"usd_price\":\"7\",\"description\":\"Manage Lab Tests Charges and Reports\",\"download_link\":\"https:\\/\\/chikitsa.net\\/downloads\\/lab\\/\",\"image_link\":\"https:\\/\\/chikitsa.net\\/wp-content\\/uploads\\/2019\\/05\\/lab-1.jpg\",\"change_log\":{\"changed\":[\"Instructions for Technician\",\"Display Doctor Name\"]}}', 'lab', '0.0.5');

-- --------------------------------------------------------

--
-- Table structure for table `pid_clinic`
--

CREATE TABLE `pid_clinic` (
  `clinic_id` int(11) NOT NULL,
  `start_time` varchar(10) NOT NULL,
  `end_time` varchar(10) NOT NULL,
  `time_interval` decimal(11,2) NOT NULL DEFAULT 0.50,
  `clinic_name` varchar(50) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL,
  `tag_line` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `clinic_address` varchar(500) DEFAULT NULL,
  `landline` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `facebook` varchar(50) DEFAULT NULL,
  `twitter` varchar(50) DEFAULT NULL,
  `google_plus` varchar(50) DEFAULT NULL,
  `next_followup_days` int(11) DEFAULT 15,
  `clinic_logo` varchar(255) DEFAULT NULL,
  `website` varchar(50) DEFAULT NULL,
  `max_patient` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `favicon_logo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_clinic`
--

INSERT INTO `pid_clinic` (`clinic_id`, `start_time`, `end_time`, `time_interval`, `clinic_name`, `clinic_code`, `tag_line`, `clinic_address`, `landline`, `mobile`, `email`, `facebook`, `twitter`, `google_plus`, `next_followup_days`, `clinic_logo`, `website`, `max_patient`, `is_deleted`, `sync_status`, `favicon_logo`) VALUES
(1, '09:00:00', '18:00:00', '30.00', 'Poliklinik Indah', '', 'Clinic Management Software', '', '', '', '', NULL, NULL, NULL, 15, NULL, '', 1, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pid_contacts`
--

CREATE TABLE `pid_contacts` (
  `contact_id` int(11) NOT NULL,
  `title` varchar(5) DEFAULT NULL,
  `first_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `middle_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `second_number` varchar(25) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `contact_image` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(50) DEFAULT NULL,
  `address_line_1` varchar(150) DEFAULT NULL,
  `address_line_2` varchar(150) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_contact_details`
--

CREATE TABLE `pid_contact_details` (
  `contact_detail_id` int(11) NOT NULL,
  `clinic_code` varchar(6) DEFAULT NULL,
  `contact_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `detail` varchar(150) NOT NULL,
  `is_default` int(1) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_data`
--

CREATE TABLE `pid_data` (
  `ck_data_id` int(11) NOT NULL,
  `ck_key` varchar(255) NOT NULL,
  `ck_value` text NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_data`
--

INSERT INTO `pid_data` (`ck_data_id`, `ck_key`, `ck_value`, `is_deleted`, `sync_status`) VALUES
(1, 'default_language', 'english', NULL, NULL),
(2, 'default_timezone', 'Asia/Jakarta', NULL, 0),
(3, 'default_timeformate', 'h:i A', NULL, NULL),
(4, 'default_dateformate', 'd-m-Y', NULL, NULL),
(5, 'working_days', '7,1,2,3,4,5,6', NULL, NULL),
(6, 'software_name', 'Chikitsa', NULL, NULL),
(7, 'copyright_text', '&copy; 2020 Sanskruti Technologies', NULL, NULL),
(8, 'copyright_url', 'http://sanskruti.net/ ', NULL, NULL),
(9, 'website_text', 'Chikitsa', NULL, NULL),
(10, 'website_url', 'http://chikitsa.sanskruti.net/ ', NULL, NULL),
(11, 'support_text', 'Support Forum', NULL, NULL),
(12, 'support_url', 'http://sanskruti.net/chikitsa/bug-tracker/', NULL, NULL),
(13, 'login_page', 'appointment/index', NULL, NULL),
(14, 'tax_type', 'bill', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pid_doctor`
--

CREATE TABLE `pid_doctor` (
  `doctor_id` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `contact_id` int(11) NOT NULL,
  `degree` varchar(150) DEFAULT NULL,
  `specification` varchar(300) DEFAULT NULL,
  `experience` varchar(300) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `licence_number` varchar(50) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `userid` varchar(16) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT NULL,
  `erpnext_key` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_followup`
--

CREATE TABLE `pid_followup` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `followup_date` date NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_invoice`
--

CREATE TABLE `pid_invoice` (
  `invoice_id` int(11) NOT NULL,
  `static_prefix` varchar(10) NOT NULL DEFAULT '',
  `left_pad` int(11) NOT NULL,
  `next_id` int(11) NOT NULL,
  `currency_symbol` varchar(10) DEFAULT NULL,
  `currency_postfix` char(10) DEFAULT '/-',
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `number_of_decimal` int(11) NOT NULL DEFAULT 2,
  `decimal_symbol` varchar(20) NOT NULL DEFAULT '.',
  `thousands_separator` varchar(20) NOT NULL DEFAULT ','
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_invoice`
--

INSERT INTO `pid_invoice` (`invoice_id`, `static_prefix`, `left_pad`, `next_id`, `currency_symbol`, `currency_postfix`, `is_deleted`, `sync_status`, `number_of_decimal`, `decimal_symbol`, `thousands_separator`) VALUES
(1, '', 3, 1, 'Rp.', '', NULL, 0, 2, '.', ',');

-- --------------------------------------------------------

--
-- Table structure for table `pid_language_data`
--

CREATE TABLE `pid_language_data` (
  `id` int(11) NOT NULL,
  `l_name` varchar(25) NOT NULL,
  `l_index` varchar(150) NOT NULL,
  `l_value` varchar(700) CHARACTER SET utf8 DEFAULT NULL,
  `file_name` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_language_data`
--

INSERT INTO `pid_language_data` (`id`, `l_name`, `l_index`, `l_value`, `file_name`) VALUES
(1, 'english', 'app_name', 'Poliklinik Indah', 'main_lang.php'),
(2, 'english', 'app_tagline', 'Clinic Management System', 'main_lang.php'),
(3, 'english', 'main_title', 'Chikitsa - Clinic Management System', 'main_lang.php'),
(4, 'english', 'cmp_version', 'ADN Versi 1 ', 'main_lang.php'),
(5, 'english', 'cmp_name', 'ADN Team Technology', 'main_lang.php'),
(6, 'english', 'about_chikitsa', 'Tentang Aplikasi ini ', 'main_lang.php'),
(7, 'english', 'sign_in', 'Sign In', 'main_lang.php'),
(8, 'english', '7min', '7 Menit', 'main_lang.php'),
(9, 'english', '30min', '30 Menit', 'main_lang.php'),
(10, 'english', '15min', '15 Menit', 'main_lang.php'),
(11, 'english', '1hr', '1 Jam', 'main_lang.php'),
(12, 'english', '5min', '5 Menit', 'main_lang.php'),
(13, 'english', 'main_section', 'Main Section', 'main_lang.php'),
(14, 'english', 'second_section', 'Second Section', 'main_lang.php'),
(15, 'english', 'title_color', 'Title Color', 'main_lang.php'),
(16, 'english', 'background_color', 'Warna Latar Belakang', 'main_lang.php'),
(17, 'english', 'text_color', 'Text Color', 'main_lang.php'),
(18, 'english', 'third_section', 'Third Section', 'main_lang.php'),
(19, 'english', 'about', 'Tentang', 'main_lang.php'),
(20, 'english', 'about_settings', 'Tentang Setelan', 'main_lang.php'),
(21, 'english', 'about_page_settings', 'Setelan Halaman ', 'main_lang.php'),
(22, 'english', 'access_on_menu', 'Akses Menu', 'main_lang.php'),
(23, 'english', 'access_code', 'Kode Akses', 'main_lang.php'),
(24, 'english', 'account_group_master', 'Akun Grup Master', 'main_lang.php'),
(25, 'english', 'account_group', 'Akun Grup', 'main_lang.php'),
(26, 'english', 'account_details_meta', 'Detail Akun Meta', 'main_lang.php'),
(27, 'english', 'account_group_name', 'Akun Grup Name', 'main_lang.php'),
(28, 'english', 'account_group_order', 'Akun Grup Order', 'main_lang.php'),
(29, 'english', 'accounts', 'Akun', 'main_lang.php'),
(30, 'english', 'action', 'Tindakan', 'main_lang.php'),
(31, 'english', 'account_groups', 'Akun Grup', 'main_lang.php'),
(32, 'english', 'account', 'Akun', 'main_lang.php'),
(33, 'english', 'actions', 'Tindakan', 'main_lang.php'),
(34, 'english', 'amount', 'Jumlah', 'main_lang.php'),
(35, 'english', 'activate', 'Aktivasi', 'main_lang.php'),
(36, 'english', 'available_quantity', 'Kuantitas yang tersedia', 'main_lang.php'),
(37, 'english', 'add', 'Tambah', 'main_lang.php'),
(38, 'english', 'add_condition', 'Tambahkan Kondisi ', 'main_lang.php'),
(39, 'english', 'additional_css', 'Additional CSS', 'main_lang.php'),
(40, 'english', 'add_another_medicine', 'Tambah Obat Lain', 'main_lang.php'),
(41, 'english', 'add_appointment', 'Tambahkan jadwal janji temu', 'main_lang.php'),
(42, 'english', 'add_slider', 'Tambah Slider', 'main_lang.php'),
(43, 'english', 'add_alerts', 'Tambah Peringatan', 'main_lang.php'),
(44, 'english', 'add_about_page_post', 'Tambah Halaman page post', 'main_lang.php'),
(45, 'english', 'add_footer_section', 'Tambah bagian footer', 'main_lang.php'),
(46, 'english', 'add_top_section', 'Tambah Bagian Atas', 'main_lang.php'),
(47, 'english', 'add_image', 'Tambah Gambar', 'main_lang.php'),
(48, 'english', 'add_category', 'Tambah Kategori', 'main_lang.php'),
(49, 'english', 'add_footer_credit', 'Tambah bagian footer credit', 'main_lang.php'),
(50, 'english', 'add_detail', 'Tambahkan Detail', 'main_lang.php'),
(51, 'english', 'add_department', 'Tambahkan unit/divisi/bidang/seksi', 'main_lang.php'),
(52, 'english', 'add_from_users', 'Tambahkan dari pengguna', 'main_lang.php'),
(53, 'english', 'add_new_user', 'Tambah pengguna baru', 'main_lang.php'),
(54, 'english', 'add_more_contact_number', 'Tambahkan lagi nomor kontak', 'main_lang.php'),
(55, 'english', 'add_news', 'Tambah berita', 'main_lang.php'),
(56, 'english', 'add_test', 'Tambah Tes', 'main_lang.php'),
(57, 'english', 'add_as_medicine', 'Tambah Sebagai Obat', 'main_lang.php'),
(58, 'english', 'add_inquiry', 'Tambahkan Pemeriksaan', 'main_lang.php'),
(59, 'english', 'add_service', 'Tambah Pelayanan', 'main_lang.php'),
(60, 'english', 'add_section', 'Tambah section / bagian', 'main_lang.php'),
(61, 'english', 'add_reference_by', 'Tambah refrensi dari', 'main_lang.php'),
(62, 'english', 'add_refund', 'Tambah Refund / Pengembalian dana', 'main_lang.php'),
(63, 'english', 'add_user', 'Tambah Pengguna', 'main_lang.php'),
(64, 'english', 'add_treatment', 'Tambah Treatment / Pengobatan', 'main_lang.php'),
(65, 'english', 'add_language', 'Tambah bahasa', 'main_lang.php'),
(66, 'english', 'add_fee', 'Tambah Fee (Biaya)', 'main_lang.php'),
(67, 'english', 'add_payment', 'Tambah Pembayaran', 'main_lang.php'),
(68, 'english', 'add_extension', 'Tambah Ektensi', 'main_lang.php'),
(69, 'english', 'add_bottom_section', 'Tambahkan Bagian Bawah', 'main_lang.php'),
(70, 'english', 'add_patient', 'Tambah Pesian', 'main_lang.php'),
(71, 'english', 'add_license_key', 'Tambah lisensi kunci', 'main_lang.php'),
(72, 'english', 'added_date', 'Tambah Tanggal', 'main_lang.php'),
(73, 'english', 'address', 'Alamat', 'main_lang.php'),
(74, 'english', 'addresstype', 'Alamat Tipe', 'main_lang.php'),
(75, 'english', 'address_line_1', 'Alamat Baris 1  ', 'main_lang.php'),
(76, 'english', 'address_line_2', 'Alamat Baris 2  ', 'main_lang.php'),
(77, 'english', 'administration', 'Administrasi', 'main_lang.php'),
(78, 'english', 'administrator', 'Administrator', 'main_lang.php'),
(79, 'english', 'appointment_calendar', 'Kalender Janji Temu', 'main_lang.php'),
(80, 'english', 'adult_teeth', 'Gigi Dewasa ', 'main_lang.php'),
(81, 'english', 'amount_paid', 'Jumlah yang dibayarkan', 'main_lang.php'),
(82, 'english', 'admin_log_in', 'Admin LogIn', 'main_lang.php'),
(83, 'english', 'after', 'Setelah', 'main_lang.php'),
(84, 'english', 'afternoon_time', 'Waktu Sore', 'main_lang.php'),
(85, 'english', 'afternoon', 'Sore', 'main_lang.php'),
(86, 'english', 'age', 'Umur', 'main_lang.php'),
(87, 'english', 'alerts', 'Peringatan', 'main_lang.php'),
(88, 'english', 'alert_settings', 'Peringatan Setelan', 'main_lang.php'),
(89, 'english', 'alert_sms_log', 'Peringatan SMS Log', 'main_lang.php'),
(90, 'english', 'alert_email_log', 'Peringatan Email Log', 'main_lang.php'),
(91, 'english', 'alert_time', 'Peringatan Waktu', 'main_lang.php'),
(92, 'english', 'alert_name', 'Nama Peringatan', 'main_lang.php'),
(93, 'english', 'all', 'Semua', 'main_lang.php'),
(94, 'english', 'allot', 'Membagikan ', 'main_lang.php'),
(95, 'english', 'allow_menu', 'Izinkan Menu', 'main_lang.php'),
(96, 'english', 'allow_center', 'Izinkan Pusat', 'main_lang.php'),
(97, 'english', 'allocate', 'alokasi', 'main_lang.php'),
(98, 'english', 'allow_repeat', 'Izinkan Ulang', 'main_lang.php'),
(99, 'english', 'all_sell', 'Semua Penjualan', 'main_lang.php'),
(100, 'english', 'all_users', 'Semua Pengguna', 'main_lang.php'),
(101, 'english', 'stock_all_sell', 'All Sell', 'main_lang.php'),
(102, 'english', 'all_patients', 'Semua Pasien', 'main_lang.php'),
(103, 'english', 'all_clinic', 'Semua Klinik', 'main_lang.php'),
(104, 'english', 'all_folloups', 'Semua Tindak Lanjut', 'main_lang.php'),
(105, 'english', 'appointment', 'Janji temu', 'main_lang.php'),
(106, 'english', 'appointment_details', 'Detail Janji Temu', 'main_lang.php'),
(107, 'english', 'appointments', 'Janji temu', 'main_lang.php'),
(108, 'english', 'appointment_report', 'Laporan Janji Temu', 'main_lang.php'),
(109, 'english', 'appointment_reason', 'Alasan Janji', 'main_lang.php'),
(110, 'english', 'appointment_date', 'Tanggal Janji', 'main_lang.php'),
(111, 'english', 'appointment_time_interval', 'Interval Waktu Janji', 'main_lang.php'),
(112, 'english', 'availability', 'Ketersediaan ', 'main_lang.php'),
(113, 'english', 'assets', 'Aset', 'main_lang.php'),
(114, 'english', 'available', 'Tersedia', 'main_lang.php'),
(115, 'english', 'available_stock', 'Stok tersedia', 'main_lang.php'),
(116, 'english', 'average_price', 'Harga rata-rata', 'main_lang.php'),
(117, 'english', 'additional_detail_label', 'Tambahan Detail Label ', 'main_lang.php'),
(118, 'english', 'amount_in_account', 'Jumlah Dalam Akun ', 'main_lang.php'),
(119, 'english', 'approve', 'Menyetujui', 'main_lang.php'),
(120, 'english', 'adjust_from_account', 'Sesuaikan Dari Akun', 'main_lang.php'),
(121, 'english', 'additional_detail', 'Tambahan Detail ', 'main_lang.php'),
(122, 'english', 'baby_teeth', 'Gigi Bayi ', 'main_lang.php'),
(123, 'english', 'back', 'Kembali', 'main_lang.php'),
(124, 'english', 'batch', 'Kelompok ', 'main_lang.php'),
(125, 'english', 'backup', 'Cadangkan', 'main_lang.php'),
(126, 'english', 'back_to', 'Kembali ke ', 'main_lang.php'),
(127, 'english', 'backup_restore', 'Cadangkan Dan Restore', 'main_lang.php'),
(128, 'english', 'back_to_app', 'Kembali ke app', 'main_lang.php'),
(129, 'english', 'book_an_appoinment', 'Menjadwalkan pertemuan', 'main_lang.php'),
(130, 'english', 'balance', 'Saldo', 'main_lang.php'),
(131, 'english', 'back_to_visit', 'Kembali ke pengujung ', 'main_lang.php'),
(132, 'english', 'balance_amount', 'Jumlah Saldo', 'main_lang.php'),
(133, 'english', 'bank_payment', 'Pembayaran Bank', 'main_lang.php'),
(134, 'english', 'bank_payments', 'Pembayaran Bank', 'main_lang.php'),
(135, 'english', 'bank_receipt', 'Tanda Terima Bank', 'main_lang.php'),
(136, 'english', 'barcode', 'Barcode', 'main_lang.php'),
(137, 'english', 'bed', 'Kasur', 'main_lang.php'),
(138, 'english', 'bank_receipts', 'Tanda Terima Bank', 'main_lang.php'),
(139, 'english', 'before', 'Sebelum', 'main_lang.php'),
(140, 'english', 'beds', 'Kasur', 'main_lang.php'),
(141, 'english', 'bill', 'Tagihan', 'main_lang.php'),
(142, 'english', 'bill_no', 'Nomor tagihan', 'main_lang.php'),
(143, 'english', 'bills', 'Tagihan ', 'main_lang.php'),
(144, 'english', 'bill_amount', 'Jumlah yang Ditagih', 'main_lang.php'),
(145, 'english', 'bill_details', 'Rincian tagihan', 'main_lang.php'),
(146, 'english', 'bill_id', 'ID tagihan', 'main_lang.php'),
(147, 'english', 'bills_payments', 'Pembayaran Tagihan', 'main_lang.php'),
(148, 'english', 'bill_date', 'Tanggal tagihan', 'main_lang.php'),
(149, 'english', 'bill_number', 'Nomor tagihan', 'main_lang.php'),
(150, 'english', 'bill_type', 'Jenis tagihan', 'main_lang.php'),
(151, 'english', 'back_to_payment', 'Kembali ke Pembayaran ', 'main_lang.php'),
(152, 'english', 'back_to_appointment', 'Kembali ke Janji Temu', 'main_lang.php'),
(153, 'english', 'book', 'Pesan ', 'main_lang.php'),
(154, 'english', 'body', 'Tubuh', 'main_lang.php'),
(155, 'english', 'bought_at', 'Membeli', 'main_lang.php'),
(156, 'english', 'bill_report', 'Laporan Detail Tagihan', 'main_lang.php'),
(157, 'english', 'bought_quantity', 'Jumlah Pembelian', 'main_lang.php'),
(158, 'english', 'bought_avg', 'Rata rata Pembelian', 'main_lang.php'),
(159, 'english', 'browse', 'Jelajahi', 'main_lang.php'),
(160, 'english', 'blood_group', 'Golongan darah', 'main_lang.php'),
(161, 'english', 'book_appoinment', 'Menjadwalkan pertemuan', 'main_lang.php'),
(162, 'english', 'bottom_section_1', 'Bagian Bawah 1', 'main_lang.php'),
(163, 'english', 'bottom_section_3', 'Bagian Bawah 3', 'main_lang.php'),
(164, 'english', 'button', 'Tombol', 'main_lang.php'),
(165, 'english', 'button_text', 'Tombol teks', 'main_lang.php'),
(166, 'english', 'bottom_section_2', 'Bagian Bawah 2', 'main_lang.php'),
(167, 'english', 'button_url', 'Tombol Url', 'main_lang.php'),
(168, 'english', 'bonus_percentage', 'Presentase Bonus', 'main_lang.php'),
(169, 'english', 'bonus', 'Bonus', 'main_lang.php'),
(170, 'english', 'billed', 'Ditagih', 'main_lang.php'),
(171, 'english', 'calendar', 'Kalender Bulanan', 'main_lang.php'),
(172, 'english', 'calendar_hours', 'Kalender Harian', 'main_lang.php'),
(173, 'english', 'cancel', 'batalkan ', 'main_lang.php'),
(174, 'english', 'cash', 'Tunai', 'main_lang.php'),
(175, 'english', 'cancelled', 'Dibatalkan', 'main_lang.php'),
(176, 'english', 'case_number', 'Kasus No. ', 'main_lang.php'),
(177, 'english', 'case', 'kasus', 'main_lang.php'),
(178, 'english', 'cases', 'kasus ', 'main_lang.php'),
(179, 'english', 'cash_receipt', 'Nota Pembayaran Tunai', 'main_lang.php'),
(180, 'english', 'cash_receipts', 'Nota Pembayaran Tunai', 'main_lang.php'),
(181, 'english', 'cash_payment', 'Pembayaran Tunai', 'main_lang.php'),
(182, 'english', 'case_date', 'Tanggal Kasus', 'main_lang.php'),
(183, 'english', 'category', 'Kategori', 'main_lang.php'),
(184, 'english', 'categories', 'Kategori', 'main_lang.php'),
(185, 'english', 'cash_payments', 'Pembayaran Tunai', 'main_lang.php'),
(186, 'english', 'center', 'Center', 'main_lang.php'),
(187, 'english', 'centers', 'Centers', 'main_lang.php'),
(188, 'english', 'center_logo', 'Center Logo', 'main_lang.php'),
(189, 'english', 'center_details', 'Center Details', 'main_lang.php'),
(190, 'english', 'center_name', 'Center Name', 'main_lang.php'),
(191, 'english', 'center_code', 'Center Code', 'main_lang.php'),
(192, 'english', 'change', 'Perubahan ', 'main_lang.php'),
(193, 'english', 'change_center', 'Change Center', 'main_lang.php'),
(194, 'english', 'change_theme_color', 'Theme Settings', 'main_lang.php'),
(195, 'english', 'change_language', 'Ganti Bahasa ', 'main_lang.php'),
(196, 'english', 'change_profile', 'Ganti Profil ', 'main_lang.php'),
(197, 'english', 'change_status_of_field', 'Change status of field', 'main_lang.php'),
(198, 'english', 'change_timezone', 'Change Time Zone', 'main_lang.php'),
(199, 'english', 'change_template', 'Ganti Template ', 'main_lang.php'),
(200, 'english', 'charges', 'Biaya', 'main_lang.php'),
(201, 'english', 'charges_fees', 'Biaya', 'main_lang.php'),
(202, 'english', 'cheque', 'Cek ', 'main_lang.php'),
(203, 'english', 'cheque_number', 'Nomor Cek', 'main_lang.php'),
(204, 'english', 'chikitsa_new_version_available', 'Tersedia. Perbaruhi Sekarang!', 'main_lang.php'),
(205, 'english', 'choose_file', 'Pilih Berkas ', 'main_lang.php'),
(206, 'english', 'city', 'Kota', 'main_lang.php'),
(207, 'english', 'close', 'Tutup', 'main_lang.php'),
(208, 'english', 'clinic', 'Center', 'main_lang.php'),
(209, 'english', 'clear_data', 'Hapus Data', 'main_lang.php'),
(210, 'english', 'clinic_address', 'Alamat Klinik', 'main_lang.php'),
(211, 'english', 'clinic_details', 'Detail Klinik', 'main_lang.php'),
(212, 'english', 'clinic_end_time', 'Waktu Tutup Klinik', 'main_lang.php'),
(213, 'english', 'clinic_landline', 'Telepon Klinik', 'main_lang.php'),
(214, 'english', 'clinic_note', 'Catatan Klinik', 'main_lang.php'),
(215, 'english', 'clinic_logo', 'Logo Klinik', 'main_lang.php'),
(216, 'english', 'clinic_name', 'Nama Klinik', 'main_lang.php'),
(217, 'english', 'clinic_phone_1', 'No Hp Klinik 1', 'main_lang.php'),
(218, 'english', 'clinic_phone_2', 'No Hp Klinik 2', 'main_lang.php'),
(219, 'english', 'clinic_start_time', 'Waktu Buka Klinik', 'main_lang.php'),
(220, 'english', 'clinic_runs_full_day', 'Klinik 24Jam', 'main_lang.php'),
(221, 'english', 'cost', 'Biaya', 'main_lang.php'),
(222, 'english', 'column_1', 'Kolom 1 ', 'main_lang.php'),
(223, 'english', 'column_2', 'Kolom 2', 'main_lang.php'),
(224, 'english', 'complete', 'Lengkap', 'main_lang.php'),
(225, 'english', 'completed_appointment', 'Janji Temu Lengkap', 'main_lang.php'),
(226, 'english', 'completed_sessions', 'Sesi Selesai', 'main_lang.php'),
(227, 'english', 'company', 'Perusahaan', 'main_lang.php'),
(228, 'english', 'company_information', 'Informasi Perusahaan', 'main_lang.php'),
(229, 'english', 'compare', 'Bandingkan', 'main_lang.php'),
(230, 'english', 'content', 'Konten', 'main_lang.php'),
(231, 'english', 'conditions', 'Kondisi', 'main_lang.php'),
(232, 'english', 'country_code', 'Kode Wilayah', 'main_lang.php'),
(233, 'english', 'contact', 'Kontak', 'main_lang.php'),
(234, 'english', 'contact_details', 'Kontak Detail', 'main_lang.php'),
(235, 'english', 'continue', 'Lanjut', 'main_lang.php'),
(236, 'english', 'copyright', '© 2022', 'main_lang.php'),
(237, 'english', 'copyright_text', 'Copyright Text', 'main_lang.php'),
(238, 'english', 'consultation_in', 'Konsultasi Masuk', 'main_lang.php'),
(239, 'english', 'confirm_password', 'Konfirmasi Password', 'main_lang.php'),
(240, 'english', 'consultation', 'Konsultasi', 'main_lang.php'),
(241, 'english', 'copyright_url', 'Copyright URL', 'main_lang.php'),
(242, 'english', 'consultation_out', 'Konsultasi Keluar', 'main_lang.php'),
(243, 'english', 'contact_number', 'Nomor Kontak', 'main_lang.php'),
(244, 'english', 'cost_price', 'Harga Biaya', 'main_lang.php'),
(245, 'english', 'country', 'Wilayah', 'main_lang.php'),
(246, 'english', 'curr_pre', 'Currency Prefix', 'main_lang.php'),
(247, 'english', 'curr_post', 'Currency Postfix', 'main_lang.php'),
(248, 'english', 'cr_ac_name', 'Cr. A/c Name', 'main_lang.php'),
(249, 'english', 'created_by', 'Dibuat Oleh', 'main_lang.php'),
(250, 'english', 'column_1_header', 'Header Kolom 1 ', 'main_lang.php'),
(251, 'english', 'custom_details', 'Custom Details', 'main_lang.php'),
(252, 'english', 'currency', 'Currency', 'main_lang.php'),
(253, 'english', 'column_1_content', 'Konten Kolom 1', 'main_lang.php'),
(254, 'english', 'ccavenue', 'CCAvenue  ', 'main_lang.php'),
(255, 'english', 'contact_us', 'Kontak Kami', 'main_lang.php'),
(256, 'english', 'copy', 'Salin', 'main_lang.php'),
(257, 'english', 'change_language_file', 'Ganti Bahasa Berkas ', 'main_lang.php'),
(258, 'english', 'ccavenue_settings', 'CCAvenue Settings', 'main_lang.php'),
(259, 'english', 'create_language_file', 'Buat Bahasa Baru', 'main_lang.php'),
(260, 'english', 'cancelled_appoinment_by_patient', 'In case of appointment cancellation by Patient, refund will have to be done manually ', 'main_lang.php'),
(261, 'english', 'compare_image', 'Minimum two images required for comparision', 'main_lang.php'),
(262, 'english', 'dr_ac_name', 'dr. A/c Name ', 'main_lang.php'),
(263, 'english', 'day', 'Hari', 'main_lang.php'),
(264, 'english', 'daily', 'Harian ', 'main_lang.php'),
(265, 'english', 'does_not_have_value', 'Does not have value', 'main_lang.php'),
(266, 'english', 'days', 'Hari', 'main_lang.php'),
(267, 'english', 'dose', 'Dosis', 'main_lang.php'),
(268, 'english', 'daily_hour', 'Harian/ Per Jam', 'main_lang.php'),
(269, 'english', 'daily_per_bed_charge', 'Biaya Per Tempat Tidur ( Hari )  ', 'main_lang.php'),
(270, 'english', 'date', 'Tanggal', 'main_lang.php'),
(271, 'english', 'dashboard', 'Dasbor', 'main_lang.php'),
(272, 'english', 'date_format', 'Format Tanggal', 'main_lang.php'),
(273, 'english', 'deallocate', 'Membatalkan Alokasi', 'main_lang.php'),
(274, 'english', 'degrees', 'Derajat', 'main_lang.php'),
(275, 'english', 'deactivate', 'Menonaktifkan ', 'main_lang.php'),
(276, 'english', 'delete', 'Hapus', 'main_lang.php'),
(277, 'english', 'delete_item', 'Hapus item', 'main_lang.php'),
(278, 'english', 'delete_supplier', 'Hapus Supplier', 'main_lang.php'),
(279, 'english', 'delete_treatment', 'Hapus Treatmeent ', 'main_lang.php'),
(280, 'english', 'delete_user', 'Delete User ', 'main_lang.php'),
(281, 'english', 'department', 'Departemen  ', 'main_lang.php'),
(282, 'english', 'departments', 'Departemen', 'main_lang.php'),
(283, 'english', 'department_name', 'Nama Departemen ', 'main_lang.php'),
(284, 'english', 'desired_stock', 'Stok yang diinginkan', 'main_lang.php'),
(285, 'english', 'detail', 'Rincian', 'main_lang.php'),
(286, 'english', 'details', 'Rincian', 'main_lang.php'),
(287, 'english', 'default', 'Default', 'main_lang.php'),
(288, 'english', 'due_amount', 'Jumlah Jatuh Tempo', 'main_lang.php'),
(289, 'english', 'discount', 'Diskon ', 'main_lang.php'),
(290, 'english', 'display', 'Tampilan', 'main_lang.php'),
(291, 'english', 'dismiss', 'Menolak', 'main_lang.php'),
(292, 'english', 'dismissed', 'Ditolak', 'main_lang.php'),
(293, 'english', 'display_google_ads', 'Display Google Ads', 'main_lang.php'),
(294, 'english', 'display_in', 'Tampilan Masuk ', 'main_lang.php'),
(295, 'english', 'display_name', 'Nama Tampilan ', 'main_lang.php'),
(296, 'english', 'discount_amount', 'Jumlah Diskon', 'main_lang.php'),
(297, 'english', 'discount_percentage', 'Diskon Presentase ', 'main_lang.php'),
(298, 'english', 'dob', 'Tanggal Kelahiran', 'main_lang.php'),
(299, 'english', 'doctors', 'Dokter', 'main_lang.php'),
(300, 'english', 'doctor_share', 'Doctor Share', 'main_lang.php'),
(301, 'english', 'doctor_name', 'Nama Dokter', 'main_lang.php'),
(302, 'english', 'doctor', 'Dokter', 'main_lang.php'),
(303, 'english', 'doctor_availability', 'Dokter Yang Bertugas', 'main_lang.php'),
(304, 'english', 'doctor_detail', 'Detail Dokter', 'main_lang.php'),
(305, 'english', 'doctor_bonus_report', 'Laporan Bonus Dokter', 'main_lang.php'),
(306, 'english', 'doctor_inavailability', 'Dokter tidak tersedia', 'main_lang.php'),
(307, 'english', 'doctor_unavailability', 'Ketidakhadiran Dokter', 'main_lang.php'),
(308, 'english', 'doctor_schedule', 'Jadwal Dokter', 'main_lang.php'),
(309, 'english', 'download', 'Unduh ', 'main_lang.php'),
(310, 'english', 'download_extension', 'Unduh Ekstensi ', 'main_lang.php'),
(311, 'english', 'downloading_files', 'Unduh Berkas ', 'main_lang.php'),
(312, 'english', 'doctor_preferences', 'Refrensi Dokter', 'main_lang.php'),
(313, 'english', 'duration', 'Durasi ', 'main_lang.php'),
(314, 'english', 'dr', 'dr. ', 'main_lang.php'),
(315, 'english', 'description', 'Deskripsi', 'main_lang.php'),
(316, 'english', 'duplicate', 'Duplikat ', 'main_lang.php'),
(317, 'english', 'disease', 'Penyakit', 'main_lang.php'),
(318, 'english', 'diagnosed_diseases', 'Penyakit yang Didiagnosis', 'main_lang.php'),
(319, 'english', 'diseases', 'Penyakit', 'main_lang.php'),
(320, 'english', 'eraser', 'Eraser', 'main_lang.php'),
(321, 'english', 'decimal_symbol', 'Simbol Desimal', 'main_lang.php'),
(322, 'english', 'erpnext_sync', 'Erpnext Sync', 'main_lang.php'),
(323, 'english', 'erpnext_url', 'Erpnext URL', 'main_lang.php'),
(324, 'english', 'enable_about_page', 'Enable About Page', 'main_lang.php'),
(325, 'english', 'end_date', 'End Date / Tanggal Akhir', 'main_lang.php'),
(326, 'english', 'edit', 'Edit', 'main_lang.php'),
(327, 'english', 'end_time', 'End Time /Jam Akhir', 'main_lang.php'),
(328, 'english', 'edit_Contact', 'Edit Kontak', 'main_lang.php'),
(329, 'english', 'edit_section', 'Edit Section', 'main_lang.php'),
(330, 'english', 'edit_treatment', 'Edit Pengobatan', 'main_lang.php'),
(331, 'english', 'edit_medicine_too', 'Edit Obat', 'main_lang.php'),
(332, 'english', 'edit_user', 'Edit User', 'main_lang.php'),
(333, 'english', 'email', 'Email', 'main_lang.php'),
(334, 'english', 'edit_test', 'Edit Tes', 'main_lang.php'),
(335, 'english', 'email_alert_name', 'Email Peringatan Nama', 'main_lang.php'),
(336, 'english', 'email_log', 'Email Catatan', 'main_lang.php'),
(337, 'english', 'email_id', 'Email ID', 'main_lang.php'),
(338, 'english', 'email_bill', 'Email Tagihan', 'main_lang.php'),
(339, 'english', 'email_settings', 'Setting Email', 'main_lang.php'),
(340, 'english', 'established_patient', 'Established Patient', 'main_lang.php'),
(341, 'english', 'enter_details_to_login', 'Enter Details To Login ', 'main_lang.php'),
(342, 'english', 'enter_email_address', 'Enter Email Address ', 'main_lang.php'),
(343, 'english', 'extracting', 'Extracting', 'main_lang.php'),
(344, 'english', 'extraction_failed', 'Extraction Failed', 'main_lang.php'),
(345, 'english', 'extensions', 'Extensions', 'main_lang.php'),
(346, 'english', 'expenditure', 'Expenditure', 'main_lang.php'),
(347, 'english', 'experience', 'Experience', 'main_lang.php'),
(348, 'english', 'exceptional_days', 'Exceptional Days', 'main_lang.php'),
(349, 'english', 'export_to_excel', 'Export to Excel', 'main_lang.php'),
(350, 'english', 'expiry_date', 'Expiry Date', 'main_lang.php'),
(351, 'english', 'enter_new_password', 'Enter your new password below', 'main_lang.php'),
(352, 'english', 'enable_news', 'Enable Halaman Berita', 'main_lang.php'),
(353, 'english', 'enable_online_appointment', 'Enable Janji Ketemuan', 'main_lang.php'),
(354, 'english', 'enable_ccavenue', 'Enable CCAvenue', 'main_lang.php'),
(355, 'english', 'enable_paypal', 'Enable PayPal', 'main_lang.php'),
(356, 'english', 'enable_admin_approval', 'Enable Admin Approval', 'main_lang.php'),
(357, 'english', 'enable_sandbox', 'Enable Sandbox', 'main_lang.php'),
(358, 'english', 'enable_service_page', 'Enable Halaman Servis', 'main_lang.php'),
(359, 'english', 'email_alert_time', 'Email Peringatan Waktu', 'main_lang.php'),
(360, 'english', 'edit_format', 'Edit Format', 'main_lang.php'),
(361, 'english', 'email_format', 'Email Format', 'main_lang.php'),
(362, 'english', 'edit_language', 'Edit Bahasa', 'main_lang.php'),
(363, 'english', 'face', 'Face', 'main_lang.php'),
(364, 'english', 'facebook_link', 'Facebook Link', 'main_lang.php'),
(365, 'english', 'facebook', 'Facebook', 'main_lang.php'),
(366, 'english', 'fax', 'Fax', 'main_lang.php'),
(367, 'english', 'fees', 'Biaya Fee', 'main_lang.php'),
(368, 'english', 'fees_detail', 'Detail Biaya Fee', 'main_lang.php'),
(369, 'english', 'female', 'Perempuan', 'main_lang.php'),
(370, 'english', 'file', 'File', 'main_lang.php'),
(371, 'english', 'file_content', 'File Content', 'main_lang.php'),
(372, 'english', 'filter', 'Filter', 'main_lang.php'),
(373, 'english', 'first', 'First', 'main_lang.php'),
(374, 'english', 'first_name', 'Nama Depan', 'main_lang.php'),
(375, 'english', 'fields', 'Fields', 'main_lang.php'),
(376, 'english', 'field_label', 'Tempat Label', 'main_lang.php'),
(377, 'english', 'find_us_here', 'Find Us Here', 'main_lang.php'),
(378, 'english', 'field_options', 'Field Option', 'main_lang.php'),
(379, 'english', 'field_order', 'Field Order', 'main_lang.php'),
(380, 'english', 'field_name', 'Tempat Nama', 'main_lang.php'),
(381, 'english', 'field_type', 'Field Type', 'main_lang.php'),
(382, 'english', 'field_width', 'Field Width', 'main_lang.php'),
(383, 'english', 'field_status', 'Field Status', 'main_lang.php'),
(384, 'english', 'foc', 'F.O.C.', 'main_lang.php'),
(385, 'english', 'follow', 'Follow', 'main_lang.php'),
(386, 'english', 'follow_on', 'Follow On', 'main_lang.php'),
(387, 'english', 'follow_up', 'Follow Up', 'main_lang.php'),
(388, 'english', 'follow_ups', 'Follow Ups', 'main_lang.php'),
(389, 'english', 'footer_credits', 'Footer Credits', 'main_lang.php'),
(390, 'english', 'footer_settings', 'Footer Settings', 'main_lang.php'),
(391, 'english', 'footer_credit_settings', 'Footer Credit Settings', 'main_lang.php'),
(392, 'english', 'for', 'For', 'main_lang.php'),
(393, 'english', 'forgot_password', 'Forgot Password?', 'main_lang.php'),
(394, 'english', 'form', 'Form', 'main_lang.php'),
(395, 'english', 'found', 'Found', 'main_lang.php'),
(396, 'english', 'frequency', 'Frequency', 'main_lang.php'),
(397, 'english', 'from_date', 'From Date', 'main_lang.php'),
(398, 'english', 'from_time', 'From Time', 'main_lang.php'),
(399, 'english', 'from_name', 'From Name', 'main_lang.php'),
(400, 'english', 'to_time', 'To Time', 'main_lang.php'),
(401, 'english', 'from_doctor', 'From Doctor', 'main_lang.php'),
(402, 'english', 'frontend', 'Frontend', 'main_lang.php'),
(403, 'english', 'framework', 'Framework', 'main_lang.php'),
(404, 'english', 'full_day', 'Full Day', 'main_lang.php'),
(405, 'english', 'fixed_amount', 'Fixed Amount', 'main_lang.php'),
(406, 'english', 'from_email', 'From Email', 'main_lang.php'),
(407, 'english', 'featured', 'Featured', 'main_lang.php'),
(408, 'english', 'featured_image', 'Featured Image', 'main_lang.php'),
(409, 'english', 'footer_section_1', 'Footer Section 1', 'main_lang.php'),
(410, 'english', 'footer_section_2', 'Footer Section 2', 'main_lang.php'),
(411, 'english', 'footer_section_3', 'Footer Section 3', 'main_lang.php'),
(412, 'english', 'gender', 'Gender', 'main_lang.php'),
(413, 'english', 'footer_section_4', 'Footer Section 4', 'main_lang.php'),
(414, 'english', 'file_size', 'Allow Maximum File size (in KB)', 'main_lang.php'),
(415, 'english', 'file_type', 'Allowed File Types', 'main_lang.php'),
(416, 'english', 'file_type_msg', 'Seperate File types by jpeg|jpg|png etc.', 'main_lang.php'),
(417, 'english', 'gain', 'Gain', 'main_lang.php'),
(418, 'english', 'gallery', 'Gallery', 'main_lang.php'),
(419, 'english', 'go', 'Go', 'main_lang.php'),
(420, 'english', 'google_plus', 'Google Plus', 'main_lang.php'),
(421, 'english', 'general_settings', 'General Settings', 'main_lang.php'),
(422, 'english', 'group_by', 'Group By', 'main_lang.php'),
(423, 'english', 'group', 'Group', 'main_lang.php'),
(424, 'english', 'group_name', 'Group Name', 'main_lang.php'),
(425, 'english', 'gallery_setting_msg', '(You can manage the allowed File Types and allowed File Size from Administration > Settings > Gallery)', 'main_lang.php'),
(426, 'english', 'header', 'Header', 'main_lang.php'),
(427, 'english', 'hidden', 'Hidden', 'main_lang.php'),
(428, 'english', 'home', 'Home', 'main_lang.php'),
(429, 'english', 'hour', 'hour', 'main_lang.php'),
(430, 'english', 'hourly', 'Hourly', 'main_lang.php'),
(431, 'english', 'hourly_per_bed_charge', 'Per Bed Charge ( Hourly )', 'main_lang.php'),
(432, 'english', 'html_content', 'HTML Content', 'main_lang.php'),
(433, 'english', 'header_settings', 'Header Settings', 'main_lang.php'),
(434, 'english', 'header_contact_number', 'Header Contact Number', 'main_lang.php'),
(435, 'english', 'has_additional_details', 'Has Additional Details', 'main_lang.php'),
(436, 'english', 'home_settings', 'Home Page Settings', 'main_lang.php'),
(437, 'english', 'has_value', 'Has Value', 'main_lang.php'),
(438, 'english', 'heading', 'Heading', 'main_lang.php'),
(439, 'english', 'history', 'History', 'main_lang.php'),
(440, 'english', 'home_page_settings', 'Home Page Settings', 'main_lang.php'),
(441, 'english', 'home_page_slider', 'Home Page Slider', 'main_lang.php'),
(442, 'english', 'home_page_bottom_section', 'Home Page Bottom Section', 'main_lang.php'),
(443, 'english', 'home_page_top_section', 'Home Page Top Section', 'main_lang.php'),
(444, 'english', 'half_day', 'Half Day', 'main_lang.php'),
(445, 'english', 'invoice', 'Tagihan', 'main_lang.php'),
(446, 'english', 'if_field', 'If Field', 'main_lang.php'),
(447, 'english', 'id', 'Id', 'main_lang.php'),
(448, 'english', 'icon', 'Icon', 'main_lang.php'),
(449, 'english', 'inavailablity', 'Inavailablity', 'main_lang.php'),
(450, 'english', 'install', 'Install', 'main_lang.php'),
(451, 'english', 'invoice_prefix', 'Invoice Prefix', 'main_lang.php'),
(452, 'english', 'installing', 'Installing', 'main_lang.php'),
(453, 'english', 'invoice_number', 'Nomor Tagihan', 'main_lang.php'),
(454, 'english', 'invoice_details', 'Detail Tagihan', 'main_lang.php'),
(455, 'english', 'invoice_settings', 'Setting Tagihan', 'main_lang.php'),
(456, 'english', 'in_minutes', 'in minutes', 'main_lang.php'),
(457, 'english', 'in_group', 'In Group', 'main_lang.php'),
(458, 'english', 'instructions', 'Instructions', 'main_lang.php'),
(459, 'english', 'is_active', 'Is Active', 'main_lang.php'),
(460, 'english', 'is_checked', 'Is checked', 'main_lang.php'),
(461, 'english', 'is_unchecked', 'Is unchecked', 'main_lang.php'),
(462, 'english', 'item', 'Item', 'main_lang.php'),
(463, 'english', 'item_number', 'Item Number', 'main_lang.php'),
(464, 'english', 'is_default', 'Is Default', 'main_lang.php'),
(465, 'english', 'item_name', 'Item Name', 'main_lang.php'),
(466, 'english', 'item_type', 'Item Type', 'main_lang.php'),
(467, 'english', 'items', 'Items', 'main_lang.php'),
(468, 'english', 'image', 'Image', 'main_lang.php'),
(469, 'english', 'import', 'Import CSV', 'main_lang.php'),
(470, 'english', 'images', 'Images', 'main_lang.php'),
(471, 'english', 'image_id', 'Image ID', 'main_lang.php'),
(472, 'english', 'image_name', 'Image Name', 'main_lang.php'),
(473, 'english', 'image_path', 'Image Path', 'main_lang.php'),
(474, 'english', 'issue_refund', 'Issue Refund', 'main_lang.php'),
(475, 'english', 'income', 'Income', 'main_lang.php'),
(476, 'english', 'individual', 'Individual', 'main_lang.php'),
(477, 'english', 'information', 'Information', 'main_lang.php'),
(478, 'english', 'joining_date', 'Joining Date', 'main_lang.php'),
(479, 'english', 'journal_voucher', 'Journal Voucher', 'main_lang.php'),
(480, 'english', 'jurisdiction', 'Subject to Surat Jurisdiction', 'main_lang.php'),
(481, 'english', 'journal_vouchers', 'Journal Vouchers', 'main_lang.php'),
(482, 'english', 'key', 'Key', 'main_lang.php'),
(483, 'english', 'landline', 'Landline', 'main_lang.php'),
(484, 'english', 'languages', 'Languages', 'main_lang.php'),
(485, 'english', 'last_name', 'Last Name', 'main_lang.php'),
(486, 'english', 'last', 'Last', 'main_lang.php'),
(487, 'english', 'lab_tests', 'Lab Tests', 'main_lang.php'),
(488, 'english', 'lab_instructions', 'Lab instructions', 'main_lang.php'),
(489, 'english', 'lab_reports', 'Lab Reports', 'main_lang.php'),
(490, 'english', 'lab_test', 'Lab Test', 'main_lang.php'),
(491, 'english', 'latest_news', 'Latest News', 'main_lang.php'),
(492, 'english', 'length_invoice', 'Length of Invoice Number', 'main_lang.php'),
(493, 'english', 'login', 'Login', 'main_lang.php'),
(494, 'english', 'login_yourself_to_get_access', 'Login yourself to get access', 'main_lang.php'),
(495, 'english', 'log_out', 'Log Out', 'main_lang.php'),
(496, 'english', 'license_key', 'License Key', 'main_lang.php'),
(497, 'english', 'licence_number', 'License Number', 'main_lang.php'),
(498, 'english', 'line2', 'Line 2', 'main_lang.php'),
(499, 'english', 'line1', 'Line 1', 'main_lang.php'),
(500, 'english', 'list_master', 'List Master', 'main_lang.php'),
(501, 'english', 'liabilities', 'Liabilities', 'main_lang.php'),
(502, 'english', 'language', 'Language', 'main_lang.php'),
(503, 'english', 'language_name', 'Language Name', 'main_lang.php'),
(504, 'english', 'latest', 'Latest', 'main_lang.php'),
(505, 'english', 'link', 'Link', 'main_lang.php'),
(506, 'english', 'link_text', 'Link Text', 'main_lang.php'),
(507, 'english', 'link_url', 'Link URL', 'main_lang.php'),
(508, 'english', 'marker', 'Marker', 'main_lang.php'),
(509, 'english', 'male', 'Male', 'main_lang.php'),
(510, 'english', 'marking', 'Marking', 'main_lang.php'),
(511, 'english', 'marking_images', 'Marking Images', 'main_lang.php'),
(512, 'english', 'max_patient', 'Max Patients At a Time', 'main_lang.php'),
(513, 'english', 'medicine', 'Medicine', 'main_lang.php'),
(514, 'english', 'menu_access', 'Menu Access', 'main_lang.php'),
(515, 'english', 'medicine_store_bill', 'Medicine Store Bill', 'main_lang.php'),
(516, 'english', 'medicine_name', 'Medicine Name', 'main_lang.php'),
(517, 'english', 'mobile', 'Handphone', 'main_lang.php'),
(518, 'english', 'mobile_no', 'No Handphone', 'main_lang.php'),
(519, 'english', 'middle', 'Middle', 'main_lang.php'),
(520, 'english', 'medicines', 'Medicines', 'main_lang.php'),
(521, 'english', 'module', 'Module', 'main_lang.php'),
(522, 'english', 'mode', 'Mode', 'main_lang.php'),
(523, 'english', 'morning', 'Pagi', 'main_lang.php'),
(524, 'english', 'mrp', 'M.R.P.', 'main_lang.php'),
(525, 'english', 'modules', 'Modules', 'main_lang.php'),
(526, 'english', 'middle_name', 'Middle Name', 'main_lang.php'),
(527, 'english', 'morning_time', 'Waktu Pagi', 'main_lang.php'),
(528, 'english', 'message', 'Message', 'main_lang.php'),
(529, 'english', 'minutes', 'Menit', 'main_lang.php'),
(530, 'english', 'make', 'Make', 'main_lang.php'),
(531, 'english', 'media', 'Media', 'main_lang.php'),
(532, 'english', 'make_appointment', 'Make Appointment', 'main_lang.php'),
(533, 'english', 'merchant_id', 'Merchant ID', 'main_lang.php'),
(534, 'english', 'my_account', 'Akun Saya', 'main_lang.php'),
(535, 'english', 'minimum_stock', 'Minimum Stock Yang Dibutuhkan', 'main_lang.php'),
(536, 'english', 'make_an_appointment', 'Make an Appointment', 'main_lang.php'),
(537, 'english', 'maximum_about_posts', '(You have reached the Maximum About Posts that can be added)', 'main_lang.php'),
(538, 'english', 'maximum_footer_posts', '(You have reached the Maximum Footer Sections Posts that can be added)', 'main_lang.php'),
(539, 'english', 'maximum_top_posts', '(You have reached the Maximum Top Sections Posts that can be added) ', 'main_lang.php'),
(540, 'english', 'maximum_footer_credits', '(You have reached the Maximum Footer credit Posts that can be added) ', 'main_lang.php'),
(541, 'english', 'maximum_bottom_posts', '(You have reached the Maximum Bottom Sections Posts that can be added) ', 'main_lang.php'),
(542, 'english', 'minimum_income', 'Pendapatan Minimum', 'main_lang.php'),
(543, 'english', 'month', 'Bulan', 'main_lang.php'),
(544, 'english', 'medical', 'Medical', 'main_lang.php'),
(545, 'english', 'name', 'Nama', 'main_lang.php'),
(546, 'english', 'none', 'None', 'main_lang.php'),
(547, 'english', 'next_follow_up', 'Next Followup After', 'main_lang.php'),
(548, 'english', 'net_total', 'Net Total', 'main_lang.php'),
(549, 'english', 'news_date', 'Tanggal Berita', 'main_lang.php'),
(550, 'english', 'next_follow_date', 'Next Followup Date', 'main_lang.php'),
(551, 'english', 'news_title', 'Judul', 'main_lang.php'),
(552, 'english', 'news', 'Berita', 'main_lang.php'),
(553, 'english', 'new', 'New', 'main_lang.php'),
(554, 'english', 'new_appointment', 'Janji Baru', 'main_lang.php'),
(555, 'english', 'new_contact', 'Kontak Baru', 'main_lang.php'),
(556, 'english', 'new_inquiry', 'Pertanyaan  Baru', 'main_lang.php'),
(557, 'english', 'new_inquires', 'Pertanyaan Baru', 'main_lang.php'),
(558, 'english', 'new_password', 'New Password', 'main_lang.php'),
(559, 'english', 'new_sell', 'New Sell', 'main_lang.php'),
(560, 'english', 'news_setting', 'News Page Settings', 'main_lang.php'),
(561, 'english', 'no', 'No', 'main_lang.php'),
(562, 'english', 'night', 'N', 'main_lang.php'),
(563, 'english', 'non_taxable_revenue', 'Non Taxable Revenue', 'main_lang.php'),
(564, 'english', 'no_of_beds', 'Banyaknya Tempat  Tidur', 'main_lang.php'),
(565, 'english', 'not_available', 'Tidak Tersedia', 'main_lang.php'),
(566, 'english', 'notes', 'Catatan', 'main_lang.php'),
(567, 'english', 'notes_for_patient', 'Catatan Untuk Pasien', 'main_lang.php'),
(568, 'english', 'number', 'Nomor', 'main_lang.php'),
(569, 'english', 'number_of_columns', 'Number Of Columns', 'main_lang.php'),
(570, 'english', 'news_page_settings', 'News Page Settings', 'main_lang.php'),
(571, 'english', 'night_time', 'Night Time', 'main_lang.php'),
(572, 'english', 'needs_cash_calc', 'Butuh kalkulator', 'main_lang.php'),
(573, 'english', 'nurse', 'Suster', 'main_lang.php'),
(574, 'english', 'no_prescription', 'No Prescription Found', 'main_lang.php'),
(575, 'english', 'number_of_decimal', 'Decimal Places', 'main_lang.php'),
(576, 'english', 'no_image_for_comparision', 'Tidak Ada Gambar yang Dipilih untuk perbandingan', 'main_lang.php'),
(577, 'english', 'on', 'On', 'main_lang.php'),
(578, 'english', 'our', 'Our', 'main_lang.php'),
(579, 'english', 'our_team', 'Our Team', 'main_lang.php'),
(580, 'english', 'office', 'Kantor', 'main_lang.php'),
(581, 'english', 'our_services', 'Our services', 'main_lang.php'),
(582, 'english', 'office_branch', 'Kantor Cabang', 'main_lang.php'),
(583, 'english', 'old_password', 'Old Password', 'main_lang.php'),
(584, 'english', 'option', 'Option', 'main_lang.php'),
(585, 'english', 'opening', 'Opening', 'main_lang.php'),
(586, 'english', 'opening_stock', 'Opening Stock', 'main_lang.php'),
(587, 'english', 'other', 'Other', 'main_lang.php'),
(588, 'english', 'of_appoinment_time', 'Perjajian Waktu', 'main_lang.php'),
(589, 'english', 'paid', 'Paid', 'main_lang.php'),
(590, 'english', 'page_title', 'Page Title', 'main_lang.php'),
(591, 'english', 'paid_cash', 'Paid Cash', 'main_lang.php'),
(592, 'english', 'paid_amount', 'Paid Amount', 'main_lang.php'),
(593, 'english', 'parent', 'Wali Pasien', 'main_lang.php'),
(594, 'english', 'particular', 'Particular', 'main_lang.php'),
(595, 'english', 'password', 'Password', 'main_lang.php'),
(596, 'english', 'patient', 'Pasien', 'main_lang.php'),
(597, 'english', 'patient_detail', 'Detail Pasien', 'main_lang.php'),
(598, 'english', 'patient_details', 'Detail Pasien', 'main_lang.php'),
(599, 'english', 'patient_account', 'Akun Pasien', 'main_lang.php'),
(600, 'english', 'patient_id', 'ID Pasien', 'main_lang.php'),
(601, 'english', 'patient_name', 'Nama Pasien', 'main_lang.php'),
(602, 'english', 'patients', 'Pasien', 'main_lang.php'),
(603, 'english', 'patient_notes', 'Catatan Pasien', 'main_lang.php'),
(604, 'english', 'patient_report', 'Laporan Pasien', 'main_lang.php'),
(605, 'english', 'patient_added_after', 'Patient Added After', 'main_lang.php'),
(606, 'english', 'payment', 'Pembayaran', 'main_lang.php'),
(607, 'english', 'payments', 'Payments', 'main_lang.php'),
(608, 'english', 'patient_wise_alert_settings', 'Patient wise Alert Settings', 'main_lang.php'),
(609, 'english', 'payment_methods', 'Metode Pembayaran', 'main_lang.php'),
(610, 'english', 'payment_form', 'Formulir Pembayaran', 'main_lang.php'),
(611, 'english', 'payment_amount', 'Jumlah Pembayaran', 'main_lang.php'),
(612, 'english', 'payment_adjustement', 'Payment Adjustement', 'main_lang.php'),
(613, 'english', 'payment_date', 'Tanggal Pembayaran', 'main_lang.php'),
(614, 'english', 'payment_method', 'Metode Pembayaran', 'main_lang.php'),
(615, 'english', 'payment_mode', 'Payment Mode', 'main_lang.php'),
(616, 'english', 'payment_history', 'Histori Pembayaran', 'main_lang.php'),
(617, 'english', 'payment_status', 'Status Pembayaran', 'main_lang.php'),
(618, 'english', 'paypal_settings', 'PayPal Settings', 'main_lang.php'),
(619, 'english', 'paypal_business_email', 'PayPal Business Email', 'main_lang.php'),
(620, 'english', 'pending', 'Pending', 'main_lang.php'),
(621, 'english', 'pending_payments', 'Pending Pembayaran', 'main_lang.php'),
(622, 'english', 'per_bed_charge', 'Per Bed Charge', 'main_lang.php'),
(623, 'english', 'per_day', 'Per Day', 'main_lang.php'),
(624, 'english', 'phone_number', 'No. HP', 'main_lang.php'),
(625, 'english', 'per_hour', 'Per Hour', 'main_lang.php'),
(626, 'english', 'placeholder', 'Placeholder', 'main_lang.php'),
(627, 'english', 'post', 'Post', 'main_lang.php'),
(628, 'english', 'posts', 'Posts', 'main_lang.php'),
(629, 'english', 'post_content', 'Post Content', 'main_lang.php'),
(630, 'english', 'postal_code', 'Postal Code', 'main_lang.php'),
(631, 'english', 'post_title', 'Post Title', 'main_lang.php'),
(632, 'english', 'post_type', 'Post Type', 'main_lang.php'),
(633, 'english', 'print', 'Print', 'main_lang.php'),
(634, 'english', 'print_receipt', 'Print Nota', 'main_lang.php'),
(635, 'english', 'profile', 'Profile', 'main_lang.php'),
(636, 'english', 'progress', 'Progress', 'main_lang.php'),
(637, 'english', 'prev_bal', 'Previous Balance', 'main_lang.php'),
(638, 'english', 'prev_due', 'Previous Due', 'main_lang.php'),
(639, 'english', 'preferred_size', 'Preferred size 260X60', 'main_lang.php'),
(640, 'english', 'price', 'Harga', 'main_lang.php'),
(641, 'english', 'print_report', 'Print Laporan', 'main_lang.php'),
(642, 'english', 'prescription', 'Prescription', 'main_lang.php'),
(643, 'english', 'preferences', 'Preferences', 'main_lang.php'),
(644, 'english', 'purchase', 'Purchase', 'main_lang.php'),
(645, 'english', 'purchase_date', 'Purchase Date', 'main_lang.php'),
(646, 'english', 'purchase_return', 'Purchase Return', 'main_lang.php'),
(647, 'english', 'purchase_register', 'Purchase Register', 'main_lang.php'),
(648, 'english', 'promocode', 'Promocode', 'main_lang.php'),
(649, 'english', 'promocodes', 'Promocodes', 'main_lang.php'),
(650, 'english', 'percentage', 'Percentage', 'main_lang.php'),
(651, 'english', 'pending_appointments', 'Pending Pertemuan', 'main_lang.php'),
(652, 'english', 'pending_payment', 'Pending Pembayaran', 'main_lang.php'),
(653, 'english', 'planned_appointment', 'This is Appointment is a Planned Session', 'main_lang.php'),
(654, 'english', 'planned_visit', 'This is Visit is a Planned Session', 'main_lang.php'),
(655, 'english', 'planned_sessions', 'Planned Sessions', 'main_lang.php'),
(656, 'english', 'payment_pending', 'Keep Payment pending until approved', 'main_lang.php'),
(657, 'english', 'phone', 'HP', 'main_lang.php'),
(658, 'english', 'paypal', 'PayPal', 'main_lang.php'),
(659, 'english', 'pay', 'Bayar', 'main_lang.php'),
(660, 'english', 'prefered_language', 'Prefered Language', 'main_lang.php'),
(661, 'english', 'prescribed_medicine', 'Prescribed Medicine', 'main_lang.php'),
(662, 'english', 'quantity', 'Quantity', 'main_lang.php'),
(663, 'english', 'qrcode', 'QRcode', 'main_lang.php'),
(664, 'english', 'fixed', 'Fixed', 'main_lang.php'),
(665, 'english', 'variable', 'Variable', 'main_lang.php'),
(666, 'english', 'decimal_places', 'Tempat desimal ', 'main_lang.php'),
(667, 'english', 'in', 'In', 'main_lang.php'),
(668, 'english', 'rate', 'Rate', 'main_lang.php'),
(669, 'english', 'reason', 'Reason', 'main_lang.php'),
(670, 'english', 'response', 'Response', 'main_lang.php'),
(671, 'english', 'rebrand', 'Rebrand', 'main_lang.php'),
(672, 'english', 'receipt_template', 'Receipt Templates', 'main_lang.php'),
(673, 'english', 'refund', 'Refund', 'main_lang.php'),
(674, 'english', 'reference_by', 'Reference By', 'main_lang.php'),
(675, 'english', 'receipt', 'Receipt', 'main_lang.php'),
(676, 'english', 'report', 'Report', 'main_lang.php'),
(677, 'english', 'restore', 'Restore', 'main_lang.php'),
(678, 'english', 'remark', 'Remark', 'main_lang.php'),
(679, 'english', 'reset_password', 'Reset Password', 'main_lang.php'),
(680, 'english', 'remove_logo', 'Remove Logo', 'main_lang.php'),
(681, 'english', 'reports', 'Reports', 'main_lang.php'),
(682, 'english', 'remove', 'Remove', 'main_lang.php'),
(683, 'english', 'remove_patient_image', 'Remove Patient Image', 'main_lang.php'),
(684, 'english', 'renew_license', 'Renew License', 'main_lang.php'),
(685, 'english', 'renew_license_to_update', 'Renew License To Update', 'main_lang.php'),
(686, 'english', 'quantity_exceeds', 'Required Quantity exceeds Available Stock', 'main_lang.php'),
(687, 'english', 'receive_fee', 'Received fees for Professional services and other charges of our', 'main_lang.php'),
(688, 'english', 'room', 'Room', 'main_lang.php'),
(689, 'english', 'rooms_categories', 'Rooms Categories', 'main_lang.php'),
(690, 'english', 'rooms_allocate', 'Rooms Allocate', 'main_lang.php'),
(691, 'english', 'rooms', 'Rooms', 'main_lang.php'),
(692, 'english', 'rooms_calendar', 'Rooms Calendar', 'main_lang.php'),
(693, 'english', 'rooms_beds', 'Rooms/ Beds', 'main_lang.php'),
(694, 'english', 'register', 'Register', 'main_lang.php'),
(695, 'english', 'registration', 'Registration', 'main_lang.php'),
(696, 'english', 'reference_details', 'Reference Details', 'main_lang.php'),
(697, 'english', 'resend_code', 'Resend Code', 'main_lang.php'),
(698, 'english', 'residence', 'Residence', 'main_lang.php'),
(699, 'english', 'restore_backup', 'Restore Backup', 'main_lang.php'),
(700, 'english', 'return', 'Return', 'main_lang.php'),
(701, 'english', 'return_change', 'Return Change', 'main_lang.php'),
(702, 'english', 'return_date', 'Return Date', 'main_lang.php'),
(703, 'english', 'room_charges', 'Room Charges Reports', 'main_lang.php'),
(704, 'english', 'room_number', 'No Ruangan', 'main_lang.php'),
(705, 'english', 'refund_date', 'Refund Date', 'main_lang.php'),
(706, 'english', 'refund_amount', 'Refund Amount', 'main_lang.php'),
(707, 'english', 'refund_note', 'Refund Note', 'main_lang.php'),
(708, 'english', 'refresh', 'Refresh', 'main_lang.php'),
(709, 'english', 'reject', 'Reject', 'main_lang.php'),
(710, 'english', 'required_quantity', 'Required Quantity', 'main_lang.php'),
(711, 'english', 'reason_for_appointment', 'Reason for Appointment', 'main_lang.php'),
(712, 'english', 'rtl', 'RTL', 'main_lang.php'),
(713, 'english', 'reload_language_file', 'Reload Language File', 'main_lang.php'),
(714, 'english', 'right_to_left', 'Right to Left Language', 'main_lang.php'),
(715, 'english', 'reload_language_file_instruction', 'This will overwrite the changes from language file.', 'main_lang.php'),
(716, 'english', 'slider_image', 'Slider Image', 'main_lang.php'),
(717, 'english', 'sign_up', 'Sign up', 'main_lang.php'),
(718, 'english', 'slider_1', 'Slider 1', 'main_lang.php'),
(719, 'english', 'slider_3', 'Slider 3', 'main_lang.php'),
(720, 'english', 'slider_2', 'Slider 2', 'main_lang.php'),
(721, 'english', 'slider', 'Slider', 'main_lang.php'),
(722, 'english', 'section', 'Section', 'main_lang.php'),
(723, 'english', 'section_1', 'Section 1', 'main_lang.php'),
(724, 'english', 'section_3', 'Section 3', 'main_lang.php'),
(725, 'english', 'section_2', 'Section 2', 'main_lang.php'),
(726, 'english', 'section_4', 'Section 4', 'main_lang.php'),
(727, 'english', 'section_name', 'Section Name', 'main_lang.php'),
(728, 'english', 'senderid', 'Sender ID', 'main_lang.php'),
(729, 'english', 'schedule', 'Schedule', 'main_lang.php'),
(730, 'english', 'save', 'Save', 'main_lang.php'),
(731, 'english', 'second_number', 'Second Number', 'main_lang.php'),
(732, 'english', 'search', 'Search', 'main_lang.php'),
(733, 'english', 'search_by_name', 'Search By Name', 'main_lang.php'),
(734, 'english', 'select', 'Select', 'main_lang.php'),
(735, 'english', 'select_lang', 'Select your Language', 'main_lang.php'),
(736, 'english', 'select_currency', 'Select Currency', 'main_lang.php'),
(737, 'english', 'select_duration', 'Select Duration', 'main_lang.php'),
(738, 'english', 'select_date', 'Select Date', 'main_lang.php'),
(739, 'english', 'select_media_image', 'Select Media Image', 'main_lang.php'),
(740, 'english', 'select_time_zone', 'Select Your Time zone', 'main_lang.php'),
(741, 'english', 'select_all', 'Select All', 'main_lang.php'),
(742, 'english', 'select_blood_group', 'Select Blood Group', 'main_lang.php'),
(743, 'english', 'select_mode', 'Select Mode', 'main_lang.php'),
(744, 'english', 'sell', 'Sell', 'main_lang.php'),
(745, 'english', 'subject', 'Subject', 'main_lang.php'),
(746, 'english', 'shortcode_label', 'Shortcodes you need to use:', 'main_lang.php'),
(747, 'english', 'shortcode_patient_name', '[patient_name] - Patient Name', 'main_lang.php'),
(748, 'english', 'shortcode_patient_id', '[patient_id] - Patient ID', 'main_lang.php'),
(749, 'english', 'shortcode_clinic_logo', '[clinic_logo] - Clinic Logo - Can be set in Clinic Detail', 'main_lang.php'),
(750, 'english', 'shortcode_clinic_name', '[clinic_name] - Clinic Name - Can be set in Clinic Detail', 'main_lang.php'),
(751, 'english', 'shortcode_clinic_address', '[clinic_address] - Clinic Address - Can be set in Clinic Detail', 'main_lang.php'),
(752, 'english', 'shortcode_clinic_mobile', '[mobile] - Mobile - Can be set in Clinic Detail', 'main_lang.php'),
(753, 'english', 'shortcode_clinic_landline', '[landline] - Landline - Can be set in Clinic Detail', 'main_lang.php'),
(754, 'english', 'shortcode_clinic_email', '[email] - Email - Can be set in Clinic Detail', 'main_lang.php'),
(755, 'english', 'shortcode_tag_line', '[tag_line] - Tag Line - Can be set in Clinic Detail', 'main_lang.php'),
(756, 'english', 'shortcode_doctor_name', '[doctor_name] - Doctor Name', 'main_lang.php'),
(757, 'english', 'shortcode_dose_time', '[dose_time] - Morning | Tuesday | Wednesday', 'main_lang.php'),
(758, 'english', 'shortcode_sms_medicine_details', '[sms_medicine_details] - All Medicine Details in Table Format', 'main_lang.php'),
(759, 'english', 'shortcode_medicine_details', '[medicine_details] - All Medicine Details in Table Format', 'main_lang.php');
INSERT INTO `pid_language_data` (`id`, `l_name`, `l_index`, `l_value`, `file_name`) VALUES
(760, 'english', 'shortcode_appointment_time', '[appointment_time] - Appointment Time', 'main_lang.php'),
(761, 'english', 'shortcode_appointment_date', '[appointment_date] - Appointment Date', 'main_lang.php'),
(762, 'english', 'shortcode_appointment_status', '[appointment_status] - Appointment Status', 'main_lang.php'),
(763, 'english', 'shortcode_bill', '[bill] - Soft Copy of Bill', 'main_lang.php'),
(764, 'english', 'shortcode_appointment_reason', '[appointment_reason] - Appointment Reason', 'main_lang.php'),
(765, 'english', 'shortcode_bill_id', '[bill_id] - ID of Bill', 'main_lang.php'),
(766, 'english', 'shortcode_bill_date', '[bill_date] - Date of Bill', 'main_lang.php'),
(767, 'english', 'shortcode_bill_time', '[bill_time] - Time of Bill', 'main_lang.php'),
(768, 'english', 'shortcode_previous_due', '[previous_due] - Previous Dues', 'main_lang.php'),
(769, 'english', 'shortcode_patient_email', '[patient_email] - Email ID', 'main_lang.php'),
(770, 'english', 'shortcode_visit_date', '[visit_date] - Date of Visit', 'main_lang.php'),
(771, 'english', 'shortcode_patient_sex', '[sex] - Patient Sex', 'main_lang.php'),
(772, 'english', 'shortcode_patient_age', '[age] - Patient Age', 'main_lang.php'),
(773, 'english', 'shortcode_total', '[total] - Total of this Bill', 'main_lang.php'),
(774, 'english', 'shortcode_patient_phone_number', '[patient_phone_number] - Phone Number', 'main_lang.php'),
(775, 'english', 'shortcode_paid_amount', '[paid_amount] - Paid Amount', 'main_lang.php'),
(776, 'english', 'shortcode_username', '[username] - Will be replaced by Username', 'main_lang.php'),
(777, 'english', 'shortcode_password', '[password] - Will be replaced by Password', 'main_lang.php'),
(778, 'english', 'shortcode_senderid', '[senderid] - Will be replaced by Sender ID', 'main_lang.php'),
(779, 'english', 'shortcode_mobileno', '[mobileno] - Will be replaced by Receipient Mobile Number', 'main_lang.php'),
(780, 'english', 'shortcode_message', '[message] - Will be replaced by Message', 'main_lang.php'),
(781, 'english', 'shortcode_template_id', '[template_id] - Will be replaced by Template ID', 'main_lang.php'),
(782, 'english', 'shortcode_bill_columns', 'Columns to display in table For Bill', 'main_lang.php'),
(783, 'english', 'share_type', 'Share Type', 'main_lang.php'),
(784, 'english', 'shortcode_prescription_columns', 'Columns to display in table For Prescription', 'main_lang.php'),
(785, 'english', 'sms_settings', 'SMS Settings', 'main_lang.php'),
(786, 'english', 'smtp_instructions', 'Below fields only required for sending SMTP Emails', 'main_lang.php'),
(787, 'english', 'services_settings', 'Services Settings', 'main_lang.php'),
(788, 'english', 'stock_sell', 'Sell', 'main_lang.php'),
(789, 'english', 'sell_id', 'Sell Id', 'main_lang.php'),
(790, 'english', 'set', 'Set', 'main_lang.php'),
(791, 'english', 'sell_amount', 'Sell Amount', 'main_lang.php'),
(792, 'english', 'sell_date', 'Sell Date', 'main_lang.php'),
(793, 'english', 'sell_price', 'Sell Price', 'main_lang.php'),
(794, 'english', 'set_as_default', 'Set as Default', 'main_lang.php'),
(795, 'english', 'settings', 'Settings', 'main_lang.php'),
(796, 'english', 'services', 'Services', 'main_lang.php'),
(797, 'english', 'service', 'Service', 'main_lang.php'),
(798, 'english', 'services_type', 'Services Types', 'main_lang.php'),
(799, 'english', 'session', 'Session', 'main_lang.php'),
(800, 'english', 'sessions', 'Sessions', 'main_lang.php'),
(801, 'english', 'session_report', 'Session Report', 'main_lang.php'),
(802, 'english', 'setting', 'Setting', 'main_lang.php'),
(803, 'english', 'signature', 'Signature', 'main_lang.php'),
(804, 'english', 'software_name', 'Software Name', 'main_lang.php'),
(805, 'english', 'sold_at', 'Sold At', 'main_lang.php'),
(806, 'english', 'sold_avg', 'Sold Avg', 'main_lang.php'),
(807, 'english', 'sold_quantity', 'Sold Quantity', 'main_lang.php'),
(808, 'english', 'special_access', 'Special Access', 'main_lang.php'),
(809, 'english', 'sr_no', 'Sr. No.', 'main_lang.php'),
(810, 'english', 'start_date', 'Start Date', 'main_lang.php'),
(811, 'english', 'staff', 'Staff', 'main_lang.php'),
(812, 'english', 'start_time', 'Start Time', 'main_lang.php'),
(813, 'english', 'specialization', 'Specialization', 'main_lang.php'),
(814, 'english', 'state', 'State', 'main_lang.php'),
(815, 'english', 'static_prefix', 'Static Prefix', 'main_lang.php'),
(816, 'english', 'status', 'Status', 'main_lang.php'),
(817, 'english', 'stock', 'Stock', 'main_lang.php'),
(818, 'english', 'stock_item', 'Item', 'main_lang.php'),
(819, 'english', 'stock_report', 'Report', 'main_lang.php'),
(820, 'english', 'stock_stock_report', 'Stock Report', 'main_lang.php'),
(821, 'english', 'submit', 'Submit', 'main_lang.php'),
(822, 'english', 'supplier', 'Supplier', 'main_lang.php'),
(823, 'english', 'sub_total', 'Sub Total', 'main_lang.php'),
(824, 'english', 'suppliers', 'Suppliers', 'main_lang.php'),
(825, 'english', 'stock_suppliers', 'Suppliers', 'main_lang.php'),
(826, 'english', 'stock_purchase_report', 'Purchase Report', 'main_lang.php'),
(827, 'english', 'stock_purchase', 'Purchase', 'main_lang.php'),
(828, 'english', 'support', 'Support', 'main_lang.php'),
(829, 'english', 'supplier_name', 'Supplier Name', 'main_lang.php'),
(830, 'english', 'support_text', 'Support Text', 'main_lang.php'),
(831, 'english', 'select_beautician', 'Select Doctor', 'main_lang.php'),
(832, 'english', 'select_doctor', 'Select Doctor', 'main_lang.php'),
(833, 'english', 'support_url', 'Support URL', 'main_lang.php'),
(834, 'english', 'select_a_Slot', 'Select a Slot', 'main_lang.php'),
(835, 'english', 'select_fields', 'Select Fields', 'main_lang.php'),
(836, 'english', 'sell_return', 'Sell Return', 'main_lang.php'),
(837, 'english', 'select_tax_rate', 'Select Tax Rate', 'main_lang.php'),
(838, 'english', 'select_patient', 'Select Patient', 'main_lang.php'),
(839, 'english', 'stock_sell_report', 'All Sell Report', 'main_lang.php'),
(840, 'english', 'total_sell_report', 'Total Sell Report', 'main_lang.php'),
(841, 'english', 'synchronize', 'Synchronize', 'main_lang.php'),
(842, 'english', 'smtp_host', 'SMTP Host', 'main_lang.php'),
(843, 'english', 'smtp_port', 'SMTP Port', 'main_lang.php'),
(844, 'english', 'sms_url', 'URL to send SMS', 'main_lang.php'),
(845, 'english', 'sms_alert_time', 'SMS Alert Time', 'main_lang.php'),
(846, 'english', 'sms_template_id', 'SMS Template ID', 'main_lang.php'),
(847, 'english', 'sms_format', 'SMS Format', 'main_lang.php'),
(848, 'english', 'sms_log', 'SMS Log', 'main_lang.php'),
(849, 'english', 'ssn_id', 'Adhar Number', 'main_lang.php'),
(850, 'english', 'save_complete', 'Save and Complete', 'main_lang.php'),
(851, 'english', 'save_and_bill', 'Save and Create Bill', 'main_lang.php'),
(852, 'english', 'set_alert_time', 'Set Alert Time', 'main_lang.php'),
(853, 'english', 'slot', 'Slot', 'main_lang.php'),
(854, 'english', 'total_appointments', 'Total Appointments', 'main_lang.php'),
(855, 'english', 'to', 'To', 'main_lang.php'),
(856, 'english', 'take_backup', 'Take Backup', 'main_lang.php'),
(857, 'english', 'tag_line', 'Tag Line', 'main_lang.php'),
(858, 'english', 'task', 'Task', 'main_lang.php'),
(859, 'english', 'tax', 'Tax', 'main_lang.php'),
(860, 'english', 'tasks', 'Tasks', 'main_lang.php'),
(861, 'english', 'tax_amount', 'Tax Amount', 'main_lang.php'),
(862, 'english', 'tax_revenue', 'Tax Revenue', 'main_lang.php'),
(863, 'english', 'taxable', 'Taxable', 'main_lang.php'),
(864, 'english', 'taxable_revenue', 'Taxable Revenue', 'main_lang.php'),
(865, 'english', 'tax_rates', 'Tax Rates', 'main_lang.php'),
(866, 'english', 'tax_report', 'Tax Report', 'main_lang.php'),
(867, 'english', 'tax_rate', 'Tax Rate', 'main_lang.php'),
(868, 'english', 'template_name', 'Template Name', 'main_lang.php'),
(869, 'english', 'template_content', 'Template Content', 'main_lang.php'),
(870, 'english', 'thanks', 'Received with Thanks', 'main_lang.php'),
(871, 'english', 'time', 'Time', 'main_lang.php'),
(872, 'english', 'test', 'Test', 'main_lang.php'),
(873, 'english', 'timings', 'Timings', 'main_lang.php'),
(874, 'english', 'timestamp', 'Timestamp', 'main_lang.php'),
(875, 'english', 'time_format', 'Time Format', 'main_lang.php'),
(876, 'english', 'time_zone', 'Time Zone', 'main_lang.php'),
(877, 'english', 'to_admin_panel', ' To Admin Pannel', 'main_lang.php'),
(878, 'english', 'time_interval', 'Time Interval', 'main_lang.php'),
(879, 'english', 'to_date', 'To Date', 'main_lang.php'),
(880, 'english', 'title', 'Title', 'main_lang.php'),
(881, 'english', 'to_be_paid', 'To Be Paid', 'main_lang.php'),
(882, 'english', 'total', 'Total', 'main_lang.php'),
(883, 'english', 'total_due_after_payment', 'Total Due After Payment', 'main_lang.php'),
(884, 'english', 'treatment', 'Treatment', 'main_lang.php'),
(885, 'english', 'transport', 'Transport', 'main_lang.php'),
(886, 'english', 'treatment_report', 'Treatment Report', 'main_lang.php'),
(887, 'english', 'treatments', 'Treatments', 'main_lang.php'),
(888, 'english', 'treatment_name', 'Treatment Name', 'main_lang.php'),
(889, 'english', 'treatment_charges', 'Treatment Charges/Fees', 'main_lang.php'),
(890, 'english', 'type', 'Type', 'main_lang.php'),
(891, 'english', 'twitter', 'Twitter', 'main_lang.php'),
(892, 'english', 'twitter_link', 'Twitter Link', 'main_lang.php'),
(893, 'english', 'theme', 'Theme', 'main_lang.php'),
(894, 'english', 'txn_id', 'TXN ID', 'main_lang.php'),
(895, 'english', 'tax_rate_name', 'Tax Rate Name', 'main_lang.php'),
(896, 'english', 'test_name', 'Test Name', 'main_lang.php'),
(897, 'english', 'tests', 'Tests', 'main_lang.php'),
(898, 'english', 'text', 'Text', 'main_lang.php'),
(899, 'english', 'top_section_2', 'Top Section 2', 'main_lang.php'),
(900, 'english', 'top_section_1', 'Top Section 1', 'main_lang.php'),
(901, 'english', 'top_section_3', 'Top Section 3', 'main_lang.php'),
(902, 'english', 'this_payment_is_rejected', 'This Payment is rejected', 'main_lang.php'),
(903, 'english', 'types', 'Types', 'main_lang.php'),
(904, 'english', 'thousands_separator', 'Thousands Separator', 'main_lang.php'),
(905, 'english', 'upload', 'Upload', 'main_lang.php'),
(906, 'english', 'upload_extension', 'Upload Extensions', 'main_lang.php'),
(907, 'english', 'update', 'Update', 'main_lang.php'),
(908, 'english', 'username', 'Username', 'main_lang.php'),
(909, 'english', 'updates', 'Updates', 'main_lang.php'),
(910, 'english', 'update_now', 'Update Now', 'main_lang.php'),
(911, 'english', 'user', 'User', 'main_lang.php'),
(912, 'english', 'url', 'URL', 'main_lang.php'),
(913, 'english', 'users', 'Users', 'main_lang.php'),
(914, 'english', 'using', 'Using', 'main_lang.php'),
(915, 'english', 'upload_language_file', 'Upload existing language file', 'main_lang.php'),
(916, 'english', 'unpacking_zip_package', 'Unpacking Zip Package', 'main_lang.php'),
(917, 'english', 'vaccine', 'Vaccine', 'main_lang.php'),
(918, 'english', 'vaccines', 'Vaccines', 'main_lang.php'),
(919, 'english', 'upcoming_appointments', 'Upcoming Appointments', 'main_lang.php'),
(920, 'english', 'vaccine_master', 'Vaccination', 'main_lang.php'),
(921, 'english', 'vaccine_name', 'Vaccine Name', 'main_lang.php'),
(922, 'english', 'view', 'View', 'main_lang.php'),
(923, 'english', 'viewed', 'Viewed', 'main_lang.php'),
(924, 'english', 'visit', 'Visit', 'main_lang.php'),
(925, 'english', 'visit_date', 'Visit Date', 'main_lang.php'),
(926, 'english', 'visit_time', 'Visit Time', 'main_lang.php'),
(927, 'english', 'verify', 'Verify', 'main_lang.php'),
(928, 'english', 'version', 'Version', 'main_lang.php'),
(929, 'english', 'visits', 'Visits', 'main_lang.php'),
(930, 'english', 'visit_type', 'Visit Type', 'main_lang.php'),
(931, 'english', 'verification_code', 'Verification Code', 'main_lang.php'),
(932, 'english', 'verify_email', 'Verify Email', 'main_lang.php'),
(933, 'english', 'voucher_no', 'Voucher No.', 'main_lang.php'),
(934, 'english', 'voucher_date', 'Voucher Date', 'main_lang.php'),
(935, 'english', 'view_larger_map', 'View Larger Map', 'main_lang.php'),
(936, 'english', 'view_prescription', 'View Prescription', 'main_lang.php'),
(937, 'english', 'value', 'Value', 'main_lang.php'),
(938, 'english', 'visit_report', 'Medical History Report', 'main_lang.php'),
(939, 'english', 'welcome', 'Welcome', 'main_lang.php'),
(940, 'english', 'waiting', 'Waiting', 'main_lang.php'),
(941, 'english', 'waiting_in', 'Waiting In', 'main_lang.php'),
(942, 'english', 'whole_day', 'Whole Day', 'main_lang.php'),
(943, 'english', 'website', 'Website', 'main_lang.php'),
(944, 'english', 'website_url', 'Website URL', 'main_lang.php'),
(945, 'english', 'website_text', 'Website Text', 'main_lang.php'),
(946, 'english', 'working_days', 'Working Days', 'main_lang.php'),
(947, 'english', 'working_key', 'Working Key', 'main_lang.php'),
(948, 'english', 'working', 'Working', 'main_lang.php'),
(949, 'english', 'non_working', 'Tidak Bekerja', 'main_lang.php'),
(950, 'english', 'we_provide', 'We Provide', 'main_lang.php'),
(951, 'english', 'year', 'Year', 'main_lang.php'),
(952, 'english', 'sunday', 'Sunday', 'main_lang.php'),
(953, 'english', 'monday', 'Senin', 'main_lang.php'),
(954, 'english', 'tuesday', 'Tuesday', 'main_lang.php'),
(955, 'english', 'wednesday', 'Wednesday', 'main_lang.php'),
(956, 'english', 'friday', 'Friday', 'main_lang.php'),
(957, 'english', 'thursday', 'Thursday', 'main_lang.php'),
(958, 'english', 'saturday', 'Saturday', 'main_lang.php'),
(959, 'english', 'your_username', 'Your Username', 'main_lang.php'),
(960, 'english', 'your_password', 'Your Password', 'main_lang.php'),
(961, 'english', 'room_numbers_for', 'Room Numbers for', 'main_lang.php'),
(962, 'english', 'aplha_space', 'The %s field may only contain alpha characters & White spaces', 'main_lang.php'),
(963, 'english', 'irreversible_process', 'This is a irreversible process.It may cause loss of data. Be really really sure before restoring data.', 'main_lang.php'),
(964, 'english', 'first_or_last', 'Please enter First Name or Last Name', 'main_lang.php'),
(965, 'english', 'password_not_match', 'Old Password Not Matched', 'main_lang.php'),
(966, 'english', 'numbersof_days_between_two_appointments', 'Set it to basic numbers of days between two appointments. Set it to 0, to disable automatically setting next followup.', 'main_lang.php'),
(967, 'english', 'calculation_purpose_only', '*Bidang ini hanya untuk tujuan perhitungan. Tambahkan jumlah pemba', 'main_lang.php'),
(968, 'english', 'clickto_toggle_display', '(Click to toggle display)', 'main_lang.php'),
(969, 'english', 'nobillsfound_for_selected_parameters', 'No Bills found for selected parameters', 'main_lang.php'),
(970, 'english', 'norecfound', 'No Record Found', 'main_lang.php'),
(971, 'english', 'areyousure', 'Apakah Anda yakin?', 'main_lang.php'),
(972, 'english', 'areyousure_delete', 'Anda yakin ingin menghapus?', 'main_lang.php'),
(973, 'english', 'areyousure_reject', 'Apakah Anda yakin ingin menolak?', 'main_lang.php'),
(974, 'english', 'areyousure_approve', 'Apakah Anda yakin ingin menyetujui?', 'main_lang.php'),
(975, 'english', 'please_select', 'Please Select', 'main_lang.php'),
(976, 'english', 'areyousure_cleardata', 'Apakah Anda yakin ingin Menghapus Data?', 'main_lang.php'),
(977, 'english', 'areyousure_deactivate', 'Anda yakin ingin menonaktifkan?', 'main_lang.php'),
(978, 'english', 'jpg_format_not_allow', 'Jpg File format is allowed &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Image Size: 800 * 800', 'main_lang.php'),
(979, 'english', 'tempnote', '&nbsp;&nbsp;&nbsp;&nbsp;* Changing an existing template name will not rename the template. Instead it will create a copy of the template.', 'main_lang.php'),
(980, 'english', 'invalid_username', 'Invalid Username and/or Password', 'main_lang.php'),
(981, 'english', 'no_file_chosen', 'No File Chosen', 'main_lang.php'),
(982, 'english', 'no_treatment_added_add_treatment', 'No Treatments added. Add a treatment.', 'main_lang.php'),
(983, 'english', 'no_vaccine_added_add_vaccine', 'No Vaccines added. Add a Vaccine.', 'main_lang.php'),
(984, 'english', 'no_vaccine_schedule_added_add_vaccine', 'No Vaccines schedule added. Add a Vaccine Schedule.', 'main_lang.php'),
(985, 'english', 'temptext', 'The template directory must be set to writable to use the template editor.', 'main_lang.php'),
(986, 'english', 'upload_extention_instruction', 'If you have a extension in a .zip format, you may install it by uploading it here.', 'main_lang.php'),
(987, 'english', 'no_visits', 'No Visits for this patient', 'main_lang.php'),
(988, 'english', 'toggle_display', '(Click to toggle display)', 'main_lang.php'),
(989, 'english', 'initial_password_message', 'Initial password is same as username', 'main_lang.php'),
(990, 'english', 'thanks_to_amazing_works', 'Chikitsa would not have been possible without the amazing works listed below', 'main_lang.php'),
(991, 'english', 'no_disease', 'Tidak Ada Gejala,Tambahkan Gejala', 'main_lang.php'),
(992, 'english', 'is_active_email', 'The {field} is not active. Kindly contact administrator', 'main_lang.php'),
(993, 'english', 'validate_date_or_day', 'Please enter Date or select Days.', 'main_lang.php'),
(994, 'english', 'non_working_day', 'This is a Non Working Day', 'main_lang.php'),
(995, 'english', 'max_post_allowed', '(You have reached the Maximum About Posts that can be added)', 'main_lang.php'),
(996, 'english', 'time_booked', 'This time is already booked with maximum patients!', 'main_lang.php'),
(997, 'english', 'image_for_compare', 'Please Select images for compare', 'main_lang.php'),
(998, 'english', 'doctor_not_available', 'Dokter tidak tersedia diwaktu ini', 'main_lang.php'),
(999, 'english', 'error_saving_image', 'Some Error occured while trying to save Image.', 'main_lang.php'),
(1000, 'english', 'select_two', 'Please Select only Two', 'main_lang.php'),
(1001, 'english', 'save_language_instructions', '(Just change the text and move to next to save)', 'main_lang.php'),
(1002, 'english', 'validate_code', 'Verification Code is not valid', 'main_lang.php'),
(1003, 'english', 'no_email_registered', 'Tidak Ada Username Dan Email Yang Terdaftar', 'main_lang.php'),
(1004, 'english', 'reset_password_instructions', 'Please enter your username or email address. You will receive a link to create a new password via email.', 'main_lang.php'),
(1005, 'english', 'check_confirmation_link', 'Periksa Link Tautan Konfirmasi Pada Email Anda.', 'main_lang.php'),
(1006, 'english', 'paypal_cancel_salutation', 'Dear Member', 'main_lang.php'),
(1007, 'english', 'appointment_payment_success', 'Pembayaran Anda berhasil, terima kasih telah memesan janji temu.', 'main_lang.php'),
(1008, 'english', 'paypal_cancel_message', 'We are sorry! Your last transaction was cancelled.', 'main_lang.php'),
(1009, 'english', 'file_missing', 'Folder Missing', 'main_lang.php'),
(1010, 'english', 'sms_username_instruction', 'Enter the username provided by the SMS API Provider', 'main_lang.php'),
(1011, 'english', 'sms_password_instruction', 'Enter the password provided by the SMS API Provider', 'main_lang.php'),
(1012, 'english', 'sms_senderid_instruction', 'Enter the sender ID provided by the SMS API Provider', 'main_lang.php'),
(1013, 'english', 'sms_countrycode_instruction', 'Keep it blank to not include Country Code in Mobile Number', 'main_lang.php'),
(1014, 'english', 'updating_to_latest', 'Updating Chikitsa to Latest Version.<br/> This process may take several minutes.<br/>', 'main_lang.php'),
(1015, 'english', 'donot_close_browser', '<strong>Please do not close the browser till the process completes.</strong><br/>', 'main_lang.php'),
(1016, 'english', 'sms_url_instruction', 'Enter the URL provided by the SMS API Provider', 'main_lang.php'),
(1017, 'english', 'download_chikitsa', 'Downloading Latest poliklinik zip...<br/> ', 'main_lang.php'),
(1018, 'english', 'unzip_file', 'Unzipping the zip file. <br/>', 'main_lang.php'),
(1019, 'english', 'no_services', 'No Services added. Add a Service.', 'main_lang.php'),
(1020, 'english', 'extension_requires', 'This extension requires %1 %2', 'main_lang.php'),
(1021, 'english', 'compatible_version', 'Compatible with this version of %1', 'main_lang.php'),
(1022, 'english', 'please_enter_first_name', 'Please Enter First Name', 'main_lang.php'),
(1023, 'english', 'please_enter_last_name', 'Please Enter Last Name', 'main_lang.php'),
(1024, 'english', 'please_enter_mobile_number', 'Please Enter Mobile Number', 'main_lang.php'),
(1025, 'english', 'please_enter_language_name', 'Please Enter Language Name', 'main_lang.php'),
(1026, 'english', 'australian_currency', 'Australian Dollar (AUD)', 'main_lang.php'),
(1027, 'english', 'brazilian_currency', 'Brazilian Real (BRL)', 'main_lang.php'),
(1028, 'english', 'canadian_currency', 'Dolar Kanada (CAD)', 'main_lang.php'),
(1029, 'english', 'czech_currency', 'Czech Koruna (CZK)', 'main_lang.php'),
(1030, 'english', 'danish_currency', 'Danish Krone (DKK)', 'main_lang.php'),
(1031, 'english', 'israeli_currency', 'Israeli New Sheqel (ILS)', 'main_lang.php'),
(1032, 'english', 'euro_currency', 'Euro (EUR)', 'main_lang.php'),
(1033, 'english', 'hungarian_currency', 'Hungarian Forint (HUF)', 'main_lang.php'),
(1034, 'english', 'hong_kong_currency', 'Hong Kong Dollar (HKD)', 'main_lang.php'),
(1035, 'english', 'japanese_currency', 'Japanese Yen (JPY)', 'main_lang.php'),
(1036, 'english', 'malaysian_currency', 'Malaysian Ringgit (MYR)', 'main_lang.php'),
(1037, 'english', 'mexican_currency', 'Mexican Peso (MXN)', 'main_lang.php'),
(1038, 'english', 'norwegian_currency', 'Norwegian Krone (NOK)', 'main_lang.php'),
(1039, 'english', 'new_zealand_currency', 'New Zealand Dollar (NZD)', 'main_lang.php'),
(1040, 'english', 'philippine_currency', 'Philippine Peso (PHP)', 'main_lang.php'),
(1041, 'english', 'polish_currency', 'Polish Zloty (PLN)', 'main_lang.php'),
(1042, 'english', 'pound_currency', 'Pound Sterling (GBP)', 'main_lang.php'),
(1043, 'english', 'singapore_currency', 'Singapore Dollar (SGD)', 'main_lang.php'),
(1044, 'english', 'swiss_currency', 'Swiss Franc (CHF)', 'main_lang.php'),
(1045, 'english', 'swedish_currency', 'Swedish Krona (SEK)', 'main_lang.php'),
(1046, 'english', 'taiwan_currency', 'Taiwan New Dollar (TWD)', 'main_lang.php'),
(1047, 'english', 'uae_currency', 'UAE Dirham (AED)', 'main_lang.php'),
(1048, 'english', 'us_currency', 'U.S. Dollar (USD)', 'main_lang.php'),
(1049, 'english', 'thai_currency', 'Thai Baht (THB)', 'main_lang.php'),
(1050, 'english', 'bangladesh_currency', 'Bangladesh Taka (BDT)', 'main_lang.php'),
(1051, 'english', 'bahraini_currency', 'Bahraini Dinar (BHD)', 'main_lang.php'),
(1052, 'english', 'chinese_currency', 'Chinese Yuan Renminbi (CNY)', 'main_lang.php'),
(1053, 'english', 'indian_currency', 'Indian Rupee (INR)', 'main_lang.php'),
(1054, 'english', 'kenyan_currency', 'Kenyan Shilling (KES)', 'main_lang.php'),
(1055, 'english', 'kuwaiti_currency', 'Kuwaiti Dinar (KWD)', 'main_lang.php'),
(1056, 'english', 'mauritius_currency', 'Mauritius Rupee (MUR)', 'main_lang.php'),
(1057, 'english', 'sri_lankan_currency', 'Sri Lankan Rupee (LKR)', 'main_lang.php'),
(1058, 'english', 'omani_currency', 'Omani Rial (OMR)', 'main_lang.php'),
(1059, 'english', 'qatari_currency', 'Qatari Riyal (QAR)', 'main_lang.php'),
(1060, 'english', 'nepalese_currency', 'Nepalese Rupee (NPR)', 'main_lang.php'),
(1061, 'english', 'saudi_currency', 'Saudi Riyal (SAR)', 'main_lang.php'),
(1062, 'english', 'grace_hours', 'Grace Hours', 'main_lang.php'),
(1063, 'english', 'south_african_currency', 'South African Rand (ZAR)', 'main_lang.php'),
(1064, 'english', 'base_charge', 'Biaya Dasar untuk jam minimum', 'main_lang.php'),
(1065, 'english', 'minimum_hours_for_admission', 'Minimum Waktu Pendaftaran', 'main_lang.php'),
(1066, 'english', 'enable_patient_account', 'Enable Akun Pasien', 'main_lang.php'),
(1067, 'english', 'patient_account_msg', '(You will be able to take more payment than invoice amount. The additional payment will be maintained in Patient Account. This amount can be used to adjust the bill next time)', 'main_lang.php'),
(1068, 'english', 'favicon', 'favicon', 'main_lang.php'),
(1069, 'english', 'preferred_size_icon', 'Favicon Preferred size 16X16', 'main_lang.php'),
(1070, 'english', 'all_items', 'Semua barang', 'main_lang.php'),
(1071, 'english', 'all_purchase', 'Semua Pembelian', 'main_lang.php'),
(1072, 'english', 'stock_reports', 'Stock Report', 'main_lang.php'),
(1073, 'english', 'content_section', 'Bagian Konten', 'main_lang.php');

-- --------------------------------------------------------

--
-- Table structure for table `pid_language_master`
--

CREATE TABLE `pid_language_master` (
  `language_id` int(11) NOT NULL,
  `language_name` varchar(25) NOT NULL,
  `is_rtl` int(1) NOT NULL DEFAULT 0,
  `is_default` int(1) NOT NULL DEFAULT 0,
  `is_loaded` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_language_master`
--

INSERT INTO `pid_language_master` (`language_id`, `language_name`, `is_rtl`, `is_default`, `is_loaded`) VALUES
(1, 'english', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pid_menu_access`
--

CREATE TABLE `pid_menu_access` (
  `id` int(11) NOT NULL,
  `menu_name` varchar(50) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `allow` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_menu_access`
--

INSERT INTO `pid_menu_access` (`id`, `menu_name`, `category_name`, `allow`) VALUES
(1, 'administration', 'System Administrator', 1),
(2, 'all_patients', 'System Administrator', 1),
(3, 'all_users', 'System Administrator', 1),
(4, 'appointments', 'System Administrator', 1),
(5, 'appointment_report', 'System Administrator', 1),
(6, 'backup', 'System Administrator', 1),
(7, 'bank_payment', 'System Administrator', 1),
(8, 'bill', 'System Administrator', 1),
(9, 'bill_report', 'System Administrator', 1),
(10, 'cash_receipt', 'System Administrator', 1),
(11, 'clinic detail', 'System Administrator', 1),
(12, 'general_settings', 'System Administrator', 1),
(13, 'issue_refund', 'System Administrator', 1),
(14, 'modules', 'System Administrator', 1),
(15, 'new_inquiry', 'System Administrator', 1),
(16, 'new_patient', 'System Administrator', 1),
(17, 'patients', 'System Administrator', 1),
(18, 'patient_report', 'System Administrator', 1),
(19, 'payment', 'System Administrator', 1),
(20, 'payments', 'System Administrator', 1),
(21, 'payment_methods', 'System Administrator', 1),
(22, 'pending_payments', 'System Administrator', 1),
(23, 'reference_by', 'System Administrator', 1),
(24, 'reports', 'System Administrator', 1),
(25, 'setting', 'System Administrator', 1),
(26, 'tax_rates', 'System Administrator', 1),
(27, 'tax_report', 'System Administrator', 1),
(28, 'users', 'System Administrator', 1),
(29, 'working_days', 'System Administrator', 1),
(32, 'administration', 'Administrator', 1),
(33, 'all_patients', 'Administrator', 1),
(34, 'all_users', 'Administrator', 1),
(35, 'appointments', 'Administrator', 1),
(36, 'appointment_report', 'Administrator', 1),
(37, 'backup', 'Administrator', 1),
(38, 'bank_payment', 'Administrator', 1),
(39, 'bill', 'Administrator', 1),
(40, 'bill_report', 'Administrator', 1),
(41, 'cash_receipt', 'Administrator', 1),
(42, 'clinic detail', 'Administrator', 1),
(43, 'general_settings', 'Administrator', 1),
(44, 'issue_refund', 'Administrator', 1),
(45, 'modules', 'Administrator', 1),
(46, 'new_inquiry', 'Administrator', 1),
(47, 'new_patient', 'Administrator', 1),
(48, 'patients', 'Administrator', 1),
(49, 'patient_report', 'Administrator', 1),
(50, 'payment', 'Administrator', 1),
(51, 'payments', 'Administrator', 1),
(52, 'payment_methods', 'Administrator', 1),
(53, 'pending_payments', 'Administrator', 1),
(54, 'reference_by', 'Administrator', 1),
(55, 'reports', 'Administrator', 1),
(56, 'setting', 'Administrator', 1),
(57, 'tax_rates', 'Administrator', 1),
(58, 'tax_report', 'Administrator', 1),
(59, 'users', 'Administrator', 1),
(60, 'working_days', 'Administrator', 1),
(63, 'patient_report', 'Doctor', 1),
(64, 'appointment_report', 'Doctor', 1),
(65, 'bill_report', 'Doctor', 1),
(66, 'tax_report', 'Doctor', 1),
(67, 'new_patient', 'Doctor', 1),
(68, 'payment', 'Doctor', 1),
(69, 'payments', 'Doctor', 1),
(70, 'bill', 'Doctor', 1),
(71, 'issue_refund', 'Doctor', 1),
(72, 'appointment report', 'Doctor', 1),
(73, 'reports', 'Doctor', 1),
(74, 'appointments', 'Doctor', 1),
(75, 'new_inquiry', 'Doctor', 1),
(76, 'all_patients', 'Doctor', 1),
(77, 'patients', 'Doctor', 1),
(78, 'bill report', 'Doctor', 1),
(79, 'pending_payments', 'Doctor', 1),
(80, 'patient_report', 'Nurse', 1),
(81, 'appointment_report', 'Nurse', 1),
(82, 'bill_report', 'Nurse', 1),
(83, 'tax_report', 'Nurse', 1),
(84, 'new_patient', 'Nurse', 1),
(85, 'payment', 'Nurse', 1),
(86, 'payments', 'Nurse', 1),
(87, 'bill', 'Nurse', 1),
(88, 'issue_refund', 'Nurse', 1),
(89, 'patients', 'Nurse', 1),
(90, 'all_patients', 'Nurse', 1),
(91, 'new_inquiry', 'Nurse', 1),
(92, 'appointments', 'Nurse', 1),
(93, 'appointment report', 'Nurse', 1),
(94, 'reports', 'Nurse', 1),
(95, 'new_patient', 'Receptionist', 1),
(96, 'payment', 'Receptionist', 1),
(97, 'payments', 'Receptionist', 1),
(98, 'bill', 'Receptionist', 1),
(99, 'issue_refund', 'Receptionist', 1),
(100, 'pending_payments', 'Receptionist', 1),
(101, 'appointments', 'Receptionist', 1),
(102, 'new_inquiry', 'Receptionist', 1),
(103, 'all_patients', 'Receptionist', 1),
(104, 'patients', 'Receptionist', 1),
(105, 'language', 'System Administrator', 1),
(106, 'visit_report', 'Doctor', 1),
(107, 'visit_report', 'System Administrator', 1),
(108, 'visit_report', 'Nurse', 1),
(109, 'visit_report', 'Administrator', 1),
(110, 'visit_report', 'Receptionist', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pid_modules`
--

CREATE TABLE `pid_modules` (
  `module_id` int(11) NOT NULL,
  `module_name` varchar(50) NOT NULL,
  `module_display_name` varchar(50) NOT NULL,
  `module_description` varchar(150) NOT NULL,
  `module_status` int(1) NOT NULL,
  `module_version` varchar(10) DEFAULT NULL,
  `activation_hook` varchar(50) DEFAULT NULL,
  `license_key` varchar(100) DEFAULT NULL,
  `license_status` varchar(100) DEFAULT NULL,
  `required_modules` varchar(250) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `valid_till` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_navigation_menu`
--

CREATE TABLE `pid_navigation_menu` (
  `id` int(11) NOT NULL,
  `menu_name` varchar(250) DEFAULT NULL,
  `parent_name` varchar(250) NOT NULL,
  `menu_order` int(11) NOT NULL,
  `menu_url` varchar(500) DEFAULT NULL,
  `menu_icon` varchar(100) DEFAULT NULL,
  `menu_text` varchar(200) DEFAULT NULL,
  `required_module` varchar(25) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_navigation_menu`
--

INSERT INTO `pid_navigation_menu` (`id`, `menu_name`, `parent_name`, `menu_order`, `menu_url`, `menu_icon`, `menu_text`, `required_module`, `is_deleted`, `sync_status`) VALUES
(1, 'cash_receipt', 'account', 500, 'account/cash_receipt', NULL, 'cash_receipt', NULL, NULL, NULL),
(2, 'bank_payment', 'account', 200, 'account/bank_payment', NULL, 'bank_payment', NULL, NULL, NULL),
(3, 'general_settings', 'frontend', 400, 'frontend/general_settings', NULL, 'general_settings', 'frontend', NULL, NULL),
(4, 'reference_by', 'administration', 750, 'settings/reference_by', NULL, 'reference_by', NULL, NULL, NULL),
(5, 'backup', 'administration', 600, 'settings/backup', NULL, 'backup', NULL, NULL, NULL),
(6, 'new_patient', 'patients', 100, 'patient/insert', NULL, 'add_patient', NULL, NULL, NULL),
(7, 'working_days', 'administration', 200, 'settings/working_days', NULL, 'working_days', NULL, NULL, NULL),
(8, 'all_users', 'users', 100, 'admin/users', NULL, 'all_users', NULL, NULL, NULL),
(9, 'patients', '', 200, '#', 'fa-users', 'patients', '', NULL, NULL),
(10, 'all_patients', 'patients', 0, 'patient/index', NULL, 'all_patients', NULL, NULL, NULL),
(11, 'new_inquiry', 'patients', 200, 'patient/new_inquiry_report', NULL, 'new_inquiry', NULL, NULL, NULL),
(12, 'appointments', '', 100, 'appointment/index', 'fa-calendar', 'appointments', '', NULL, NULL),
(13, 'reports', '', 400, '#', 'fa-line-chart', 'reports', '', NULL, NULL),
(14, 'administration', '', 500, '#', 'fa-cog', 'administration', '', NULL, NULL),
(15, 'modules', '', 600, 'module/index', 'fa-shopping-cart', 'modules', '', NULL, NULL),
(16, 'appointment_report', 'reports', 100, 'appointment/appointment_report', '', 'appointment_report', '', NULL, NULL),
(17, 'bill_report', 'reports', 300, 'patient/bill_detail_report', '', 'bill_report', '', NULL, NULL),
(18, 'clinic detail', 'administration', 100, 'settings/clinic', '', 'clinic_details', '', NULL, NULL),
(19, 'users', 'administration', 300, '#', '', 'users', '', NULL, NULL),
(20, 'setting', 'administration', 500, 'settings/change_settings', '', 'setting', '', NULL, NULL),
(21, 'payment', '', 300, '#', 'fa-money', 'bills_payments', '', NULL, NULL),
(22, 'pending_payments', 'administration', 400, '/payment/pending_payments', '', 'pending_payments', '', NULL, NULL),
(23, 'patient_report', 'reports', 90, 'patient/patient_report', NULL, 'patient_report', NULL, NULL, NULL),
(24, 'issue_refund', 'payment', 300, 'payment/issue_refund', NULL, 'issue_refund', NULL, NULL, NULL),
(25, 'bill', 'payment', 100, 'bill/index', NULL, 'bills', NULL, NULL, NULL),
(26, 'payments', 'payment', 200, 'payment/index', NULL, 'payments', NULL, NULL, NULL),
(27, 'payment_methods', 'administration', 650, 'payment/payment_methods', NULL, 'payment_methods', NULL, NULL, NULL),
(28, 'tax_rates', 'administration', 700, 'settings/tax_rates', NULL, 'tax_rates', NULL, NULL, NULL),
(29, 'tax_report', 'reports', 600, 'bill/tax_report', NULL, 'tax_report', NULL, NULL, NULL),
(30, 'language', 'administration', 500, 'settings/language', NULL, 'language', NULL, NULL, NULL),
(31, 'visit_report', 'reports', 250, 'patient/visit_report', NULL, 'visit_report', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pid_nurse`
--

CREATE TABLE `pid_nurse` (
  `nurse_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `joining_date` date NOT NULL,
  `department_id` varchar(25) NOT NULL,
  `userid` varchar(16) NOT NULL,
  `is_deleted` int(11) NOT NULL,
  `sync_status` int(11) NOT NULL,
  `gender` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_patient`
--

CREATE TABLE `pid_patient` (
  `patient_id` int(11) NOT NULL,
  `blood_group` varchar(3) DEFAULT NULL,
  `reference_by_detail` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `contact_id` int(11) NOT NULL,
  `patient_since` date NOT NULL,
  `display_id` varchar(12) DEFAULT NULL,
  `ssn_id` varchar(25) DEFAULT NULL,
  `followup_date` date DEFAULT NULL,
  `reference_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `gender` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `wp_user_id` int(11) DEFAULT NULL,
  `clinic_id` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL,
  `is_inquiry` int(1) DEFAULT NULL,
  `inquiry_reason` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `erpnext_key` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_patient_account`
--

CREATE TABLE `pid_patient_account` (
  `patient_account_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `adjust_amount` decimal(11,2) NOT NULL,
  `refund_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_payment`
--

CREATE TABLE `pid_payment` (
  `payment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `pay_date` date NOT NULL,
  `pay_mode` varchar(50) NOT NULL,
  `pay_amount` decimal(10,0) NOT NULL DEFAULT 0,
  `additional_detail` varchar(50) DEFAULT NULL,
  `level` varchar(25) NOT NULL,
  `clinic_id` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `payment_status` varchar(25) NOT NULL DEFAULT 'complete',
  `clinic_code` varchar(6) DEFAULT NULL,
  `collected_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_payment_methods`
--

CREATE TABLE `pid_payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `payment_method_name` varchar(25) NOT NULL,
  `has_additional_details` int(1) NOT NULL,
  `additional_detail_label` varchar(50) NOT NULL,
  `needs_cash_calc` int(1) NOT NULL DEFAULT 0,
  `payment_pending` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_payment_methods`
--

INSERT INTO `pid_payment_methods` (`payment_method_id`, `payment_method_name`, `has_additional_details`, `additional_detail_label`, `needs_cash_calc`, `payment_pending`) VALUES
(1, 'Cash', 0, '', 1, NULL),
(2, 'Cheque', 1, 'Cheque Number', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pid_payment_transaction`
--

CREATE TABLE `pid_payment_transaction` (
  `transaction_id` int(11) NOT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `visit_id` int(11) NOT NULL,
  `amount` decimal(11,2) NOT NULL,
  `payment_type` varchar(50) NOT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_receipt_template`
--

CREATE TABLE `pid_receipt_template` (
  `template_id` int(11) NOT NULL,
  `template` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `is_default` int(1) NOT NULL,
  `template_name` varchar(25) NOT NULL,
  `type` varchar(15) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `is_original` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_receipt_template`
--

INSERT INTO `pid_receipt_template` (`template_id`, `template`, `is_default`, `template_name`, `type`, `is_deleted`, `sync_status`, `is_original`) VALUES
(1, '<h1 style=\"text-align: center;\">[clinic_name]</h1><h2 style=\"text-align: center;\">[tag_line]</h2><p style=\"text-align: center;\">[clinic_address]</p><p style=\"text-align: center;\"><strong style=\"line-height: 1.42857143;\">Landline : </strong><span style=\"line-height: 1.42857143;\">[landline]</span> <strong style=\"line-height: 1.42857143;\">Mobile : </strong><span style=\"line-height: 1.42857143;\">[mobile]</span> <strong style=\"line-height: 1.42857143;\">Email : </strong><span style=\"text-align: center;\"> [email]</span></p><hr id=\"null\" /><h3 style=\"text-align: center;\"><u style=\"text-align: center;\">RECEIPT</u></h3><p><span style=\"text-align: left;\"><strong>Date : </strong>[bill_date] [bill_time]</span><span style=\"float: right;\"><strong>Receipt Number :</strong> [bill_id]</span></p><p style=\"text-align: left;\"><strong style=\"text-align: left;\">Patient Name: </strong><span style=\"text-align: left;\">[patient_name]<br /></span></p><hr id=\"null\" style=\"text-align: left;\" /><p>Received fees for Professional services and other charges of our:</p><p>&nbsp;</p><p>&nbsp;</p><table style=\"width: 100%; margin-top: 25px; margin-bottom: 25px; border-collapse: collapse; border: 1px solid black;\"><thead><tr><td style=\"width: 400px; text-align: left; padding: 5px; border: 1px solid black;\"><strong style=\"width: 400px; text-align: left;\">Item</strong></td><td style=\"padding: 5px; border: 1px solid black;\"><strong>Quantity</strong></td><td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>M.R.P.</strong></td><td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>Amount</strong></td></tr></thead><tbody><tr><td colspan=\"4\">[col:particular|quantity|mrp|amount]</td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Discount</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[discount]</strong></td></tr><tr><td>[tax_details]</td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Total</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[total]</strong></td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Paid Amount</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\">[paid_amount]</td></tr></tbody></table><p>Received with Thanks,</p><p>For [clinic_name]</p><p>&nbsp;</p><p>&nbsp;</p><p>Signature</p>', 0, 'Main', 'bill', NULL, NULL, 1),
(2, '<h1 style=\"text-align: center;\">[clinic_name]</h1><h2 style=\"text-align: center;\">[tag_line]</h2><p style=\"text-align: center;\">[clinic_address]</p><p style=\"text-align: center;\"><strong style=\"line-height: 1.42857143;\">Landline : </strong><span style=\"line-height: 1.42857143;\">[landline]</span> <strong style=\"line-height: 1.42857143;\">Mobile : </strong><span style=\"line-height: 1.42857143;\">[mobile]</span> <strong style=\"line-height: 1.42857143;\">Email : </strong><span style=\"text-align: center;\"> [email]</span></p><hr id=\"null\" /><h3 style=\"text-align: center;\"><u style=\"text-align: center;\">RECEIPT</u></h3><p><span style=\"text-align: left;\"><strong>Date : </strong>[bill_date] [bill_time]</span><span style=\"float: right;\"><strong>Receipt Number :</strong> [bill_id]</span></p><p style=\"text-align: left;\"><strong style=\"text-align: left;\">Patient Name: </strong><span style=\"text-align: left;\">[patient_name]<br /></span></p><hr id=\"null\" style=\"text-align: left;\" /><p>Received fees for Professional services and other charges of our:</p><p>&nbsp;</p><p>&nbsp;</p><table style=\"width: 100%; margin-top: 25px; margin-bottom: 25px; border-collapse: collapse; border: 1px solid black;\"><thead><tr><td style=\"width: 400px; text-align: left; padding: 5px; border: 1px solid black;\"><strong style=\"width: 400px; text-align: left;\">Item</strong></td><td style=\"padding: 5px; border: 1px solid black;\"><strong>Quantity</strong></td><td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>M.R.P.</strong></td><td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>Amount</strong></td>[tax_column_header]</tr></thead><tbody><tr><td colspan=\"4\">[col:particular|quantity|mrp|amount|tax_amount]</td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Discount</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[discount]</strong></td></tr><tr><td>[tax_details]</td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Total</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[total]</strong></td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Paid Amount</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\">[paid_amount]</td></tr></tbody></table><p>Received with Thanks,</p><p>For [clinic_name]</p><p>&nbsp;</p><p>&nbsp;</p><p>Signature</p>', 0, 'Main with Tax', 'bill', NULL, NULL, 1),
(3, '<h1 style=\"text-align: center;\">[clinic_name]</h1><h2 style=\"text-align: center;\">[tag_line]</h2><p style=\"text-align: center;\">[clinic_address]</p><p style=\"text-align: center;\"><strong style=\"line-height: 1.42857143;\">Landline : </strong><span style=\"line-height: 1.42857143;\">[landline]</span> <strong style=\"line-height: 1.42857143;\">Mobile : </strong><span style=\"line-height: 1.42857143;\">[mobile]</span> <strong style=\"line-height: 1.42857143;\">Email : </strong><span style=\"text-align: center;\"> [email]</span></p><hr id=\"null\" /><h3 style=\"text-align: center;\"><u style=\"text-align: center;\">RECEIPT</u></h3><p><span style=\"text-align: left;\"><strong>Date : </strong>[bill_date] [bill_time]</span><span style=\"float: right;\"><strong>Receipt Number :</strong> [bill_id]</span></p><p style=\"text-align: left;\"><strong style=\"text-align: left;\">Patient Name: </strong><span style=\"text-align: left;\">[patient_name]<br /></span></p><hr id=\"null\" style=\"text-align: left;\" /><p>Received fees for Professional services and other charges of our:</p><p>&nbsp;</p><p>&nbsp;</p><table style=\"width: 100%; margin-top: 25px; margin-bottom: 25px; border-collapse: collapse; border: 1px solid black;\"><thead><tr><td style=\"width: 400px; text-align: left; padding: 5px; border: 1px solid black;\"><strong style=\"width: 400px; text-align: left;\">Item</strong></td><td style=\"padding: 5px; border: 1px solid black;\"><strong>Quantity</strong></td><td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>M.R.P.</strong></td><td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>Amount</strong></td>[tax_column_header]</tr></thead><tbody><tr><td colspan=\"4\">[col:particular|quantity|mrp|amount|tax_amount]</td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Discount</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[discount]</strong></td></tr><tr><td>[tax_details]</td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Total</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[total]</strong></td></tr><tr><td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Paid Amount</td><td style=\"text-align: right; padding: 5px; border: 1px solid black;\">[paid_amount]</td></tr></tbody></table><p>Received with Thanks,</p><p>For [clinic_name]</p><p>&nbsp;</p><p>&nbsp;</p><p>Signature</p>', 0, 'Main with Tax', 'bill', NULL, NULL, 1),
(4, '<h1 style=\"text-align: center;\">[clinic_name]</h1>\r\n<h2 style=\"text-align: center;\">[tag_line]</h2>\r\n<p style=\"text-align: center;\">[clinic_address]</p>\r\n<p style=\"text-align: center;\"><strong style=\"line-height: 1.42857143;\">Landline : </strong><span style=\"line-height: 1.42857143;\">[landline]</span> <strong style=\"line-height: 1.42857143;\">Mobile : </strong><span style=\"line-height: 1.42857143;\">[mobile]</span> <strong style=\"line-height: 1.42857143;\">Email : </strong><span style=\"text-align: center;\"> [email]</span></p>\r\n<hr id=\"null\" />\r\n<h3 style=\"text-align: center;\"><u style=\"text-align: center;\">RECEIPT</u></h3>\r\n<p><span style=\"text-align: left;\"><strong>Date : </strong>[bill_date] [bill_time]</span><span style=\"float: right;\"><strong>Receipt Number :</strong> [bill_id]</span></p>\r\n<p><span style=\"float: right;\"><strong>Created By :</strong> [created_by]</span></p>\r\n<p style=\"text-align: left;\"><strong style=\"text-align: left;\">Patient Name: </strong><span style=\"text-align: left;\">[patient_name]<br /></span></p>\r\n<hr id=\"null\" style=\"text-align: left;\" />\r\n<p>Received fees for Professional services and other charges of our:</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>[tax_column_header]</p>\r\n<table style=\"width: 100%; margin-top: 25px; margin-bottom: 25px; border-collapse: collapse; border: 1px solid black;\">\r\n<thead>\r\n<tr>\r\n<td style=\"width: 400px; text-align: left; padding: 5px; border: 1px solid black;\"><strong style=\"width: 400px; text-align: left;\">Item</strong></td>\r\n<td style=\"padding: 5px; border: 1px solid black;\"><strong>Quantity</strong></td>\r\n<td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>M.R.P.</strong></td>\r\n<td style=\"width: 100px; text-align: right; padding: 5px; border: 1px solid black;\"><strong>Amount</strong></td>\r\n</tr>\r\n</thead>\r\n<tbody>\r\n<tr>\r\n<td colspan=\"4\">[col:particular|quantity|mrp|amount|tax_amount]</td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px; border: 1px solid black; width: 141.811%;\" colspan=\"3\">Vat Tax</td>\r\n<td style=\"text-align: right; padding: 5px; border: 1px solid black; width: 10%;\"><strong>[vat_tax]</strong></td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\">Discount</td>\r\n<td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[discount]</strong></td>\r\n</tr>\r\n<tr>\r\n<td>[tax_details]</td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\"><strong style=\"width: 400px; text-align: left;\">Total</strong></td>\r\n<td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[total]</strong></td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px; border: 1px solid black;\" colspan=\"2\"><strong style=\"width: 400px; text-align: left;\">Payment Method</strong></td>\r\n<td style=\"padding: 5px; border: 1px solid black;\"><strong style=\"width: 400px; text-align: left;\">Collected By</strong></td>\r\n<td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong style=\"width: 400px; text-align: left;\">Amount</strong></td>\r\n</tr>\r\n<tr>\r\n<td colspan=\"4\">[paycol:payment_mode|collected_by|payment_amount]</td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\"><strong style=\"width: 400px; text-align: left;\">Paid Amount</strong></td>\r\n<td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[paid_amount]</strong></td>\r\n</tr>\r\n<tr>\r\n<td style=\"padding: 5px; border: 1px solid black;\" colspan=\"3\"><strong style=\"width: 400px; text-align: left;\">Due Amount</strong></td>\r\n<td style=\"text-align: right; padding: 5px; border: 1px solid black;\"><strong>[due_amount]</strong></td>\r\n</tr>\r\n\r\n</tbody>\r\n</table>\r\n<p>Received with Thanks,</p>\r\n<p>For [clinic_name]</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>Signature</p>', 0, 'Main with Payment', 'bill', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pid_reference_by`
--

CREATE TABLE `pid_reference_by` (
  `reference_id` int(11) NOT NULL,
  `reference_option` varchar(25) NOT NULL,
  `reference_add_option` int(1) DEFAULT NULL,
  `placeholder` varchar(25) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_refund`
--

CREATE TABLE `pid_refund` (
  `refund_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `refund_amount` int(12) NOT NULL,
  `refund_date` date NOT NULL,
  `refund_note` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_tax_rates`
--

CREATE TABLE `pid_tax_rates` (
  `tax_id` int(11) NOT NULL,
  `tax_rate_name` varchar(25) NOT NULL,
  `tax_rate` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_tax_rates`
--

INSERT INTO `pid_tax_rates` (`tax_id`, `tax_rate_name`, `tax_rate`) VALUES
(1, 'No Tax', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `pid_todos`
--

CREATE TABLE `pid_todos` (
  `id_num` int(11) NOT NULL,
  `userid` int(11) DEFAULT 0,
  `todo` varchar(250) DEFAULT NULL,
  `done` int(11) DEFAULT 0,
  `add_date` datetime DEFAULT NULL,
  `done_date` datetime DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_users`
--

CREATE TABLE `pid_users` (
  `userid` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(25) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `level` varchar(25) NOT NULL,
  `is_active` int(1) NOT NULL DEFAULT 1,
  `contact_id` int(11) DEFAULT NULL,
  `centers` varchar(50) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `prefered_language` varchar(25) DEFAULT NULL,
  `profile_image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_users`
--

INSERT INTO `pid_users` (`userid`, `name`, `username`, `password`, `level`, `is_active`, `contact_id`, `centers`, `is_deleted`, `sync_status`, `prefered_language`, `profile_image`) VALUES
(1, 'System Administrator', 'admin', 'YWRtaW4xMjM=', 'System Administrator', 1, NULL, NULL, NULL, NULL, 'english', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pid_user_categories`
--

CREATE TABLE `pid_user_categories` (
  `id` int(11) NOT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pid_user_categories`
--

INSERT INTO `pid_user_categories` (`id`, `category_name`, `is_deleted`, `sync_status`) VALUES
(1, 'System Administrator', NULL, NULL),
(2, 'Administrator', NULL, NULL),
(3, 'Doctor', NULL, NULL),
(4, 'Nurse', NULL, NULL),
(5, 'Receptionist', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pid_user_verification`
--

CREATE TABLE `pid_user_verification` (
  `verification_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `verification_code` int(6) NOT NULL,
  `code_generated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `code_is_verified` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_version`
--

CREATE TABLE `pid_version` (
  `id` int(11) NOT NULL,
  `current_version` varchar(11) NOT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_bill`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_bill` (
`bill_id` int(11)
,`bill_date` date
,`doctor_name` varchar(158)
,`doctor_id` int(11)
,`patient_id` int(11)
,`display_id` varchar(12)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`total_amount` decimal(10,2)
,`due_amount` decimal(11,2)
,`item_tax_amount` decimal(32,2)
,`pay_amount` decimal(33,0)
,`bill_tax_amount` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_bill_detail_report`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_bill_detail_report` (
`bill_id` int(11)
,`bill_date` date
,`visit_id` int(11)
,`particular` varchar(50)
,`amount` decimal(10,2)
,`tax_amount` decimal(10,2)
,`userid` int(11)
,`patient_name` varchar(152)
,`display_id` varchar(12)
,`type` varchar(25)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_bill_payment_r`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_bill_payment_r` (
`pay_date` date
,`bill_id` int(11)
,`adjust_amount` decimal(11,0)
,`payment_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_bill_tax_report`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_bill_tax_report` (
`display_id` varchar(12)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`bill_id` int(11)
,`bill_date` date
,`total_amount` decimal(10,2)
,`tax_amount` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_contact_email`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_contact_email` (
`contact_id` int(11)
,`email` varchar(150)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_doctor`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_doctor` (
`name` varchar(158)
,`centers` varchar(50)
,`is_active` int(1)
,`title` varchar(5)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`doctor_id` int(11)
,`userid` varchar(16)
,`is_deleted` int(11)
,`degree` varchar(150)
,`specification` varchar(300)
,`experience` varchar(300)
,`joining_date` date
,`licence_number` varchar(50)
,`department_id` int(11)
,`gender` varchar(10)
,`description` varchar(250)
,`dob` date
,`contact_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_email`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_email` (
`contact_id` int(11)
,`emails` mediumtext
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_patient`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_patient` (
`ssn_id` varchar(25)
,`is_inquiry` int(1)
,`inquiry_reason` varchar(50)
,`sync_status` int(11)
,`is_deleted` int(11)
,`erpnext_key` varchar(25)
,`patient_id` int(11)
,`clinic_id` int(11)
,`blood_group` varchar(3)
,`clinic_code` varchar(6)
,`patient_since` date
,`age` int(11)
,`display_id` varchar(12)
,`gender` varchar(50)
,`dob` date
,`reference_by` varchar(50)
,`reference_by_detail` varchar(50)
,`followup_date` date
,`in_account_amount` decimal(34,2)
,`display_name` varchar(255)
,`contact_id` int(11)
,`title` varchar(5)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`patient_name` varchar(158)
,`phone_number` varchar(150)
,`email` varchar(150)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_payment`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_payment` (
`payment_id` int(11)
,`clinic_id` int(11)
,`pay_date` date
,`pay_mode` varchar(50)
,`payment_status` varchar(25)
,`additional_detail` varchar(50)
,`pay_amount` decimal(10,0)
,`patient_id` int(11)
,`display_id` varchar(12)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_report`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_report` (
`appointment_id` int(11)
,`patient_id` int(11)
,`clinic_code` varchar(6)
,`patient_name` varchar(152)
,`doctor_id` int(11)
,`clinic_id` int(11)
,`status` varchar(255)
,`clinic_name` varchar(50)
,`doctor_name` varchar(152)
,`appointment_date` date
,`appointment_time` time
,`waiting_in` time
,`waiting_duration` int(9)
,`consultation_in` time
,`consultation_out` time
,`consultation_duration` int(9)
,`waiting_out` time
,`collection_amount` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_tax_report`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_tax_report` (
`display_id` varchar(12)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`bill_id` int(11)
,`bill_date` date
,`taxable_amount` decimal(32,2)
,`non_taxable_amount` decimal(32,2)
,`discount` decimal(32,2)
,`item_tax_amount` decimal(10,2)
,`total_amount` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_visit`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_visit` (
`visit_id` int(11)
,`visit_date` varchar(60)
,`visit_time` varchar(50)
,`appointment_reason` varchar(100)
,`type` varchar(50)
,`notes` text
,`patient_notes` text
,`doctor_id` int(11)
,`name` varchar(158)
,`patient_id` int(11)
,`reference_by` varchar(50)
,`reference_by_detail` varchar(50)
,`bill_id` int(11)
,`total_amount` decimal(10,2)
,`bill_tax_amount` decimal(32,2)
,`item_tax_amount` decimal(32,2)
,`due_amount` decimal(11,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pid_view_visit_treatments`
-- (See below for the actual view)
--
CREATE TABLE `pid_view_visit_treatments` (
`visit_id` int(11)
,`particular` varchar(50)
,`type` varchar(25)
);

-- --------------------------------------------------------

--
-- Table structure for table `pid_visit`
--

CREATE TABLE `pid_visit` (
  `visit_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `visit_date` varchar(60) NOT NULL,
  `clinic_id` int(1) DEFAULT NULL,
  `visit_time` varchar(50) DEFAULT NULL,
  `patient_notes` text DEFAULT NULL,
  `appointment_reason` varchar(100) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `clinic_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pid_working_days`
--

CREATE TABLE `pid_working_days` (
  `uid` int(11) NOT NULL,
  `working_date` date NOT NULL,
  `working_status` varchar(15) NOT NULL,
  `working_reason` varchar(50) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `sync_status` int(11) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_bill`
--
DROP TABLE IF EXISTS `pid_view_bill`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_bill`  AS SELECT `bill`.`bill_id` AS `bill_id`, `bill`.`bill_date` AS `bill_date`, `doctor`.`name` AS `doctor_name`, ifnull(`visit`.`doctor_id`,`bill`.`doctor_id`) AS `doctor_id`, `patient`.`patient_id` AS `patient_id`, `patient`.`display_id` AS `display_id`, `contacts`.`first_name` AS `first_name`, `contacts`.`middle_name` AS `middle_name`, `contacts`.`last_name` AS `last_name`, `bill`.`total_amount` AS `total_amount`, `bill`.`due_amount` AS `due_amount`, (select ifnull(sum(`bill_detail`.`tax_amount`),0) from `pid_bill_detail` `bill_detail` where `bill_detail`.`bill_id` = `bill`.`bill_id`) AS `item_tax_amount`, sum(if(`payment`.`payment_status` <> 'rejected',`bill_payment_r`.`adjust_amount`,0)) AS `pay_amount`, (select `view_visit`.`bill_tax_amount` from `pid_view_visit` `view_visit` where `bill`.`visit_id` = `view_visit`.`visit_id`) AS `bill_tax_amount` FROM ((((((`pid_bill` `bill` left join `pid_patient` `patient` on(`bill`.`patient_id` = `patient`.`patient_id`)) left join `pid_contacts` `contacts` on(`contacts`.`contact_id` = `patient`.`contact_id`)) left join `pid_visit` `visit` on(`bill`.`visit_id` = `visit`.`visit_id`)) left join `pid_bill_payment_r` `bill_payment_r` on(`bill`.`bill_id` = `bill_payment_r`.`bill_id`)) left join `pid_payment` `payment` on(`payment`.`payment_id` = `bill_payment_r`.`payment_id`)) left join `pid_view_doctor` `doctor` on(ifnull(`visit`.`doctor_id`,`bill`.`doctor_id`) = `doctor`.`doctor_id`)) GROUP BY `bill`.`bill_id`, `bill`.`bill_date`, `doctor`.`name`, ifnull(`visit`.`doctor_id`,`bill`.`doctor_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_bill_detail_report`
--
DROP TABLE IF EXISTS `pid_view_bill_detail_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_bill_detail_report`  AS SELECT `bill`.`bill_id` AS `bill_id`, `bill`.`bill_date` AS `bill_date`, `bill`.`visit_id` AS `visit_id`, `bill_detail`.`particular` AS `particular`, `bill_detail`.`amount` AS `amount`, `bill_detail`.`tax_amount` AS `tax_amount`, `visit`.`userid` AS `userid`, concat(`view_patient`.`first_name`,' ',`view_patient`.`middle_name`,' ',`view_patient`.`last_name`) AS `patient_name`, `view_patient`.`display_id` AS `display_id`, `bill_detail`.`type` AS `type` FROM (((`pid_bill` `bill` left join `pid_bill_detail` `bill_detail` on(`bill_detail`.`bill_id` = `bill`.`bill_id`)) left join `pid_visit` `visit` on(`visit`.`visit_id` = `bill`.`visit_id`)) left join `pid_view_patient` `view_patient` on(`view_patient`.`patient_id` = `bill`.`patient_id`)) WHERE ifnull(`bill_detail`.`is_deleted`,0) <> 11  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_bill_payment_r`
--
DROP TABLE IF EXISTS `pid_view_bill_payment_r`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_bill_payment_r`  AS SELECT `payment`.`pay_date` AS `pay_date`, `bill_payment_r`.`bill_id` AS `bill_id`, `bill_payment_r`.`adjust_amount` AS `adjust_amount`, `payment`.`payment_id` AS `payment_id` FROM (`pid_payment` `payment` join `pid_bill_payment_r` `bill_payment_r` on(`bill_payment_r`.`payment_id` = `payment`.`payment_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_bill_tax_report`
--
DROP TABLE IF EXISTS `pid_view_bill_tax_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_bill_tax_report`  AS SELECT `patient`.`display_id` AS `display_id`, `patient`.`first_name` AS `first_name`, `patient`.`middle_name` AS `middle_name`, `patient`.`last_name` AS `last_name`, `bill`.`bill_id` AS `bill_id`, `bill`.`bill_date` AS `bill_date`, `bill`.`total_amount` AS `total_amount`, sum(`bill_detail`.`amount`) AS `tax_amount` FROM ((`pid_bill` `bill` join `pid_view_patient` `patient` on(`patient`.`patient_id` = `bill`.`patient_id`)) left join `pid_bill_detail` `bill_detail` on(`bill_detail`.`bill_id` = `bill`.`bill_id` and `bill_detail`.`type` = 'tax')) GROUP BY `bill`.`bill_id``bill_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_contact_email`
--
DROP TABLE IF EXISTS `pid_view_contact_email`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_contact_email`  AS SELECT `pid_contact_details`.`contact_id` AS `contact_id`, `pid_contact_details`.`detail` AS `email` FROM `pid_contact_details` WHERE `pid_contact_details`.`type` = 'email''email'  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_doctor`
--
DROP TABLE IF EXISTS `pid_view_doctor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_doctor`  AS SELECT concat(ifnull(`contacts`.`title`,''),' ',convert(ifnull(`contacts`.`first_name`,'') using utf8mb4),' ',convert(ifnull(`contacts`.`middle_name`,'') using utf8mb4),' ',convert(ifnull(`contacts`.`last_name`,'') using utf8mb4)) AS `name`, `users`.`centers` AS `centers`, `users`.`is_active` AS `is_active`, `contacts`.`title` AS `title`, `contacts`.`first_name` AS `first_name`, `contacts`.`middle_name` AS `middle_name`, `contacts`.`last_name` AS `last_name`, `doctor`.`doctor_id` AS `doctor_id`, `doctor`.`userid` AS `userid`, `users`.`is_deleted` AS `is_deleted`, `doctor`.`degree` AS `degree`, `doctor`.`specification` AS `specification`, `doctor`.`experience` AS `experience`, `doctor`.`joining_date` AS `joining_date`, `doctor`.`licence_number` AS `licence_number`, `doctor`.`department_id` AS `department_id`, `doctor`.`gender` AS `gender`, `doctor`.`description` AS `description`, `doctor`.`dob` AS `dob`, `doctor`.`contact_id` AS `contact_id` FROM ((`pid_doctor` `doctor` join `pid_contacts` `contacts` on(`contacts`.`contact_id` = `doctor`.`contact_id`)) join `pid_users` `users` on(`users`.`userid` = `doctor`.`userid`)) WHERE ifnull(`doctor`.`is_deleted`,0) <> 1 AND ifnull(`users`.`is_deleted`,0) <> 11  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_email`
--
DROP TABLE IF EXISTS `pid_view_email`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_email`  AS SELECT `pid_contact_details`.`contact_id` AS `contact_id`, group_concat(`pid_contact_details`.`detail` separator ',') AS `emails` FROM `pid_contact_details` WHERE `pid_contact_details`.`type` = 'email' GROUP BY `pid_contact_details`.`contact_id``contact_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_patient`
--
DROP TABLE IF EXISTS `pid_view_patient`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_patient`  AS SELECT `patient`.`ssn_id` AS `ssn_id`, `patient`.`is_inquiry` AS `is_inquiry`, `patient`.`inquiry_reason` AS `inquiry_reason`, `patient`.`sync_status` AS `sync_status`, `patient`.`is_deleted` AS `is_deleted`, `patient`.`erpnext_key` AS `erpnext_key`, `patient`.`patient_id` AS `patient_id`, `patient`.`clinic_id` AS `clinic_id`, `patient`.`blood_group` AS `blood_group`, `patient`.`clinic_code` AS `clinic_code`, `patient`.`patient_since` AS `patient_since`, `patient`.`age` AS `age`, `patient`.`display_id` AS `display_id`, `patient`.`gender` AS `gender`, `patient`.`dob` AS `dob`, `patient`.`reference_by` AS `reference_by`, `patient`.`reference_by_detail` AS `reference_by_detail`, `patient`.`followup_date` AS `followup_date`, (select ifnull(sum(ifnull(`patient_account`.`adjust_amount`,0)),0) from `pid_patient_account` `patient_account` where `patient_account`.`patient_id` = `patient`.`patient_id` and `patient_account`.`payment_id` is not null) - (select ifnull(sum(ifnull(`patient_account`.`adjust_amount`,0)),0) from `pid_patient_account` `patient_account` where `patient_account`.`patient_id` = `patient`.`patient_id` and `patient_account`.`bill_id` is not null) AS `in_account_amount`, `contacts`.`display_name` AS `display_name`, `contacts`.`contact_id` AS `contact_id`, `contacts`.`title` AS `title`, `contacts`.`first_name` AS `first_name`, `contacts`.`middle_name` AS `middle_name`, `contacts`.`last_name` AS `last_name`, concat(ifnull(`contacts`.`title`,''),' ',ifnull(`contacts`.`first_name`,''),' ',ifnull(`contacts`.`middle_name`,''),' ',ifnull(`contacts`.`last_name`,'')) AS `patient_name`, (select `contact_details`.`detail` from `pid_contact_details` `contact_details` where `contact_details`.`contact_id` = `contacts`.`contact_id` and `contact_details`.`type` = 'mobile' limit 1) AS `phone_number`, `contacts`.`email` AS `email` FROM (`pid_patient` `patient` left join `pid_contacts` `contacts` on(`patient`.`contact_id` = `contacts`.`contact_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_payment`
--
DROP TABLE IF EXISTS `pid_view_payment`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_payment`  AS SELECT DISTINCT `payment`.`payment_id` AS `payment_id`, `payment`.`clinic_id` AS `clinic_id`, `payment`.`pay_date` AS `pay_date`, `payment`.`pay_mode` AS `pay_mode`, `payment`.`payment_status` AS `payment_status`, `payment`.`additional_detail` AS `additional_detail`, `payment`.`pay_amount` AS `pay_amount`, `patient`.`patient_id` AS `patient_id`, `patient`.`display_id` AS `display_id`, `contacts`.`first_name` AS `first_name`, `contacts`.`middle_name` AS `middle_name`, `contacts`.`last_name` AS `last_name` FROM ((`pid_payment` `payment` join `pid_patient` `patient` on(`patient`.`patient_id` = `payment`.`patient_id`)) join `pid_contacts` `contacts` on(`contacts`.`contact_id` = `patient`.`contact_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_report`
--
DROP TABLE IF EXISTS `pid_view_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_report`  AS SELECT `appointment`.`appointment_id` AS `appointment_id`, `appointment`.`patient_id` AS `patient_id`, `appointment`.`clinic_code` AS `clinic_code`, concat(ifnull(`view_patient`.`first_name`,''),' ',ifnull(`view_patient`.`middle_name`,''),' ',ifnull(`view_patient`.`last_name`,'')) AS `patient_name`, `appointment`.`doctor_id` AS `doctor_id`, `appointment`.`clinic_id` AS `clinic_id`, `appointment`.`status` AS `status`, `clinic`.`clinic_name` AS `clinic_name`, concat(ifnull(`contacts`.`first_name`,''),' ',ifnull(`contacts`.`middle_name`,''),' ',ifnull(`contacts`.`last_name`,'')) AS `doctor_name`, `appointment`.`appointment_date` AS `appointment_date`, min(`appointment`.`start_time`) AS `appointment_time`, max(case `appointment_log`.`status` when 'Waiting' then `appointment_log`.`from_time` end) AS `waiting_in`, max(case `appointment_log`.`status` when 'Consultation' then `appointment_log`.`from_time` end) - max(case `appointment_log`.`status` when 'Waiting' then `appointment_log`.`from_time` end) AS `waiting_duration`, max(case `appointment_log`.`status` when 'Consultation' then `appointment_log`.`from_time` end) AS `consultation_in`, max(case `appointment_log`.`status` when 'Complete' then `appointment_log`.`from_time` end) AS `consultation_out`, max(case `appointment_log`.`status` when 'Complete' then `appointment_log`.`from_time` end) - max(case `appointment_log`.`status` when 'Consultation' then `appointment_log`.`from_time` end) AS `consultation_duration`, max(case `appointment_log`.`old_status` when 'Consultation' then timediff(`appointment_log`.`to_time`,`appointment_log`.`from_time`) end) AS `waiting_out`, max(`bill`.`total_amount`) AS `collection_amount` FROM ((((((`pid_appointments` `appointment` left join `pid_view_patient` `view_patient` on(`appointment`.`patient_id` = `view_patient`.`patient_id`)) left join `pid_bill` `bill` on(`appointment`.`visit_id` = `bill`.`visit_id`)) left join `pid_appointment_log` `appointment_log` on(`appointment`.`appointment_id` = `appointment_log`.`appointment_id`)) left join `pid_doctor` `doctor` on(`doctor`.`doctor_id` = `appointment`.`doctor_id`)) left join `pid_contacts` `contacts` on(`contacts`.`contact_id` = `doctor`.`contact_id`)) left join `pid_clinic` `clinic` on(`clinic`.`clinic_id` = `appointment`.`clinic_id`)) GROUP BY `appointment`.`appointment_id`, concat(ifnull(`view_patient`.`first_name`,''),' ',ifnull(`view_patient`.`middle_name`,''),' ',ifnull(`view_patient`.`last_name`,''))  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_tax_report`
--
DROP TABLE IF EXISTS `pid_view_tax_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_tax_report`  AS SELECT `patient`.`display_id` AS `display_id`, `patient`.`first_name` AS `first_name`, `patient`.`middle_name` AS `middle_name`, `patient`.`last_name` AS `last_name`, `bill`.`bill_id` AS `bill_id`, `bill`.`bill_date` AS `bill_date`, (select sum(ifnull(`bill_detail_tax`.`amount`,0)) from `pid_bill_detail` `bill_detail_tax` where `bill_detail_tax`.`bill_id` = `bill`.`bill_id` and ifnull(`bill_detail_tax`.`tax_amount`,0) > 0) AS `taxable_amount`, (select sum(ifnull(`bill_detail_non`.`amount`,0)) from `pid_bill_detail` `bill_detail_non` where `bill_detail_non`.`bill_id` = `bill`.`bill_id` and ifnull(`bill_detail_non`.`tax_amount`,0) = 0 and `bill_detail_non`.`type` <> 'discount') AS `non_taxable_amount`, (select sum(ifnull(`bill_detail_discount`.`amount`,0)) from `pid_bill_detail` `bill_detail_discount` where `bill_detail_discount`.`bill_id` = `bill`.`bill_id` and `bill_detail_discount`.`type` = 'discount') AS `discount`, `bill`.`tax_amount` AS `item_tax_amount`, `bill`.`total_amount` AS `total_amount` FROM (`pid_bill` `bill` join `pid_view_patient` `patient` on(`patient`.`patient_id` = `bill`.`patient_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_visit`
--
DROP TABLE IF EXISTS `pid_view_visit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_visit`  AS SELECT `visit`.`visit_id` AS `visit_id`, `visit`.`visit_date` AS `visit_date`, `visit`.`visit_time` AS `visit_time`, `visit`.`appointment_reason` AS `appointment_reason`, `visit`.`type` AS `type`, `visit`.`notes` AS `notes`, `visit`.`patient_notes` AS `patient_notes`, `visit`.`doctor_id` AS `doctor_id`, `doctor`.`name` AS `name`, `visit`.`patient_id` AS `patient_id`, `patient`.`reference_by` AS `reference_by`, `patient`.`reference_by_detail` AS `reference_by_detail`, `bill`.`bill_id` AS `bill_id`, `bill`.`total_amount` AS `total_amount`, (select ifnull(sum(ifnull(`bill_detail`.`amount`,0)),0) from `pid_bill_detail` `bill_detail` where `bill_detail`.`bill_id` = `bill`.`bill_id` and `bill_detail`.`type` = 'tax') AS `bill_tax_amount`, (select sum(`item_bill_detail`.`tax_amount`) from `pid_bill_detail` `item_bill_detail` where `item_bill_detail`.`bill_id` = `bill`.`bill_id`) AS `item_tax_amount`, `bill`.`due_amount` AS `due_amount` FROM (((`pid_visit` `visit` join `pid_view_doctor` `doctor` on(`doctor`.`doctor_id` = `visit`.`doctor_id`)) join `pid_patient` `patient` on(`patient`.`patient_id` = `visit`.`patient_id`)) join `pid_bill` `bill` on(`bill`.`visit_id` = `visit`.`visit_id`)) ORDER BY `visit`.`patient_id` ASC, `visit`.`visit_date` ASC, `visit`.`visit_time` ASC  ;

-- --------------------------------------------------------

--
-- Structure for view `pid_view_visit_treatments`
--
DROP TABLE IF EXISTS `pid_view_visit_treatments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pid_view_visit_treatments`  AS SELECT `visit`.`visit_id` AS `visit_id`, `bill_detail`.`particular` AS `particular`, `bill_detail`.`type` AS `type` FROM ((`pid_visit` `visit` left join `pid_bill` `bill` on(`bill`.`visit_id` = `visit`.`visit_id`)) left join `pid_bill_detail` `bill_detail` on(`bill_detail`.`bill_id` = `bill`.`bill_id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pid_appointments`
--
ALTER TABLE `pid_appointments`
  ADD PRIMARY KEY (`appointment_id`);

--
-- Indexes for table `pid_appointment_log`
--
ALTER TABLE `pid_appointment_log`
  ADD PRIMARY KEY (`appointment_log_id`);

--
-- Indexes for table `pid_bill`
--
ALTER TABLE `pid_bill`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `pid_bill_detail`
--
ALTER TABLE `pid_bill_detail`
  ADD PRIMARY KEY (`bill_detail_id`);

--
-- Indexes for table `pid_bill_payment_r`
--
ALTER TABLE `pid_bill_payment_r`
  ADD PRIMARY KEY (`bill_payment_id`);

--
-- Indexes for table `pid_chikitsa_xml_check`
--
ALTER TABLE `pid_chikitsa_xml_check`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pid_clinic`
--
ALTER TABLE `pid_clinic`
  ADD PRIMARY KEY (`clinic_id`);

--
-- Indexes for table `pid_contacts`
--
ALTER TABLE `pid_contacts`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `pid_contact_details`
--
ALTER TABLE `pid_contact_details`
  ADD PRIMARY KEY (`contact_detail_id`);

--
-- Indexes for table `pid_data`
--
ALTER TABLE `pid_data`
  ADD PRIMARY KEY (`ck_data_id`),
  ADD UNIQUE KEY `ck_key` (`ck_key`);

--
-- Indexes for table `pid_doctor`
--
ALTER TABLE `pid_doctor`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `pid_followup`
--
ALTER TABLE `pid_followup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pid_invoice`
--
ALTER TABLE `pid_invoice`
  ADD PRIMARY KEY (`invoice_id`);

--
-- Indexes for table `pid_language_data`
--
ALTER TABLE `pid_language_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `l_name` (`l_name`,`l_index`);

--
-- Indexes for table `pid_language_master`
--
ALTER TABLE `pid_language_master`
  ADD PRIMARY KEY (`language_id`),
  ADD UNIQUE KEY `language_name` (`language_name`);

--
-- Indexes for table `pid_menu_access`
--
ALTER TABLE `pid_menu_access`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_name` (`menu_name`,`category_name`);

--
-- Indexes for table `pid_modules`
--
ALTER TABLE `pid_modules`
  ADD PRIMARY KEY (`module_id`),
  ADD UNIQUE KEY `module_name` (`module_name`),
  ADD UNIQUE KEY `module_name_2` (`module_name`);

--
-- Indexes for table `pid_navigation_menu`
--
ALTER TABLE `pid_navigation_menu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_name` (`menu_name`);

--
-- Indexes for table `pid_nurse`
--
ALTER TABLE `pid_nurse`
  ADD PRIMARY KEY (`nurse_id`);

--
-- Indexes for table `pid_patient`
--
ALTER TABLE `pid_patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `pid_patient_account`
--
ALTER TABLE `pid_patient_account`
  ADD PRIMARY KEY (`patient_account_id`);

--
-- Indexes for table `pid_payment`
--
ALTER TABLE `pid_payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `pid_payment_methods`
--
ALTER TABLE `pid_payment_methods`
  ADD PRIMARY KEY (`payment_method_id`);

--
-- Indexes for table `pid_payment_transaction`
--
ALTER TABLE `pid_payment_transaction`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `pid_receipt_template`
--
ALTER TABLE `pid_receipt_template`
  ADD PRIMARY KEY (`template_id`);

--
-- Indexes for table `pid_reference_by`
--
ALTER TABLE `pid_reference_by`
  ADD PRIMARY KEY (`reference_id`);

--
-- Indexes for table `pid_tax_rates`
--
ALTER TABLE `pid_tax_rates`
  ADD PRIMARY KEY (`tax_id`);

--
-- Indexes for table `pid_todos`
--
ALTER TABLE `pid_todos`
  ADD PRIMARY KEY (`id_num`);

--
-- Indexes for table `pid_users`
--
ALTER TABLE `pid_users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `pid_user_categories`
--
ALTER TABLE `pid_user_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pid_user_verification`
--
ALTER TABLE `pid_user_verification`
  ADD PRIMARY KEY (`verification_id`);

--
-- Indexes for table `pid_version`
--
ALTER TABLE `pid_version`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pid_visit`
--
ALTER TABLE `pid_visit`
  ADD PRIMARY KEY (`visit_id`);

--
-- Indexes for table `pid_working_days`
--
ALTER TABLE `pid_working_days`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pid_appointments`
--
ALTER TABLE `pid_appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_appointment_log`
--
ALTER TABLE `pid_appointment_log`
  MODIFY `appointment_log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_bill`
--
ALTER TABLE `pid_bill`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_bill_detail`
--
ALTER TABLE `pid_bill_detail`
  MODIFY `bill_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_bill_payment_r`
--
ALTER TABLE `pid_bill_payment_r`
  MODIFY `bill_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_chikitsa_xml_check`
--
ALTER TABLE `pid_chikitsa_xml_check`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `pid_clinic`
--
ALTER TABLE `pid_clinic`
  MODIFY `clinic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pid_contacts`
--
ALTER TABLE `pid_contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_contact_details`
--
ALTER TABLE `pid_contact_details`
  MODIFY `contact_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_data`
--
ALTER TABLE `pid_data`
  MODIFY `ck_data_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `pid_doctor`
--
ALTER TABLE `pid_doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_followup`
--
ALTER TABLE `pid_followup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_invoice`
--
ALTER TABLE `pid_invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pid_language_data`
--
ALTER TABLE `pid_language_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1074;

--
-- AUTO_INCREMENT for table `pid_language_master`
--
ALTER TABLE `pid_language_master`
  MODIFY `language_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pid_menu_access`
--
ALTER TABLE `pid_menu_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `pid_modules`
--
ALTER TABLE `pid_modules`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_navigation_menu`
--
ALTER TABLE `pid_navigation_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `pid_nurse`
--
ALTER TABLE `pid_nurse`
  MODIFY `nurse_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_patient`
--
ALTER TABLE `pid_patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_patient_account`
--
ALTER TABLE `pid_patient_account`
  MODIFY `patient_account_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_payment`
--
ALTER TABLE `pid_payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_payment_methods`
--
ALTER TABLE `pid_payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pid_payment_transaction`
--
ALTER TABLE `pid_payment_transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_receipt_template`
--
ALTER TABLE `pid_receipt_template`
  MODIFY `template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pid_reference_by`
--
ALTER TABLE `pid_reference_by`
  MODIFY `reference_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_tax_rates`
--
ALTER TABLE `pid_tax_rates`
  MODIFY `tax_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pid_todos`
--
ALTER TABLE `pid_todos`
  MODIFY `id_num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pid_users`
--
ALTER TABLE `pid_users`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pid_user_categories`
--
ALTER TABLE `pid_user_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pid_user_verification`
--
ALTER TABLE `pid_user_verification`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_version`
--
ALTER TABLE `pid_version`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_visit`
--
ALTER TABLE `pid_visit`
  MODIFY `visit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pid_working_days`
--
ALTER TABLE `pid_working_days`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
