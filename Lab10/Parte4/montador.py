#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
--- Julio Alves Meesquita da Silva 	-- 156061 --
--- Gabriel Bonani Machado 			-- 155416 --

Montador para o processador feito no Laboratório de Lógicos

Código:
	formatos de instrução:
		op r1, r2
		op r1, #0x0
		op r1, #0b0
		op r1, #0
		op r1, rotulo

	formato para criação de rotulos
		rotulo:

execução:
	python montador.py arquivo_codigo saida=inst_mem.mif

	saida é opcicional

A saída é realizada na stdout e no arquivo de saida
"""

import sys
import re

regs = {
	'r0': '000',
	'r1': '001',
	'r2': '010',
	'r3': '011',
	'r4': '100',
	'r5': '101',
	'r6': '110',
	'r7': '111'
}

cmds = {
	'mv': 	'000',
	'mvi': 	'001',
	'add': 	'010',
	'sub': 	'011',
	'ld': 	'100',
	'st': 	'101',
	'mvnz': '110'
}

default_header =\
"""DEPTH = 128;
WIDTH = 16;
ADDRESS_RADIX = HEX;
DATA_RADIX = BIN;
CONTENT
BEGIN
"""

ROTULO = '999'

class I9Exception(Exception):
	pass

class InvalidExpressionException(I9Exception):
	"""docstring for InvalidCommandException"""
	pass

class InvalidNumberException(I9Exception):
	"""docstring for InvalidCommandException"""
	pass

class InvalidRegisterException(I9Exception):
	"""docstring for InvalidCommandException"""
	pass

class InvalidOperationException(I9Exception):
	"""docstring for InvalidCommandException"""
	pass

def int_to_16bits(imd):
	cmd_line = str(bin(imd))[2:]
	while len(cmd_line) < 16:
		cmd_line = '0' + cmd_line
	return cmd_line

def decode_line(line):
	cmd_line = (line.split('//')[0]).strip()
	if cmd_line:
		# Checa por comandos
		cmd_line_ = re.search("([A-Za-z]\w+)\s+([A-Za-z]\w+)\s*[,]\s*([A-Za-z0-9#]\w+)", cmd_line)
		if cmd_line_:
			op = cmd_line_.group(1)
			rx = cmd_line_.group(2)
			ry = cmd_line_.group(3)
			return op.lower(), rx.lower(), ry.lower()

		# Checa por rotulo
		cmd_line_ = re.search("([A-Za-z]\w+):", cmd_line)
		if cmd_line_:
			return ROTULO, cmd_line_.group(1).lower(), None

		raise InvalidExpressionException(cmd_line)


	return (None, None, None)


def mount(source_code):
	out = list()
	cmd_line = None
	rotulos = dict()

	to_be_linked = list()

	with open(source_code) as f:
		for line in f.readlines():
			op, rx, ry = decode_line(line)
			try:
				if op is None:
					continue
				elif op == ROTULO:
					rotulos[rx] = len(out)
				elif op == 'mvi':
					cmd_line = cmds[op] + regs[rx] + '0'*10
					out.append(cmd_line)
					if(ry[0]=='#'):
						ry = ry[1:]
						if ry[:2] == '0b':
							imd = int(ry, 2)
						elif ry[:2] == '0x':
							imd = int(ry, 16)
						else:
							imd = int(ry)
						cmd_line = int_to_16bits(imd)
						if len(cmd_line) > 16:
							raise InvalidNumberException
					else:
						cmd_line = ry
						to_be_linked.append(len(out))
					out.append(cmd_line)
				else:
					cmd_line = cmds[op] + regs[rx] + regs[ry] + '0'*7
					out.append(cmd_line)
			except KeyError:
				raise InvalidExpressionException
			except ValueError:
				raise InvalidNumberException

	for i in to_be_linked:
		out[i] = int_to_16bits(rotulos[out[i]])

	return out

def main(source_code, output_file):
	cmd_list = mount(source_code)
	with open(output_file, 'w') as f:
		print default_header
		f.write(default_header)
		for i in range(len(cmd_list)):
			index = hex(i)[2:].upper()
			if len(index) < 2:
				index = '0' + index
			print '%s : %s;' % (index, cmd_list[i])
			f.write('%s : %s;\n' % (index, cmd_list[i]))
		print	
		f.write('\n')
		print 'END;'
		f.write('END;\n')


if __name__ == '__main__':

	if len(sys.argv) == 2:
		output_file = 'inst_mem.mif'
	else:
		output_file = sys.argv[2]

	main(sys.argv[1], output_file)