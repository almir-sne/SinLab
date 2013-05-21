class Atividade < ActiveRecord::Base
  attr_accessible :dia_id, :horas, :observacao, :mes_id, :projeto_id, :user_id, :aprovacao
  attr_accessible :aprovado, :reprovado
  attr_accessible :valor_da_bolsa_fau, :horas_da_bolsa_fau, :funcao, :data_admissao_fau, :data_demissao_fau

	belongs_to :mes
	belongs_to :dia
	belongs_to :projeto

  def data
    mes = Mes.find mes_id
    Date.new(mes.ano, mes.numero, Dia.find(dia_id).numero)
  end

  def bar_width
		width = horas.nil? ? "0" : (horas / 360).to_s
		width + "%"
	end
	
	def formato_horas
	  aux_h = 0
	  aux_m = 0
	  retorno = "00:00"
	  if !horas.nil?
	    aux_h = (horas / 3600).to_i
	    
	    aux_m = ((horas%3600)/60).to_i
	    
	    retorno = aux_h.to_s + ":"
	    if aux_h < 10
	      retorno = "0" + retorno
	    end
	    
	    if aux_m < 10
        retorno = retorno + "0"
      end
      retorno = retorno + aux_m.to_s	    
	  end
    
    retorno
  end

end
