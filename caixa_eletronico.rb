class CaixaEletronico

	attr_reader :saldo_atual

	def initialize(saldo_inicial)
		@saldo_atual = saldo_inicial
	end

	def saque(valor)
		if (valor > @saldo_atual)
			raise SaldoInsulficienteError
		end

		@saldo_atual = @saldo_atual - valor
	end

	def notas_sacadas(valor)
		calculador = CalculadorDeNotas.new
		calculador.calcula valor
	end

end

class SaldoInsulficienteError < StandardError
end

class CalculadorDeNotas

	NOTAS = [ 100, 50, 20, 10, 5, 1 ]

	def calcula(valor)
		notas = notas_separadas(valor)
		check notas, valor
		return notas
	end

private

	def notas_separadas(valor)
		notas = {}

		NOTAS.each do | nota |
			while (valor > 0)
				if (valor < nota)
					break
				end

				notas[nota.to_s] ||= 0
				notas[nota.to_s] += 1
				valor -= nota
			end
		end

		notas
	end

	def check(notas, valor)
		soma = 0
		notas.each { | nota, qtde | soma += (nota.to_i * qtde) }

 		unless soma == valor
 			mensagem = "Notas invalidas para o valor"
 			mensagem << "\n- Notas: #{notas.to_s}"
 			mensagem << "\n- Somando da: #{soma}"
 			mensagem << "\n- Soma esperada: #{valor}"
			raise mensagem
		end
	end

end
