require_relative '../spec_helper'
require 'atividade'
require 'cartao'

describe Atividade do
  describe "The minutos method for Activity" do
		context "initialized without nothing done before" do
			before do 
		  	@atividade = Atividade.new
			end
		  
		  it 'has no minutes' do
		  	@atividade.minutos.should be == 0
		  end
		end

		context "activity had some stuff done befote it was created" do
			before do 
		  	@atividade = Atividade.new(:minutos => 30)
			end

		  it "has some minutes done" do
		  	@atividade.minutos.should be == 30		  	
		  end

		end
	end

	describe "The cor_status method for Activity" do
		context "activity judgement is not made" do
			before do
				@atividade = Atividade.new
			end

			it "has no color status" do
				@atividade.cor_status.should be_empty
			end
		end

		context "activity judgement is already made" do
			let(:atividade)  {Atividade.new(:aprovacao => true)}

			it "has approval color status" do
				"green-background".should eq(atividade.cor_status)
			end
		end

		context "activity judgement is already made" do
			let(:atividade)  {Atividade.new(:aprovacao => false)}

			it "has non-approval color status" do
				"red-background".should eq(atividade.cor_status)
			end
		end
	end

	describe "The trello_id method for Activity" do
		context "there is no card" do
			let(:atividade) {Atividade.new}

			it "has no id associated" do
				atividade.trello_id.should be nil
			end
		end
	end
end
