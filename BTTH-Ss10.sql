create database btss10;
use btss10;
CREATE TABLE Patients (
    Patient_ID CHAR(5) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Admission_Time DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Vitals_Logs (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID CHAR(5),
    Heart_Rate INT CHECK (Heart_Rate > 0),
    Blood_Pressure VARCHAR(10),
    Record_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);
INSERT INTO Patients (Patient_ID, Full_Name) VALUES
('BN001', 'Nguyen Van A'),
('BN002', 'Tran Thi B'),
('BN003', 'Le Van C');
INSERT INTO Vitals_Logs (Patient_ID, Heart_Rate, Blood_Pressure) VALUES
('BN001', 72, '120/80'),
('BN001', 75, '118/79'),
('BN002', 80, '130/85'),
('BN003', 65, '110/70'),
('BN003', 70, '115/75');
 create index idx_search on VItals_logs(Patient_ID,Log_ID);
create or replace view  ER_Dashboard_View as 
 select ifnull(Heart_Rate,'Pending'),
 p.Full_Name,
 p.Admission_Time,
 v.Blood_Pressure,
 case 
 when heart_rate > 50 then 'CRITICAL' 
 when heart_rate < 50 then 'STABLE'
 end as Urgency_Level
 from vitals_logs as v
 join patients as  p
 on v.patient_id = p.patient_id;
 select * from ER_Dashboard_View;
 
