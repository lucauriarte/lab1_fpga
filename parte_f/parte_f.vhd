-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Sat Nov 08 16:53:19 2025"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY parte_f IS 
	PORT
	(
		SCL :  IN  STD_LOGIC;
		SDA :  IN  STD_LOGIC;
		Dir_esclavo :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		ACK :  OUT  STD_LOGIC;
		Datos :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END parte_f;

ARCHITECTURE bdf_type OF parte_f IS 

COMPONENT maquina_i2c
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 SDA : IN STD_LOGIC;
		 fin_dir : IN STD_LOGIC;
		 soy : IN STD_LOGIC;
		 fin_dato : IN STD_LOGIC;
		 hab_dir : OUT STD_LOGIC;
		 hab_dat : OUT STD_LOGIC;
		 ack_o : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT shift_reg_7bit
	PORT(SCL : IN STD_LOGIC;
		 SDA : IN STD_LOGIC;
		 Hab_Dir : IN STD_LOGIC;
		 dir_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT contador_mod7
	PORT(SCL : IN STD_LOGIC;
		 Hab_Dir : IN STD_LOGIC;
		 fin_dir : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT contador_mod8
	PORT(SCL : IN STD_LOGIC;
		 Hab_Dat : IN STD_LOGIC;
		 fin_dato : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT shift_reg_8bit
	PORT(SCL : IN STD_LOGIC;
		 SDA : IN STD_LOGIC;
		 Hab_Dat : IN STD_LOGIC;
		 dato_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comparador_dir
	PORT(dir_recibida : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 mi_direccion : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 soy : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(6 DOWNTO 0);


BEGIN 
SYNTHESIZED_WIRE_0 <= '0';



b2v_inst : maquina_i2c
PORT MAP(reset => SYNTHESIZED_WIRE_0,
		 clock => SCL,
		 SDA => SDA,
		 fin_dir => SYNTHESIZED_WIRE_1,
		 soy => SYNTHESIZED_WIRE_2,
		 fin_dato => SYNTHESIZED_WIRE_3,
		 hab_dir => SYNTHESIZED_WIRE_9,
		 hab_dat => SYNTHESIZED_WIRE_10,
		 ack_o => ACK);


b2v_inst2 : shift_reg_7bit
PORT MAP(SCL => SCL,
		 SDA => SDA,
		 Hab_Dir => SYNTHESIZED_WIRE_9,
		 dir_out => SYNTHESIZED_WIRE_8);


b2v_inst3 : contador_mod7
PORT MAP(SCL => SCL,
		 Hab_Dir => SYNTHESIZED_WIRE_9,
		 fin_dir => SYNTHESIZED_WIRE_1);


b2v_inst4 : contador_mod8
PORT MAP(SCL => SCL,
		 Hab_Dat => SYNTHESIZED_WIRE_10,
		 fin_dato => SYNTHESIZED_WIRE_3);


b2v_inst5 : shift_reg_8bit
PORT MAP(SCL => SCL,
		 SDA => SDA,
		 Hab_Dat => SYNTHESIZED_WIRE_10,
		 dato_out => Datos);


b2v_inst6 : comparador_dir
PORT MAP(dir_recibida => SYNTHESIZED_WIRE_8,
		 mi_direccion => Dir_esclavo,
		 soy => SYNTHESIZED_WIRE_2);



END bdf_type;