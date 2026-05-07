-- =====================================================
-- Clinic Database System
-- Clean GitHub-ready SQL file
-- Project: Relational database design for a healthcare clinic
-- DBMS: MySQL
-- =====================================================

CREATE DATABASE IF NOT EXISTS clinic_database;
USE clinic_database;

-- Drop tables in correct order
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS professionals;
DROP TABLE IF EXISTS patients;

-- =====================================================
-- Table: Patients
-- =====================================================

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    dob DATE,
    sex VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(50),
    address VARCHAR(100),
    registration_date DATE,
    emergency_contact VARCHAR(150),

    INDEX idx_patients_last_name (last_name),
    INDEX idx_patients_phone (phone),
    INDEX idx_patients_email (email)
);

-- =====================================================
-- Table: Professionals
-- =====================================================

CREATE TABLE professionals (
    professional_id INT PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    role VARCHAR(40) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(50),

    INDEX idx_professionals_last_name (last_name),
    INDEX idx_professionals_role (role)
);

-- =====================================================
-- Table: Services
-- =====================================================

CREATE TABLE services (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(80) NOT NULL,
    description VARCHAR(200),
    standard_duration_mins INT NOT NULL,
    standard_fee DECIMAL(8,2) NOT NULL,

    INDEX idx_services_name (service_name)
);

-- =====================================================
-- Table: Appointments
-- =====================================================

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    service_id INT NOT NULL,
    professional_id INT NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Booked',
    notes VARCHAR(200),

    INDEX idx_appt_patient_dt (patient_id, appointment_datetime),
    INDEX idx_appt_service_dt (service_id, appointment_datetime),
    INDEX idx_appt_prof_dt (professional_id, appointment_datetime),

    CONSTRAINT fk_appt_patient
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),

    CONSTRAINT fk_appt_service
        FOREIGN KEY (service_id) REFERENCES services(service_id),

    CONSTRAINT fk_appt_professional
        FOREIGN KEY (professional_id) REFERENCES professionals(professional_id)
);

-- =====================================================
-- Table: Attendance
-- =====================================================

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    check_in_time DATETIME,
    check_out_time DATETIME,
    outcome VARCHAR(100),
    clinical_notes VARCHAR(500),

    CONSTRAINT fk_attendance_appointment
        FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- =====================================================
-- Table: Bills
-- =====================================================

