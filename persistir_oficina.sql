INSERT INTO clientes (cpf, primeiro_nome, ultimo_nome, logradouro, bairro, cidade) 
VALUES
('57489365584','Simone','Cintra','Rua Marte, 166','Santo Ignácio','São Paulo'),
('21568332411','Carla','Oliveira','Rua Vênus, 99','Nova York','Belo Horizonte'),
('88742695583','Anderson','Coelho','Rua Nove, 77','Santo Agostinho','Belo Horizonte'),
('66577423984','Maria','Lima','Rua Lins, 600','Brás','Santo Amaro'),
('11458962279','Leonardo','Santos','Rua Genova, 10','Asa Norte','Rio de Janeiro'),
('99523687445','Marina','Costa','Rua Paris, 74','Bairro Santo Antônio','Belo Horizonte');

INSERT INTO veiculos (marca, modelo, cor, placa, clientes_cpf) 
VALUES
('Chevrolet','Onix','Prata','LSU3J43','11458962279'),
('Fiat','Toro','Branca','AKI3P58','57489365584'),
('Fiat','Punto','Preta','KJJ5I97','99523687445'),
('Volkswagen','Saveiro','Branca','MMY8S22','88742695583'),
('Renault','Duster','Prata','PCP4L66','11458962279'),
('Honda','Fit','Prata','HFR1U88','21568332411'),
('Volkswagen','UP','Vermelha','GFR4Y22','88742695583');

INSERT INTO mecanicos (nome_mecanico) 
VALUES
('José Geraldo Brás'),
('Francisco de Araújo Gomes'),
('Márcio Arruda da Silva'),
('Vander de Assis');

INSERT INTO especializacoes (nome_especializacao) 
VALUES
('Eletricista Automotivo'),
('Pintor Automotivo'),
('Lanternagem Automotiva'),
('Mecânica Automotiva');

INSERT INTO mec_espec (mecanicos_idmecanico, especializacoes_idespecializacao) 
VALUES
(4,1),
(1,2),
(3,3),
(1,2),
(2,4),
(2,3),
(3,4);

INSERT INTO servicos (desc_servico, preco_servico) 
VALUES
('Manutenção da embreagem',270.00),
('Revisão dos componentes de Freio',325.85),
('Troca de óleo do motor',230.00),
('Troca de lâmpadas',40.00),
('Alinhamento e Balanceamento',220.00),
('Revisão no Sistema de Arrefecimento',305.00),
('Pintura Automotiva (Completa)',2150.00);

INSERT INTO pecas (desc_peca, preco_peca) 
VALUES
('Filtro De Ar Automotivo',158.90),
('Kit de Farol para Carro Automotivo Lanterna',153.45),
('Kit Conector Chicote Radio e Antena',32.00),
('Pastilhas Freio Acdelco Meriva/montana/corsa',116.39),
('Tinta automotiva poliéster 900ml - Cinza',55.00),
('Kit Embreagem Plato Disco Original - GM',558.17),
('Óleo Motor Texaco Havoline Semissintético',49.90);

INSERT INTO ordens_servico (data_os, data_entrega, status, veiculos_idveiculo, mecanicos_idmecanico) 
VALUES
('2022-09-19','2022-09-19','Avaliação',3,2),
('2022-09-19','2022-09-25','Autorizado',5,1),
('2022-09-19','2022-09-20','Autorizado',4,3),
('2022-09-19','2022-09-20','Autorizado',1,4);

INSERT INTO det_os_servicos (ordens_servico_id_os, servicos_idservico) 
VALUES
(5,3),
(6,7),
(7,5),
(8,1);

INSERT INTO det_os_pecas (ordens_servico_id_os, pecas_idpeca) 
VALUES
(5,28),
(6,26);






























