-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2025 at 07:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `university`
--

-- --------------------------------------------------------

--
-- Table structure for table `student_results`
--

CREATE TABLE `student_results` (
  `SL_NO` int(11) NOT NULL,
  `EXAM_ROLL` varchar(10) DEFAULT NULL,
  `STUDENT_NAME` varchar(50) DEFAULT NULL,
  `REG_NO` varchar(10) DEFAULT NULL,
  `GPA` float DEFAULT NULL,
  `PRE_CGPA` float DEFAULT NULL,
  `PRE_CCH` float DEFAULT NULL,
  `CGPA` float DEFAULT NULL,
  `CCH` float DEFAULT NULL,
  `REMARKS` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_results`
--

INSERT INTO `student_results` (`SL_NO`, `EXAM_ROLL`, `STUDENT_NAME`, `REG_NO`, `GPA`, `PRE_CGPA`, `PRE_CCH`, `CGPA`, `CCH`, `REMARKS`) VALUES
(1, '2102002', 'RUSNI AKTER', '10129', 3.125, 3.366, 41, 3.284, 62, 'Passed'),
(2, '2102003', 'MD. ABU TAHIER', '10130', 3.625, 3.354, 41, 3.446, 62, 'Passed'),
(3, '2102004', 'MD. ABDULLAH AL MAMUN', '10131', 2.688, 2.552, 35, 2.587, 47, 'Conditional Passed, F in CCE 121, CCE 211, CIT 213, EEE 121, MAT 211 = 5'),
(4, '2102005', 'MD. KAMRUZZAMAN', '10132', 2.875, 2.636, 29, 2.706, 41, 'Conditional Passed, F in AIS 211, CCE 121, CIT 211, EEE 121, MAT 111, MAT 211, PHY 111 = 7'),
(5, '2102006', 'UDITA SARKAR CHANDRABINDU', '10133', 3.804, 3.726, 41, 3.752, 62, 'Passed'),
(6, '2102007', 'MEHEDI HASAN', '10134', 3.571, 3.762, 41, 3.697, 62, 'Passed'),
(7, '2102008', 'ABDUL JOBAYER', '10135', 3.107, 2.931, 41, 2.991, 62, 'Passed'),
(8, '2102009', 'MD. MAHIBULLAH HOWLADER', '10136', 3.661, 3.503, 41, 3.557, 62, 'Passed'),
(9, '2102010', 'NUSRAT JAHAN MIM', '10137', 3.839, 3.502, 41, 3.616, 62, 'Passed'),
(10, '2102012', 'AISHWARIYA SARDER', '10139', 3.554, 3.082, 41, 3.242, 62, 'Passed'),
(11, '2102013', 'MAHEDI HASAN NAZMUL', '10140', 3.804, 3.826, 41, 3.819, 62, 'Passed'),
(12, '2102014', 'SADIA HOMAYRA NOWSHIN', '10141', 3.589, 3.235, 41, 3.355, 62, 'Passed'),
(13, '2102015', 'MD. RAIDUL ISLAM MAHI', '10142', 3.582, 3.62, 41, 3.596, 59, 'Conditional Passed, F in CCE 211 = 1'),
(14, '2102016', 'MD. MEHEDI HASAN', '10143', 3.667, 3.322, 41, 3.427, 59, 'Conditional Passed, F in CIT 213 = 1'),
(15, '2102017', 'DUROY DAS', '10144', 3.304, 3.248, 41, 3.293, 62, 'Passed'),
(16, '2102018', 'JANNATUL MIM', '10145', 3.542, 3.576, 41, 3.566, 59, 'Conditional Passed, F in CIT 211 = 1'),
(17, '2102019', 'HRIDOY CHANDRA SARKER', '10146', 3.104, 3.014, 41, 3.041, 59, 'Conditional Passed, F in CCE 211 = 1'),
(18, '2102020', 'MD. SADMAN KABIR BHUIYAN', '10147', 3.786, 3.481, 41, 3.82, 62, 'Passed'),
(19, '2102021', 'SADMAN HAFIZ SHUVO', '10148', 3.146, 3.142, 41, 2.934, 59, 'Conditional Passed, F in CIT 213 = 1'),
(20, '2102022', 'NOSHIN NAZIA', '10149', 3.125, 3.102, 41, 3.11, 62, 'Passed'),
(21, '2102023', 'MD. SENARUL ISLAM', '10150', 3.446, 3.119, 41, 3.23, 62, 'Passed'),
(22, '2102024', 'MD. SHARAFAT KARIM', '10151', 3.964, 3.877, 41, 3.906, 62, 'Passed'),
(23, '2102025', 'SEEMANTA SHILL', '10152', 3.214, 3.223, 41, 3.22, 62, 'Passed'),
(24, '2102026', 'NAYEMA FERDOUSHI', '10153', 3.857, 3.788, 41, 3.801, 62, 'Passed'),
(25, '2102027', 'MD. AFRIDI ALOM PRANTO', '10154', 3.464, 3.393, 41, 3.417, 62, 'Passed'),
(26, '2102028', 'SHAWAN MAHMUD ABDULLAH', '10155', 2, 3.01, 38, 2.936, 41, 'Failed, F in AIS 211, CCE 121, CCE 211, CIT 211, CIT 212, EEE 211, EEE 212, MAT 211 = 8'),
(27, '2102030', 'YASIN ARAFAT', '10157', 3.643, 3.46, 41, 3.522, 62, 'Passed'),
(28, '2102031', 'TANVIR ANJUM RAHAT', '10158', 3.179, 3.673, 36.5, 2.858, 57.5, 'Promoted, F in CCE 121, CCE 122 = 2'),
(29, '2102032', 'MD. ARIFUL ISLAM MASUM', '10159', 3.375, 2.955, 41, 3.083, 59, 'Conditional Passed, F in CIT 213 = 1'),
(30, '2102033', 'AKASH PAUL', '10160', 3.232, 3.236, 41, 3.235, 62, 'Passed'),
(31, '2102034', 'MD. AL MAMUN', '10161', 3.768, 3.372, 41, 3.506, 62, 'Passed'),
(32, '2102035', 'BASUDHA SHOME', '10162', 3.094, 2.762, 38, 3.28, 50, 'Conditional Passed, F in AIS 211, CIT 211, CIT 213, MAT 111 = 4'),
(33, '2102036', 'ABUL BASAR', '10163', 3.429, 3.303, 41, 3.346, 62, 'Passed'),
(34, '2102037', 'MD. SABBIK KHAN MOYEEM', '10164', 2.696, 2.887, 32, 2.811, 53, 'Promoted, F in CCE 121, PHY 111, PHY 121 = 3'),
(35, '2102038', 'MD. NOUSHAD BHUIYAN', '10165', 2.964, 3.207, 41, 3.125, 62, 'Passed'),
(36, '2102039', 'SUVO BISWAS', '10166', 3.2, 3.038, 41, 3.081, 56, 'Conditional Passed, F in CIT 211, CIT 213 = 2'),
(37, '2102040', 'MAHIR ASHAB', '10167', 3.179, 3.318, 39.5, 3.27, 60, 'Promoted, F in CCE 122 = 1'),
(38, '2102041', 'OMAR FARUK TANVIR', '10168', 3.469, 3.192, 41, 3.255, 53, 'Conditional Passed, F in AIS 211, CCE 211, CIT 211 = 3'),
(39, '2102042', 'MD. NAIMUR RAHMAN NAIEM', '10169', 3.054, 3.046, 41, 3.049, 62, 'Passed'),
(40, '2102043', 'MD. TANVIR ISLAM', '10170', 3.161, 3.364, 41, 3.295, 62, 'Passed'),
(41, '2102044', 'NAZMUS SAKIB', '10171', 3.083, 3.02, 38, 3.04, 56, 'Conditional Passed, F in CCE 121, CIT 211 = 2'),
(42, '2102046', 'MD. HAJEK ANJUM BENOY', '10173', 3.482, 3.176, 41, 3.28, 62, 'Passed'),
(43, '2102047', 'PUSPITA BAIDYA', '10174', 3.357, 3.511, 41, 3.459, 62, 'Passed'),
(44, '2102048', 'MD. MEHEDI HASAN MONIR', '10175', 3.357, 3.439, 41, 3.411, 62, 'Passed'),
(45, '2102049', 'PROSENJIT MONDOL', '10176', 3.839, 3.497, 41, 3.613, 62, 'Passed'),
(46, '2102050', 'NUR MOHAMMAD NAIM', '10177', 2.786, 4.346, 41, 3.216, 62, 'Passed'),
(47, '2102051', 'MD. SAFIULLAH FARAYJ', '10178', 3.339, 3.198, 41, 3.246, 62, 'Passed'),
(48, '2102052', 'MOHAMMED SAKIB HASAN', '10179', 3.679, 3.284, 41, 3.418, 62, 'Passed'),
(49, '2102054', 'AMIT KUMAR BARMAN', '10181', 3.2, 3.005, 41, 3.057, 56, 'Conditional Passed, F in CCE 211, CIT 213 = 2'),
(50, '2102055', 'MST. MEHERIN JAHAN JUI', '10182', 3.625, 3.691, 41, 3.669, 62, 'Passed'),
(51, '2102056', 'SANDIPTA SAHA', '10183', 3.75, 3.343, 41, 3.481, 62, 'Passed'),
(52, '2102057', 'SHAID IBNA SOBHAN', '10184', 3.714, 3.459, 41, 3.545, 62, 'Passed'),
(53, '2102058', 'MD. SIFAT', '10185', 2.8, 2.766, 39.5, 2.775, 54.5, 'Conditional Passed, F in CCE 122, CCE 211, CIT 213 = 3'),
(54, '2102059', 'MD. ABDUL KAIYUM', '10186', 3.607, 3.54, 41, 3.563, 62, 'Passed'),
(55, '2102060', 'HADIBUZZAMAN', '10187', 3.679, 3.163, 41, 3.338, 62, 'Passed'),
(56, '2102062', 'MAHAJABIN AFROZ MOUSHE', '10189', 2.594, 2.553, 38, 2.563, 50, 'Conditional Passed, F in AIS 211, CCE 121, CCE 211, EEE 211 = 4'),
(57, '2102063', 'SANZIDA ISLAM NUHA', '10190', 3.75, 3.428, 41, 3.537, 62, 'Passed'),
(58, '2102064', 'MD. MOBIN HAQUE', '10191', 3.286, 3.349, 41, 3.328, 62, 'Passed'),
(59, '2102065', 'IMAMUL KABIR ANAN', '10192', 3.625, 3.26, 41, 3.384, 62, 'Passed'),
(60, '2102066', 'NAZMUS SAKIB', '10193', 2.896, 2.695, 38, 2.76, 56, 'Conditional Passed, F in CCE 121, MAT 211 = 2'),
(61, '2102067', 'MOHAMMAD FARHADUL HAQUE FUAD', '10194', 3.192, 3.046, 41, 3.093, 60.5, 'Conditional Passed, F in CIT 212 = 1'),
(62, '2102068', 'MD. NAZMUL HASAN KHOKUN', '10195', 3.607, 3.093, 41, 3.267, 62, 'Passed'),
(63, '2102069', 'MD. ABDUL HAI FAHIM', '10196', 2.625, 3.191, 41, 3.039, 56, 'Conditional Passed, F in CCE 211, CIT 213 = 2'),
(64, '2102070', 'JAHID HASAN', '10197', 3.054, 2.823, 41, 2.901, 62, 'Passed'),
(65, '2102071', 'JIHADUL ISLAM', '10198', 3.464, 3.002, 41, 3.158, 62, 'Passed'),
(66, '2102072', 'MD. SAFAYET HOSSAIN', '10199', 3.083, 2.641, 41, 2.776, 59, 'Conditional Passed, F in CCE 211 = 1'),
(67, '2102073', 'RAGHIB AL SHAHRIAR', '10200', 3.554, 3.029, 41, 3.207, 62, 'Passed'),
(68, '2102074', 'ABDULLAH', '10201', 3.458, 3.064, 41, 3.184, 59, 'Conditional Passed, F in CIT 213 = 1'),
(69, '2102075', 'AFRIN JAHAN', '10202', 3.536, 2.848, 41, 3.081, 62, 'Passed');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `student_results`
--
ALTER TABLE `student_results`
  ADD PRIMARY KEY (`SL_NO`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `student_results`
--
ALTER TABLE `student_results`
  MODIFY `SL_NO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