CREATE TABLE bills (
    bill_id INT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    amount DECIMAL(8,2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    paid_date DATE,

    INDEX idx_bills_paid (paid),

    CONSTRAINT fk_bill_appointment
        FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- =====================================================
-- Sample Data
-- =====================================================

INSERT INTO patients VALUES 
  (1, 'Muhammad', 'Smith', '1974-09-04', 'Female', '+44 732 2679 9935', 'muhammad.smith90@example.com', '109 High St, Aberdeen', '2007-02-07', 'Isla Wilson'),
  (2, 'Ava', 'White', '2002-11-13', 'Other', '+44 702 7924 6574', 'ava.white285@example.com', '56 Victoria Rd, Inverness', '2021-01-14', 'Ethan Brown'),
  (3, 'Daniel', 'Martin', '1961-03-14', 'Male', '+44 718 5803 6925', 'daniel.martin592@example.com', '181 Station Rd, Aberdeen', '2019-11-01', 'Ava Roberts'),
  (4, 'Daniel', 'Walker', '1964-08-04', 'Other', '+44 753 5374 2169', 'daniel.walker624@example.com', '137 Main St, Dundee', '2015-05-15', 'Ethan Thomas'),
  (5, 'James', 'Wright', '1974-01-08', 'Male', '+44 739 6155 4483', 'james.wright672@example.com', '102 Queen St, Dundee', '2010-12-10', 'Thomas Wilson'),
  (6, 'Fiona', 'Palmer', '1990-05-06', 'Female', '+44 7700 006 328', 'fiona.palmer6@example.com', '37 Argyle St, St Andrews, KY16 9NS', '2017-05-03', 'Jack Stevenson (Daughter) +44 7711 006 132'),
  (7, 'Lachlan', 'McDonald', '1969-01-14', 'Male', '+44 7700 007 674', 'lachlan.mcdonald7@example.com', '52 Seaton Drive, Dundee, DD1 4DF', '2017-01-27', 'Lucy Stevenson (Sister) +44 7711 007 928'),
  (8, 'Hannah', 'Nolan', '1980-06-23', 'Female', '+44 7700 008 384', 'hannah.nolan8@example.com', '41 Hope St, Stirling, FK8 1AY', '2021-01-10', 'Iain Sinclair (Daughter) +44 7711 008 199'),
  (9, 'Sarah', 'Davidson', '1956-01-23', 'Female', '+44 7700 009 847', 'sarah.davidson9@example.com', '119 High St, Perth, PH1 5TJ', '2024-01-19', 'Cameron MacPherson (Sister) +44 7711 009 949'),
  (10, 'Zara', 'Crawford', '1995-12-27', 'Female', '+44 7700 010 171', 'zara.crawford10@example.com', '13 Bridge St, Inverness, IV1 1PX', '2020-02-13', 'Cameron Forbes (Partner) +44 7711 010 489'),
  (11, 'Owen', 'Robertson', '1984-06-30', 'Male', '+44 7700 011 314', 'owen.robertson11@example.com', '173 South St, Glasgow, G12 8SW', '2019-09-30', 'Zoe Watson (Mother) +44 7711 011 646'),
  (12, 'Samuel', 'MacKay', '1967-12-19', 'Male', '+44 7700 012 670', 'samuel.mackay12@example.com', '58 Harbour Rd, Aberdeen, AB10 1BD', '2020-01-02', 'Craig Fraser (Brother) +44 7711 012 510'),
  (13, 'Daniel', 'Frost', '1987-04-19', 'Male', '+44 7700 013 771', 'daniel.frost13@example.com', '129 Queens Road, Elgin, IV30 1BU', '2023-04-19', 'Malcolm Davidson (Mother) +44 7711 013 352'),
  (14, 'Brenda', 'Stevenson', '1980-10-25', 'Female', '+44 7700 014 508', 'brenda.stevenson14@example.com', '94 Bridge St, Edinburgh, EH2 2QR', '2017-07-12', 'Morven Cameron (Partner) +44 7711 014 873'),
  (15, 'Lucy', 'Watson', '1997-12-15', 'Female', '+44 7700 015 532', 'lucy.watson15@example.com', '154 Market St, Perth, PH1 5TJ', '2019-10-27', 'Ailsa Craig (Son) +44 7711 015 641'),
  (16, 'Calum', 'Houston', '1961-02-28', 'Other', '+44 7700 016 798', 'calum.houston16@example.com', '139 South St, Stirling, FK8 1AY', '2022-02-02', 'Lachlan Burns (Daughter) +44 7711 016 261'),
  (17, 'Murray', 'Khan', '1991-09-14', 'Male', '+44 7700 017 880', 'murray.khan17@example.com', '47 Argyle St, Inverness, IV1 1PX', '2018-09-19', 'Grace McDonald (Friend) +44 7711 017 303'),
  (18, 'Cameron', 'Gordon', '1958-09-29', 'Male', '+44 7700 018 100', 'cameron.gordon18@example.com', '155 Harbour Rd, Elgin, IV30 1BU', '2020-06-13', 'Gregor Morrison (Brother) +44 7711 018 999'),
  (19, 'Hamish', 'Crawford', '2002-02-13', 'Male', '+44 7700 019 849', 'hamish.crawford19@example.com', '126 Market St, St Andrews, KY16 9NS', '2018-11-08', 'Alasdair Stewart (Son) +44 7711 019 662'),
  (20, 'Thomas', 'MacLean', '1994-10-04', 'Male', '+44 7700 020 873', 'thomas.maclean20@example.com', '178 Barnton Ave, Inverness, IV1 1PX', '2022-10-21', 'Mairi Neilson (Brother) +44 7711 020 548'),
  (21, 'Hamish', 'Forbes', '2003-06-23', 'Male', '+44 7700 021 121', 'hamish.forbes21@example.com', '152 Bridge St, Cupar, KY15 4BU', '2024-01-29', 'Duncan MacLeod (Partner) +44 7711 021 824'),
  (22, 'Finlay', 'Fraser', '1952-06-18', 'Male', '+44 7700 022 172', 'finlay.fraser22@example.com', '133 Bonnygate, Inverness, IV1 1PX', '2018-06-26', 'Emily Cameron (Father) +44 7711 022 652'),
  (23, 'Ava', 'Crawford', '1977-05-05', 'Female', '+44 7700 023 903', 'ava.crawford23@example.com', '123 Seaton Drive, Dundee, DD1 4DF', '2021-10-01', 'Fraser Reid (Daughter) +44 7711 023 462'),
  (24, 'Murray', 'Douglas', '1964-11-30', 'Male', '+44 7700 024 761', 'murray.douglas24@example.com', '27 Nethergate, Perth, PH1 5TJ', '2019-02-24', 'Anna Munro (Partner) +44 7711 024 354'),
  (25, 'Duncan', 'Stewart', '1980-04-03', 'Male', '+44 7700 025 385', 'duncan.stewart25@example.com', '120 Bonnygate, Glasgow, G12 8SW', '2024-04-25', 'Kirsty MacPherson (Partner) +44 7711 025 151'),
  (26, 'Calum', 'Sinclair', '1959-05-02', 'Other', '+44 7700 026 270', 'calum.sinclair26@example.com', '106 Meadow View, Elgin, IV30 1BU', '2021-04-02', 'Ewan Ritchie (Spouse) +44 7711 026 268'),
  (27, 'Samuel', 'Davidson', '1957-08-21', 'Male', '+44 7700 027 392', 'samuel.davidson27@example.com', '110 Meadow View, Edinburgh, EH2 2QR', '2023-07-01', 'Samuel Burns (Father) +44 7711 027 159'),
  (28, 'Mairi', 'Palmer', '1987-01-30', 'Female', '+44 7700 028 151', 'mairi.palmer28@example.com', '151 Cedar Court, St Andrews, KY16 9NS', '2017-11-25', 'Catriona Robertson (Spouse) +44 7711 028 620'),
  (29, 'Eilidh', 'Craig', '2003-12-12', 'Female', '+44 7700 029 982', 'eilidh.craig29@example.com', '62 Queens Road, Glasgow, G12 8SW', '2017-06-12', 'Ivy Findlay (Friend) +44 7711 029 708'),
  (30, 'Luna', 'Neilson', '1970-10-17', 'Female', '+44 7700 030 635', 'luna.neilson30@example.com', '82 Castle St, Dundee, DD1 4DF', '2019-12-24', 'Emily Frost (Brother) +44 7711 030 344'),
  (31, 'Arthur', 'Baird', '1988-08-22', 'Male', '+44 7700 031 423', 'arthur.baird31@example.com', '20 Rose St, Elgin, IV30 1BU', '2023-01-12', 'Eva Crawford (Partner) +44 7711 031 175'),
  (32, 'Alasdair', 'Stewart', '1985-02-05', 'Male', '+44 7700 032 350', 'alasdair.stewart32@example.com', '96 Queen St, Edinburgh, EH2 2QR', '2024-05-02', 'Kirsty Gordon (Sister) +44 7711 032 726'),
  (33, 'Joanne', 'MacPherson', '1988-12-05', 'Female', '+44 7700 033 206', 'joanne.macpherson33@example.com', '36 Castle St, Glasgow, G12 8SW', '2020-01-21', 'Iain Palmer (Cousin) +44 7711 033 259'),
  (34, 'Iain', 'Frost', '1986-04-15', 'Male', '+44 7700 034 803', 'iain.frost34@example.com', '164 Castle St, St Andrews, KY16 9NS', '2024-02-12', 'Caitlin Davidson (Spouse) +44 7711 034 194'),
  (35, 'Torin', 'Fraser', '2007-06-20', 'Male', '+44 7700 035 889', 'torin.fraser35@example.com', '35 Castle St, Edinburgh, EH2 2QR', '2021-10-18', 'Miriam Johnston (Cousin) +44 7711 035 822'),
  (36, 'Amy', 'Kerr', '1951-12-20', 'Female', '+44 7700 036 252', 'amy.kerr36@example.com', '141 Union St, Stirling, FK8 1AY', '2018-06-07', 'Luna MacPherson (Mother) +44 7711 036 540'),
  (37, 'Owen', 'Fraser', '1985-04-18', 'Male', '+44 7700 037 798', 'owen.fraser37@example.com', '65 Argyle St, Stirling, FK8 1AY', '2018-09-26', 'Zara Young (Friend) +44 7711 037 867'),
  (38, 'Saoirse', 'Robertson', '1956-03-31', 'Female', '+44 7700 038 522', 'saoirse.robertson38@example.com', '8 Church St, Stirling, FK8 1AY', '2018-10-15', 'Eilidh Neilson (Father) +44 7711 038 373'),
  (39, 'Chloe', 'Buchanan', '1952-01-20', 'Female', '+44 7700 039 979', 'chloe.buchanan39@example.com', '122 Bridge St, Dundee, DD1 4DF', '2019-07-22', 'Hannah Boyd (Sister) +44 7711 039 940'),
  (40, 'Arthur', 'Ross', '1982-06-18', 'Male', '+44 7700 040 385', 'arthur.ross40@example.com', '19 South St, Stirling, FK8 1AY', '2023-01-06', 'Kavya McDonald (Daughter) +44 7711 040 795'),
  (41, 'Calum', 'Morrison', '1951-05-14', 'Male', '+44 7700 041 282', 'calum.morrison41@example.com', '150 Castle St, Aberdeen, AB10 1BD', '2020-07-08', 'Iain Craig (Daughter) +44 7711 041 453'),
  (42, 'Robert', 'Morrison', '1983-10-23', 'Male', '+44 7700 042 294', 'robert.morrison42@example.com', '67 Union St, Perth, PH1 5TJ', '2024-07-09', 'Euan Murray (Cousin) +44 7711 042 803'),
  (43, 'Ewan', 'Kerr', '1965-06-19', 'Male', '+44 7700 043 738', 'ewan.kerr43@example.com', '82 High St, Inverness, IV1 1PX', '2021-07-07', 'Isobel Paterson (Daughter) +44 7711 043 434'),
  (44, 'Tracey', 'Stewart', '1995-08-04', 'Female', '+44 7700 044 780', 'tracey.stewart44@example.com', '99 Church St, Cupar, KY15 4BU', '2017-01-02', 'Ivy Paterson (Daughter) +44 7711 044 661'),
  (45, 'Iain', 'MacLean', '1957-10-24', 'Male', '+44 7700 045 721', 'iain.maclean45@example.com', '169 Harbour Rd, Elgin, IV30 1BU', '2022-04-23', 'Kirsty Johnston (Father) +44 7711 045 623'),
  (46, 'Brenda', 'Robertson', '1965-02-13', 'Female', '+44 7700 046 390', 'brenda.robertson46@example.com', '133 Princes St, Glasgow, G12 8SW', '2019-03-27', 'Sean Houston (Sister) +44 7711 046 330'),
  (47, 'Gregor', 'Findlay', '1977-11-09', 'Male', '+44 7700 047 970', 'gregor.findlay47@example.com', '20 Elm Grove, Perth, PH1 5TJ', '2024-10-23', 'Nadia Crawford (Father) +44 7711 047 835'),
  (48, 'Angus', 'Findlay', '1998-12-02', 'Male', '+44 7700 048 804', 'angus.findlay48@example.com', '3 Argyle St, Perth, PH1 5TJ', '2017-07-25', 'Duncan Grant (Cousin) +44 7711 048 575'),
  (49, 'Amy', 'Henderson', '1999-08-26', 'Female', '+44 7700 049 783', 'amy.henderson49@example.com', '137 Harbour Rd, Elgin, IV30 1BU', '2023-02-23', 'Sienna Khan (Cousin) +44 7711 049 536'),
  (50, 'Cameron', 'Palmer', '1952-08-31', 'Male', '+44 7700 050 560', 'cameron.palmer50@example.com', '68 Bonnygate, Inverness, IV1 1PX', '2021-12-07', 'Orla Cameron (Father) +44 7711 050 381'),
  (51, 'Malcolm', 'Findlay', '1990-06-21', 'Male', '+44 7700 051 427', 'malcolm.findlay51@example.com', '140 King St, Edinburgh, EH2 2QR', '2018-09-18', 'Oliver Forbes (Daughter) +44 7711 051 810'),
  (52, 'Eilidh', 'Young', '1981-06-19', 'Female', '+44 7700 052 655', 'eilidh.young52@example.com', '121 Seaton Drive, Aberdeen, AB10 1BD', '2023-07-21', 'Alistair Young (Daughter) +44 7711 052 888'),
  (53, 'Fiona', 'Ellis', '1971-07-14', 'Female', '+44 7700 053 588', 'fiona.ellis53@example.com', '3 Victoria Rd, Inverness, IV1 1PX', '2023-02-15', 'Fiona Young (Cousin) +44 7711 053 865'),
  (54, 'Caitlin', 'Cameron', '1993-05-20', 'Female', '+44 7700 054 546', 'caitlin.cameron54@example.com', '126 Great Western Rd, Perth, PH1 5TJ', '2018-11-08', 'Archie Neilson (Daughter) +44 7711 054 841'),
  (55, 'Kirsty', 'Wallace', '1973-01-14', 'Female', '+44 7700 055 503', 'kirsty.wallace55@example.com', '153 Great Western Rd, Glasgow, G12 8SW', '2022-03-07', 'Kavya MacLean (Mother) +44 7711 055 987'),
  (56, 'Alasdair', 'Buchanan', '1987-04-19', 'Male', '+44 7700 056 565', 'alasdair.buchanan56@example.com', '85 Princes St, Perth, PH1 5TJ', '2017-12-02', 'Ethan Ellis (Daughter) +44 7711 056 358'),
  (57, 'Brenda', 'Gordon', '2004-06-28', 'Female', '+44 7700 057 329', 'brenda.gordon57@example.com', '168 Market St, Aberdeen, AB10 1BD', '2017-03-25', 'Rory Findlay (Father) +44 7711 057 959'),
  (58, 'Saoirse', 'Stewart', '1977-12-09', 'Female', '+44 7700 058 217', 'saoirse.stewart58@example.com', '146 Hope St, Elgin, IV30 1BU', '2023-10-18', 'Rachel Davidson (Brother) +44 7711 058 271'),
  (59, 'Brenda', 'Frost', '2000-03-24', 'Female', '+44 7700 059 418', 'brenda.frost59@example.com', '29 Great Western Rd, Inverness, IV1 1PX', '2019-03-24', 'Sofia Houston (Daughter) +44 7711 059 506'),
  (60, 'Harris', 'Watson', '1992-02-22', 'Male', '+44 7700 060 813', 'harris.watson60@example.com', '79 High St, Cupar, KY15 4BU', '2024-06-02', 'Lewis Boyd (Cousin) +44 7711 060 538'),
  (61, 'Robert', 'Baird', '1986-01-07', 'Male', '+44 7700 061 969', 'robert.baird61@example.com', '109 Meadow View, Glasgow, G12 8SW', '2018-09-19', 'Amy Allan (Son) +44 7711 061 824'),
  (62, 'Murray', 'Murray', '1966-05-19', 'Male', '+44 7700 062 730', 'murray.murray62@example.com', '139 Cedar Court, Elgin, IV30 1BU', '2020-08-13', 'Amy Khan (Friend) +44 7711 062 374'),
  (63, 'Elena', 'MacKay', '1951-08-19', 'Female', '+44 7700 063 349', 'elena.mackay63@example.com', '120 Riverbank, Stirling, FK8 1AY', '2022-06-21', 'Rory Cameron (Brother) +44 7711 063 286'),
  (64, 'Alasdair', 'Munro', '1990-11-02', 'Male', '+44 7700 064 818', 'alasdair.munro64@example.com', '72 Rose St, St Andrews, KY16 9NS', '2021-07-23', 'Samuel Sinclair (Father) +44 7711 064 837'),
  (65, 'Saoirse', 'Nolan', '1977-11-27', 'Female', '+44 7700 065 828', 'saoirse.nolan65@example.com', '127 Dockside, Aberdeen, AB10 1BD', '2024-10-04', 'Jack Burns (Father) +44 7711 065 514'),
  (66, 'Arthur', 'Stevenson', '1984-08-30', 'Male', '+44 7700 066 666', 'arthur.stevenson66@example.com', '137 Victoria Rd, Perth, PH1 5TJ', '2024-11-18', 'Brenda MacPherson (Brother) +44 7711 066 460'),
  (67, 'Oliver', 'Davidson', '1993-03-03', 'Male', '+44 7700 067 838', 'oliver.davidson67@example.com', '51 Harbour Rd, Glasgow, G12 8SW', '2019-06-06', 'Brenda Gordon (Mother) +44 7711 067 296'),
  (68, 'Morven', 'Khan', '1970-09-26', 'Female', '+44 7700 068 711', 'morven.khan68@example.com', '74 Argyle St, Dundee, DD1 4DF', '2020-05-23', 'James Forbes (Brother) +44 7711 068 283'),
  (69, 'Peter', 'Stewart', '1990-01-24', 'Male', '+44 7700 069 155', 'peter.stewart69@example.com', '143 Queen St, Edinburgh, EH2 2QR', '2017-02-20', 'Grace Ellis (Son) +44 7711 069 205'),
  (70, 'Sienna', 'Bruce', '1979-06-24', 'Female', '+44 7700 070 288', 'sienna.bruce70@example.com', '15 Castle St, Elgin, IV30 1BU', '2017-10-31', 'Lachlan Kerr (Daughter) +44 7711 070 603'),
  (71, 'Faye', 'Douglas', '1998-03-18', 'Female', '+44 7700 071 930', 'faye.douglas71@example.com', '146 Perth Rd, Glasgow, G12 8SW', '2021-09-01', 'Neil Morrison (Cousin) +44 7711 071 882'),
  (72, 'Aisha', 'Forbes', '1958-09-25', 'Female', '+44 7700 072 489', 'aisha.forbes72@example.com', '117 Dockside, Inverness, IV1 1PX', '2023-12-19', 'Bella MacLean (Sister) +44 7711 072 682'),
  (73, 'Logan', 'Reid', '1959-04-17', 'Male', '+44 7700 073 740', 'logan.reid73@example.com', '56 Castle St, Glasgow, G12 8SW', '2017-11-04', 'Theo Findlay (Mother) +44 7711 073 665'),
  (74, 'Alistair', 'Johnston', '1963-11-01', 'Male', '+44 7700 074 581', 'alistair.johnston74@example.com', '76 Union St, Dundee, DD1 4DF', '2022-02-03', 'Daniel Frost (Sister) +44 7711 074 819'),
  (75, 'Lachlan', 'Davidson', '1957-11-17', 'Male', '+44 7700 075 703', 'lachlan.davidson75@example.com', '171 Barnton Ave, Perth, PH1 5TJ', '2018-09-03', 'Lachlan Gordon (Father) +44 7711 075 763'),
  (76, 'Lucy', 'Kerr', '2004-03-25', 'Female', '+44 7700 076 911', 'lucy.kerr76@example.com', '80 Queen St, Elgin, IV30 1BU', '2021-07-07', 'Hamish Henderson (Sister) +44 7711 076 816'),
  (77, 'Nadia', 'Gordon', '1976-08-12', 'Female', '+44 7700 077 182', 'nadia.gordon77@example.com', '155 Union St, Perth, PH1 5TJ', '2017-04-16', 'Miriam Graham (Friend) +44 7711 077 356'),
  (78, 'Archie', 'Crawford', '1970-01-11', 'Male', '+44 7700 078 883', 'archie.crawford78@example.com', '174 South St, Cupar, KY15 4BU', '2022-10-27', 'Lewis Ellis (Mother) +44 7711 078 581'),
  (79, 'Morven', 'Grant', '1970-08-12', 'Female', '+44 7700 079 750', 'morven.grant79@example.com', '127 King St, Elgin, IV30 1BU', '2024-07-07', 'Harris Young (Brother) +44 7711 079 428'),
  (80, 'Cameron', 'Munro', '1981-12-22', 'Male', '+44 7700 080 607', 'cameron.munro80@example.com', '75 Queens Road, St Andrews, KY16 9NS', '2019-10-31', 'Finlay Henderson (Partner) +44 7711 080 422'),
  (81, 'Angus', 'McDonald', '1955-01-01', 'Male', '+44 7700 081 773', 'angus.mcdonald81@example.com', '140 Elm Grove, Perth, PH1 5TJ', '2023-12-26', 'Jamie Ross (Cousin) +44 7711 081 470'),
  (82, 'Laura', 'Johnston', '1959-01-27', 'Female', '+44 7700 082 308', 'laura.johnston82@example.com', '70 Byres Rd, Inverness, IV1 1PX', '2017-04-29', 'Kirsty Nolan (Son) +44 7711 082 224'),
  (83, 'Zoe', 'Findlay', '1962-03-23', 'Other', '+44 7700 083 418', 'zoe.findlay83@example.com', '143 Rose St, St Andrews, KY16 9NS', '2018-04-10', 'Eilidh Sinclair (Father) +44 7711 083 961'),
  (84, 'Ross', 'Baird', '1954-03-20', 'Male', '+44 7700 084 610', 'ross.baird84@example.com', '76 South St, Perth, PH1 5TJ', '2023-03-08', 'Katie Bruce (Father) +44 7711 084 567'),
  (85, 'Fraser', 'Craig', '1975-03-11', 'Male', '+44 7700 085 984', 'fraser.craig85@example.com', '19 South St, Perth, PH1 5TJ', '2017-01-11', 'Archie McDonald (Sister) +44 7711 085 940'),
  (86, 'Oliver', 'Stevenson', '1970-12-04', 'Male', '+44 7700 086 601', 'oliver.stevenson86@example.com', '40 Dockside, St Andrews, KY16 9NS', '2023-02-04', 'Katie Boyd (Brother) +44 7711 086 665'),
  (87, 'Theo', 'Ross', '1963-05-03', 'Male', '+44 7700 087 685', 'theo.ross87@example.com', '100 Bridge St, Perth, PH1 5TJ', '2021-04-11', 'Lewis Graham (Son) +44 7711 087 822'),
  (88, 'Arthur', 'Baird', '1998-09-11', 'Male', '+44 7700 088 137', 'arthur.baird88@example.com', '34 Princes St, Glasgow, G12 8SW', '2017-03-04', 'Kirsty Reid (Cousin) +44 7711 088 567'),
  (89, 'Luna', 'Baird', '1998-02-08', 'Female', '+44 7700 089 580', 'luna.baird89@example.com', '69 Princes St, Cupar, KY15 4BU', '2020-09-07', 'Laura Ritchie (Partner) +44 7711 089 972'),
  (90, 'Kavya', 'Buchanan', '1987-11-17', 'Female', '+44 7700 090 835', 'kavya.buchanan90@example.com', '126 Union St, Cupar, KY15 4BU', '2018-01-06', 'Callum Findlay (Sister) +44 7711 090 332'),
  (91, 'Jamie', 'Ellis', '1967-12-27', 'Male', '+44 7700 091 993', 'jamie.ellis91@example.com', '27 Dockside, Edinburgh, EH2 2QR', '2020-08-21', 'Laura Paterson (Spouse) +44 7711 091 147'),
  (92, 'Orla', 'Boyd', '1984-08-08', 'Female', '+44 7700 092 249', 'orla.boyd92@example.com', '64 Seaton Drive, Cupar, KY15 4BU', '2017-11-20', 'Aisha Grant (Mother) +44 7711 092 279'),
  (93, 'Ivy', 'Wallace', '1964-05-03', 'Female', '+44 7700 093 609', 'ivy.wallace93@example.com', '151 George St, Dundee, DD1 4DF', '2019-11-12', 'Sophie Watson (Sister) +44 7711 093 570'),
  (94, 'Zoe', 'Burns', '1964-10-06', 'Female', '+44 7700 094 261', 'zoe.burns94@example.com', '20 Dockside, Stirling, FK8 1AY', '2019-10-22', 'Bella Paterson (Daughter) +44 7711 094 806'),
  (95, 'Oliver', 'Ross', '1983-09-05', 'Male', '+44 7700 095 209', 'oliver.ross95@example.com', '62 Riverbank, Cupar, KY15 4BU', '2020-04-24', 'Kai Crawford (Sister) +44 7711 095 816'),
  (96, 'Arthur', 'Ritchie', '1990-01-05', 'Male', '+44 7700 096 679', 'arthur.ritchie96@example.com', '177 Nethergate, Cupar, KY15 4BU', '2019-08-01', 'Brenda Cameron (Sister) +44 7711 096 894'),
  (97, 'Ainsley', 'Forbes', '1967-04-08', 'Female', '+44 7700 097 735', 'ainsley.forbes97@example.com', '66 Byres Rd, Glasgow, G12 8SW', '2021-12-11', 'Nadia Baird (Spouse) +44 7711 097 416'),
  (98, 'Owen', 'Khan', '1999-02-16', 'Male', '+44 7700 098 402', 'owen.khan98@example.com', '85 Seaton Drive, Edinburgh, EH2 2QR', '2021-02-07', 'Angus Stewart (Cousin) +44 7711 098 997'),
  (99, 'Morven', 'Robertson', '1991-09-04', 'Female', '+44 7700 099 925', 'morven.robertson99@example.com', '77 Princes St, Glasgow, G12 8SW', '2019-07-14', 'Sophie Kerr (Mother) +44 7711 099 872'),
  (100, 'Miriam', 'Houston', '1982-10-13', 'Female', '+44 7700 100 474', 'miriam.houston100@example.com', '25 Queens Road, Aberdeen, AB10 1BD', '2021-02-18', 'Adam Gordon (Partner) +44 7711 100 565');

 
INSERT INTO professionals VALUES
(1, 'Sarah', 'Campbell', 'GP', '+44 1224 000 111', 's.campbell@clinic.uk'),
(2, 'Michael', 'Fraser', 'Physiotherapist', '+44 1224 000 222', 'm.fraser@clinic.uk'),
(3, 'Aisha', 'Murray', 'Nurse', '+44 1224 000 333', 'a.murray@clinic.uk'),
(4, 'Robert', 'Kennedy', 'Counsellor', '+44 1224 000 444', 'r.kennedy@clinic.uk'),
(5, 'Emily', 'Stewart', 'Dietician', '+44 1224 000 555', 'e.stewart@clinic.uk');

INSERT INTO services VALUES
(1, 'GP Consultation', 'General practitioner consultation', 15, 45.00),
(2, 'Physiotherapy Session', 'Physical therapy session', 45, 60.00),
(3, 'Diabetes Management', 'Review and management plan', 30, 55.00),
(4, 'Counselling Session', 'Talking therapy session', 50, 65.00),
(5, 'Flu Vaccination', 'Seasonal flu shot', 10, 15.00),
(6, 'Health Education Workshop', 'Group health education', 60, 0.00),
(7, 'Blood Test', 'Routine blood panel', 20, 25.00),
(8, 'Blood Pressure Check', 'BP monitor and advice', 10, 10.00),
(9, 'Asthma Review', 'Asthma control review', 25, 40.00),
(10, 'Mental Health Review', 'Medication and wellbeing review', 30, 50.00),
(11, 'Prenatal Checkup', 'Routine prenatal check', 30, 50.00),
(12, 'Postnatal Support', 'Support session post birth', 40, 50.00),
(13, 'Smoking Cessation', 'Stop smoking support', 30, 0.00),
(14, 'Dietician Consultation', 'Nutrition and diet planning', 45, 55.00),
(15, 'Covid Booster', 'Covid-19 booster dose', 10, 20.00);

INSERT INTO appointments VALUES
(1, 1, 1, 1, '2025-10-24 10:30:00', 'Completed', 'Routine GP checkup completed successfully.'),
(2, 2, 2, 2, '2025-10-25 14:00:00', 'Completed', 'Physiotherapy for back pain improvement.'),
(3, 3, 3, 1, '2025-10-26 09:00:00', 'Booked', 'Upcoming diabetes management review.'),
(4, 4, 4, 4, '2025-10-27 11:30:00', 'Completed', 'Counselling session on stress management.'),
(5, 5, 5, 3, '2025-10-28 15:00:00', 'Cancelled', 'Patient cancelled flu vaccination.'),
(6, 87, 12, 3, '2025-01-22 11:45:00', 'Booked', 'Postnatal support session and follow-up advice planned.'),
(7, 48, 2, 2, '2025-01-24 10:45:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(8, 72, 6, 3, '2025-01-26 10:00:00', 'Completed', 'Health education workshop attendance recorded.'),
(9, 60, 15, 3, '2025-01-28 11:45:00', 'Completed', 'Covid booster appointment completed or scheduled.'),
(10, 6, 1, 1, '2025-01-29 12:00:00', 'Completed', 'General consultation completed with routine advice provided.'),
(11, 69, 3, 3, '2025-01-31 12:30:00', 'Completed', 'Diabetes management review and monitoring discussed.'),
(12, 96, 12, 3, '2025-02-03 12:15:00', 'Cancelled', 'Appointment cancelled before attendance: Postnatal Support.'),
(13, 84, 2, 2, '2025-02-04 13:45:00', 'Cancelled', 'Appointment cancelled before attendance: Physiotherapy Session.'),
(14, 36, 1, 1, '2025-02-07 11:15:00', 'Completed', 'General consultation completed with routine advice provided.'),
(15, 31, 14, 5, '2025-02-08 09:30:00', 'Completed', 'Dietary review with personalised nutrition plan.'),
(16, 83, 6, 3, '2025-02-09 12:30:00', 'Completed', 'Health education workshop attendance recorded.'),
(17, 16, 14, 5, '2025-02-12 09:15:00', 'Completed', 'Dietary review with personalised nutrition plan.'),
(18, 77, 1, 1, '2025-02-13 15:30:00', 'Completed', 'General consultation completed with routine advice provided.'),
(19, 17, 13, 4, '2025-02-17 10:00:00', 'Booked', 'Smoking cessation support and replacement options discussed.'),
(20, 71, 4, 4, '2025-02-19 10:15:00', 'Completed', 'Counselling session focused on stress and coping strategies.'),
(21, 19, 13, 4, '2025-02-21 09:30:00', 'Booked', 'Smoking cessation support and replacement options discussed.'),
(22, 19, 3, 3, '2025-02-23 11:15:00', 'Completed', 'Diabetes management review and monitoring discussed.'),
(23, 4, 3, 3, '2025-02-23 11:15:00', 'Completed', 'Diabetes management review and monitoring discussed.'),
(24, 3, 3, 3, '2025-02-26 09:15:00', 'Booked', 'Diabetes management review and monitoring discussed.'),
(25, 68, 2, 2, '2025-03-01 09:45:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(26, 47, 9, 1, '2025-03-03 09:45:00', 'Completed', 'Asthma review and inhaler technique checked.'),
(27, 79, 1, 1, '2025-03-05 15:30:00', 'Completed', 'General consultation completed with routine advice provided.'),
(28, 4, 1, 1, '2025-03-06 15:45:00', 'Completed', 'General consultation completed with routine advice provided.'),
(29, 14, 8, 3, '2025-03-09 12:00:00', 'Cancelled', 'Appointment cancelled before attendance: Blood Pressure Check.'),
(30, 42, 10, 4, '2025-03-09 09:15:00', 'Completed', 'Mental health medication and wellbeing review.'),
(31, 82, 10, 4, '2025-03-13 14:30:00', 'Completed', 'Mental health medication and wellbeing review.'),
(32, 77, 9, 1, '2025-03-14 12:45:00', 'Completed', 'Asthma review and inhaler technique checked.'),
(33, 90, 2, 2, '2025-03-17 14:15:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(34, 30, 7, 3, '2025-03-18 15:45:00', 'Completed', 'Routine blood sample collected for testing.'),
(35, 94, 2, 2, '2025-03-20 12:30:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(36, 48, 3, 3, '2025-03-23 12:00:00', 'Completed', 'Diabetes management review and monitoring discussed.'),
(37, 11, 2, 2, '2025-03-24 09:30:00', 'Booked', 'Physiotherapy review with exercise plan updated.'),
(38, 72, 1, 1, '2025-03-27 13:30:00', 'Completed', 'General consultation completed with routine advice provided.'),
(39, 53, 6, 3, '2025-03-29 15:45:00', 'Cancelled', 'Appointment cancelled before attendance: Health Education Workshop.'),
(40, 93, 1, 1, '2025-03-30 13:30:00', 'Completed', 'General consultation completed with routine advice provided.'),
(41, 74, 9, 1, '2025-03-31 10:45:00', 'Completed', 'Asthma review and inhaler technique checked.'),
(42, 14, 6, 3, '2025-04-04 11:00:00', 'Booked', 'Health education workshop attendance recorded.'),
(43, 74, 4, 4, '2025-04-05 15:00:00', 'Completed', 'Counselling session focused on stress and coping strategies.'),
(44, 85, 14, 5, '2025-04-08 11:00:00', 'Completed', 'Dietary review with personalised nutrition plan.'),
(45, 90, 13, 4, '2025-04-09 11:30:00', 'Completed', 'Smoking cessation support and replacement options discussed.'),
(46, 19, 10, 4, '2025-04-12 12:00:00', 'Completed', 'Mental health medication and wellbeing review.'),
(47, 82, 1, 1, '2025-04-12 14:15:00', 'Completed', 'General consultation completed with routine advice provided.'),
(48, 59, 6, 3, '2025-04-14 11:30:00', 'Booked', 'Health education workshop attendance recorded.'),
(49, 100, 10, 4, '2025-04-18 09:00:00', 'Completed', 'Mental health medication and wellbeing review.'),
(50, 97, 10, 4, '2025-04-18 14:00:00', 'Completed', 'Mental health medication and wellbeing review.'),
(51, 85, 7, 3, '2025-04-21 13:45:00', 'Completed', 'Routine blood sample collected for testing.'),
(52, 28, 13, 4, '2025-04-24 09:30:00', 'Completed', 'Smoking cessation support and replacement options discussed.'),
(53, 37, 11, 1, '2025-04-26 13:45:00', 'Completed', 'Routine prenatal check and observations recorded.'),
(54, 40, 1, 1, '2025-04-26 12:00:00', 'Completed', 'General consultation completed with routine advice provided.'),
(55, 39, 4, 4, '2025-04-28 15:30:00', 'Completed', 'Counselling session focused on stress and coping strategies.'),
(56, 16, 1, 1, '2025-05-01 14:45:00', 'Completed', 'General consultation completed with routine advice provided.'),
(57, 49, 9, 1, '2025-05-04 10:30:00', 'Completed', 'Asthma review and inhaler technique checked.'),
(58, 95, 1, 1, '2025-05-05 09:45:00', 'Cancelled', 'Appointment cancelled before attendance: GP Consultation.'),
(59, 41, 10, 4, '2025-05-07 13:45:00', 'Booked', 'Mental health medication and wellbeing review.'),
(60, 54, 5, 3, '2025-05-08 12:00:00', 'No-show', 'Patient did not attend scheduled flu vaccination.'),
(61, 22, 13, 4, '2025-05-12 12:30:00', 'Completed', 'Smoking cessation support and replacement options discussed.'),
(62, 14, 4, 4, '2025-05-13 13:45:00', 'Completed', 'Counselling session focused on stress and coping strategies.'),
(63, 51, 14, 5, '2025-05-15 14:30:00', 'Completed', 'Dietary review with personalised nutrition plan.'),
(64, 100, 3, 3, '2025-05-16 13:00:00', 'Completed', 'Diabetes management review and monitoring discussed.'),
(65, 25, 15, 3, '2025-05-19 11:15:00', 'Completed', 'Covid booster appointment completed or scheduled.'),
(66, 19, 5, 3, '2025-05-20 10:15:00', 'Booked', 'Seasonal flu vaccination appointment.'),
(67, 84, 2, 2, '2025-05-22 15:45:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(68, 73, 13, 4, '2025-05-26 12:30:00', 'Cancelled', 'Appointment cancelled before attendance: Smoking Cessation.'),
(69, 81, 6, 3, '2025-05-26 12:00:00', 'Completed', 'Health education workshop attendance recorded.'),
(70, 81, 5, 3, '2025-05-29 13:00:00', 'Completed', 'Seasonal flu vaccination appointment.'),
(71, 10, 5, 3, '2025-05-31 12:00:00', 'Completed', 'Seasonal flu vaccination appointment.'),
(72, 37, 2, 2, '2025-06-03 15:00:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(73, 65, 7, 3, '2025-06-04 13:00:00', 'Completed', 'Routine blood sample collected for testing.'),
(74, 74, 11, 1, '2025-06-05 11:45:00', 'Completed', 'Routine prenatal check and observations recorded.'),
(75, 8, 8, 3, '2025-06-07 15:30:00', 'No-show', 'Patient did not attend scheduled blood pressure check.'),
(76, 11, 9, 1, '2025-06-11 10:00:00', 'Completed', 'Asthma review and inhaler technique checked.'),
(77, 57, 8, 3, '2025-06-13 13:15:00', 'Completed', 'Blood pressure check and lifestyle advice provided.'),
(78, 37, 7, 3, '2025-06-14 15:30:00', 'Completed', 'Routine blood sample collected for testing.'),
(79, 7, 13, 4, '2025-06-17 14:30:00', 'Completed', 'Smoking cessation support and replacement options discussed.'),
(80, 13, 9, 1, '2025-06-19 12:30:00', 'Completed', 'Asthma review and inhaler technique checked.'),
(81, 85, 15, 3, '2025-06-21 15:15:00', 'Completed', 'Covid booster appointment completed or scheduled.'),
(82, 75, 11, 1, '2025-06-21 11:30:00', 'No-show', 'Patient did not attend scheduled prenatal checkup.'),
(83, 90, 11, 1, '2025-06-24 10:00:00', 'Completed', 'Routine prenatal check and observations recorded.'),
(84, 49, 11, 1, '2025-06-26 15:15:00', 'Completed', 'Routine prenatal check and observations recorded.'),
(85, 95, 11, 1, '2025-06-29 09:45:00', 'Completed', 'Routine prenatal check and observations recorded.'),
(86, 3, 6, 3, '2025-06-30 10:15:00', 'Completed', 'Health education workshop attendance recorded.'),
(87, 99, 8, 3, '2025-07-01 10:15:00', 'Completed', 'Blood pressure check and lifestyle advice provided.'),
(88, 38, 14, 5, '2025-07-03 13:00:00', 'Completed', 'Dietary review with personalised nutrition plan.'),
(89, 99, 10, 4, '2025-07-05 13:45:00', 'Completed', 'Mental health medication and wellbeing review.'),
(90, 24, 14, 5, '2025-07-09 15:15:00', 'Booked', 'Dietary review with personalised nutrition plan.'),
(91, 6, 7, 3, '2025-07-10 14:15:00', 'No-show', 'Patient did not attend scheduled blood test.'),
(92, 79, 5, 3, '2025-07-13 15:45:00', 'Completed', 'Seasonal flu vaccination appointment.'),
(93, 31, 5, 3, '2025-07-14 15:15:00', 'Completed', 'Seasonal flu vaccination appointment.'),
(94, 74, 8, 3, '2025-07-16 15:30:00', 'Booked', 'Blood pressure check and lifestyle advice planned.'),
(95, 65, 9, 1, '2025-07-18 10:15:00', 'Booked', 'Asthma review and inhaler technique checked.'),
(96, 18, 14, 5, '2025-07-20 09:45:00', 'Cancelled', 'Appointment cancelled before attendance: Dietician Consultation.'),
(97, 71, 15, 3, '2025-07-21 14:00:00', 'Completed', 'Covid booster appointment completed or scheduled.'),
(98, 98, 3, 3, '2025-07-24 12:15:00', 'Booked', 'Diabetes management review and monitoring discussed.'),
(99, 12, 15, 3, '2025-07-25 15:45:00', 'Cancelled', 'Appointment cancelled before attendance: Covid Booster.'),
(100, 4, 7, 3, '2025-07-27 12:30:00', 'Completed', 'Routine blood sample collected for testing.'),
(101, 11, 6, 3, '2025-07-29 09:30:00', 'Cancelled', 'Appointment cancelled before attendance: Health Education Workshop.'),
(102, 92, 11, 1, '2025-08-01 15:15:00', 'Completed', 'Routine prenatal check and observations recorded.'),
(103, 37, 15, 3, '2025-08-03 14:15:00', 'Booked', 'Covid booster appointment scheduled or scheduled.'),
(104, 61, 8, 3, '2025-08-06 09:00:00', 'Completed', 'Blood pressure check and lifestyle advice provided.'),
(105, 28, 14, 5, '2025-08-06 13:45:00', 'Completed', 'Dietary review with personalised nutrition plan.'),
(106, 37, 4, 4, '2025-08-09 09:00:00', 'Completed', 'Counselling session focused on stress and coping strategies.'),
(107, 82, 13, 4, '2025-08-12 12:00:00', 'Completed', 'Smoking cessation support and replacement options discussed.'),
(108, 64, 10, 4, '2025-08-14 09:15:00', 'Booked', 'Mental health medication and wellbeing review.'),
(109, 38, 7, 3, '2025-08-14 13:30:00', 'Completed', 'Routine blood sample collected for testing.'),
(110, 54, 3, 3, '2025-08-18 14:00:00', 'Completed', 'Diabetes management review and monitoring discussed.'),
(111, 47, 2, 2, '2025-08-20 13:00:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(112, 61, 1, 1, '2025-08-22 12:30:00', 'Completed', 'General consultation completed with routine advice provided.'),
(113, 3, 6, 3, '2025-08-22 11:15:00', 'Booked', 'Health education workshop attendance recorded.'),
(114, 81, 2, 2, '2025-08-26 14:30:00', 'Completed', 'Physiotherapy review with exercise plan updated.'),
(115, 46, 9, 1, '2025-08-27 15:15:00', 'Booked', 'Asthma review and inhaler technique checked.'),
(116, 88, 8, 3, '2025-08-30 12:15:00', 'Booked', 'Blood pressure check and lifestyle advice planned.'),
(117, 9, 12, 3, '2025-08-31 09:30:00', 'Completed', 'Postnatal support session and follow-up advice provided.'),
(118, 26, 15, 3, '2025-09-01 11:30:00', 'Completed', 'Covid booster appointment completed or scheduled.'),
(119, 70, 8, 3, '2025-09-04 09:15:00', 'Completed', 'Blood pressure check and lifestyle advice provided.'),
(120, 100, 1, 1, '2025-09-07 11:30:00', 'Completed', 'General consultation completed with routine advice provided.');

INSERT INTO attendance VALUES
(1, 1, '2025-10-24 10:20:00', '2025-10-24 11:15:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(2, 2, '2025-10-25 13:45:00', '2025-10-25 14:45:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(3, 3, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(4, 4, '2025-10-27 11:20:00', '2025-10-27 12:05:00', 'Attended', 'Patient engaged well; follow-up session recommended.'),
(5, 5, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(6, 6, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(7, 7, '2025-01-24 10:35:00', '2025-01-24 11:30:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(8, 8, '2025-01-26 09:45:00', '2025-01-26 10:35:00', 'Attended', 'Group session completed; information leaflet provided.'),
(9, 9, '2025-01-28 11:30:00', '2025-01-28 12:30:00', 'Attended', 'Booster status recorded with aftercare advice.'),
(10, 10, '2025-01-29 11:45:00', '2025-01-29 12:25:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(11, 11, '2025-01-31 12:20:00', '2025-01-31 12:45:00', 'Attended', 'Blood glucose trends reviewed; monitoring plan updated.'),
(12, 12, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(13, 13, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(14, 14, '2025-02-07 11:00:00', '2025-02-07 11:50:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(15, 15, '2025-02-08 09:15:00', '2025-02-08 10:15:00', 'Attended', 'Meal plan reviewed; realistic dietary goals agreed.'),
(16, 16, '2025-02-09 12:20:00', '2025-02-09 13:05:00', 'Attended', 'Group session completed; information leaflet provided.'),
(17, 17, '2025-02-12 09:00:00', '2025-02-12 09:50:00', 'Attended', 'Meal plan reviewed; realistic dietary goals agreed.'),
(18, 18, '2025-02-13 15:20:00', '2025-02-13 16:05:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(19, 19, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(20, 20, '2025-02-19 10:10:00', '2025-02-19 10:30:00', 'Attended', 'Patient engaged well; follow-up session recommended.'),
(21, 21, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(22, 22, '2025-02-23 11:05:00', '2025-02-23 11:50:00', 'Attended', 'Blood glucose trends reviewed; monitoring plan updated.'),
(23, 23, '2025-02-23 11:00:00', '2025-02-23 11:40:00', 'Attended', 'Blood glucose trends reviewed; monitoring plan updated.'),
(24, 24, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(25, 25, '2025-03-01 09:40:00', '2025-03-01 10:40:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(26, 26, '2025-03-03 09:35:00', '2025-03-03 10:00:00', 'Attended', 'Asthma control reviewed; action plan updated.'),
(27, 27, '2025-03-05 15:25:00', '2025-03-05 16:05:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(28, 28, '2025-03-06 15:30:00', '2025-03-06 16:00:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(29, 29, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(30, 30, '2025-03-09 09:00:00', '2025-03-09 10:00:00', 'Attended', 'Medication tolerance discussed; wellbeing plan reviewed.'),
(31, 31, '2025-03-13 14:20:00', '2025-03-13 15:15:00', 'Attended', 'Medication tolerance discussed; wellbeing plan reviewed.'),
(32, 32, '2025-03-14 12:30:00', '2025-03-14 13:10:00', 'Attended', 'Asthma control reviewed; action plan updated.'),
(33, 33, '2025-03-17 14:05:00', '2025-03-17 14:50:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(34, 34, '2025-03-18 15:40:00', '2025-03-18 16:00:00', 'Attended', 'Sample taken and sent to laboratory.'),
(35, 35, '2025-03-20 12:25:00', '2025-03-20 13:15:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(36, 36, '2025-03-23 11:45:00', '2025-03-23 12:15:00', 'Attended', 'Blood glucose trends reviewed; monitoring plan updated.'),
(37, 37, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(38, 38, '2025-03-27 13:20:00', '2025-03-27 14:15:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(39, 39, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(40, 40, '2025-03-30 13:15:00', '2025-03-30 14:05:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(41, 41, '2025-03-31 10:35:00', '2025-03-31 11:10:00', 'Attended', 'Asthma control reviewed; action plan updated.'),
(42, 42, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(43, 43, '2025-04-05 14:55:00', '2025-04-05 15:45:00', 'Attended', 'Patient engaged well; follow-up session recommended.'),
(44, 44, '2025-04-08 10:45:00', '2025-04-08 11:45:00', 'Attended', 'Meal plan reviewed; realistic dietary goals agreed.'),
(45, 45, '2025-04-09 11:15:00', '2025-04-09 12:05:00', 'Attended', 'Quit plan reviewed; replacement therapy discussed.'),
(46, 46, '2025-04-12 11:45:00', '2025-04-12 12:15:00', 'Attended', 'Medication tolerance discussed; wellbeing plan reviewed.'),
(47, 47, '2025-04-12 14:05:00', '2025-04-12 14:50:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(48, 48, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(49, 49, '2025-04-18 08:45:00', '2025-04-18 09:25:00', 'Attended', 'Medication tolerance discussed; wellbeing plan reviewed.'),
(50, 50, '2025-04-18 13:45:00', '2025-04-18 14:25:00', 'Attended', 'Medication tolerance discussed; wellbeing plan reviewed.'),
(51, 51, '2025-04-21 13:40:00', '2025-04-21 14:10:00', 'Attended', 'Sample taken and sent to laboratory.'),
(52, 52, '2025-04-24 09:20:00', '2025-04-24 09:45:00', 'Attended', 'Quit plan reviewed; replacement therapy discussed.'),
(53, 53, '2025-04-26 13:30:00', '2025-04-26 14:20:00', 'Attended', 'Routine checks normal; next appointment advised.'),
(54, 54, '2025-04-26 11:45:00', '2025-04-26 12:25:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(55, 55, '2025-04-28 15:25:00', '2025-04-28 15:45:00', 'Attended', 'Patient engaged well; follow-up session recommended.'),
(56, 56, '2025-05-01 14:30:00', '2025-05-01 15:30:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(57, 57, '2025-05-04 10:20:00', '2025-05-04 11:25:00', 'Attended', 'Asthma control reviewed; action plan updated.'),
(58, 58, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(59, 59, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(60, 60, NULL, NULL, 'No-show', 'Patient did not attend; follow-up may be required.'),
(61, 61, '2025-05-12 12:20:00', '2025-05-12 12:45:00', 'Attended', 'Quit plan reviewed; replacement therapy discussed.'),
(62, 62, '2025-05-13 13:30:00', '2025-05-13 14:40:00', 'Attended', 'Patient engaged well; follow-up session recommended.'),
(63, 63, '2025-05-15 14:15:00', '2025-05-15 15:25:00', 'Attended', 'Meal plan reviewed; realistic dietary goals agreed.'),
(64, 64, '2025-05-16 12:55:00', '2025-05-16 13:45:00', 'Attended', 'Blood glucose trends reviewed; monitoring plan updated.'),
(65, 65, '2025-05-19 11:10:00', '2025-05-19 11:30:00', 'Attended', 'Booster status recorded with aftercare advice.'),
(66, 66, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(67, 67, '2025-05-22 15:35:00', '2025-05-22 16:10:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(68, 68, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(69, 69, '2025-05-26 11:45:00', '2025-05-26 12:25:00', 'Attended', 'Group session completed; information leaflet provided.'),
(70, 70, '2025-05-29 12:45:00', '2025-05-29 13:35:00', 'Attended', 'Vaccine administered or appointment status recorded.'),
(71, 71, '2025-05-31 11:50:00', '2025-05-31 12:25:00', 'Attended', 'Vaccine administered or appointment status recorded.'),
(72, 72, '2025-06-03 14:45:00', '2025-06-03 15:35:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(73, 73, '2025-06-04 12:50:00', '2025-06-04 13:55:00', 'Attended', 'Sample taken and sent to laboratory.'),
(74, 74, '2025-06-05 11:30:00', '2025-06-05 12:10:00', 'Attended', 'Routine checks normal; next appointment advised.'),
(75, 75, NULL, NULL, 'No-show', 'Patient did not attend; follow-up may be required.'),
(76, 76, '2025-06-11 09:45:00', '2025-06-11 10:25:00', 'Attended', 'Asthma control reviewed; action plan updated.'),
(77, 77, '2025-06-13 13:00:00', '2025-06-13 14:10:00', 'Attended', 'Blood pressure measured; lifestyle advice discussed.'),
(78, 78, '2025-06-14 15:15:00', '2025-06-14 15:45:00', 'Attended', 'Sample taken and sent to laboratory.'),
(79, 79, '2025-06-17 14:25:00', '2025-06-17 14:45:00', 'Attended', 'Quit plan reviewed; replacement therapy discussed.'),
(80, 80, '2025-06-19 12:15:00', '2025-06-19 13:25:00', 'Attended', 'Asthma control reviewed; action plan updated.'),
(81, 81, '2025-06-21 15:10:00', '2025-06-21 16:10:00', 'Attended', 'Booster status recorded with aftercare advice.'),
(82, 82, NULL, NULL, 'No-show', 'Patient did not attend; follow-up may be required.'),
(83, 83, '2025-06-24 09:45:00', '2025-06-24 10:15:00', 'Attended', 'Routine checks normal; next appointment advised.'),
(84, 84, '2025-06-26 15:00:00', '2025-06-26 16:10:00', 'Attended', 'Routine checks normal; next appointment advised.'),
(85, 85, '2025-06-29 09:35:00', '2025-06-29 10:30:00', 'Attended', 'Routine checks normal; next appointment advised.'),
(86, 86, '2025-06-30 10:00:00', '2025-06-30 11:00:00', 'Attended', 'Group session completed; information leaflet provided.'),
(87, 87, '2025-07-01 10:10:00', '2025-07-01 10:30:00', 'Attended', 'Blood pressure measured; lifestyle advice discussed.'),
(88, 88, '2025-07-03 12:50:00', '2025-07-03 13:45:00', 'Attended', 'Meal plan reviewed; realistic dietary goals agreed.'),
(89, 89, '2025-07-05 13:35:00', '2025-07-05 14:40:00', 'Attended', 'Medication tolerance discussed; wellbeing plan reviewed.'),
(90, 90, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(91, 91, NULL, NULL, 'No-show', 'Patient did not attend; follow-up may be required.'),
(92, 92, '2025-07-13 15:30:00', '2025-07-13 16:20:00', 'Attended', 'Vaccine administered or appointment status recorded.'),
(93, 93, '2025-07-14 15:05:00', '2025-07-14 16:00:00', 'Attended', 'Vaccine administered or appointment status recorded.'),
(94, 94, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(95, 95, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(96, 96, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(97, 97, '2025-07-21 13:50:00', '2025-07-21 14:55:00', 'Attended', 'Booster status recorded with aftercare advice.'),
(98, 98, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(99, 99, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(100, 100, '2025-07-27 12:20:00', '2025-07-27 12:55:00', 'Attended', 'Sample taken and sent to laboratory.'),
(101, 101, NULL, NULL, 'Cancelled', 'Appointment cancelled before consultation.'),
(102, 102, '2025-08-01 15:05:00', '2025-08-01 16:00:00', 'Attended', 'Routine checks normal; next appointment advised.'),
(103, 103, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(104, 104, '2025-08-06 08:55:00', '2025-08-06 09:15:00', 'Attended', 'Blood pressure measured; lifestyle advice discussed.'),
(105, 105, '2025-08-06 13:35:00', '2025-08-06 14:40:00', 'Attended', 'Meal plan reviewed; realistic dietary goals agreed.'),
(106, 106, '2025-08-09 08:55:00', '2025-08-09 09:35:00', 'Attended', 'Patient engaged well; follow-up session recommended.'),
(107, 107, '2025-08-12 11:45:00', '2025-08-12 12:35:00', 'Attended', 'Quit plan reviewed; replacement therapy discussed.'),
(108, 108, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(109, 109, '2025-08-14 13:25:00', '2025-08-14 14:15:00', 'Attended', 'Sample taken and sent to laboratory.'),
(110, 110, '2025-08-18 13:50:00', '2025-08-18 14:45:00', 'Attended', 'Blood glucose trends reviewed; monitoring plan updated.'),
(111, 111, '2025-08-20 12:50:00', '2025-08-20 13:15:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(112, 112, '2025-08-22 12:20:00', '2025-08-22 13:25:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.'),
(113, 113, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(114, 114, '2025-08-26 14:25:00', '2025-08-26 14:55:00', 'Attended', 'Mobility improved; home exercise plan reinforced.'),
(115, 115, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(116, 116, NULL, NULL, 'Pending', 'Appointment scheduled; clinical notes not yet available.'),
(117, 117, '2025-08-31 09:25:00', '2025-08-31 09:45:00', 'Attended', 'Support provided; feeding and recovery advice discussed.'),
(118, 118, '2025-09-01 11:15:00', '2025-09-01 12:15:00', 'Attended', 'Booster status recorded with aftercare advice.'),
(119, 119, '2025-09-04 09:10:00', '2025-09-04 09:30:00', 'Attended', 'Blood pressure measured; lifestyle advice discussed.'),
(120, 120, '2025-09-07 11:20:00', '2025-09-07 12:05:00', 'Attended', 'Vitals reviewed; patient advised to book follow-up if symptoms continue.');

INSERT INTO bills VALUES
(1, 1, 45.00, FALSE, NULL),
(2, 2, 60.00, FALSE, NULL),
(3, 3, 55.00, FALSE, NULL),
(4, 4, 65.00, FALSE, NULL),
(5, 5, 0.00, FALSE, NULL),
(6, 6, 50.00, FALSE, NULL),
(7, 7, 60.00, TRUE, '2025-01-24'),
(8, 8, 0.00, TRUE, '2025-01-26'),
(9, 9, 20.00, TRUE, '2025-01-28'),
(10, 10, 45.00, TRUE, '2025-01-29'),
(11, 11, 55.00, TRUE, '2025-01-31'),
(12, 12, 0.00, FALSE, NULL),
(13, 13, 0.00, FALSE, NULL),
(14, 14, 45.00, TRUE, '2025-02-07'),
(15, 15, 55.00, TRUE, '2025-02-08'),
(16, 16, 0.00, TRUE, '2025-02-09'),
(17, 17, 55.00, TRUE, '2025-02-12'),
(18, 18, 45.00, TRUE, '2025-02-13'),
(19, 19, 0.00, FALSE, NULL),
(20, 20, 65.00, TRUE, '2025-02-19'),
(21, 21, 0.00, FALSE, NULL),
(22, 22, 55.00, TRUE, '2025-02-23'),
(23, 23, 55.00, FALSE, NULL),
(24, 24, 55.00, FALSE, NULL),
(25, 25, 60.00, TRUE, '2025-03-01'),
(26, 26, 40.00, TRUE, '2025-03-03'),
(27, 27, 45.00, TRUE, '2025-03-05'),
(28, 28, 45.00, TRUE, '2025-03-06'),
(29, 29, 0.00, FALSE, NULL),
(30, 30, 50.00, FALSE, NULL),
(31, 31, 50.00, TRUE, '2025-03-13'),
(32, 32, 40.00, TRUE, '2025-03-14'),
(33, 33, 60.00, TRUE, '2025-03-17'),
(34, 34, 25.00, TRUE, '2025-03-18'),
(35, 35, 60.00, TRUE, '2025-03-20'),
(36, 36, 55.00, TRUE, '2025-03-23'),
(37, 37, 60.00, FALSE, NULL),
(38, 38, 45.00, TRUE, '2025-03-27'),
(39, 39, 0.00, FALSE, NULL),
(40, 40, 45.00, TRUE, '2025-03-30'),
(41, 41, 40.00, TRUE, '2025-03-31'),
(42, 42, 0.00, FALSE, NULL),
(43, 43, 65.00, TRUE, '2025-04-05'),
(44, 44, 55.00, FALSE, NULL),
(45, 45, 0.00, TRUE, '2025-04-09'),
(46, 46, 50.00, TRUE, '2025-04-12'),
(47, 47, 45.00, FALSE, NULL),
(48, 48, 0.00, FALSE, NULL),
(49, 49, 50.00, TRUE, '2025-04-18'),
(50, 50, 50.00, TRUE, '2025-04-18'),
(51, 51, 25.00, TRUE, '2025-04-21'),
(52, 52, 0.00, TRUE, '2025-04-24'),
(53, 53, 50.00, TRUE, '2025-04-26'),
(54, 54, 45.00, TRUE, '2025-04-26'),
(55, 55, 65.00, TRUE, '2025-04-28'),
(56, 56, 45.00, TRUE, '2025-05-01'),
(57, 57, 40.00, TRUE, '2025-05-04'),
(58, 58, 0.00, FALSE, NULL),
(59, 59, 50.00, FALSE, NULL),
(60, 60, 15.00, FALSE, NULL),
(61, 61, 0.00, TRUE, '2025-05-12'),
(62, 62, 65.00, TRUE, '2025-05-13'),
(63, 63, 55.00, TRUE, '2025-05-15'),
(64, 64, 55.00, TRUE, '2025-05-16'),
(65, 65, 20.00, TRUE, '2025-05-19'),
(66, 66, 15.00, FALSE, NULL),
(67, 67, 60.00, TRUE, '2025-05-22'),
(68, 68, 0.00, FALSE, NULL),
(69, 69, 0.00, TRUE, '2025-05-26'),
(70, 70, 15.00, FALSE, NULL),
(71, 71, 15.00, TRUE, '2025-05-31'),
(72, 72, 60.00, TRUE, '2025-06-03'),
(73, 73, 25.00, TRUE, '2025-06-04'),
(74, 74, 50.00, TRUE, '2025-06-05'),
(75, 75, 10.00, FALSE, NULL),
(76, 76, 40.00, TRUE, '2025-06-11'),
(77, 77, 10.00, TRUE, '2025-06-13'),
(78, 78, 25.00, FALSE, NULL),
(79, 79, 0.00, TRUE, '2025-06-17'),
(80, 80, 40.00, TRUE, '2025-06-19'),
(81, 81, 20.00, TRUE, '2025-06-21'),
(82, 82, 50.00, FALSE, NULL),
(83, 83, 50.00, TRUE, '2025-06-24'),
(84, 84, 50.00, TRUE, '2025-06-26'),
(85, 85, 50.00, TRUE, '2025-06-29'),
(86, 86, 0.00, TRUE, '2025-06-30'),
(87, 87, 10.00, TRUE, '2025-07-01'),
(88, 88, 55.00, TRUE, '2025-07-03'),
(89, 89, 50.00, TRUE, '2025-07-05'),
(90, 90, 55.00, FALSE, NULL),
(91, 91, 25.00, FALSE, NULL),
(92, 92, 15.00, TRUE, '2025-07-13'),
(93, 93, 15.00, TRUE, '2025-07-14'),
(94, 94, 10.00, FALSE, NULL),
(95, 95, 40.00, FALSE, NULL),
(96, 96, 0.00, FALSE, NULL),
(97, 97, 20.00, TRUE, '2025-07-21'),
(98, 98, 55.00, FALSE, NULL),
(99, 99, 0.00, FALSE, NULL),
(100, 100, 25.00, TRUE, '2025-07-27'),
(101, 101, 0.00, FALSE, NULL),
(102, 102, 50.00, TRUE, '2025-08-01'),
(103, 103, 20.00, FALSE, NULL),
(104, 104, 10.00, TRUE, '2025-08-06'),
(105, 105, 55.00, TRUE, '2025-08-06'),
(106, 106, 65.00, FALSE, NULL),
(107, 107, 0.00, TRUE, '2025-08-12'),
(108, 108, 50.00, FALSE, NULL),
(109, 109, 25.00, FALSE, NULL),
(110, 110, 55.00, FALSE, NULL),
(111, 111, 60.00, TRUE, '2025-08-20'),
(112, 112, 45.00, TRUE, '2025-08-22'),
(113, 113, 0.00, FALSE, NULL),
(114, 114, 60.00, TRUE, '2025-08-26'),
(115, 115, 40.00, FALSE, NULL),
(116, 116, 10.00, FALSE, NULL),
(117, 117, 50.00, TRUE, '2025-08-31'),
(118, 118, 20.00, TRUE, '2025-09-01'),
(119, 119, 10.00, TRUE, '2025-09-04'),
(120, 120, 45.00, TRUE, '2025-09-07');


-- =====================================================
-- Example Analytical Queries
-- =====================================================

-- Query 1: Female patients within a selected date-of-birth range
SELECT 
    patient_id, 
    first_name, 
    last_name, 
    dob, 
    address
FROM patients
WHERE LOWER(sex) = 'female'
  AND dob BETWEEN '1955-11-01' AND '1980-11-01';

-- Query 2: Cancelled appointments
SELECT *
FROM appointments
WHERE LOWER(status) = 'cancelled';

-- Query 3: Upcoming appointments with patient contact details
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.phone,
    a.appointment_datetime
FROM appointments a
JOIN patients p 
    ON a.patient_id = p.patient_id
WHERE a.appointment_datetime > '2025-01-01'
ORDER BY a.appointment_datetime;

-- Query 4: Bill payment status by patient and service
SELECT 
    b.bill_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient,
    s.service_name,
    b.amount,
    CASE 
        WHEN b.paid = TRUE THEN 'Paid' 
        ELSE 'Unpaid' 
    END AS payment_status
FROM bills b
JOIN appointments a 
    ON b.appointment_id = a.appointment_id
JOIN patients p 
    ON a.patient_id = p.patient_id
JOIN services s 
    ON a.service_id = s.service_id
ORDER BY 
    b.paid DESC, 
    p.first_name DESC;

-- Query 5: Total revenue by service for paid bills in 2025
SELECT 
    s.service_name,
    SUM(b.amount) AS total_revenue,
    COUNT(*) AS number_of_bills
FROM bills b
JOIN appointments a 
    ON b.appointment_id = a.appointment_id
JOIN services s 
    ON a.service_id = s.service_id
WHERE b.paid = TRUE
  AND b.paid_date BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY s.service_name
ORDER BY total_revenue DESC;

-- Query 6: Total number of appointments per patient
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(*) AS total_appointments
FROM appointments a
JOIN patients p 
    ON a.patient_id = p.patient_id
GROUP BY 
    p.patient_id,
    p.first_name,
    p.last_name
ORDER BY total_appointments DESC;
