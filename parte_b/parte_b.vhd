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
-- CREATED		"Tue Nov 04 17:21:42 2025"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY parte_b IS 
	PORT
	(
		A0 :  IN  STD_LOGIC;
		B0 :  IN  STD_LOGIC;
		A1 :  IN  STD_LOGIC;
		B1 :  IN  STD_LOGIC;
		P0 :  OUT  STD_LOGIC;
		P1 :  OUT  STD_LOGIC;
		P2 :  OUT  STD_LOGIC;
		P3 :  OUT  STD_LOGIC
	);
END parte_b;

ARCHITECTURE bdf_type OF parte_b IS 

COMPONENT parte_a
	PORT(A : IN STD_LOGIC;
		 B : IN STD_LOGIC;
		 Cin : IN STD_LOGIC;
		 S : OUT STD_LOGIC;
		 Cout : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_18 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_20 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_18 <= '0';
SYNTHESIZED_WIRE_3 <= '0';
SYNTHESIZED_WIRE_19 <= '0';
SYNTHESIZED_WIRE_11 <= '0';
SYNTHESIZED_WIRE_13 <= '0';
SYNTHESIZED_WIRE_20 <= '0';






b2v_inst11 : parte_a
PORT MAP(A => SYNTHESIZED_WIRE_18,
		 B => SYNTHESIZED_WIRE_18,
		 Cin => SYNTHESIZED_WIRE_2,
		 S => SYNTHESIZED_WIRE_4);


b2v_inst12 : parte_a
PORT MAP(A => SYNTHESIZED_WIRE_3,
		 B => SYNTHESIZED_WIRE_4,
		 Cin => SYNTHESIZED_WIRE_5,
		 S => SYNTHESIZED_WIRE_7);


b2v_inst13 : parte_a
PORT MAP(A => SYNTHESIZED_WIRE_19,
		 B => SYNTHESIZED_WIRE_7,
		 Cin => SYNTHESIZED_WIRE_19,
		 S => P3);





b2v_inst3 : parte_a
PORT MAP(A => SYNTHESIZED_WIRE_9,
		 B => SYNTHESIZED_WIRE_10,
		 Cin => SYNTHESIZED_WIRE_11,
		 S => P1,
		 Cout => SYNTHESIZED_WIRE_14);


P0 <= A0 AND B0;


SYNTHESIZED_WIRE_10 <= A1 AND B0;


SYNTHESIZED_WIRE_9 <= A0 AND B1;


b2v_inst7 : parte_a
PORT MAP(A => SYNTHESIZED_WIRE_12,
		 B => SYNTHESIZED_WIRE_13,
		 Cin => SYNTHESIZED_WIRE_14,
		 S => SYNTHESIZED_WIRE_16,
		 Cout => SYNTHESIZED_WIRE_2);


SYNTHESIZED_WIRE_12 <= A1 AND B1;


b2v_inst9 : parte_a
PORT MAP(A => SYNTHESIZED_WIRE_20,
		 B => SYNTHESIZED_WIRE_16,
		 Cin => SYNTHESIZED_WIRE_20,
		 S => P2,
		 Cout => SYNTHESIZED_WIRE_5);


END bdf_type;