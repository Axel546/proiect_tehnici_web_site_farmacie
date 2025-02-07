DROP TYPE IF EXISTS categ_produse;
DROP TYPE IF EXISTS tipuri_produse;
DROP TYPE IF EXISTS tipuri_ambalaj_produse;

CREATE TYPE categ_produse as ENUM('medicamente', 'cosmetice', 'suplimente', 'produse_farmaceutice');
CREATE TYPE tipuri_produse as ENUM('antibiotic', 'anti-inflamator', 'calmant', 'antihistaminic', 'hidratant', 'anti-imbatranire', 'igiena', 'vitamine', 'minerale', 'imunitate', 'digestie');
CREATE TYPE tipuri_ambalaj_produse as ENUM('tablete', 'flacoane', 'capsule', 'plicuri', 'drajeuri', 'crema', 'gel', 'shoturi', 'kit', 'lichid', 'comprimate');

CREATE TABLE IF NOT EXISTS produse (
    id serial PRIMARY KEY,
    nume VARCHAR(50) UNIQUE NOT NULL,
    descriere TEXT,
    imagine VARCHAR(300),
    categorie categ_produse DEFAULT 'medicamente',
    tip_produs tipuri_produse DEFAULT 'anti-inflamator',
    pret NUMERIC(8,2) NOT NULL,
    cantitate INT NOT NULL CHECK (cantitate>=0),
    unitati INT NOT NULL CHECK (unitati>=0),
    data_adaugare TIMESTAMP DEFAULT current_timestamp,
    tip_ambalaj tipuri_ambalaj_produse DEFAULT 'tablete',
    ingrediente VARCHAR[],
    cu_reteta BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT into produse (nume, descriere, imagine, categorie, tip_produs, pret, cantitate, unitati, data_adaugare, tip_ambalaj, ingrediente, cu_reteta) VALUES
('boost_imunitate', 'Supliment pentru cresterea imunitatii', 'boost_imunitate.jpg', 'suplimente', 'imunitate', 50.00, 100, 30, current_timestamp, 'shoturi', ARRAY['Vitamina C', 'Zinc'], FALSE),
('calciu_vitamina_D3', 'Supliment cu calciu si vitamina D3', 'calciu_vitamina_D3.jpg', 'suplimente', 'minerale', 30.00, 200, 20, current_timestamp, 'comprimate', ARRAY['Calciu', 'Vitamina D3'], FALSE),
('claritin_tablete', 'Antihistaminic pentru alergii', 'claritin_tablete.jpg', 'medicamente', 'antihistaminic', 25.00, 50, 10, current_timestamp, 'tablete', ARRAY['Loratadina'], FALSE),
('crema_anticelulita', 'Crema anticelulitica pentru piele', 'crema_anticelulita.jpg', 'cosmetice', 'hidratant', 40.00, 75, 1, current_timestamp, 'crema', ARRAY['Extract de cafea', 'Coenzima Q10'], FALSE),
('crema_calmanta', 'Crema calmanta pentru iritatii', 'crema_calmanta.jpg', 'cosmetice', 'calmant', 35.00, 80, 1, current_timestamp, 'crema', ARRAY['Aloe Vera', 'Panthenol'], FALSE),
('crema_hidratanta_hialuronic', 'Crema hidratanta cu acid hialuronic', 'crema_hidratanta_hialuronic.jpg', 'cosmetice', 'hidratant', 45.00, 60, 1, current_timestamp, 'crema', ARRAY['Acid Hialuronic', 'Glicerina'], FALSE),
('crema_ingrijire_calcaie', 'Crema pentru ingrijirea calcaielor', 'crema_ingrijire_calcaie.jpg', 'cosmetice', 'hidratant', 30.00, 90, 1, current_timestamp, 'crema', ARRAY['Uree', 'Lanolina'], FALSE),
('fenistil_gel', 'Gel antihistaminic pentru mancarimi', 'fenistil_gel.jpg', 'medicamente', 'antihistaminic', 25.00, 50, 1, current_timestamp, 'gel', ARRAY['Dimetinden'], FALSE),
('gel_igiena_intima', 'Gel pentru igiena intima', 'gel_igiena_intima.jpg', 'produse_farmaceutice', 'igiena', 20.00, 120, 1, current_timestamp, 'gel', ARRAY['Extract de musetel'], FALSE),
('kit_cosmetice_acnee', 'Kit pentru tratarea acneei', 'kit_cosmetice_acnee.jpg', 'cosmetice', 'anti-imbatranire', 70.00, 40, 1, current_timestamp, 'kit', ARRAY['Acid Salicilic', 'Niacinamide'], FALSE),
('klacid_comprimate_500', 'Antibiotic pentru infectii bacteriene', 'klacid_comprimate_500.jpg', 'medicamente', 'antibiotic', 80.00, 500, 5, current_timestamp, 'tablete', ARRAY['Claritromicina'], TRUE),
('multivitamine_minerale', 'Complex de multivitamine si minerale', 'multivitamine_minerale.jpg', 'suplimente', 'vitamine', 55.00, 150, 20, current_timestamp, 'comprimate', ARRAY['Vitamine A-Z', 'Magneziu'], FALSE),
('nurofen_forte_400_drajeuri', 'Antiinflamator pentru dureri puternice', 'nurofen_forte_400_drajeuri.jpg', 'medicamente', 'anti-inflamator', 35.00, 400, 24, current_timestamp, 'drajeuri', ARRAY['Ibuprofen'], FALSE),
('nurofen_junior_portocale', 'Suspensie pentru copii cu aroma de portocale', 'nurofen_junior_portocale.jpg', 'medicamente', 'anti-inflamator', 40.00, 60, 1, current_timestamp, 'lichid', ARRAY['Ibuprofen'], FALSE),
('nurofen_raceala_comprimate', 'Medicament pentru raceala si gripa', 'nurofen_raceala_comprimate.jpg', 'medicamente', 'anti-inflamator', 38.00, 200, 12, current_timestamp, 'comprimate', ARRAY['Ibuprofen', 'Pseudoefedrina'], FALSE),
('sampon_par_gras_mentol', 'Sampon pentru par gras cu mentol', 'sampon_par_gras_mentol.jpg', 'cosmetice', 'igiena', 25.00, 100, 1, current_timestamp, 'lichid', ARRAY['Mentol', 'Extract de urzica'], FALSE),
('spray_igiena_nazala', 'Spray pentru igiena nazala', 'spray_igiena_nazala.jpg', 'produse_farmaceutice', 'igiena', 28.00, 110, 1, current_timestamp, 'lichid', ARRAY['Apa de mare'], FALSE),
('vitamina_D_capsule', 'Supliment de vitamina D', 'vitamina_D_capsule.jpg', 'suplimente', 'vitamine', 45.00, 200, 1, current_timestamp, 'capsule', ARRAY['Vitamina D3'], FALSE),
('zinnat_comprimate_500', 'Antibiotic cu cefuroxim', 'zinnat_comprimate_500.jpg', 'medicamente', 'antibiotic', 85.00, 500, 10, current_timestamp, 'comprimate', ARRAY['Cefuroxim'], TRUE),
('colebil_drajeuri', 'Supliment pentru digestie', 'colebil_drajeuri.jpg', 'suplimente', 'digestie', 32.00, 150, 20, current_timestamp, 'drajeuri', ARRAY['Extract de bila'], FALSE);