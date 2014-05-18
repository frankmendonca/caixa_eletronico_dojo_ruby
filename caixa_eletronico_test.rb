require './caixa_eletronico'

describe CaixaEletronico do

	it 'com dinheiro' do
		@caixa = CaixaEletronico.new(100)
		@caixa.saldo_atual.should == 100
	end

	context 'Saque' do

		it 'depois do saque, sem dinheito' do
			@caixa = CaixaEletronico.new(100)
			@caixa.saque 100
			@caixa.saldo_atual.should == 0
		end

		it 'depois do saque, com dinheito' do
			@caixa = CaixaEletronico.new(250)
			@caixa.saque 100
			@caixa.saldo_atual.should == 150
		end

		it 'saldo insuficiente' do
			@caixa = CaixaEletronico.new(100)

			expect { @caixa.saque 200 }.to raise_error(SaldoInsulficienteError)
		end

	end

	context 'Notas dos Saques' do

		before { @caixa = CaixaEletronico.new(1000) }

		it 'sacar 100, 1 nota de 100' do
			@caixa.notas_sacadas(100).should eql({ '100' => 1 })
		end

		it 'sacar 75, 1 nota de 50, 1 nota de 20, 1 nota de 5' do
			@caixa.notas_sacadas(75).should eql({ '50' => 1, '20' => 1, '5' => 1 })
		end

		it 'sacar 289, 2 notas de 100, 1 nota de 50, 1 nota de 20, 1 nota de 10, 1 nota de 5, 4 notas de 1' do
			@caixa.notas_sacadas(289).should eql({ '100' => 2, '50' => 1, '20' => 1, '10' => 1, '5' => 1, '1' => 4 })
		end

	end

end
